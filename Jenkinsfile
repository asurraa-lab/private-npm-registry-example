pipeline {
  agent {
    dockerfile {
      filename 'ci/ci.dockerfile'
    }

  }
  stages {
    stage('Install dependency') {
      steps {
        sh '''
          yarn install 
          '''
      }
    }

  }
  environment {
    GIT_ORG = 'asurraa'
    PROJECT_NAME = 'good-neighbors-system'
    SERVER = '194.233.70.51'
    BRANCH = 'dev'
    ENV_MODE = 'dev'
    NPM_TOKEN = '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'
  }
}