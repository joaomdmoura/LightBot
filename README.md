# LightBot

This is a bot to integrate Lighthouse with Github Pull Requests.

If you don't know what lighthouse is you should check this [google presentation](https://developers.google.com/web/tools/lighthouse/).

The TLDR version is;
It's a tool that audits web pages check and rating performance, accessibility, and more.

The main motivation of this library is to help people to perform quick comparisons between two URL performances within PRs, this might be helpful to check if the code of that PR increases or decreases overall perfomance when compared to production.

![Image of LightBot](https://imgur.com/7iXEgjX.png)

- [Setup](#setup)
- [Starting LightBot](#starting-lightbot)
- [Using it](#using-it)

----------------

## Setup

- Clone this repository to an server
- Install dependencies
  - Ruby
  - Bundler
  - Redis
  - Lighthouse (npm package)
- Install gems with `bundle install`
- Set two env variables `GH_USERNAME` and `GH_PASSWORD`
- Make sure the Github user is watching the repositories you want.

## Starting LightBot

Once everything is properly set all you need to do is to start `sideikiq` for the `\workers\*` folder.
You might want to start is a deamon. Make sure you run it within the main folder of the project.

Example.
```
sidekiq  -C config/sidekiq.yml -r ./workers/* -d -L sidekiq.log
```

This will start `sidekiq` using the correct config, as deamon, and put the logs into `sidekiq.log`.

## Using it

To use it mention `@lightbot` on a PR with two URLs you want it to compare.
**Make sure the github account is watching the repository.**

```@lightbot run http://staging.joaomdmoura.com http://joaomdmoura.com```

Lightbot uses polling to catch new mentions, so it might take up to 5 minutes for it to leave a comment on the PR with the reuslts.
