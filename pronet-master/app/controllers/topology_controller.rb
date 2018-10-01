# The Topology is the most heavy of all of the controllers. 
# If you are having database issues, it is quite likely that this controller is the culprit.
# It queries all of the readonly information about what the network is doing. 

class TopologyController < ApplicationController
  before_action :require_signed_in!
  
  def index
    @ethernet_nodes = Pronet::OfethernetNode.all
    @ethernet_ports = Pronet::OfethernetPort.all
    @ethernet_links = Pronet::OfethernetLink.all
    @optical_nodes = Pronet::OpticalNode.all
    @optical_cards = Pronet::OpticalCard.all
    @optical_ports = Pronet::OpticalPort.all
    @optical_links = Pronet::OpticalLink.all
    @optical_cross_layer_links = Pronet::OpticalCrossLayerLink.all
    @optical_trails = Pronet::OpticalTrail.all
    @optical_trail_hops = Pronet::OpticalTrailHops.all
  end

  def show
    # unused?
  end
end