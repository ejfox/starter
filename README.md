# Starter Template
This is a basic but opinionated starting point for prototyping apps, with an emphasis on data handling and visualization.

# Getting started
## Clone project into new folder
`git clone https://github.com/ejfox/starter.git project-slug-name`
`cd project-slug-name`

## Configure with init or edit by hand

### Initilization
For the quickest start, you can run `gulp init` to perform basic project starting actions.

```coffeescript
exec 'rm -rf .git'
exec 'git init'
exec 'rm README.md'
exec 'touch README.md'
exec 'atom .'
exec 'npm install'
exec 'gulp config'
```

Run `gulp config` for configuration walkthrough or edit `options.json` by hand

### Modifying the project
Edit coffeescript in `src/coffee/app.coffee`

Edit HTML in `src/tmpl/index.mustache`

Edit Stylus (CSS) in `src/styl/style.styl`

### Updating data
The default place for storing data is `data/data.csv`

If you have set `project.googledatakey` in `options.json` you can run `gulp getdata` to download that sheet using curl to `data/data.csv`

### Publishing
The `/build/` folder is a standalone client-side web app with everything packaged. It can be put on a webserver or uploaded to a site like Netlify.

If you have set `project.s3bucket` in `options.json` and set your S3 credentials by renaming `.env-example` and filling it out you can run `gulp s3publish` to publish to an S3 bucket, and update the data in the project by running `gulp s3publishdata` – you need to run both commands on first upload

To publish to github pages you can run `gulp gh-pages`
