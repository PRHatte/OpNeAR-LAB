export interface Issue{
    nodes:
    [{
        node_id: String,
        node_name: String,
        vendor_name: String,
        typeOfNode: String,
        layer: String
    }],

    links:
    [{
        dest_node_id: String,
        link_id: String,
        source_node_id: String
    }]

}