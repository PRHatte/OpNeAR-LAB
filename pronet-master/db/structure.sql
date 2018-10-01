--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.1
-- Dumped by pg_dump version 9.5.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: communication_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE communication_table (
    id integer NOT NULL,
    optical_node_id integer,
    ethernet_node_id integer,
    table_connection_id integer
);


--
-- Name: communication_table_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE communication_table_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: communication_table_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE communication_table_id_seq OWNED BY communication_table.id;


--
-- Name: cross_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE cross_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ethernet_nodes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE ethernet_nodes (
    id integer NOT NULL,
    node_id integer,
    node_idname character varying,
    node_name character varying,
    node_ip character varying,
    node_type integer,
    node_version character varying,
    node_controller character varying
);


--
-- Name: ethernet_nodes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE ethernet_nodes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ethernet_nodes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE ethernet_nodes_id_seq OWNED BY ethernet_nodes.id;


--
-- Name: ethernetnode_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE ethernetnode_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ethport_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE ethport_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: flows; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE flows (
    id integer NOT NULL,
    ext_flow_id integer,
    title character varying,
    dst character varying,
    src character varying,
    status integer,
    start_time timestamp without time zone,
    end_time timestamp without time zone,
    min_bandwidth numeric,
    max_bandwidth numeric,
    bandwidth_unit character varying,
    latency integer,
    method character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    bw numeric,
    duration numeric,
    startt numeric,
    user_id integer
);


--
-- Name: flows_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE flows_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: flows_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE flows_id_seq OWNED BY flows.id;


--
-- Name: host_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE host_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: hosts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE hosts (
    host_id integer DEFAULT nextval('host_seq'::regclass) NOT NULL,
    node_id integer NOT NULL,
    host_name character varying(100) NOT NULL,
    host_hwaddress character varying(100) NOT NULL,
    host_segment integer NOT NULL,
    node_controller character varying(100) DEFAULT NULL::character varying
);


--
-- Name: ofethernetlink_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE ofethernetlink_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ofethernet_link; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE ofethernet_link (
    link_id integer DEFAULT nextval('ofethernetlink_seq'::regclass) NOT NULL,
    source_port_id integer NOT NULL,
    des_port_id integer NOT NULL,
    link_cost integer NOT NULL,
    distance real NOT NULL,
    loss real NOT NULL,
    capacity integer NOT NULL
);


--
-- Name: ofethernet_node; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE ofethernet_node (
    node_id integer DEFAULT nextval('ethernetnode_seq'::regclass) NOT NULL,
    node_dpid integer NOT NULL,
    node_name character varying(100) NOT NULL,
    node_type integer NOT NULL,
    node_segment integer NOT NULL,
    node_controller character varying(100) DEFAULT NULL::character varying
);


--
-- Name: ofethernet_port; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE ofethernet_port (
    port_id integer DEFAULT nextval('ethport_seq'::regclass) NOT NULL,
    node_id integer NOT NULL,
    port_number integer NOT NULL,
    port_hwaddress character varying(100) NOT NULL,
    port_maxspeed integer NOT NULL,
    port_currentspeed integer NOT NULL,
    port_name character varying(100) NOT NULL
);


--
-- Name: optical_alarm; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE optical_alarm (
    node_autoid integer NOT NULL,
    node_id integer NOT NULL,
    aid character varying(100) NOT NULL,
    mod2 character varying(10) NOT NULL,
    alarm_name character varying(100),
    start_date date,
    start_time time without time zone,
    chassis_id integer,
    slot_id integer,
    port_id integer,
    severity integer,
    severice_affect integer,
    direction integer,
    location integer,
    description character varying(100),
    aid_detail character varying(100),
    end_date date,
    end_time time without time zone
);


--
-- Name: optical_alarm_node_autoid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE optical_alarm_node_autoid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: optical_alarm_node_autoid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE optical_alarm_node_autoid_seq OWNED BY optical_alarm.node_autoid;


--
-- Name: optical_card; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE optical_card (
    node_id integer NOT NULL,
    rack_id integer NOT NULL,
    chassis_id integer NOT NULL,
    slot_id integer NOT NULL,
    card_type integer NOT NULL,
    card_name character varying(100) NOT NULL,
    edfa_flag boolean NOT NULL
);


--
-- Name: optical_cards; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE optical_cards (
    id integer NOT NULL,
    node_id integer,
    rack_id integer,
    chassis_id integer,
    slot_id integer,
    card_type integer,
    card_name character varying,
    "EDFA_FLAG" boolean
);


--
-- Name: optical_cards_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE optical_cards_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: optical_cards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE optical_cards_id_seq OWNED BY optical_cards.id;


--
-- Name: optical_crosslayerlink; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE optical_crosslayerlink (
    crosslayer_link_id integer DEFAULT nextval('cross_seq'::regclass) NOT NULL,
    l2_port_id integer NOT NULL,
    l0_node integer NOT NULL,
    l0_chassis integer NOT NULL,
    l0_slot integer NOT NULL,
    l0_port integer NOT NULL
);


--
-- Name: optical_edfa; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE optical_edfa (
    node_id integer NOT NULL,
    chassis_id integer NOT NULL,
    slot_id integer NOT NULL,
    edfa_direction integer NOT NULL,
    edfa_type integer NOT NULL,
    setgain real NOT NULL,
    inputpower real NOT NULL,
    outputpower real NOT NULL,
    link_type integer NOT NULL,
    distance real NOT NULL,
    loss real NOT NULL,
    fiber_type integer NOT NULL,
    capacity integer NOT NULL
);


--
-- Name: optical_edfaspectrum; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE optical_edfaspectrum (
    node_id integer NOT NULL,
    chassis_id integer NOT NULL,
    slot_id integer NOT NULL,
    edfa_direction integer NOT NULL,
    frequency real NOT NULL,
    power real NOT NULL
);


--
-- Name: optical_link; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE optical_link (
    link_id integer NOT NULL,
    source_node_id integer NOT NULL,
    source_chassis_id integer NOT NULL,
    source_slot_id integer NOT NULL,
    source_port_id integer NOT NULL,
    des_node_id integer NOT NULL,
    des_chassis_id integer NOT NULL,
    des_slot_id integer NOT NULL,
    des_port_id integer NOT NULL,
    link_idname character varying(100) NOT NULL,
    link_type integer NOT NULL,
    distance real,
    loss real,
    fiber_type character varying(100),
    capacity integer
);


--
-- Name: optical_node; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE optical_node (
    node_id integer NOT NULL,
    node_idname character varying(100) NOT NULL,
    node_name character varying(100) NOT NULL,
    node_ip character varying(100) NOT NULL,
    node_type integer NOT NULL,
    node_version character varying(100) NOT NULL,
    node_controller character varying(100) DEFAULT NULL::character varying
);


--
-- Name: optical_nodes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE optical_nodes (
    id integer NOT NULL,
    node_id integer,
    node_idname character varying,
    node_name character varying,
    node_ip character varying,
    node_type integer,
    node_version character varying,
    node_controller character varying
);


--
-- Name: optical_nodes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE optical_nodes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: optical_nodes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE optical_nodes_id_seq OWNED BY optical_nodes.id;


--
-- Name: optical_port; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE optical_port (
    node_id integer NOT NULL,
    rack_id integer NOT NULL,
    chassis_id integer NOT NULL,
    slot_id integer NOT NULL,
    port_id integer NOT NULL,
    port_type integer NOT NULL,
    port_servicestate integer,
    port_idname character varying(100) NOT NULL,
    port_servicetype integer,
    frequency real
);


--
-- Name: optical_trail; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE optical_trail (
    trail_id integer NOT NULL,
    trail_idname character varying(100) NOT NULL,
    trail_name character varying(100) NOT NULL,
    trail_type integer NOT NULL,
    source_node_id integer NOT NULL,
    source_chassis_id integer NOT NULL,
    source_slot_id integer NOT NULL,
    source_port_id integer NOT NULL,
    des_node_id integer NOT NULL,
    des_chassis_id integer NOT NULL,
    des_slot_id integer NOT NULL,
    des_port_id integer NOT NULL,
    hops integer NOT NULL
);


--
-- Name: optical_trailhops; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE optical_trailhops (
    trail_id integer NOT NULL,
    link_sequence integer NOT NULL,
    link_id integer NOT NULL
);


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


--
-- Name: user_host_links; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE user_host_links (
    id integer NOT NULL,
    user_id integer,
    host_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: user_host_links_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE user_host_links_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_host_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE user_host_links_id_seq OWNED BY user_host_links.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying,
    permission_level character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY communication_table ALTER COLUMN id SET DEFAULT nextval('communication_table_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY ethernet_nodes ALTER COLUMN id SET DEFAULT nextval('ethernet_nodes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY flows ALTER COLUMN id SET DEFAULT nextval('flows_id_seq'::regclass);


--
-- Name: node_autoid; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY optical_alarm ALTER COLUMN node_autoid SET DEFAULT nextval('optical_alarm_node_autoid_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY optical_cards ALTER COLUMN id SET DEFAULT nextval('optical_cards_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY optical_nodes ALTER COLUMN id SET DEFAULT nextval('optical_nodes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_host_links ALTER COLUMN id SET DEFAULT nextval('user_host_links_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: communication_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY communication_table
    ADD CONSTRAINT communication_table_pkey PRIMARY KEY (id);


--
-- Name: ethernet_nodes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ethernet_nodes
    ADD CONSTRAINT ethernet_nodes_pkey PRIMARY KEY (id);


--
-- Name: flows_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY flows
    ADD CONSTRAINT flows_pkey PRIMARY KEY (id);


--
-- Name: hosts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY hosts
    ADD CONSTRAINT hosts_pkey PRIMARY KEY (host_id);


--
-- Name: ofethernet_link_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ofethernet_link
    ADD CONSTRAINT ofethernet_link_pkey PRIMARY KEY (link_id);


--
-- Name: ofethernet_node_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ofethernet_node
    ADD CONSTRAINT ofethernet_node_pkey PRIMARY KEY (node_id);


--
-- Name: ofethernet_port_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ofethernet_port
    ADD CONSTRAINT ofethernet_port_pkey PRIMARY KEY (port_id);


--
-- Name: optical_alarm_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY optical_alarm
    ADD CONSTRAINT optical_alarm_pkey PRIMARY KEY (node_autoid);


--
-- Name: optical_card_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY optical_card
    ADD CONSTRAINT optical_card_pkey PRIMARY KEY (node_id, chassis_id, slot_id);


--
-- Name: optical_cards_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY optical_cards
    ADD CONSTRAINT optical_cards_pkey PRIMARY KEY (id);


--
-- Name: optical_crosslayerlink_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY optical_crosslayerlink
    ADD CONSTRAINT optical_crosslayerlink_pkey PRIMARY KEY (crosslayer_link_id);


--
-- Name: optical_edfa_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY optical_edfa
    ADD CONSTRAINT optical_edfa_pkey PRIMARY KEY (node_id, chassis_id, slot_id, edfa_direction);


--
-- Name: optical_edfaspectrum_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY optical_edfaspectrum
    ADD CONSTRAINT optical_edfaspectrum_pkey PRIMARY KEY (node_id, chassis_id, slot_id, edfa_direction);


--
-- Name: optical_link_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY optical_link
    ADD CONSTRAINT optical_link_pkey PRIMARY KEY (link_id);


--
-- Name: optical_node_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY optical_node
    ADD CONSTRAINT optical_node_pkey PRIMARY KEY (node_id);


--
-- Name: optical_nodes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY optical_nodes
    ADD CONSTRAINT optical_nodes_pkey PRIMARY KEY (id);


--
-- Name: optical_port_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY optical_port
    ADD CONSTRAINT optical_port_pkey PRIMARY KEY (node_id, chassis_id, slot_id, port_id);


--
-- Name: optical_trail_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY optical_trail
    ADD CONSTRAINT optical_trail_pkey PRIMARY KEY (trail_id);


--
-- Name: optical_trailhops_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY optical_trailhops
    ADD CONSTRAINT optical_trailhops_pkey PRIMARY KEY (trail_id, link_sequence);


--
-- Name: schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: user_host_links_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_host_links
    ADD CONSTRAINT user_host_links_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_flows_on_ext_flow_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_flows_on_ext_flow_id ON flows USING btree (ext_flow_id);


--
-- Name: index_user_host_links_on_host_id_and_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_user_host_links_on_host_id_and_user_id ON user_host_links USING btree (host_id, user_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: fk_alarm_portid; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY optical_alarm
    ADD CONSTRAINT fk_alarm_portid FOREIGN KEY (node_id, chassis_id, slot_id, port_id) REFERENCES optical_port(node_id, chassis_id, slot_id, port_id);


--
-- Name: fk_ethernet_crosslayerlink; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY optical_crosslayerlink
    ADD CONSTRAINT fk_ethernet_crosslayerlink FOREIGN KEY (l2_port_id) REFERENCES ofethernet_port(port_id);


--
-- Name: fk_ofethernet_destination_portid; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ofethernet_link
    ADD CONSTRAINT fk_ofethernet_destination_portid FOREIGN KEY (des_port_id) REFERENCES ofethernet_port(port_id);


--
-- Name: fk_ofethernet_hostid; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY hosts
    ADD CONSTRAINT fk_ofethernet_hostid FOREIGN KEY (node_id) REFERENCES ofethernet_node(node_id);


--
-- Name: fk_ofethernet_portid; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ofethernet_port
    ADD CONSTRAINT fk_ofethernet_portid FOREIGN KEY (node_id) REFERENCES ofethernet_node(node_id);


--
-- Name: fk_ofethernet_source_portid; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ofethernet_link
    ADD CONSTRAINT fk_ofethernet_source_portid FOREIGN KEY (source_port_id) REFERENCES ofethernet_port(port_id);


--
-- Name: fk_optical_cardid; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY optical_port
    ADD CONSTRAINT fk_optical_cardid FOREIGN KEY (node_id, chassis_id, slot_id) REFERENCES optical_card(node_id, chassis_id, slot_id);


--
-- Name: fk_optical_crosslayerlink; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY optical_crosslayerlink
    ADD CONSTRAINT fk_optical_crosslayerlink FOREIGN KEY (l0_node, l0_chassis, l0_slot, l0_port) REFERENCES optical_port(node_id, chassis_id, slot_id, port_id);


--
-- Name: fk_optical_destination_portid; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY optical_link
    ADD CONSTRAINT fk_optical_destination_portid FOREIGN KEY (des_node_id, des_chassis_id, des_slot_id, des_port_id) REFERENCES optical_port(node_id, chassis_id, slot_id, port_id);


--
-- Name: fk_optical_destination_portid; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY optical_trail
    ADD CONSTRAINT fk_optical_destination_portid FOREIGN KEY (des_node_id, des_chassis_id, des_slot_id, des_port_id) REFERENCES optical_port(node_id, chassis_id, slot_id, port_id);


--
-- Name: fk_optical_edfa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY optical_edfa
    ADD CONSTRAINT fk_optical_edfa FOREIGN KEY (node_id, chassis_id, slot_id) REFERENCES optical_card(node_id, chassis_id, slot_id);


--
-- Name: fk_optical_edfa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY optical_edfaspectrum
    ADD CONSTRAINT fk_optical_edfa FOREIGN KEY (node_id, chassis_id, slot_id) REFERENCES optical_card(node_id, chassis_id, slot_id);


--
-- Name: fk_optical_source_portid; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY optical_link
    ADD CONSTRAINT fk_optical_source_portid FOREIGN KEY (source_node_id, source_chassis_id, source_slot_id, source_port_id) REFERENCES optical_port(node_id, chassis_id, slot_id, port_id);


--
-- Name: fk_optical_source_portid; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY optical_trail
    ADD CONSTRAINT fk_optical_source_portid FOREIGN KEY (source_node_id, source_chassis_id, source_slot_id, source_port_id) REFERENCES optical_port(node_id, chassis_id, slot_id, port_id);


--
-- Name: hosts_node_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY hosts
    ADD CONSTRAINT hosts_node_id_fkey FOREIGN KEY (node_id) REFERENCES ofethernet_node(node_id);


--
-- Name: ofethernet_link_des_port_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ofethernet_link
    ADD CONSTRAINT ofethernet_link_des_port_id_fkey FOREIGN KEY (des_port_id) REFERENCES ofethernet_port(port_id);


--
-- Name: ofethernet_link_source_port_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ofethernet_link
    ADD CONSTRAINT ofethernet_link_source_port_id_fkey FOREIGN KEY (source_port_id) REFERENCES ofethernet_port(port_id);


--
-- Name: ofethernet_port_node_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ofethernet_port
    ADD CONSTRAINT ofethernet_port_node_id_fkey FOREIGN KEY (node_id) REFERENCES ofethernet_node(node_id);


--
-- Name: optical_alarm_node_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY optical_alarm
    ADD CONSTRAINT optical_alarm_node_id_fkey FOREIGN KEY (node_id) REFERENCES optical_node(node_id);


--
-- Name: optical_card_node_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY optical_card
    ADD CONSTRAINT optical_card_node_id_fkey FOREIGN KEY (node_id) REFERENCES optical_node(node_id);


--
-- Name: optical_crosslayerlink_l2_port_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY optical_crosslayerlink
    ADD CONSTRAINT optical_crosslayerlink_l2_port_id_fkey FOREIGN KEY (l2_port_id) REFERENCES ofethernet_port(port_id);


--
-- Name: optical_edfaspectrum_node_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY optical_edfaspectrum
    ADD CONSTRAINT optical_edfaspectrum_node_id_fkey FOREIGN KEY (node_id) REFERENCES optical_node(node_id);


--
-- Name: optical_port_node_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY optical_port
    ADD CONSTRAINT optical_port_node_id_fkey FOREIGN KEY (node_id) REFERENCES optical_node(node_id);


--
-- Name: optical_trailhops_link_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY optical_trailhops
    ADD CONSTRAINT optical_trailhops_link_id_fkey FOREIGN KEY (link_id) REFERENCES optical_link(link_id);


--
-- Name: optical_trailhops_trail_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY optical_trailhops
    ADD CONSTRAINT optical_trailhops_trail_id_fkey FOREIGN KEY (trail_id) REFERENCES optical_trail(trail_id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO schema_migrations (version) VALUES ('0'), ('20170221205803'), ('20170310030724'), ('20170310195306'), ('20170323005626'), ('20170330014742'), ('20170330020111'), ('20170331002312'), ('20170413223753');


