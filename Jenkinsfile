pipeline {
  environment {
      registry = 'rajubothra/devops'
      registryCredential = 'dockerhub_id'
      devcontext = 'dev-swarm'
      prodcontext = 'prod-swarm'
      devnode = '10.0.0.52'
      prodnode = '10.0.0.123'
      dockerImage = ''
  }
  agent any
    stages {
        stage('Building Dev Docker Branch') {
            when {
                expression {
                    return env.BRANCH_NAME != 'master'
                }
            }
            steps {
                script {
                    dockerImage = docker.build registry + ":v$BUILD_NUMBER"
                }
            }
        }
      
      stage('Deploy our image') {

          steps {

              script {

                  docker.withRegistry( '', registryCredential ) {

                      dockerImage.push()

                  }

              }

          }

      }

      stage('Cleaning up') {

          steps {

              sh "docker rmi $registry:v$BUILD_NUMBER"

          }

      }

      stage('deploying to docker swarm') {

          steps {
             sh "docker context use $devcontext"
              sh "docker service rm testing1 || true"
              sh "docker service create --name testing1 -p 8100:80 $registry:v$BUILD_NUMBER"

          }

      }

      stage('verifying the deployment') {

          steps {

              sh 'curl http://$devnode:8100' || exit 1'

          }

      }

  }

