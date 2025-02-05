pipeline {
    agent {
        docker {
            image 'jenkins/agent'
            args '-v /var/run/docker.sock:/var/run/docker.sock'
        }
    }
    stages {
        stage('prep') {
            steps {
                git 'https://github.com/ibrahim-reda-2001/jenkins-node_project.git'
            }
        }
        stage('ci') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-cred', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    sh """
                    docker build . -f dockerfile -t ibrahimelmsery1/iti-lab
                    echo \$PASSWORD | docker login -u \$USERNAME --password-stdin
                    docker push ibrahimelmsery1/iti-lab
                    """
                }
            }
        }
        stage('cd') {
            steps {
                script {
                    try {
                        sh """
                            # Remove existing container if it exists
                            docker rm -f node-project || true
                            
                            # Run new container
                            docker run -d -p 3000:3000 --name node-project ibrahimelmsery1/iti-lab
                            
                            # Check if container is running
                            if ! docker ps | grep -q node-project; then
                                exit 1
                            fi
                        """
                    } catch (Exception e) {
                        sh """
                            docker stop node-project || true
                            docker rm node-project || true
                        """
                        throw e
                    }
                }
            }
        }
    }
    post {
        cleanup {
            cleanWs()
        }
    }
}
/******************/
pipeline {
    agent {
        docker {
            image 'jenkins/agent'
            args '-v /var/run/docker.sock:/var/run/docker.sock'
        }
    }
    stages {
        stage('prep') {
            steps {
                git 'https://github.com/ibrahim-reda-2001/jenkins-node_project.git'
            }
        }
        stage('ci') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-cred', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    sh """
                    docker build . -f dockerfile -t ibrahimelmsery1/iti-lab
                    echo \$PASSWORD | docker login -u \$USERNAME --password-stdin
                    docker push ibrahimelmsery1/iti-lab
                    """
                }
            }
        }
        stage('cd') {
            steps {
                sh """
                docker run -d -p 3000:3000 --name node-project ibrahimelmsery1/iti-lab
                """
            }
        }
    }
    post {
        cleanup {
            cleanWs()
        }
    }
}
