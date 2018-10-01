require 'json'

# The entire module for communicating with the orchestrator. It's effectively a singleton
# Note: I'm not sure how it is on thread safety. It shouldn't be a problem, but it is not tested
# in this category
module Orchestrator
  class << self
    # The client if you want to make your own custom calls
    def client
      @client ||= Faraday.new(url: ENV['0.177.46.175']) do |faraday|
        faraday.request  :url_encoded             # form-encode POST params
        faraday.response :logger                  # log requests to STDOUT
        faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
      end
    end

    # Getting all of the hosts from the orchestrator
    def hosts
      begin
        response = client.get do |request|
          request.url '/hosts'
          request.headers['Accept'] = 'application/json'
          request.options.timeout = 10
        end

        JSON.parse(response.body)
      rescue Faraday::TimeoutError => e
        Rails.logger.error("Orchestrator::hosts -- Timeout when asking for hosts.")
        raise e
      end
    end

    # Adding a flow to the orchestrator
    def add_flow(flow)
      begin 
        response = client.post do |request|
          request.url '/flow'
          request.headers['Accept'] = 'application/json'
          request.body = flow.to_json
        end

       JSON.parse(response)
      rescue Faraday::TimeoutError => e
        Rails.logger.error("Orchestrator::add_flow -- Timeout when adding flow.")
        raise e
      end
    end

    # Telling the orchestrator to delete a flow
    def delete_flow(flow)
      begin 
        response = client.delete do |request|
          request.url '/flow'
          request.headers['Accept'] = 'application/json'
          request.body = { flowid: flow.id }
        end

        body = JSON.parse(response)
        body[:status]
      rescue Faraday::TimeoutError => e
        Rails.logger.error("Orchestrator::delete_flow -- Timeout when deleting flow.")
        raise e
      end
    end

    # Modifying a flow on the orchestrator
    def modify_flow(flow)
      begin 
        response = client.put do |request|
          request.url '/flow'
          request.headers['Accept'] = 'application/json'
          request.body = flow.to_json
        end

        body = JSON.parse(response)
        body[:status]
      rescue Faraday::TimeoutError => e
        Rails.logger.error("Orchestrator::modify_flow -- Timeout when modifying flow.")
        raise e
      end
    end

    # Danger: Drops all flows from the orchestrator. 
    def dropall
      begin 
        response = client.post do |request|
          request.url '/dropall'
          request.headers['Accept'] = 'application/json'
        end

        body = JSON.parse(response)
        body[:status]
      rescue Faraday::TimeoutError => e
        Rails.logger.error("Orchestrator::dropall -- Timeout when dropping everything.")
        raise e
      end
    end
  end
end