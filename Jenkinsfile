pipeline {
    agent any 
    stages {
        stage("Clone Code") {
            steps {
                echo "Cloning the code"
                git url: "https://github.com/DanielleTchonla/Containerization-of-Django-app.git", branch: "main"
            }
        }

        stage("Build") {
            steps {
                script {
                    try {
                        echo "Building the Docker image..."
                        sh "docker build -t my-note-app:latest ." // Explicitly tag with 'latest'
                    } catch (Exception e) {
                        // Catch any errors that occur during the build step
                        echo "Error building the Docker image: ${e.message}"
                        currentBuild.result = 'FAILURE' // Mark the build as failed
                        error("Build failed")
                    }
                }
            }
        }

        stage("Push to Docker Hub") {
            stage("Push to Docker Hub"){
            steps {
                echo "Pushing the image to docker hub"
                withCredentials([usernamePassword(credentialsId:"Docker",passwordVariable:"dockerHubPass",usernameVariable:"dockerHubUser")]){
                sh "docker tag my-note-app ${env.dockerHubUser}/my-note-app:latest"
                sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPass}"
                sh "docker push ${env.dockerHubUser}/my-note-app:latest"
                }
            }
        }
        }

        stage("Deploy") {
            steps {
                echo "Deploying the container"
                sh "docker-compose down && docker-compose up -d"
            }
        }
    }
}

