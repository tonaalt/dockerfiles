#!/bin/bash
# This simple script will go thru all the docker files in the folder, 
# and builds them with local registery tag, and pushes them to registery

# Directory containing subdirectories with Dockerfiles
DOCKERFILES_DIR="."

# Local registry address
REGISTRY_ADDRESS="10.103.6.20:5000"

# Navigate to the dockerfiles directory
cd "$DOCKERFILES_DIR"

# Loop through each subdirectory
for DIR in */ ; do
    # Remove trailing slash to get the container name
    CONTAINER_NAME="${DIR%/}"

    echo "Building image for $CONTAINER_NAME..."

    # Build the Docker image
    docker build -t "$REGISTRY_ADDRESS/$CONTAINER_NAME:latest" "$DIR"

    # Check if build was successful
    if [ $? -eq 0 ]; then
        echo "Successfully built $CONTAINER_NAME. Pushing to registry..."

        # Push the image to the local registry
        docker push "$REGISTRY_ADDRESS/$CONTAINER_NAME:latest"

        # Check if push was successful
        if [ $? -eq 0 ]; then
            echo "Successfully pushed $CONTAINER_NAME to the registry."
        else
            echo "Failed to push $CONTAINER_NAME to the registry."
        fi
    else
        echo "Failed to build image for $CONTAINER_NAME."
    fi
done

echo "Processing complete."
