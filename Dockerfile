# https://hub.docker.com/_/golang/
FROM golang:1.15.8-alpine3.12 AS builder
RUN apk --update --no-cache add git

ENV GO111MODULE=on
ENV GOPROXY=https://goproxy.cn,direct

RUN go get -u github.com/swaggo/swag/cmd/swag
RUN go get -u github.com/reviewdog/reviewdog/cmd/reviewdog


#
FROM golangci/golangci-lint:v1.36-alpine
RUN apk --update --no-cache add make

COPY --from=builder /go/bin/swag /go/bin
COPY --from=builder /go/bin/reviewdog /go/bin
