pipeline 
{
    agent any 
    environment 
    {
     DOCKER_REPO_NAME = 'game'

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
               withCredentails([usernamePassword(credentialsID: 'dockerhub', passwordVariable: 'DOCKER_HUB_PASSWORD', usernameVariable: 'DOCKER_HUB_USERNAME')]) {
                        sh "docker login -u ${DOCKER_HUB_USERNAME} -p ${DOCKER_HUB_PASSWORD}"
                        sh "docker tag game:${BUILD_NUMBER} ${DOCKER_HUB_USERNAME}/${DOCKER_REPO_NAME}:${BUILD_NUMBER}"
                        sh "docker push ${DOCKER_HUB_USERNAME}/${DOCKER_REPO_NAME}:${BUILD_NUMBER}"
               }
            }
                    
        }

    }
        
}  


