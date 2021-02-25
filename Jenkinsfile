def remote = [:]
remote.name = 'web server'
remote.host = '45.32.246.10'
remote.user = 'root'
remote.password = '5Ns]RP6Ah?xK5Nd='
remote.allowAnyHosts = true
pipeline {
  agent any
  
  environment {
    DISABLE_AUTH = 'true'
    DB_ENGINE    = 'sqlite'
  }
  
  stages {
    stage('Static Check') {
      steps {
        sh 'echo Static Check'
      }
    } 
    stage('Unit Testing') {
      steps {
        sh 'echo Unit Testing'
      }
    }
    stage('Cypress Integration Testing') {
      steps {
        sh 'echo Start Cypress Integration Testing'
        sh './getCypressCode.sh'
        sh './executeCypressTest.sh'
     }
    }
    stage('Build Result Image') {
      steps {
        sh 'printenv'
        sh 'docker build -t yana96docker/result ./result'
        echo 'Build result completed'
      }
    } 
    stage('Build Vote Image') {
      steps {
        sh 'docker build -t yana96docker/vote ./vote'
      }
    }
    stage('Build Worker Image') {
      steps {
        sh 'docker build -t yana96docker/worker ./worker'
      }
    }
    stage('E2E Testing') {
      steps {
        parallel(
          Chrome: {
            echo "Running E2E Testing on Chrome"
          },
          Firefox: {
            echo "Running E2E Testing on Firefox"
          },
          Safari: {
            echo "Running E2E Testing on Safari"
          }
        )
      }    
    } 
    stage('Push Result Image') {
      when {
        expression {
          return env.GIT_BRANCH == "origin/master"
        }
      }
      steps {
        withDockerRegistry(credentialsId: 'yanatest', url:'') {
          sh 'docker push yana96docker/result'
        }
      }
    }
    stage('Push Vote Image') {
      when {
        expression {
          return env.GIT_BRANCH == "origin/master"
        }
      }
      steps {
        withDockerRegistry(credentialsId: 'yanatest', url:'') {
          sh 'docker push yana96docker/vote'
        }
      }
    }
    stage('Push Worker Image') {
      when {
        expression {
          return env.GIT_BRANCH == "origin/master"
        }
      }
      steps {
        withDockerRegistry(credentialsId: 'yanatest', url:'') {
          sh 'docker push yana96docker/worker'
        }
      }
    }
    stage('Deployment') {
      steps {
        sshCommand remote: remote, command: 
        "cd /home/don/projects/example-voting-app && " +
        "git pull && " +
        "docker-compose pull && " +
        "docker-compose down && " +
        "docker-compose up -d && " + 
        "docker-compose ps" 
      }
    }
  }
}
