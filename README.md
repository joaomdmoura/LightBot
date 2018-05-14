# Lighthouse Bot

This is a bot to integrate Lighthouse with Github Pull Requests.

If you don't know what lighthouse is you should check this [google presentation](https://developers.google.com/web/tools/lighthouse/).

The TLDR version is;
It's a tool that audits web pages check and rating performance, accessibility, and more.

----------------

## How to setup

- Clone this repository to an server
- Install dependencies
  - Ruby
  - Bundler
  - Redis
- Install gems with `bundle install`
- Set two env variables `GH_USERNAME` and `GH_PASSWORD`
- Make sure the Github user is watching the repositories you want.

## Starting Lighthouse Bot

Once everything is properly set all you need to do is to start `sideikiq` for the `\workers\*` folder.
You might want to start is a deamon. Make sure you run it within the main folder of the project.

Example.
```
sidekiq  -C config/sidekiq.yml -r ./workers/* -d -L sidekiq.log
```

This will start `sidekiq` using the correct config, as deamon, and put the logs into `sidekiq.log`.