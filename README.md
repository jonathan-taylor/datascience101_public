Data Science 101 materials
--------------------------

![Travis-CI Build Status](https://travis-ci.com/jonathan-taylor/datascience101.svg?token=DppeTQ6K83n5N1KaeP62&branch=master])

- Directory `modules` contains each module.

- Within each module, lectures are *_lecture.Rmd, lab is *_lab.Rmd

- To build: `make all`. Output is under `build` with main webpage being `build/index.html`

- Assumes you have `pandoc` installed as well as `rmarkdown, knitr` R libraries.

- Uses sphinx (standard python-doc building package) to build main webpage.

- Assumes pip is available and python install is such that `jupyter`, `sphinx` and `notedown` are pip-installable.

Assumptions about modules
-------------------------

- Any libraries needed for the module that are CRAN available are listed in
file `R-requirements.txt`

- Any libraries available through `devtools::install_github` are listed in
file `R-github.txt`

- Any local data file, figures, etc needed for module is in the directory `modules/MODULENAME/`.

- For each lab, students will run `setup.R` first. By default, these
simply look for packages and install if needed. Any additional commands
can be put in this file.

- Zipfiles are created for each module in the build process.

- NOTE: the state of the zipfile is what is in the git repo. If you
have not committed changes, they will not appear in the zipfile!!!!!

Building zipfile
----------------

- To make just the zipfile

     make zipfiles/MODULENAME.zip

- NOTE: the state of the zipfile is what is in the git repo. If you
have not committed changes, they will not appear in the zipfile!!!!!

Building entire module including zipfiles
-----------------------------------------

- The Makefile has a target for each module that will rebuild all .html pages, .ipynb files
as well as the zipfile.

     make build/MODULENAME

(e.g. make build/intro)

- NOTE: the state of the zipfile is what is in the git repo. If you
have not committed changes, they will not appear in the zipfile!!!!!

Building the entire site from git repo
--------------------------------------

- To test that the current state of the git repo is buildable, run

     make test_build

- NOTE: any changes not committed to the git repo will not be seen in this process!!!

Upload to course webpage
------------------------

- Run `env SUNET=tibs make upload`

Using conda
-----------

- One way to ensure consistent builds is to use a standard
version of python and
R. [Conda](http://conda.pydata.org/docs/download.html) provides such a
solution. 

- Assuming you have installed conda, one can create a virtualenv
specific for this course such that everything should reliably build.

```
conda create -n datascience101 python;
source activate datascience101;
conda install jupyter; # for making notebooks (and running them)
pip install notedown nbconvert sphinx nbformat pandoc-attributes; # for installing the python dependencies
make build_all; # this builds all the HTML and notebooks after installing necessary packages
make all;
```
