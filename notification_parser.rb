class NotificationParser

  def initialize(client, notification)
    @client = client
    @notification = notification
  end

  def parse_pr_mention
    pull_request_regex = /\/([a-zA-Z]+\/[a-zA-Z]+)\/pulls\/([1-9]+)$/.match(@notification[:subject][:url])
    repository = pull_request_regex[1]
    pull_request = pull_request_regex[2].to_i
    urls = parse_urls(repository, pull_request)

    {
      pull_request: pull_request, 
      repository: repository, 
      urls: urls
    }
  end

  private

  def parse_urls(repository, pull_request)
    regex = /@lightbot run (.+) (.+)$/

    comments = @client.issue_comments(repository, pull_request).reverse
    latest_comment = comments.select {|comment| regex.match(comment[:body]) }.last
    urls = regex.match(latest_comment[:body]).to_a
    urls.shift
    urls
  end
end