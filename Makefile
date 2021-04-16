
build: lib/*dart test/*dart deps
	dartanalyzer --fatal-warnings lib/
	dartfmt -n --set-exit-if-changed lib/ test/
	pub run test_coverage

deps: pubspec.yaml
	pub get

format:
	dartfmt -w lib/ test/

build-local: format build check-publish
	genhtml -o coverage coverage/lcov.info
	open coverage/index.html

check-publish:
	pub publish -n

publish:
	pub publish