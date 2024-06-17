const { OpenAIClient, AzureKeyCredential } = require("@azure/openai");
const { Summary, Journal } = require("../Models/index"); 
require("dotenv").config();

const endpoint = process.env["AZURE_OPENAI_ENDPOINT"];
const azureApiKey = process.env["AZURE_OPENAI_KEY"];

async function fetchAndSaveAIResponse(journalID, aiResponse, iaResults) {
  console.log("== Open Ai 요약 일기 ==");
  console.log(`journalID: ${journalID}`);

  const iaResultsString = iaResults.map(result => {
    let resultString = '';

    resultString += `${result}\n`;

    return resultString;
  });

  console.log(`이미지 설명란: ${iaResultsString}`);

  const journal = await Journal.findByPk(journalID);
  if (!journal) {
    throw new Error("Journal not found");
  }

  const client = new OpenAIClient(endpoint, new AzureKeyCredential(azureApiKey));
  const deploymentId = "gpt-journal";
  const result = await client.getChatCompletions(deploymentId, [
    { role: "system", content: "You are an AI assistant that summarizes or changes the content I send to the format I want. And since I am Korean, I would like you to respond in Korean." },
    { role: "user", content: `${iaResultsString}은 오늘 찍은 사진의 주요 내용이고 ${journal.dataValues.journalText}은 오늘 내가 한 일들과 일정들을 요약해둔거야, 앞의 내용들을 ${aiResponse}처럼 바꿔서 알려주면 좋겠어.` }
  ]);

  for (const choice of result.choices) {
    const responseText = choice.message.content;
    console.log(responseText);

    await Summary.create({ summary: responseText, journalID });
  }
}

// fetchAndSaveAIResponse().catch((err) => {
//   console.error("The sample encountered an error:", err);
// });

module.exports = fetchAndSaveAIResponse;
