pipeline {
  agent {
    dockerfile {
      filename 'ci/ci.dockerfile'
    }
  }

  environment {
      GIT_ORG = 'asurraa'
      PROJECT_NAME = 'good-neighbors-system'
      SERVER = '194.233.70.51'
      BRANCH = 'dev'
      ENV_MODE = 'dev'
      NPM_TOKEN = credentials('NPM_TOKEN')
  }

  stages {
    // stage('Install Private Registry') {
    //   steps {
    //     // sh 'echo @asurraa:registry=https://npm.pkg.github.com >> ~/.npmrc'
    //     // sh 'echo //npm.pkg.github.com/:_authToken=${NPM_TOKEN} >> ~/.npmrc'
    //     sh 'npm set registry "https://npm.pkg.github.com"'
    //     sh 'npm set //npm.pkg.github.com/:_authToken=${NPM_TOKEN}'
    //     sh 'npm whoami'
    //   }
    // }

    stage('Install dependency') {
      steps {
        sh '''
          NPM_TOKEN=${NPM_TOKEN} yarn install
          '''
      }
    }

    // stage('Build') {
    //   parallel {
    //     stage('api') {
    //       steps {
    //         sh 'npx nx build api --prod --verbose'
    //       }
    //     }

    //     stage('Forex') {
    //       steps {
    //         sh 'npx env-cmd -f env/dashboard/dev.env nx build forex --prod --verbose'
    //       }
    //     }
    //   }
    // }

    // stage('rsync ') {
    //   parallel {
    //     stage('thakvika-server') {
    //       steps {
    //         sshagent(credentials: ['asurraa-dev-server']) {
    //           sh 'FROM=./dist TO=/root/temp/${PROJECT_NAME} GIT_ORG=${GIT_ORG} SERVER=${SERVER} BRANCH=${BRANCH} PROJECT_NAME=${PROJECT_NAME} sh ./ci/scripts/rsync.sh'
    //         }
    //       }
    //     }
    //   }
    // }

    // stage('serve') {
    //   parallel {
    //     stage('serve api-server') {
    //       steps {
    //         sshagent(credentials: ['asurraa-dev-server']) {
    //           sh 'SERVER=${SERVER} PROJECT_NAME=${PROJECT_NAME} ENV_MODE=${ENV_MODE} sh ci/scripts/serve-api-pm2.sh'
    //         }
    //       }
    //     }

    //     stage('serve forex') {
    //       steps {
    //         sshagent(credentials: ['asurraa-dev-server']) {
    //           sh 'SERVER=${SERVER} PROJECT_NAME=${PROJECT_NAME} ENV_MODE=${ENV_MODE} sh ci/scripts/serve-dashboard-pm2.sh'
    //         }
    //       }
    //     }
    //   }
    // }
  }
}


