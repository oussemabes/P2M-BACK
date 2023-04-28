pipeline {
    agent any
    tools {
        nodejs 'nodejs-19'
    }
    parameters {
        choice(name: 'DOCKER_REGISTRY', choices: ['Docker Hub', 'Amazon ECR'], description: 'Choose the Docker registry to push the image to')
        choice(name: 'DEPLOY_TO', choices: ['EC2', 'K8S'], description: 'Choose where to deploy')
    }
    environment {
        SERVER_ADDRESS = ''
        SERVER_USERNAME = 'ec2-user'
        JENKINS_SERVER_ADDRESS = '3.123.129.244'
        JENKINS_SERVER_USERNAME = 'ec2-user'
        DB_PORT = '3306'
        DB_HOST = '52.29.69.117'
        DB_USER = 'besbes'
        DB_PASSWORD = 'letmein'
        DB_DATABASE = 'auctiondb'
        DOCKER_IMAGE_NAME = 'mahdiboudaouara/nodeappimage'
        PROJECT_NAME = 'server'
        REPO_SERVER = '739761511001.dkr.ecr.eu-central-1.amazonaws.com'
        ECR_REGISTRY = '739761511001.dkr.ecr.eu-central-1.amazonaws.com/ecr-mahdi'
        APP_URL = '139-144-162-115.ip.linodeusercontent.com'
        AWS_REGION = 'eu-central-1'
    }
    stages {
        // stage('Install Dependencies') {
        //     steps {
        //         sh 'npm install'
        //     }
        // }
        stage('increment version') {
            steps {
                script {
                    echo 'incrementing app version...'
                    sh 'npm version patch --no-git-tag-version --allow-same-version'
                    def version = sh(returnStdout: true, script: 'npm version')
                    def versionProps = readJSON text: version
                    env.IMAGE_TAG = "${versionProps[env.PROJECT_NAME]}-${BUILD_NUMBER}"
                }
            }
        }
        // stage('Test') {
        //     steps {
        //         sh 'DB_HOST=${DB_HOST} DB_PORT=${DB_PORT} DB_USER=${DB_USER}  DB_PASSWORD=${DB_PASSWORD} DB_NAME=${DB_DATABASE} npm test'
        //     }
        // }
        stage('Build') {
            steps {
                sh 'docker build -t ${DOCKER_IMAGE_NAME}:${IMAGE_TAG} .'
            }
        }
        stage('Push Image') {
            steps {
                script {
                    if (params.DOCKER_REGISTRY == 'Docker Hub') {
                        sh 'docker build -t ${DOCKER_IMAGE_NAME}:${IMAGE_TAG} .'
                        // Push the image to Docker Hub
                        withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
                            sh "echo $PASS | docker login -u $USER --password-stdin"
                            sh "docker push ${DOCKER_IMAGE_NAME}:${IMAGE_TAG}"
                        }
                    } else {
                        sh 'docker build -t ${ECR_REGISTRY}:${IMAGE_TAG} .'
                        // Push the image to Amazon ECR
                        withCredentials([usernamePassword(credentialsId: 'ecr-credentials', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
                            sh "echo $PASS | docker login --username $USER --password-stdin ${REPO_SERVER}"
                            sh "docker push ${ECR_REGISTRY}:${IMAGE_TAG}"
                        }
                    }
                }
            }
        }
        stage('Deploy') {
            when {
                branch 'main'
            }
            steps {
                script {
                    if (params.DEPLOY_TO == 'EC2') {
                        def shellCmd = "bash ./server-cmds-node.sh ${DOCKER_IMAGE_NAME} ${IMAGE_TAG}"
                        sshagent(['ec2-server-key']) {
                            sh "scp -o StrictHostKeyChecking=no server-cmds-node.sh ${SERVER_USERNAME}@${SERVER_ADDRESS}:/home/${SERVER_USERNAME}"
                            sh "scp -o StrictHostKeyChecking=no docker-compose-node.yml ${SERVER_USERNAME}@${SERVER_ADDRESS}:/home/${SERVER_USERNAME}"
                            sh "ssh -o StrictHostKeyChecking=no ${SERVER_USERNAME}@${SERVER_ADDRESS} ${shellCmd}"
                        }
                    } else {
                        withKubeConfig([credentialsId: 'clusterkubeconfig', serverUrl: 'https://c81ac799-c9ef-4da4-9d8a-872d8e6400c8.eu-central-2.linodelke.net']) {
                            sh 'envsubst < kubernetes/deployment.yaml | kubectl apply -f -'
                            sh 'envsubst < kubernetes/service.yaml | kubectl apply -f -'
                        }
                    }
                }
            }
        }

        stage('commit version update') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'github', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
                        // git config here for the first time run
                        sh 'git config --global user.email "mahdijenkins@jenkins.com"'
                        sh 'git config --global user.name "mahdijenkins"'
                        sh "git remote set-url origin https://${USER}:${PASS}@github.com/Mahdiboudaouara/serverP2M.git"
                        sh 'git add .'
                        sh 'git commit -m "ci: version bump"'
                        sh "git push origin HEAD:${BRANCH_NAME}"
                    }
                }
            }
        }
    }
    post {
        always {
            cleanWs()
        }
    }
}
