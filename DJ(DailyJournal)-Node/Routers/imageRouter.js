const express = require('express');
const router = express.Router();

router.get('/:filename', (req, res) => {
  const filename = req.params.filename;
  return res.sendFile(process.cwd() + '/files/' + filename);
});

module.exports = router;
