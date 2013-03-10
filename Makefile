IN_MD=$(wildcard input/*.md)
OUT_HTML=$(IN_MD:input/%.md=output/%.html)

.PHONY: all deploy clean

all: output
all: ${OUT_HTML}

output/%.html: %.html
	cat top.template > $@
	cat $< | tail -n +10 | head -n -2 >> $@
	cat btm.template >> $@
	rm $<

%.html: input/%.md
	pandoc --from markdown --to html --standalone $< --output $@

deploy: all
	cp -rv output/* /var/www/

output:
	mkdir -p output

clean:
	- rm -f output/*.html
