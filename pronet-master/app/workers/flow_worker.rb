class FlowWorker
  include Sidekiq::Worker

  def perform(type, flow_id)
    flow = Flow.find(flow_id)

    if type == 1
      
      if !flow.ext_flow_id
        response = Orchestrator.add_flow(flow)
        if response["failure"]
        else
          flow.ext_flow_id = response["flow_id"]
        end
      else
        response = Orchestrator.modify_flow(flow)
      end

    elsif type ==2
      response = Orchestrator.delete_flow(flow)
      
    end 

  end
end
