#!/usr/bin/python
from __future__ import print_function
import argparse, os, sys

parser = argparse.ArgumentParser(description='Install necessary R dependencies from gitub.')
parser.add_argument('files', nargs="+")
parser.add_argument('--Rscript', help="Which CRAN repo to use.")
parser.add_argument('--list', help="Where to store list of github installs.")

from Rscript import Rscript as find_Rscript

if __name__ == "__main__":

    args = parser.parse_args(sys.argv[1:])

    # find Rscript

    if not args.Rscript:
        Rscript = find_Rscript()
    else:
        Rscript = args.Rscript

    lines = []
    for filename in args.files:
        lines.extend(open(filename).read().strip().split('\n'))

    libraries = [line.strip() for line in lines if line and line[0] != '#']

    if args.list is not None:
        open(args.list, 'w').write('\n'.join(list(set(libraries))) + '\n')

    for library in libraries:
        Rsrc = """
        if (!require('%(libname)s')) {
            library(devtools);
            install_github('%(lib)s')
        }
        """ % {'lib':library, 'libname':os.path.split(library)[1]}

        cmd = '''%s -e "%s"''' % (Rscript, Rsrc.replace('\n',' '))
        print("Installing package '%s' from github if not installed" % library)
        status = os.system(cmd)
        if status != 0:
            raise SystemExit("Installation of package '%s' failed." % library)
