import { cart, images, resources } from "@prisma/client";
import { Request, Response } from "express";
import { prismaInstance } from "../..";

export const createResource = async (req: Request, res: Response) => {
  const newResource: resources = req.body;
  // const resourceImages: images[] = req.body.images;

  try {
    newResource.resource_name_data = newResource.resourceName
      .toLowerCase()
      .normalize("NFD")
      .replace(/[\u0300-\u036f]/g, "")
      .trim();

    const repeatedName = await prismaInstance.resources.findFirst({
      where: {
        resource_name_data: newResource.resource_name_data,
        userId: newResource.userId,
      },
    });

    // if (resourceImages.length <= 0) {
    //   res.status(406).json({ error: "Request should have at least one image" });
    // }

    if (repeatedName) {
      return res
        .status(409)
        .json({ error: "This resource already exists for this user" });
    }

    await prismaInstance.resources.create({
      data: newResource,
    });

    // resourceImages.map((image) => {
    //   image.resoruceId = createdResource.resourceId;
    // });

    // const imageRequest = resourceImages.map((image) =>
    //   prismaInstance.images.create({ data: image })
    // );

    res.status(201).json({ success: "Resource created successfully" });
  } catch (err) {
    console.error("Query error:", err);
    res.status(500).json({ error: "Internal server error" });
  }
};

export const addToCart = async (req: Request, res: Response) => {
  const newCart: cart = req.body;

  if (!newCart.resourceId) {
    res.status(400).json({ error: "Should have a resource id" });
  } else if (!newCart.userId) {
    res.status(400).json({ error: "Should have an user id" });
  }

  try {
    await prismaInstance.cart.create({
      data: newCart,
    });
    res.status(201).json({ success: "Resource added to cart successfully" });
  } catch (err) {
    res.status(400).json({ error: "Internal Server Error" });
  }
};

export const getCart = async (req: Request, res: Response) => {
  try {
    const paramUserId = req.query.userId ? +req.query.userId : 0;
    const resourceList = await prismaInstance.$transaction(async (tx) => {
      const userCart = await tx.cart.findMany({
        where: { userId: paramUserId },
        include: {
          resources: true,
        },
      });

      return userCart;
    });
    res.status(202).json(resourceList);
  } catch (error) {
    console.error("Query error:", error);
    res.status(500).json({ error: "Internal server error" });
  }
};

export const getResourceList = async (req: Request, res: Response) => {
  try {
    const resourceList: resources[] = await prismaInstance.resources.findMany();
    res.status(202).json({
      resource_list: resourceList,
    });
  } catch (error) {
    console.error("Query error:", error);
    res.status(500).json({ error: "Internal server error" });
  }
};
