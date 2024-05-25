import { PrismaClient } from "@prisma/client";
import express from "express";
import path from "path";
import cookieParser from "cookie-parser"
import cors from "cors";
import mainRouter from "./routes/mainRouter";

export const prismaInstance = new PrismaClient()
const app = express()

const port = process.env.PORT || 3000

app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, "../public")));
app.use(cors({
    origin: "*"
}))
app.use(mainRouter)
app.use(express.static(path.join(__dirname, '../public')));

app.listen(port, () => {console.log('listening on port ' + port)})
