import { Router } from "express";
import authRouter from "./authRouter";
import resourceRouter from "./resourcesRouter";

const mainRouter = Router();

mainRouter.get("/", function (req, res) {
  res.status(200).json({ response: "response" });
});

mainRouter.use("/authentication", authRouter)
mainRouter.use("/resource", resourceRouter)

export default mainRouter