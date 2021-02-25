set -x

cd voting_app_cypress

npm install
npx cypress run

cd -
