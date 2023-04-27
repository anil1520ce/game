pipeline 
{
    agent any 
    environment 
    {
     DOCKER_REPO_NAME = 'game'
     APP_SERVER_IP = '172.31.89.102'
     APP_SERVER_USERNAME = 'root'
     CONTAINER_NAME = 'bird-game'
     CONTAINER_PORT = '1050'

    }
    stages 
    {

        stage ('checkout src')
        {
            steps
            { 
                checkout scm
            }
        }
        stage ('Build docker') 
        {
            steps
            {
                sh 'docker build -t game:${BUILD_NUMBER} .'
            }

        }
        stage ('Push') 
        {
            steps
            {
               withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'DOCKER_HUB_PASSWORD', usernameVariable: 'DOCKER_HUB_USERNAME')]) 
                {
                    sh "echo ${DOCKER_HUB_PASSWORD} | docker login --username ${DOCKER_HUB_USERNAME} --password-stdin"
                    sh "docker tag game:${BUILD_NUMBER} ${DOCKER_HUB_USERNAME}/${DOCKER_REPO_NAME}:${BUILD_NUMBER}"
                    sh "docker push ${DOCKER_HUB_USERNAME}/${DOCKER_REPO_NAME}:${BUILD_NUMBER}"
                }
            }
                    
        }

        stage ('Deploy')
        {
            steps
            {   
                withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'DOCKER_HUB_PASSWORD', usernameVariable: 'DOCKER_HUB_USERNAME')]) 
                {
                    sh "echo ${DOCKER_HUB_PASSWORD} | docker login --username ${DOCKER_HUB_USERNAME} --password-stdin"
                    
                sshagent(['app-server-credentials']) 
                {
                    sh "ssh ${APP_SERVER_USERNAME}@${APP_SERVER_IP} 'docker pull ${DOCKER_HUB_USERNAME}/${DOCKER_REPO_NAME}:${BUILD_NUMBER}'"
                    sh "ssh ${APP_SERVER_USERNAME}@${APP_SERVER_IP} 'docker stop ${CONTAINER_NAME} || true && docker rm ${CONTAINER_NAME} || true'"
                    sh "ssh ${APP_SERVER_USERNAME}@${APP_SERVER_IP} 'docker run -d --name ${CONTAINER_NAME} -p ${CONTAINER_PORT}:${CONTAINER_PORT} ${DOCKER_HUB_USERNAME}/${DOCKER_REPO_NAME}:${BUILD_NUMBER}'"
                }
                }
      
            }

        }
        
    }  
}

