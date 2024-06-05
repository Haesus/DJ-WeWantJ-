const Sequelize = require('sequelize');
const process = require('process');
const env = process.env.NODE_ENV || 'development';
const config = require('../Config/config.js')[env];
const db = {};

let sequelize = new Sequelize(
  config.database,
  config.username,
  config.password,
  config
);

const User = require('./user');
const Journal = require('./journal');
const JournalImage = require('./journalImage');
const Summary = require('./summary');

db.User = User;
db.Journal = Journal;
db.JournalImage = JournalImage;
db.Summary = Summary;

User.init(sequelize);
Journal.init(sequelize);
JournalImage.init(sequelize);
Summary.init(sequelize);

User.associate(db);
Journal.associate(db);
JournalImage.associate(db);
Summary.associate(db);

db.sequelize = sequelize;
db.Sequelize = Sequelize;

module.exports = db;
