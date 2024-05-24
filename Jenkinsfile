pipeline {
    agent any

    environment {
        DOCKER_REGISTRY_CREDENTIALS = 'DockerHubCred'
        DOCKER_IMAGE_NAME = 'nikhilguptaiiitb/spe_backend'
    }

    stages {
        stage('Clone Repository') {
            steps {
                checkout([
                    $class: 'GitSCM',
                    branches: [[name: '*/main']],
                    doGenerateSubmoduleConfigurations: false,
                    extensions: [],
                    submoduleCfg: [],
                    userRemoteConfigs: [[url: 'https://github.com/nikhilgupta221b/SPEFinalProject.git']]
                ])
            }
        }

        stage('Build') {
            steps {
                dir('/var/lib/jenkins/workspace/') {
                    sh 'mvn clean package'
                }
            }
        }

        stage('Run Tests') {
            steps {
                dir('/var/lib/jenkins/workspace/') {
                    sh 'mvn test'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                dir('/var/lib/jenkins/workspace/') {
                    script {
                        docker.build("${DOCKER_IMAGE_NAME}", '.')
                    }
                }
            }
        }

        stage('Push Docker Image') {
            steps {
            dir('/var/lib/jenkins/workspace/') {
                    script {
                        docker.withRegistry('', 'DockerHubCred') {
                            sh "docker tag ${DOCKER_IMAGE_NAME}:latest ${DOCKER_IMAGE_NAME}:latest"
                            sh "docker push ${DOCKER_IMAGE_NAME}:latest"
                        }
                    }
                }
            }
        }

        stage('Deploy with Ansible') {
            steps {
                dir('/var/lib/jenkins/workspace/') {
                    script {
                        ansiblePlaybook(
                            playbook: 'ansibledeploy/deploy.yml',
                            inventory: 'ansibledeploy/inventory'
                        )
                    }
                }
            }
        }
    }
}
