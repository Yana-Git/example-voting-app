set -ex

if [ ! -d "./BigCommerce" ]; then
  echo "cloning cypress code..."
  git clone https://github.com/Yana-Git/BigCommerce.git
else
  echo "cypress directory exists, just pulling the latest code"
  cd BigCommerce && git pull && cd -

  # I think we can comment out below two lines
  touch cypress.json
  echo {} > cypress.json
fi
