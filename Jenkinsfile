pipeline {
    agent {
        docker {
            image 'ibrahimelmsery1/dockerslave'
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
                withCredentials([usernamePassword(credentialsId: 'mo', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
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
