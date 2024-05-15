import { Router } from "express";
import authenticate from "../controllers/auth/auth.controller";

const router = Router();

router.get("/", function (req, res) {
    res.status(200).json({ response: "response" });
  });

router.route('/authentication/login').post(authenticate);

export default router;
