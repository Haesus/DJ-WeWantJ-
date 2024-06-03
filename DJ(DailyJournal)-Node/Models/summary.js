const Sequelize = require('sequelize');

class Summary extends Sequelize.Model {
  static init(sequelize) {
    return super.init(
      {
        summary: {
          type: Sequelize.STRING(200),
          allowNull: false,
        }
      },
      {
        sequelize,
        timestamps: true,
        paranoid: true,
        modelName: 'Summary',
        tableName: 'summary',
      }
    );
  }

  static associate(db) {
    db.Summary.belongsTo(db.Journal, { foreignKey: 'journalID', sourceKey: 'id' });
  }
}

module.exports = Summary;
