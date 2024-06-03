const express = require(`express`);
const { User } = require(`../Models/`);
const router = express.Router();
const bcrypt = require(`bcrypt`);
const jwt = require(`jsonwebtoken`);
const secret = process.env.JWT_SECRET;

const createHash = async (password, saltRound) => {
    const hashed = await bcrypt.hash(password, saltRound);
    return hashed;
};

router.post(`/signUp`, async (req, res) => {
    const member = req.body;
    member.password = await createHash(member.password, 10);

    const userExists = await User.findOne({ where: { userID: member.userID } });

    if (userExists) {
        res.json({
            success: false,
            document: [member],
            message: '이미 존재하는 아이디입니다.'
        });
    }

    try {
        const result = await User.create(member);
        res.json({
            success: true,
            document: [result],
            message: `신규 가입자 등록 완료. ${member.userID}님, 가입을 환영합니다.`
        });
    } catch {
        console.log(`신규 가입자 등록에 실패했습니다.`)
        console.log(member)
        res.json({
            success: false,
            document: [member],
            message: `신규 가입자 등록 실패. 서버 문제입니다.`
        });
    };
});

router.post(`/signIn`, async (req, res) => {
    const {userID, password} = req.body;
    console.log(req.query);
    console.log(req.body);
    const options = {
        attributes: [ `id`, `userID`, `userNickName`, `password`],
        where: { userID: userID },
    };

    const result = await User.findOne(options);
    
    if (result) {
        const compared = await bcrypt.compare(password, result.password);

        if (compared) {
            const token = jwt.sign({
                id: result.id,
                userID: userID,
                userNickName: result.userNickName,
                rol: `user`,
            },
            secret
            );
            res.json({
                success: true,
                token: token,
                document: [{
                    userID,
                    userNickName: result.userNickName
                }],
                message: `로그인에 성공했습니다. ${result.userNickName}님, 환영합니다.`
            });
        } else {
            res.json({
                success: false,
                token: "",
                document: [{
                    userID
                }],
                message: `로그인에 실패했습니다. 패스워드를 확인해주세요.`
            });
        };
    } else {
        res.json({
            success: false,
            token: "",
            document: [{
                userID
            }],
            message: `로그인에 실패했습니다. 아이디를 확인해주세요.`
        });
    };
});

module.exports = router;