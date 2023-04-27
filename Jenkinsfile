pipeline {
    agent 
    environment 
    {
     DOCKER_HUB_USERNAME = credentials( 'docker-hub-username')
     DOCKER_HUB_PASSWORD = credentials( 'docker-hub-password')
     DOCKER_REPO_NAME = 'game'

    }
    stages{
        stage (checkout src) {
            steps{ 
                    checkout scm
                }
            }
        stage (Build docker) {
            steps {
                    sh 'docker built -t game:${BUILD_NUMBER} .'
                }

            }
        stage (Push) {
            steps {
               withCredentails([usernamePassword(credentialsID: 'docker-hub-credentials', passwordVariable: 'DOCKER_HUB_PASSWORD', usernameVariable: 'DOCKER_HUB_USERNAME')]) {
                        sh "docker login -u ${DOCKER_HUB_USERNAME} -p ${DOCKER_HUB_PASSWORD}"
                        sh "docker tag game:${BUILD_NUMBER} ${DOCKER_HUB_USERNAME}/${DOCKER_REPO_NAME}:${BUILD_NUMBER}"
                        sh "docker push ${DOCKER_HUB_USERNAME}/${DOCKER_REPO_NAME}:${BUILD_NUMBER}"
                    }
                    
                }

            }
        
        }  
   }
