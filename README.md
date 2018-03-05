# Starter Template
This is a basic but opinionated starting point for prototyping apps, with an emphasis on data handling and visualization.

# Getting started

`git clone https://github.com/ejfox/starter.git PROJECT-NAME`

`cd PROJECT-NAME`

Run `gulp init` to open atom, remove the `.git` folder, remove the default `README.md`, and run `npm install`

`npm start` to start gulp

Run `gulp config` for configuration walkthrough or edit `options.json` by hand

Edit coffeescript in `src/coffee/app.coffee`

Edit HTML in `src/tmpl/index.mustache`

Edit Stylus (CSS) in `src/styl/style.styl`

If you have set `project.googledatakey` in `options.json` you can run `gulp getdata` to download that sheet using curl to `data/data.csv`

If you have set `project.s3bucket` in `options.json` and set your S3 credentials by renaming `.env-example` and filling it out you can run `gulp s3publish` to publish to an S3 bucket

You can just upload or update the data on the S3 bucket by running `gulp s3publishdata`

To publish to github pages you can run `gulp github`
