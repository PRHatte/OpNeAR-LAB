namespace :app do
  task bootstrap: :environment do
    random = Random.new

    Pronet::OpticalCrossLayerLink.delete_all

    Pronet::OfethernetLink.delete_all
    Pronet::OfethernetPort.delete_all
    Pronet::Host.delete_all
    Pronet::OfethernetNode.delete_all

    puts "Generating ethernet nodes..."

    # Lets create a number of hosts.
    node_count = 20 # Hosts depend on ethernet nodes

    (0...node_count).each do |index|
      # Create an ethernet node and all of it's dependent things
      node = Pronet::OfethernetNode.create(node_dpid: random.rand(100),
                                    node_name: FFaker::Internet.slug,
                                    node_type: random.rand(3),
                                    node_segment: random.rand(5),
                                    node_controller: FFaker::Internet.slug)

      # Define one ethernet port per node, it could be multiple though
      port = Pronet::OfethernetPort.create( node_id: node.node_id,
                                            port_number: random.rand(150000),
                                            port_hwaddress: FFaker::Internet.mac,
                                            port_maxspeed: random.rand(10000),
                                            port_currentspeed: random.rand(5000),
                                            port_name: FFaker::Internet.slug)



      Pronet::Host.create(node_id: node.node_id, 
                          host_name: FFaker::Internet.slug, 
                          host_hwaddress: FFaker::Internet.mac,
                          host_segment: index)
    end

    puts "Generating ethernet links..."    

    # create the ethernet links here

    # NOTES: So it looks like links only link to ports and not nodes.

    # This is a crappy algorithm, but it will take a random number of ports and attempt to link them to each other
    # I believe that this will create a complete spanning tree. certainly not a minimum spanning tree though.
    ports = Pronet::OfethernetPort.all.to_set # cast this to an set
    connected_set = Set.new

    while !ports.empty?
      port = ports.to_a.sample # awful
      ports.delete(port)

      port_to_connect_to = connected_set.to_a.sample

      if port_to_connect_to
        # TODO: Do I need to create two records to link two nodes together?
        # I'm going to anyways
        Pronet::OfethernetLink.create(link_id: random.rand(100000000),
                                      source_port_id: port.port_id, 
                                      des_port_id: port_to_connect_to.port_id,
                                      link_cost: random.rand(100),
                                      distance: random.rand(100.0),
                                      loss: random.rand(25.0),
                                      capacity: random.rand(50)
                                      )

        Pronet::OfethernetLink.create(link_id: random.rand(100000000),
                                      source_port_id: port_to_connect_to.port_id, 
                                      des_port_id: port.port_id,
                                      link_cost: random.rand(100),
                                      distance: random.rand(100.0),
                                      loss: random.rand(25.0),
                                      capacity: random.rand(50)
                                      )
      end

      connected_set.add(port)
    end

    # Delete the tables
    Pronet::OpticalAlarm.delete_all
    Pronet::OpticalTrailHops.delete_all
    Pronet::OpticalTrail.delete_all
    Pronet::OpticalLink.delete_all
    Pronet::OpticalPort.delete_all
    Pronet::OpticalCard.delete_all
    Pronet::OpticalNode.delete_all

    
    optical_count = node_count / 2 # just half the value.

    puts "Genrating optical nodes..."

    (0...optical_count).each do |index|
      node = Pronet::OpticalNode.create(node_id: random.rand(1000000000),
                                        node_idname: FFaker::Internet.slug,
                                        node_name: FFaker::Internet.slug, # TODO: What is the difference between these?
                                        node_ip: FFaker::Internet.ip_v4_address,
                                        node_type: random.rand(5),
                                        node_version: "1.0.0",
                                        node_controller: FFaker::Internet.slug) # some human readable value?

      # optical card is relied upon by an optical port
      card = Pronet::OpticalCard.create(node_id: node.node_id,
                                        rack_id: random.rand(10),
                                        chassis_id: random.rand(5),
                                        slot_id: random.rand(10),
                                        card_type: random.rand(4),
                                        card_name: FFaker::Internet.slug,
                                        edfa_flag: random.rand(2) == 0 ? true : false
                                        )

      # optical port is relied upon by cross link layer, link, and trail.
      port = Pronet::OpticalPort.create(node_id: node.node_id,
                                        rack_id: card.rack_id,
                                        chassis_id: card.chassis_id,
                                        slot_id: card.slot_id,
                                        port_id: random.rand(1000),
                                        port_type: random.rand(3),
                                        port_idname: FFaker::Internet.slug)

      # Lets create some fake alarms, one for each node!

      end_time = random.rand(2) == 0 ? Time.now : nil
      end_date = random.rand(2) == 0 ? Date.today : nil

      alarm = OpticalAlarm.create(node_id: node.node_id,
                                          aid: FFaker::Internet.slug[0...100],
                                          mod2: FFaker::Internet.slug[0...10],
                                          alarm_name: FFaker::Lorem.phrase,
                                          start_date: Date.today - random.rand(5).days,
                                          start_time: Time.now - random.rand(5).days,
                                          chassis_id: card.chassis_id,
                                          slot_id: card.slot_id,  
                                          port_id: port.port_id,
                                          severity: random.rand(4),
                                          severice_affect: random.rand(2),
                                          direction: random.rand(3),
                                          location: random.rand(2),
                                          description: FFaker::Lorem.paragraph[0...100],
                                          aid_detail: FFaker::Lorem.phrase[0...100],
                                          end_date: end_date,
                                          end_time: end_time)
    end

    puts "Generating Optical Links..."

    # Create optical links here
    # NOTES: So it looks like links only link to ports and not nodes.

    # This is a crappy algorithm, but it will take a random number of ports and attempt to link them to each other
    # I believe that this will create a complete spanning tree. certainly not a minimum spanning tree though.
    ports = Pronet::OpticalPort.all.to_set # cast this to an set
    connected_set = Set.new

    while !ports.empty?
      port = ports.to_a.sample # awful
      ports.delete(port)

      port_to_connect_to = connected_set.to_a.sample

      if port_to_connect_to
        # TODO: Do I need to create two records to link two nodes together?
        # I'm going to anyways
        Pronet::OpticalLink.create(link_id: random.rand(100000000),
                                   source_node_id: port.node_id,
                                   source_chassis_id: port.chassis_id,
                                   source_slot_id: port.slot_id,
                                   source_port_id: port.port_id,
                                   des_node_id: port_to_connect_to.node_id,
                                   des_chassis_id: port_to_connect_to.chassis_id,
                                   des_slot_id: port_to_connect_to.slot_id,
                                   des_port_id: port_to_connect_to.port_id,
                                   link_idname: FFaker::Internet.slug,
                                   link_type: random.rand(3),
                                   distance: random.rand(100.0),
                                   loss: random.rand(50.0),
                                   fiber_type:  FFaker::Internet.slug,
                                   capacity: random.rand(100))

        Pronet::OpticalLink.create(link_id: random.rand(100000000),
                                   source_node_id: port_to_connect_to.node_id,
                                   source_chassis_id: port_to_connect_to.chassis_id,
                                   source_slot_id: port_to_connect_to.slot_id,
                                   source_port_id: port_to_connect_to.port_id,
                                   des_node_id: port.node_id,
                                   des_chassis_id: port.chassis_id,
                                   des_slot_id: port.slot_id,
                                   des_port_id: port.port_id,
                                   link_idname: FFaker::Internet.slug,
                                   link_type: random.rand(3),
                                   distance: random.rand(100.0),
                                   loss: random.rand(50.0),
                                   fiber_type: FFaker::Internet.slug,
                                   capacity: random.rand(100))
      end

      connected_set.add(port)
    end

    puts "Generating Trails..."

    trail_count = 50
    (0...trail_count).each do |index|
      hops = []

      trail_id = random.rand(100000000)
      #create all of the optical trails
      nodes = Pronet::OpticalNode.all.to_set
      source_node = nodes.to_a.sample
      optional_paths = Set.new
      optical_links = Pronet::OpticalLink.all.to_set

      while !optical_links.empty?
        optical_link = optical_links.to_a.sample
        optical_links.delete(optical_link)
        if(optical_link.source_node_id == source_node.node_id)
          optional_paths.add(optical_link)
        end
      end

      hop_seq = 1
      latest_source_node_id = source_node.node_id
      optional_path_array = optional_paths.to_a
      while !optional_path_array.empty?
        last_node_id = latest_source_node_id
        path_to_take = optional_paths.to_a.sample

        hop = Pronet::OpticalTrailHops.new( trail_id: trail_id,
                                            link_sequence: hop_seq,
                                            link_id: path_to_take.link_id)
        hops << hop

        hop_seq = hop_seq + 1
        latest_source_node_id = path_to_take.des_node_id
        optional_paths = Set.new
        optical_links = Pronet::OpticalLink.all.to_set

        while !optical_links.empty?
          optical_link = optical_links.to_a.sample
          optical_links.delete(optical_link)
          if(optical_link.source_node_id == latest_source_node_id)
            optional_paths.add(optical_link)
          end
        end

        optional_path_array = optional_paths.to_a
        #puts "Error For statement start"
        del_Index = nil
        (0...optional_path_array.count).each do |pathCount|
          #puts "L "+pathCount.to_s+"/"+optional_path_array.count.to_s
          #puts pathCount.to_s + " L "+optional_path_array[pathCount].des_node_id.to_s
          #puts pathCount.to_s+" "+last_node_id.to_s
          #puts pathCount.to_s+" "+latest_source_node_id.to_s
          if(optional_path_array[pathCount].des_node_id == last_node_id)
            #puts "L L "+optional_path_array[pathCount].des_node_id.to_s+" "+latest_source_node_id.to_s
            del_Index = pathCount
            #optional_path_array.delete(optional_path_array[pathCount])
          end
        end
        if(del_Index)
          optional_path_array.delete(optional_path_array[del_Index])
        end
        #puts optional_path_array.count.to_s
      end

      ports = Pronet::OpticalPort.all.to_set
      ports = ports.to_a
      des_node_id = latest_source_node_id
      
      des_port = source_node #placeholder. Im just initializing des_port
      (0...ports.count).each do |portCount|
        if(ports[portCount].node_id == des_node_id)
          des_port = ports[portCount]
        end
      end

      src_port = source_node #placeholder. Im just initializing des_port
      (0...ports.count).each do |portCount|
        if(ports[portCount].node_id == source_node.node_id)
          src_port = ports[portCount]
        end
      end

      
      Pronet::OpticalTrail.create(trail_id: trail_id,
                                  trail_idname: FFaker::Internet.slug,
                                  trail_name: FFaker::Lorem.phrase,
                                  trail_type: random.rand(3),
                                  source_node_id: src_port.node_id,
                                  source_chassis_id: src_port.chassis_id,
                                  source_slot_id: src_port.slot_id,
                                  source_port_id: src_port.port_id,
                                  des_node_id: des_port.node_id,
                                  des_chassis_id: des_port.chassis_id,
                                  des_slot_id: des_port.slot_id,
                                  des_port_id: des_port.port_id,
                                  hops: hop_seq)

      hops.each(&:save)
    end

    # Create cross layer links here

    # Query all of them
    optical_ports = Pronet::OpticalPort.all.to_set
    ethernet_ports = Pronet::OfethernetPort.all.to_set

    cross_layer_links_count = optical_count

    (0...cross_layer_links_count).each do |index|
      ethernet = ethernet_ports.to_a.sample
      optical = optical_ports.to_a.sample

      # Make sure we can't link them again
      optical_ports.delete(optical)
      ethernet_ports.delete(ethernet)

      # And create the cross layer links
      link = Pronet::OpticalCrossLayerLink.create(crosslayer_link_id: random.rand(100000000),
                                                  l2_port_id: ethernet.port_id,
                                                  l0_node: optical.node_id,
                                                  l0_chassis: optical.chassis_id,
                                                  l0_slot: optical.slot_id,
                                                  l0_port: optical.port_id)
    end
  end
end