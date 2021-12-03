const readline = require('readline');
const AWS = require('aws-sdk');
const S3 = new AWS.S3();


exports.handler = async function execute(event, context, callback) {
    console.log(JSON.stringify(event, null, 2));

    const bucket = event.BUCKET;
    const key = event.KEY;
    const type = event.TYPE;
    const name = event.NAME;
    const attribute = event.ATTRIBUTE;


    const data = await S3.getObject({
        Bucket: bucket,
        Key: key,
    }).promise();

    let json = JSON.parse(data.Body.toString('utf-8'));
    json = json['resources']

    for (let i = 0; i < json.length; i++) {
        if (json[i]['type'] === type) {
            const instances = json[i]['instances'];
            for (let j = 0; j < instances.length; j++) {
                if (instances[j]['attributes'].hasOwnProperty(attribute) &&
                    instances[j]['attributes']['name'] === name) {
                    const result = instances[j]['attributes'][attribute]
                    console.log("Found attribute: ", result);
                    return result;
                }
            }
        }
    }
}