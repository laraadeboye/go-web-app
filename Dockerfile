 # Stage 1:  Build the app

 FROM golang:1.22.5 AS builder

 WORKDIR /app

    # Copy go.mod files
 COPY go.mod ./

    # Download all dependencies
 RUN go mod download

    # Copy the source code
 COPY . .

    # Build the application

 RUN go build -o main .


    # Stage 2:  Build the distroless app

 FROM gcr.io/distroless/base

    # Copy the binary from the previous stage
 COPY --from=builder /app/main .

    # Copy static files from the previous stage
 COPY --from=builder /app/static ./static

    # Expose the port on which the application will run
 EXPOSE 8080

    # Command to run the application
 CMD ["./main"]
