SOURCES := index.md
TARGETS := $(patsubst %.md,%.html,$(SOURCES))

STYLES := \
	pub/tufte-css/tufte.css \
	pub/tufte-pandoc-css/pandoc.css \
	pub/tufte-pandoc-css/pandoc-solarized.css \
	pub/tufte-pandoc-css/tufte-extra.css \
	style/style.css

TMPL := pub/tufte.html5

.PHONY: all
all: $(TARGETS)

%.html: $(SOURCES) $(TMPL) $(STYLES) style
	mkdir -p out
	pandoc \
		--toc \
		--section-divs \
		--katex \
		--from markdown+tex_math_single_backslash \
		--filter pandoc-sidenote \
		--to html5+smart \
		--template=$(TMPL) \
		$(foreach style,$(STYLES),--css style/$(notdir $(style))) \
		--output out/$@ \
		$<

.PHONY: clean
clean:
	rm -rf out

.PHONY: style
style:
	mkdir -p out/style
	test -L out/img || ln -sf ../img out/img
	rsync -aPvi \
		$(STYLES) \
		pub/tufte-css/latex.css \
		pub/tufte-css/et-book/ \
		out/style
