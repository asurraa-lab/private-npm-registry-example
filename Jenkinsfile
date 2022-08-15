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
         env && yarn install 
          '''
      }
    }

    stage('install with pnpm ') {
      steps {
        sh 'env && pnpm import && pnpm install'
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