#!/usr/bin/python
from __future__ import print_function
import argparse, os, sys

parser = argparse.ArgumentParser(description='Install necessary R dependencies.')
parser.add_argument('files', nargs="+")
parser.add_argument('--repos', default="http://cloud.r-project.org", help="Which CRAN repo to use.")
parser.add_argument('--Rscript', help="What executable for Rscript?")
parser.add_argument('--list', help="Where to store list of package installs.")

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

    # ignore comments beginning with "#"

    libraries = [line.strip() for line in lines if line and line[0] != '#']

    if args.list is not None:
        open(args.list, 'w').write('\n'.join(list(set(libraries))) + '\n')

    #for library in libraries:
    Rsrc = """
    packages_needed = setdiff(c(%(libs)s), installed.packages()[,'Package']);
    for (pkg in packages_needed) {
        install.packages(pkg, repos='%(repos)s') ;
    }
    """ % {'repos':args.repos,
           'libs':', '.join(["%s" % repr(lib) for lib in libraries])}

    cmd = '''%s -e "%s"''' % (Rscript, Rsrc.replace('\n',' '))
    status = os.system(cmd)
    if status != 0:
        raise SystemExit("Installation of packages '%s' failed." % str(libraries))
