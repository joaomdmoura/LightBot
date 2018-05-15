require 'octokit'
require 'sidekiq'
require 'sidekiq/api'
require 'sidekiq-scheduler'

require "./lighthouse_report"
require "./notification_parser"
require "./comment_builder"
require "./workers/github_mention_worker"

class GithubMentionWorker
  include Sidekiq::Worker

  def perform()
    user = ENV.fetch('GH_USERNAME')
    password = ENV.fetch('GH_PASSWORD')
    client = Octokit::Client.new(:login => user, :password => password)
    notifications = client.notifications.select {|notification| notification[:reason] == "mention"  }
    client.mark_notifications_as_read

    notifications.each do |notification|
      notification_parser = NotificationParser.new(client, notification)
      mention = notification_parser.parse_pr_mention()

      reports = []
      mention[:urls].each do |url|
        reports << LighthouseReport.new(url).generate
      end

      comment = CommentBuilder.new(reports, LighthouseReport::METRICS).build

      client.add_comment(
        mention[:repository],
        mention[:pull_request],
        comment
      )
    end
  end
end
