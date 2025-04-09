FROM alpine

# Install curl and ca-certificates without cache
RUN apk add --no-cache curl ca-certificates

# Set environment variables
ENV GH_TOKEN=""
ENV cs_name=""

# Copy the start script
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Run the script
ENTRYPOINT ["/start.sh"]
