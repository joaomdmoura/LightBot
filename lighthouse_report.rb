class LighthouseReport

  METRICS = [
    "first-meaningful-paint",
    "speed-index-metric",
    "first-interactive",
    "network-requests"
  ]

  def initialize(url)
    @url = url
  end

  def generate()
    audits = JSON.parse(`lighthouse --quiet --chrome-flags="--headless" --output=json #{@url}`)["audits"]
    
    report  = {}
    METRICS.each do |metric|
      report[metric] = extract_score(audits, metric)
    end
    
    report["url"] = @url
    
    report
  end

  private

  def extract_score(audits, name)
    {
      score: audits[name]["score"],
      value: audits[name]["displayValue"]
    }
  end
end