const sync = require('./Models/sync');
sync();

const express = require(`express`);
const morgan = require(`morgan`);
const dotenv = require(`dotenv`);
dotenv.config();
const port = process.env.PORT || 3000;
const app = express();

const signRouter = require(`./Routers/signRouter`);
const journalRouter = require(`./Routers/journalRouter`);
const imageRouter = require('./Routers/imageRouter');
const checkAuth = require(`./Routers/authRouter`);

app.use(morgan(`dev`));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.use(`/sign`, signRouter);
app.use('/journal', checkAuth);
app.use(`/journal`, journalRouter);
app.use('/images', imageRouter);

app.use((_, res) => {
    res.status(404).json({ success: false, token: '', message: '요청이 잘못됨' });
  });

app.listen(port, () => {
    console.log(`PORT ${port}로 서버가 열렸습니다.`);
});