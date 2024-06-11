const { OpenAIClient, AzureKeyCredential } = require("@azure/openai");
const { Summary, Journal } = require("../Models/index"); 
require("dotenv").config();

const endpoint = process.env["AZURE_OPENAI_ENDPOINT"];
const azureApiKey = process.env["AZURE_OPENAI_KEY"];

async function fetchAndSaveAIResponse(journalID) {
  console.log("== 3줄 요약 일기 ==");
  console.log(journalID)

  const journal = await Journal.findByPk(journalID);
  if (!journal) {
    throw new Error("Journal not found");
  }
 console.log(journal.dataValues.journalText)
  const client = new OpenAIClient(endpoint, new AzureKeyCredential(azureApiKey));
  const deploymentId = "gpt-journal";
  const result = await client.getChatCompletions(deploymentId, [
    { role: "system", content: "You are an AI assistant that summarizes text into three sentences." },
    { role: "user", content: `보내주는 내용을 3줄로 요약해줘: ${journal.dataValues.journalText}` }
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
