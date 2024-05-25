/*
  Warnings:

  - Added the required column `resurce_name_data` to the `resources` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "resources" ADD COLUMN     "resurce_name_data" TEXT NOT NULL;
