import os, tempfile, argparse, sys, glob, shutil, io
import nbformat, codecs, locale
from nbconvert.preprocessors import ExecutePreprocessor
from nbconvert.preprocessors.execute import CellExecutionError
from pandocattributes import PandocAttributes

from notedown.notedown import MarkdownReader

from Rscript import Rscript as find_Rscript

languages = ['r']
class OurReader(MarkdownReader):

    def process_code_block(self, block):
        """Parse block attributes"""
        if block['type'] != self.code:
            return block

        attr = PandocAttributes(block['attributes'], 'markdown')

        if self.match == 'all':
            pass

        elif self.match == 'fenced' and block.get('indent'):
            return self.new_text_block(content=('\n' +
                                                block['icontent'] +
                                                '\n'))

        elif self.match == 'strict' and 'input' not in attr.classes:
            return self.new_text_block(content=block['raw'])

        elif self.match not in list(attr.classes) + ['fenced', 'strict']:
            return self.new_text_block(content=block['raw'])

        # set input / output status of cell
        if 'output' in attr.classes and 'json' in attr.classes:
            block['IO'] = 'output'
        elif 'input' in attr.classes:
            block['IO'] = 'input'
            attr.classes.remove('input')
        else:
            block['IO'] = 'input'

        if self.caption_comments:
            # override attributes id and caption with those set in
            # comments, if they exist
            id, caption = get_caption_comments(block['content'])
            if id:
                attr.id = id
            if caption:
                attr['caption'] = caption

        try:
            # determine the language as the first class that
            # is in the block attributes and also in the list
            # of languages
            language = set(attr.classes).intersection(languages).pop()
            attr.classes.remove(language)
        except KeyError:
            language = None

        block['language'] = language
        block['attributes'] = attr

        # ensure one identifier for python code
        if language in ('r',):
            block['language'] = u'r'
        # add alternate language execution magic
        else:
            print('language', language)
            block['cell_type'] = u'markdown'
            block['type'] = u'markdown'
            block = OurReader.create_markdown_cell(block)
            block['type'] = u'markdown'
            block['content'] = ('```\n' + block['source'] +
                                '\n```\n')
            return block
        return self.new_code_block(**block)

def delete_first_code_cell(nbfile):
    """
    We hackily injected this cell -- let's delete it
    """
    nb = nbformat.read(nbfile, nbformat.current_nbformat)

    # delete the first one

    for i, cell in enumerate(nb.cells):
        if cell['cell_type'] == 'code':
            break
    del(nb.cells[i])

    # remove empty ones

    for cell in nb.cells:
        if cell['cell_type'] == 'code' and not cell['source'].strip():
            nb.cells.remove(cell)

    ofile = open(nbfile, 'w')
    writer = codecs.getwriter(locale.getpreferredencoding())(ofile)
    nbformat.write(nb, writer)

def set_kernel(nbfile, ofilename):
    """
    A fragile attempt to set the kernelspec to be the R kernel.
    """
    nb = nbformat.read(nbfile, nbformat.current_nbformat)
    nb['metadata']['kernelspec'] = {'display_name':'R',
                                    'language':'R',
                                    'name':'ir'}
    ofile = open(ofilename, 'w')
    writer = codecs.getwriter(locale.getpreferredencoding())(ofile)
    nbformat.write(nb, writer)
    ofile.close()

def Rmd_to_ipynb(mdfile, nbfile):
    """
    Based on notedown.main.convert
    """
    with io.open(mdfile, 'r', encoding='utf-8') as f:
        contents = f.read()

    reader = OurReader(precode='',
                       magic=False,
                       match='fenced')
    notebook = reader.reads(contents, as_version=nbformat.current_nbformat)

    ofile = open(nbfile, 'w')
    writer = codecs.getwriter(locale.getpreferredencoding())(ofile)
    nbformat.write(notebook, writer)

def run_Ripynb(nbfile, ofilename):
    """
    Based on notedown.main.convert

    Assume a kernel named `ir` exists. Can be created with github IRkernel/IRkernel
    and command `IRkernel::installspec()`
    
    """
    olddir, newdir = os.path.abspath(os.path.curdir), os.path.dirname(nbfile)
    with open(nbfile) as f:
        nb = nbformat.read(f, as_version=nbformat.current_nbformat)

    ep =  ExecutePreprocessor(timeout=600, kernel_name='ir')
    try:
        ep.allow_errors = True
        ep.preprocess(nb, {'metadata': {'path':newdir}})
    except:
        print('Running %s failed' % nbfile)
        raise 

    ofile = open(ofilename, 'wt')
    writer = codecs.getwriter(locale.getpreferredencoding())(ofile)
    nbformat.write(nb, writer)

def make_notebook(Rmdfile, nbfile, Rscript=None):
    """
    Take an Rmdfile and make an R jupyter notebook out of it.
    """

    R_code = """
    library(methods);
    library(rmarkdown);
    library(knitr)
    """

    tmp_Rmdfile = os.path.join(os.path.dirname(Rmdfile),
                               os.path.split(tempfile.mkstemp()[1] + '.Rmd')[1])
    mdfile = tmp_Rmdfile[:-4] + '.md'
    os.system('cp %s %s' % (Rmdfile, tmp_Rmdfile)) 
    Rmd_src = open(tmp_Rmdfile).read().split("---") # to get past first YAML chunk -- a hack!

    Rmd_src = '''%s

```{r}
library(knitr)
opts_chunk$set(results="hide", fig.show="hide", warning=FALSE, message=FALSE)
```

    %s
    ''' % ('---'.join(Rmd_src[:2]).strip() + '\n---', '---'.join(Rmd_src[2:]))
    open(tmp_Rmdfile, 'w').write(Rmd_src)

    try: 
        cmd = '''%s -e "%s; %s"''' % (Rscript, R_code, "rmarkdown::render('%s')" % tmp_Rmdfile)
        cmd = cmd.replace('\n', ' ')
        os.system(cmd)

        Rmd_to_ipynb(mdfile, nbfile)

        set_kernel(nbfile, nbfile.replace('.ipynb', '_R.ipynb'))
        run_Ripynb(nbfile.replace('.ipynb', '_R.ipynb'), nbfile)
        os.remove(nbfile.replace('.ipynb', '_R.ipynb'))

    except:
        print("Running %s failed" % nbfile)

    finally:
        tmpfiles = glob.glob(tmp_Rmdfile[:-4] + '*')
        for tmpfile in tmpfiles:
            if os.path.isdir(tmpfile):
                shutil.rmtree(tmpfile, ignore_errors=True)
            else:
                os.remove(tmpfile)

parser = argparse.ArgumentParser(description='Export Rmd to jupyter notebooks.')
parser.add_argument('files', nargs="+")
parser.add_argument('--Rscript', help="Where to find Rscript.")

if __name__ == "__main__":

    args = parser.parse_args(sys.argv[1:])

    # find Rscript

    if args.Rscript is None:
        Rscript = find_Rscript()
    else:
        Rscript = args.Rscript

    for filename in args.files:
        print("Exporting %s to jupyter notebook" % filename)
        if os.path.splitext(filename)[1] != '.Rmd': # check the extension
            raise SystemExit('files should be Rmd files')
        make_notebook(filename, filename[:-4] + '.ipynb', Rscript=Rscript)
        delete_first_code_cell(filename[:-4] + '.ipynb')
