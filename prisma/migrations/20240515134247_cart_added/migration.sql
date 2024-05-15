-- CreateTable
CREATE TABLE "cart" (
    "cartId" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,
    "resourceId" INTEGER NOT NULL,

    CONSTRAINT "cart_pkey" PRIMARY KEY ("cartId")
);

-- AddForeignKey
ALTER TABLE "cart" ADD CONSTRAINT "cart_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "cart" ADD CONSTRAINT "cart_resourceId_fkey" FOREIGN KEY ("resourceId") REFERENCES "resources"("resourceId") ON DELETE NO ACTION ON UPDATE NO ACTION;
