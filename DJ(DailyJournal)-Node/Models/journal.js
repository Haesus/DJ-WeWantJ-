const Sequelize = require('sequelize');

class Journal extends Sequelize.Model {
  static init(sequelize) {
    return super.init(
      {
        journalTitle: {
          //일기제목
          type: Sequelize.STRING(50),
          allowNull: false,
        },
        journalText: {
          //일기내용
          type: Sequelize.TEXT,
          allowNull: false,
        },
      },
      {
        sequelize,
        timestamps: true,
        paranoid: true,
        modelName: 'Journal',
        tableName: 'journal',
      }
    );
  }

  static associate(db) {
    db.Journal.belongsTo(db.User, { foreignKey: 'userID', sourceKey: 'id' });
    db.Journal.hasMany(db.JournalImage, { foreignKey: 'journalID', sourceKey: 'id' });
    db.Journal.hasOne(db.Summary, { foreignKey: 'journalID', sourceKey: 'id' });
  }
}

module.exports = Journal;