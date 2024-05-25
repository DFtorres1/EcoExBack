import { Router } from "express";
import {
  createResource,
  getResourceList,
  addToCart,
  getCart,
} from "../controllers/resources/resources.controller";

const resourceRouter = Router();

resourceRouter.route("/").post(createResource).get(getResourceList);
resourceRouter.route("/cart").post(addToCart).get(getCart);

export default resourceRouter;
