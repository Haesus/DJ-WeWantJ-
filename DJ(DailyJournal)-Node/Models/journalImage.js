const Sequelize = require('sequelize');

class JournalImage extends Sequelize.Model {
  static init(sequelize) {
    return super.init(
      {
        // 이미지이름
        journalImageString: {
          type: Sequelize.STRING(200),
          allowNull: false,
        }
      },
      {
        sequelize,
        timestamps: true,
        paranoid: true,
        modelName: 'JournalImage',
        tableName: 'journalImage',
      }
    );
  }

  static associate(db) {
    db.JournalImage.belongsTo(db.Journal, { foreignKey: 'journalID', sourceKey: 'id' });
  }
}

module.exports = JournalImage;
