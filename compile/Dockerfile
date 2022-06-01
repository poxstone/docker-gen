# build
FROM ubuntu:18.04 as builder
WORKDIR /app 
RUN date > date.txt

# copied
FROM alpine
WORKDIR /app
COPY --from=builder /app/date.txt ./
RUN cat date.txt