.PHONY: coscript clean
default: coscript;

clean:
	xcodebuild clean

coscript: clean
	xcodebuild -target "coscript tool"