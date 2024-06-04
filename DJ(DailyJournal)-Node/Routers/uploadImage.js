const multer = require('multer');
const path = require('path');
const fs = require('fs');

// 'files' 디렉토리가 있는지 확인하고 없으면 생성
try {
  fs.readdirSync('files');
} catch (error) {
  console.log(error);
  fs.mkdirSync('files');
}

const upload = multer({
  storage: multer.diskStorage({
    destination(req, file, done) {
      done(null, 'files/');
    },
    filename(req, file, done) {
      const originalName = file.originalname; 
      req.filename = originalName;
      done(null, originalName);
    },
  }),
  limits: { fileSize: 1024 * 1024 * 100 },
});

module.exports = upload;
