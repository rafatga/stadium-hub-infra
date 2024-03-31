bootup:
	./ops/scripts/bootstrap.sh

#build-start: build start

build:
	./ops/scripts/build.sh

start: docker-shared-network-connect
	./ops/scripts/start.sh

stop:
	./ops/scripts/stop.sh

enter:
	./enter.sh ${COMPONENT}


docker-shared-network-connect:
	@./ops/scripts/docker-shared-netwrok.sh