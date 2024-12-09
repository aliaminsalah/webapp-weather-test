# Use Python slim image
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Copy application code
COPY . .

# Install dependencies (if any)
RUN pip install --no-cache-dir -r requirements.txt

# Expose the port used by the app
EXPOSE 5000

# Command to run the application
CMD ["python3", "app.py"]
