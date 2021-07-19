FROM klakegg/hugo:latest as backend

ARG GIT_BRANCH

ADD . /build
WORKDIR /build
#RUN apk add --no-cache --update git tzdata ca-certificates
# TODO: -D for draft build
RUN hugo

#RUN \
#    version=${GIT_BRANCH}-$(date +%Y%m%dT%H:%M:%S) && \
#    echo "version=$version" && \
#    cd cmd/app && \
#    go build -o /build/rp -ldfl ags "-X main.revision=${version} -s -w"

FROM umputun/reproxy:latest
COPY --from=backend /build/public /public
ENV ASSETS_LOCATION=/public
WORKDIR /public