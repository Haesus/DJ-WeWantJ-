// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

const { ImageAnalysisClient } = require('@azure-rest/ai-vision-image-analysis');
const createClient = require('@azure-rest/ai-vision-image-analysis').default;
const { AzureKeyCredential } = require('@azure/core-auth');

// Load the .env file if it exists
require("dotenv").config();

const endpoint = process.env['VISION_ENDPOINT'] || '<your_endpoint>';
const key = process.env['VISION_KEY'] || '<your_key>';
const credential = new AzureKeyCredential(key);

const client = createClient(endpoint, credential);

const features = [
  'Caption',
  'DenseCaptions',
  'Objects',
  'People',
  'Read',
  'SmartCrops',
  'Tags'
];

async function analyzeImageFromUrl(journalImageStrings) {

  let iaResults = [];

  for (let imageUrl of journalImageStrings) {
    const result = await client.path('/imageanalysis:analyze').post({
      body: {
          url: `https://journaldaily.blob.core.windows.net/journalimage/${imageUrl}`
      },
      queryParameters: {
          features: features,
          'smartCrops-aspect-ratios': [0.9, 1.33]
      },
      contentType: 'application/json'
    });

    const iaResult = result.body;

    if (!iaResult) {
      console.error(`Failed to analyze image: ${imageUrl}`);
      continue;
    }

    iaResults.push(iaResult.captionResult.text);
  }

  console.log(`iaResults: ${iaResults}`);
  return iaResults;
}

module.exports = analyzeImageFromUrl;