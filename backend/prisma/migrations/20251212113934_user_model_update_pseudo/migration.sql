/*
  Warnings:

  - The values [BEGINNER,INTERMEDIATE,ADVANCED] on the enum `Level` will be removed. If these variants are still used in the database, this will fail.
  - A unique constraint covering the columns `[pseudo]` on the table `User` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `pseudo` to the `User` table without a default value. This is not possible if the table is not empty.

*/
-- AlterEnum
BEGIN;
CREATE TYPE "Level_new" AS ENUM ('Debutant', 'Moyen', 'Expert');
ALTER TABLE "Event" ALTER COLUMN "level" DROP DEFAULT;
ALTER TABLE "UserSport" ALTER COLUMN "level" DROP DEFAULT;
ALTER TABLE "UserSport" ALTER COLUMN "level" TYPE "Level_new" USING ("level"::text::"Level_new");
ALTER TABLE "Event" ALTER COLUMN "level" TYPE "Level_new" USING ("level"::text::"Level_new");
ALTER TYPE "Level" RENAME TO "Level_old";
ALTER TYPE "Level_new" RENAME TO "Level";
DROP TYPE "Level_old";
ALTER TABLE "Event" ALTER COLUMN "level" SET DEFAULT 'Moyen';
ALTER TABLE "UserSport" ALTER COLUMN "level" SET DEFAULT 'Debutant';
COMMIT;

-- AlterTable
ALTER TABLE "Event" ALTER COLUMN "level" SET DEFAULT 'Moyen';

-- AlterTable
ALTER TABLE "User" ADD COLUMN     "pseudo" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "UserSport" ALTER COLUMN "level" SET DEFAULT 'Debutant';

-- CreateIndex
CREATE UNIQUE INDEX "User_pseudo_key" ON "User"("pseudo");
