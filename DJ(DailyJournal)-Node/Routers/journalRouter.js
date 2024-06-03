const express = require('express');
const { Journal, JournalImage } = require('../Models/index');
const router = express.Router();
const upload = require('./uploadImage');

// 일기 생성
router.post('/save', upload.array('photos', 4), async (req, res) => {
  const newJournal = req.body;
  newJournal.userID = req.id;

  try {
    const result = await Journal.create(newJournal);
    
    if (req.files && req.files.length > 0) {
      const images = req.files.map(file => ({
        journalID: result.id,
        journalImageString: file.filename,
      }));
      await JournalImage.bulkCreate(images);
    }

    res.json({ success: true, documents: [result], message: '일기 생성 완료' });
  } catch (error) {
    res.json({
      success: false,
      documents: [],
      message: `일기 생성 실패 ${error}`,
    });
  }
});

// 일기 조회
router.get('/load', async (req, res) => {
  try {
    const result = await Journal.findAll({
      include: [{ model: JournalImage }]
    });
    res.json({ success: true, documents: result, message: 'Journal 조회 성공' });
  } catch (error) {
    res.json({
      success: false,
      documents: [],
      message: `Journal 조회 실패 ${error}`,
    });
  }
});

// 일기 수정
router.patch('/:id', upload.array('photos', 4), async (req, res) => {
  const journalID = req.params.id;
  const updatedJournal = req.body;

  try {
    const [updated] = await Journal.update(updatedJournal, {
      where: { id: journalID }
    });

    if (updated) {
      if (req.files && req.files.length > 0) {
        // 기존 이미지를 삭제하고 새로운 이미지 추가
        await JournalImage.destroy({ where: { journalID } });
        const images = req.files.map(file => ({
          journalID: journalID,
          journalImageString: file.filename,
        }));
        await JournalImage.bulkCreate(images);
      }

      const updatedJournal = await Journal.findOne({ 
        where: { id: journalID },
        include: [{ model: JournalImage }]
      });
      res.json({ success: true, documents: [updatedJournal], message: '일기 수정 완료' });
    } else {
      res.json({ success: false, documents: [], message: '일기 수정 실패: 일기를 찾을 수 없습니다.' });
    }
  } catch (error) {
    res.json({
      success: false,
      documents: [],
      message: `일기 수정 실패 ${error}`,
    });
  }
});

module.exports = router;