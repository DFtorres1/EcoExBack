/*
  Warnings:

  - You are about to drop the column `resurce_name_data` on the `resources` table. All the data in the column will be lost.
  - Added the required column `resource_name_data` to the `resources` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "resources" DROP COLUMN "resurce_name_data",
ADD COLUMN     "resource_name_data" TEXT NOT NULL;
