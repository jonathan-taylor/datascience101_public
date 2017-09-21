SHELL = /bin/bash
MODULE_DIR = modules

export TOP_DIR := ${CURDIR}
export TOOLS_DIR := ${TOP_DIR}/tools
export BUILD_DIR := ${TOP_DIR}/build

MODULES = intro data summaries visualization sampling inference prediction principal_components nonparametric replicability
ZIPFILES = $(patsubst %, zipfiles/%.zip, $(MODULES))

$(MODULES): 
	make -C $(MODULE_DIR)/$@;
	-cp zipfiles/$@.zip $(BUILD_DIR)/$@;

modules: $(MODULES)

Rdeps:
	-mkdir build
	python tools/installRdeps.py modules/*/R-requirements.txt modules/*/BioC-requirements.txt R-requirements.txt --list=build/R-requirements.txt
	python tools/installRgithub.py modules/*/R-github.txt R-github.txt --list=build/R-github.txt

pydeps:
	-pip install notedown nbconvert sphinx nbformat pandoc-attributes;

$(MODULE_DIR)/%.ipynb: $(MODULE_DIR)/%.Rmd pydeps
	-python tools/export_jupyter.py $<;

zipfiles/%.zip : Rdeps
	python tools/make_zip.py $(patsubst zipfiles/%.zip, modules/%, $@)

zip: Rdeps 
	python tools/make_zip.py $(patsubst zipfiles/%.zip, modules/%, $(MODULES))

$(BUILD_DIR)/index.html : index.md pydeps
	notedown index.md > index.ipynb;
	jupyter nbconvert --to=rst index.ipynb --output=index;
	rm index.ipynb;

	notedown install.md > install.ipynb;
	jupyter nbconvert --to=rst install.ipynb --output=install;
	rm install.ipynb;

	mv index.rst install.rst sphinx;
	sphinx-build -v -E -b html sphinx _build/html ;
	tools/fixup_html_links.R _build/html/index.html ;
	-mkdir build;
	cp -r _build/html/* build;

clean:
	rm -fr $(BUILD_DIR);
	rm -fr _build;
	rm -fr $(MODULE_DIR)/*/*lecture*pdf
	rm -fr $(MODULE_DIR)/*/*.built
	rm -fr $(MODULE_DIR)/*/*lecture*html
	rm -fr $(MODULE_DIR)/*/*lab*html
	rm -fr $(MODULE_DIR)/*/*lab*ipynb
	rm -fr $(MODULE_DIR)/*/*.md
	rm -fr zipfiles

all: modules $(BUILD_DIR)/index.html
	cp profile.R build;
	cp INSTALL.R build;

rsync:
	rsync -avz build/* $(SUNET)@cardinal.stanford.edu:/afs/ir/class/stats101/WWW

upload:
	scp -r build/* $(SUNET)@cardinal.stanford.edu:/afs/ir/class/stats101/WWW

stats101_pkg: $(RPKG_FILES)
	tools/make_pkg_list.R . ./stats101
	R CMD build stats101
	R CMD INSTALL stats101_1.0-1.tar.gz
	Rscript --default-packages=stats101 -e 'stats101_setup()'

# take current state of git repo and build all
# note: if changes aren't committed they won't be seen in this
# test

test_build:
	-mkdir _build_tmp
	git archive HEAD |  gzip > _build_tmp/datascience101.tar.gz
	cd _build_tmp; tar -xvzf datascience101.tar.gz;	make zip; make all
	rm -fr _build_tmp
