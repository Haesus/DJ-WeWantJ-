// const sync = require('./Models/sync');
// sync();

const express = require(`express`);
const morgan = require(`morgan`);
const dotenv = require(`dotenv`);
dotenv.config();
const port = process.env.PORT || 3000;
const app = express();
const signRouter = require(`./Routers/signRouter`);

app.use(morgan(`dev`));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.use(`/sign`, signRouter);

app.listen(port, () => {
    console.log(`PORT ${port}로 서버가 열렸습니다.`);
});