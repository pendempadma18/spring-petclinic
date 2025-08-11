FROM maven:3.9.11-eclipse-temurin-17 AS build
RUN apt install git
RUN git clone https://github.com/pendempadma18/spring-petclinic.git && \
    cd spring-petclinic && \
    mvn package

FROM amazoncorretto:17 AS run
RUN adduser -m -d /usr/share/demo -s /bin/bash testuser
USER testuser
WORKDIR /usr/share/demo
COPY --from=build /spring-petclinic/target/*.jar name.jar
EXPOSE 8080/tcp
CMD ["java","-jar", "name.jar"]
