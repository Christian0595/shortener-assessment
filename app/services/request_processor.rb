require 'user_agent_parser'

class RequestProcessor
  def initialize(request, link)
    @request = request
    @link = link
  end

  def process
    user_agent = UserAgentParser.parse @request.user_agent
    Visit.create(
      ip_address: @request.remote_ip,
      web_browser: user_agent.to_s,
      operative_system: user_agent.os,
      date: Time.now,
      link: @link
    )
  end
end