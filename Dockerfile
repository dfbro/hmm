FROM alpine

# Install curl and ca-certificates without cache
RUN apk add --no-cache curl ca-certificates

# Set environment variables
ENV GH_TOKEN=""
ENV cs_name=""

# Create /etc/resolv.conf with Cloudflare DNS
RUN echo 'nameserver 1.1.1.1\nnameserver 1.0.0.1' > /etc/resolv.conf

# Copy the start script
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Run the script
ENTRYPOINT ["/start.sh"]
