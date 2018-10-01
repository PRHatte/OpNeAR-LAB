class CreateOpticalAlarms < ActiveRecord::Migration[5.0]
  def change

    # Note: I think this is already populated by the orchestrator.

    # execute(%Q(CREATE TABLE optical_alarm(
    #         node_autoID serial PRIMARY KEY NOT NULL, --default nextval('optical_alarm_id_seq'::regclass),
    #         node_id integer NOT NULL REFERENCES optical_node(node_id),                   --node_id more information from optical_node
    #         AID varchar(100) NOT NULL,                                                   --Object like identify which node, which card or which Port.
    #         mod2 varchar(10) NOT NULL,                                                   --Object Level
    #         alarm_name varchar(100),
    #         start_date date,
    #         start_time time,
    #         chassis_id  integer,
    #         slot_id   integer,
    #         port_id   integer,
    #         severity  integer,                                                           --0:CR 1:MJ 2:MN 3:CL
    #         severice_affect integer,                                                     --0:NSA 1:SA
    #         direction integer,                                                           --0:BTH 1:RCV 2:NA
    #         location  integer,                                                           --0:FEND 1:NEND
    #         description varchar(100),
    #         AID_detail varchar(100),
    #         end_date  date,
    #         end_time  time,
    #         constraint fk_alarm_portID
    #            foreign key (node_id,chassis_id,slot_id,port_id)
    #            REFERENCES optical_port (node_id,chassis_id,slot_id,port_id)
    #       )
    #       ;)
    # )
  end
end
