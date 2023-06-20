# Build the manager binary
FROM golang:1.20.3 as builder

WORKDIR /source
# Copy the Go Modules manifests
COPY go.mod go.mod
COPY go.sum go.sum
# Cache deps before building and copying source so that we don't need to re-download
# as much and so that source changes don't invalidate our downloaded layer
RUN go mod download

# Copy source code
COPY server.go server.go
COPY graph/ graph/
COPY internal/ internal/
COPY pkg/ pkg/

# Build
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -o server server.go

FROM scratch
COPY --from=builder /source/internal /internal
COPY --from=builder /source/server /server
CMD ["/server"]
