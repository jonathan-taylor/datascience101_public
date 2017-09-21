MODULE = visualization

%.built : %.Rmd
	python ${TOOLS_DIR}/build_slides.py $<

built_objects := $(patsubst %.Rmd,%.built,$(wildcard *.Rmd))

.PHONY: all

all: ${built_objects}
	-mkdir -p $(BUILD_DIR)/$(MODULE)
	-cp $(MODULE)*pdf $(MODULE)*html $(BUILD_DIR)/$(MODULE)
