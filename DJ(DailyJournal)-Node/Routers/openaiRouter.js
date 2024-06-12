const express = require('express');
const  fetchAndSaveAIResponse = require('./main');
const { Summary } = require('../Models/index');
const router = express.Router();

router.post('/save/:journalID', async (req, res) => {
  const { journalID } = req.params;
  console.log(`Received request to save AI response for journalID: ${journalID}`);

  try {
    await fetchAndSaveAIResponse(journalID);
    res.status(200).json({ success: true, message: 'AI 응답이 성공적으로 저장되었습니다.' });
  } catch (err) {
    res.status(500).json({ success: false, message: 'AI 응답 저장 중 오류 발생.', error: err.message });
  }
});

router.get('/load/:journalID', async (req, res) => {
  const { journalID } = req.params;
    try {
      const summaries = await Summary.findAll({
        where: { journalID }});
      res.status(200).json({ success: true, summaries });
    } catch (err) {
      res.status(500).json({ success: false, message: 'AI 응답 조회 중 오류 발생.', error: err.message });
    }
  });

module.exports = router;
