const { OpenAIClient, AzureKeyCredential } = require("@azure/openai");
const { Summary, Journal } = require("../Models/index"); 
require("dotenv").config();

const endpoint = process.env["AZURE_OPENAI_ENDPOINT"];
const azureApiKey = process.env["AZURE_OPENAI_KEY"];

async function fetchAndSaveAIResponse(journalID, aiResponse) {
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
    { role: "system", content: "You are an AI assistant that summarizes or changes the content I send to the format I want." },
    { role: "user", content: `${journal.dataValues.journalText} 앞의 내용은 내가 오늘 진행한 일과야 위 내용을 ${aiResponse}(으)로 정리해서 알려줘` }
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
