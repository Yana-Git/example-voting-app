set -ex


  echo "cypress directory exists, just pulling the latest code"
  cd voting_app_cypress && git pull && cd -

  # I think we can comment out below two lines
  touch cypress.json
  echo {} > cypress.json

