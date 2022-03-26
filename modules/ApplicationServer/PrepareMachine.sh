#!/bin/bash

apt-get update

git clone https://github.com/GuyR53/bootcamp-app.git

# Downloading nodejs libaries
curl -sL https://deb.nodesource.com/setup_14.x | sudo bash - 

apt install nodejs

# Insatalling pm2 
npm install pm2@latest -g

pm2 startup

cd bootcamp-app

sudo env PATH=$PATH:/usr/bin /usr/lib/node_modules/pm2/bin/pm2 startup systemd -u ApplicationServer-1 --hp /home/ApplicationServer-1

pm2 save


cat <<EOF >.env
# Host configuration
PORT=8080
HOST=0.0.0.0

# Postgres
PGHOST=10.0.1.4
PGUSERNAME=postgres
PGDATABASE=postgres
PGPASSWORD=p@ssw0rd42
PGPORT=5432

HOST_URL=http://20.119.127.7:8080
COOKIE_ENCRYPT_PWD=superAwesomePasswordStringThatIsAtLeast32CharactersLong!
NODE_ENV=development

# Okta configuration
OKTA_ORG_URL=https://dev-13456779-admin.okta.com
OKTA_CLIENT_ID=0oa46q4he44WAqF895d7
OKTA_CLIENT_SECRET=ckXD4trTJeUWLnuVti5l4AtzfwZHemdC20CUje_4


EOF

npm init -y

npm install @hapi/hapi@19 @hapi/bell@12 @hapi/boom@9 @hapi/cookie@11 @hapi/inert@6 @hapi/joi@17 @hapi/vision@6 dotenv@8 ejs@3 postgres@1

npm install --save-dev nodemon@2



# Initializing the data base
npm run initdb 


pm2 start "npm run dev" --name MyApp 

