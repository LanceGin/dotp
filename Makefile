
build: lib/*dart test/*dart deps
	dartanalyzer --fatal-warnings lib/
	dartfmt -n --set-exit-if-changed lib/ test/
	pub run test_coverage

deps: pubspec.yaml
	pub get

reformatting:
	dartfmt -w lib/ test/

build-local: reformatting build
	genhtml -o coverage coverage/lcov.info
	open coverage/index.html

publish:
	pub publish