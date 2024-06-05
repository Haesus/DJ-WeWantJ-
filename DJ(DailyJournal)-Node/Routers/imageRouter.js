const express = require('express');
const router = express.Router();
const { BlobServiceClient } = require(`@azure/storage-blob`);
require(`dotenv`).config();

router.get('/:filename', async (req, res) => {
    const blobname = req.params.filename;
    try {
        const blobServiceClient = BlobServiceClient.fromConnectionString(process.env.SA_CONNECTION_STRING);
        const containerClient = blobServiceClient.getContainerClient(`files`);
        const blobClient = containerClient.getBlobClient(blobname);
        const downloadBlockBlobResponse = await blobClient.download(0);

        downloadBlockBlobResponse.readableStreamBody.pipe(res);
    } catch {
        console.error(error);
        res.status(500).send("Error fetching file from A B S");
    }
});

module.exports = router;
