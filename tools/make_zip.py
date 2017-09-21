import os, argparse, tempfile, sys

parser = argparse.ArgumentParser(description='Export zipfiles of modules, optionally testing them.')
parser.add_argument('modules', nargs="+")

def make_zip(modules):
    tmpd = tempfile.mkdtemp()
    cmd = '''
    cd %(basedir)s;
    git archive HEAD | gzip > %(tmpd)s/datascience101.tar.gz;
    cd %(tmpd)s/;
    tar -xvzf datascience101.tar.gz;
    cd modules;
    ''' % {'basedir':os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)), '..')),
           'tmpd':tmpd}
    os.system(cmd)

    for module in modules:
        print(module)
        cmd = '''
        cd %(tmpd)s/modules;
        zip -r %(module)s.zip %(module)s;
        mkdir -p %(basedir)s/zipfiles;
        cp %(module)s.zip %(basedir)s/zipfiles
        ''' % {'module':module, 
               'basedir':os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)), '..')),
               'tmpd':tmpd}
        os.system(cmd)


if __name__ == "__main__":

    args = parser.parse_args(sys.argv[1:])

    modules = [os.path.split(module)[1] for module in args.modules]
    make_zip(modules)

