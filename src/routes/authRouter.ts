import { Router } from "express";
import { authenticate, register } from "../controllers/auth/auth.controller";

const authRouter = Router();

authRouter.route("/login").post(authenticate);
authRouter.route("/register").post(register);

export default authRouter;
