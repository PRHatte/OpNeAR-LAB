import mongoose from 'mongoose';
const Schema = mongoose.Schema;

let DataCenterSites = new Schema({
    sites:
    [{
    id: {type: String},
    name: {type : String},
    gateway: {type: String},
    hostnames: 
    [{type: String}]
        }]
});

// export default mongoose.model('DataCenterHosts', DataCenterHosts);

module.exports = mongoose.model('sites', DataCenterSites);