run:
	./scripts/run-web.sh

get:
	cd mobile_app && flutter pub get

analyze:
	cd mobile_app && flutter analyze

test:
	cd mobile_app && flutter test
