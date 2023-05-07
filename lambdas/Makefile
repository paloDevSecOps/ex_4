.PHONY: build clean deploy

build:
	cd ./hello && env GOARCH=amd64 GOOS=linux go build -ldflags="-s -w" -o bin/hello ./main.go && cd ..
	cd ./world && env GOARCH=amd64 GOOS=linux go build -ldflags="-s -w" -o bin/world ./main.go && cd ..

clean:
	rm -rf ./bin

deploy: clean build
	sls deploy --verbose
