class CommentBuilder

  def initialize(reports, metrics)
    @reports = reports
    @metrics = metrics
  end

  def build
    first_site = @reports[0]["url"].scan(/\/\/(.+).com/).flatten[0]
    second_site = @reports[1]["url"].scan(/\/\/(.+).com/).flatten[0]

    comment = table_header(first_site, second_site)

    @metrics.each do |k,v|
      comment += <<~TEXT
      <tr>
        <td>#{k}</td>
        <td>#{@reports[0][k][:score]}</td>
        <td>#{@reports[0][k][:value]}</td>
        <td>#{@reports[1][k][:score]}</td>
        <td>#{@reports[1][k][:value]}</td>
      </tr>
      TEXT
    end  

    comment += table_footer

  end

  private

  def table_header(first_site, second_site)
    <<~TEXT
    ### #{first_site} X #{second_site}

    <table>
      <thead>
        <tr>
          <th>Name</th>
          <th colspan="2">#{first_site}</th>
          <th colspan="2">#{second_site}</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td></td>
          <td><b>Score</b></td>
          <td><b>Time</b></td>
          <td><b>Score</b></td>
          <td><b>Time</b></td>
        </tr>
    TEXT
  end

  def table_footer
    <<~TEXT
      </tbody>
    </table>
    TEXT
  end
end