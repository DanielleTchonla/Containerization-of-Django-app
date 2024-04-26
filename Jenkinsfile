pipeline {
    agent any 
    
    stages{
        stage("Clone Code"){
            steps {
                echo "Cloning the code"
                git url:"https://github.com/DanielleTchonla/Containerization-of-Django-app.git", branch: "main"
            }
        }
        stage("Build"){
            steps {
                echo "Building the image"
                sh "docker build -t my-note-app ."
            }
        }
        stage("Push to Docker Hub"){
             steps {
                withDockerRegistry([ credentialsId: "Docker", url: "https://index.docker.io/v1/" ]) {
                    sh "docker push danielletchonla/my-note-app:latest"
                }
            }

        }
        stage("Deploy"){
            steps {
                echo "Deploying the container"
                sh "docker-compose down && docker-compose up -d"
                
            }
        }
    }
}
