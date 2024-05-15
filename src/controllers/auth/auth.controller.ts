import { roles_by_user, user_role, users } from "@prisma/client";
import { Request, Response } from "express";
import { prismaInstance } from "../..";
import jwt from "jsonwebtoken";

const authenticate = async (req: Request, res: Response) => {
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
      ? res.status(400).json({
          error: "There is no user with this username or password",
        })
      : null;

    let userRoles: user_role[] = [];
    user?.roles_by_user.map((role) => {
      userRoles.push(role.user_role);
    });

    const token = jwt.sign(
      { userRoles: userRoles[0].role_name },
      "super-secret-key",
      { expiresIn: "1h" }
    );

    res.status(200).json({
      token: token,
      user: user,
    });
  } catch (err) {
    console.error("Query error:", err);
    res.status(500).json({ error: "Internal server error" });
  }
};

export default authenticate;
