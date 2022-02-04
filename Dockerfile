
FROM ubuntu:20.04 AS base
RUN apt-get update
RUN DEBIAN_FRONTEND='noninteractive' apt-get install nodejs npm -y
COPY ./nodesource_setup.sh .
RUN bash nodesource_setup.sh
RUN apt-get install nodejs -y
EXPOSE 80


FROM base AS build
WORKDIR /src
COPY ./nodesource_setup.sh .
RUN bash nodesource_setup.sh
RUN apt-get install nodejs -y
RUN apt-get install build-essential -y
COPY . .
WORKDIR /src/frontend
RUN npm install
RUN npm run build
WORKDIR /src/backend
RUN npm install --ignore-engines
# WORKDIR /src/admin
# RUN npm install


FROM base as final
WORKDIR /app/frontend/dist
COPY --from=build /src/frontend/dist .
WORKDIR /app/admin
COPY --from=build /src/admin .
WORKDIR /app/backend
COPY --from=build /src/backend .
ENTRYPOINT ["node", "app"]
#ENTRYPOINT ["/bin/sh"]