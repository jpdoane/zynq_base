
all: pl ps

pl:
	make -C pl bitfile

ps:
	make -C ps all

run: pl
	make -C ps run


.PHONY: all run pl ps clean
clean:
	make -C pl clean
	make -C ps clean
	