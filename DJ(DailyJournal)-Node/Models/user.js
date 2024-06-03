const Sequelize = require('sequelize');

class User extends Sequelize.Model {
  static init(sequelize) {
    return super.init(
      {
        //유저아이디
        userID: {
          type: Sequelize.STRING(50),
          allowNull: false,
          unique: true,
        },
        //유저닉네임
        userNickName: {
            type: Sequelize.STRING(50),
            allowNull: false,
        },
        //유저패스워드
        password: {
          type: Sequelize.STRING(200),
          allowNull: false,
        },
      },
      {
        sequelize,
        timestamps: true,
        paranoid: true,
        modelName: 'User',
        tableName: 'user',
      }
    );
  }

  static associate(db) {
    db.User.hasMany(db.Journal, { foreignKey: 'userID', sourceKey: 'id' });
  }
}

module.exports = User;
