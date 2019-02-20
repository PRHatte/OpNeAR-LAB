import express from 'express';
import cors from 'cors';
import bodyParser from 'body-parser';
import mongoose from 'mongoose';
import Issue from './models/Issue';
import hosts from './models/DataCenterHosts';
import sites from './models/DataCenterSites';



const app=  express();
const router = express.Router();

app.use(cors());
app.use(bodyParser.json());

mongoose.connect('mongodb://localhost:27017/issues');

const connection = mongoose.connection;

connection.once('open', () => {
    console.log('MongoDb database connected succesfully');
})

router.route('/issues').get((req, res) => {
    Issue.find((err, issues) => {
        if(err)
            console.log(err);
        else
            res.json(issues);
    });

    
});

router.route('/hosts').get((req, res) => {
    hosts.find((err, hosts) => {
        if(err)
            console.log(err);
        else
            res.json(hosts);
    });

    
});

router.route('/sites').get((req, res) => {
    sites.find((err, sites) => {
        if(err)
            console.log(err);
        else
            res.json(sites);
    });

    
});


//app.get('http://140.221.216.50:9091',(req,res) => res.send("Hello World"));

app.use('/', router);

app.listen(4000, () => console.log('Express Server running on port 4000'));