import { user_role, users } from "@prisma/client";
import { Request, Response } from "express";
import { prismaInstance } from "../..";
import jwt from "jsonwebtoken";

export const authenticate = async (req: Request, res: Response) => {
  const { username, password } = req.body;

  try {
    const user = await prismaInstance.users.findFirst({
      where: {
        username: String(username),
        password: String(password),
      },
      include: {
        roles_by_user: { include: { user_role: true } },
      },
    });

    !user
      ? res.status(401).json({
          error: "There is no user with this username or password",
        })
      : null;

    let userRoles: user_role[] = [];
    user?.roles_by_user.map((role) => {
      userRoles.push(role.user_role);
    });

    const token = jwt.sign(
      { userRoles: userRoles[0].role_name, userId: user?.id },
      "super-secret-key",
      { expiresIn: "1h" }
    );

    res.status(202).json({
      token: token,
      user: user,
    });
  } catch (err) {
    console.error("Query error:", err);
    res.status(500).json({ error: "Internal server error" });
  }
};

export const register = async (req: Request, res: Response) => {
  const newUser: users = req.body;

  try {
    const repeatedEmail = await prismaInstance.users.findFirst({
      where: { email: newUser.email },
    });

    const repeatedUser = await prismaInstance.users.findFirst({
      where: { username: newUser.username },
    });

    if (repeatedUser) {
      return res.status(409).json({ error: "Username already exists" });
    }
    if (repeatedEmail) {
      return res
        .status(409)
        .json({ error: "This email has already been taken" });
    }

    const createdUser = await prismaInstance.users.create({
      data: newUser,
    });

    await prismaInstance.roles_by_user.create({
      data: {
        id: createdUser.id,
        user_role_id: 4,
      },
    });

    res.status(201).json({ success: "User created successfully" });
  } catch (err) {
    console.error("Query error:", err);
    res.status(500).json({ error: "Internal server error" });
  }
};
