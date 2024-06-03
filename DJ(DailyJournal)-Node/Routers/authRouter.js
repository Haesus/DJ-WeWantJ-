const jwt = require(`jsonwebtoken`);
const secret = process.env.JWT_SECRET;

const auth = async (req, res, next) => {
    const auth = req.get(`Authorization`);

    if (!(auth && auth.startsWith(`Bearer `))) {
        res.json({
            success: false,
            message: `Auth Error`
        });
    };

    const token = auth.split(` `)[1]

    jwt.verify(token, secret, (error, decoded) => {
        if (error) {
            res.json({
                success: false,
                message: `Auth Error`
            });
        } else {
            req.id = decoded.id;
            req.userID = decoded.userID;
            req.userNickName = decoded.userNickName;
            req.role = decoded.rol;
            
            next();
        };
    });
};

module.exports = auth;