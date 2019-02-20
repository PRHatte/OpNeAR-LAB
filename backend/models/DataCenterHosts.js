import mongoose from 'mongoose';
const Schema = mongoose.Schema;

let DataCenterHosts = new Schema({
    hosts:
    [{
    id: {type: String},
    name: {type : String},
    vms: 
    [{
        id: String,
        name: String,
        status: String

    }]
        }]
});

// export default mongoose.model('DataCenterHosts', DataCenterHosts);

module.exports = mongoose.model('hosts', DataCenterHosts);