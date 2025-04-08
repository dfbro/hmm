FROM alpine

# Install curl and ca-certificates without cache
RUN apk add --update --no-cache curl ca-certificates

# Set environment variables (defaults can be overridden at runtime)
ENV GH_TOKEN=""
ENV cs_name=""

# Copy the start script into the image
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Set the script as the entrypoint
ENTRYPOINT ["/start.sh"]
