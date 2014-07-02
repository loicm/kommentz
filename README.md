# kommentz

## Docker usage

```bash
# Build image
sudo docker build -t <username>/kommentz .

# Run container
sudo docker rm kommentz
sudo docker run -d -t -p 49001:80 --name kommentz -v $(pwd):/var/www/kommentz <username>/kommentz
```