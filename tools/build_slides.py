#!/usr/bin/python
from __future__ import print_function
import argparse, os, sys
from Rscript import Rscript as find_Rscript

parser = argparse.ArgumentParser(description='Build some slides.')
parser.add_argument('files', nargs="+")
parser.add_argument('--slidy', default=False, action='store_true', help="Make slidy slides.")
parser.add_argument('--noexit', default=False, action='store_true', help="Force stop on error.")
parser.add_argument('--Rscript', help="Which CRAN repo to use.")

R_code = """
library(methods);
library(rmarkdown);
library(knitr)
"""

if __name__ == "__main__":

    args = parser.parse_args(sys.argv[1:])

    # find Rscript

    if args.Rscript is None:
        Rscript = find_Rscript()
    else:
        Rscript = args.Rscript

    force_error = not args.noexit

    for Rmd_file in args.files:

        cmd = '''%s -e "%s; %s"''' % (Rscript, 
                                      R_code, 
                                      "rmarkdown::render('%s')" % Rmd_file)
        cmd = ' '.join(cmd.split('\n'))
        print(cmd)
        status = os.system(cmd)
        if status != 0 and force_error:
            raise SystemExit("Building %s failed. Exiting with status %d" % (Rmd_file, status))

        if args.slidy:

            slidy_file = Rmd_file[:-4] + "_slidy.Rmd"
            orig = open(Rmd_file).read()
            if 'beamer_presentation' not in orig:
                raise ValueError('only make slidy if original was beamer')

            slidy = orig.replace("beamer_presentation", "slidy_presentation")
            with open(Rmd_file[:-4] + "_slidy.Rmd", "w") as f:
                f.write(slidy)

            cmd = '''%s -e "%s; %s"''' % (args.Rscript,
                                          R_code, 
                                          "rmarkdown::render('%s')" % slidy_file)
            cmd = ' '.join(cmd.split('\n'))

            status = os.system(cmd)
            if status != 0 and force_error:
                raise SystemExit("Building %s failed. Exiting with status %d" % (Rmd_file, status))

            os.rename(slidy_file[:-3] + "html", Rmd_file[:-3] + "html")
            os.remove(slidy_file)

        # touch a .built target

        os.system('touch %s' % (Rmd_file[:-3] + 'built'))
