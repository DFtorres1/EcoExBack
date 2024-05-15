-- CreateTable
CREATE TABLE "communities" (
    "communityId" BIGSERIAL NOT NULL,
    "communityName" TEXT NOT NULL,
    "description" TEXT NOT NULL,

    CONSTRAINT "communities_pkey" PRIMARY KEY ("communityId")
);

-- CreateTable
CREATE TABLE "communitiesResources" (
    "commResId" BIGSERIAL NOT NULL,
    "resourceId" BIGINT NOT NULL,
    "communityId" BIGINT NOT NULL,

    CONSTRAINT "communitiesResources_pkey" PRIMARY KEY ("commResId")
);

-- CreateTable
CREATE TABLE "exchangedResources" (
    "exResId" BIGSERIAL NOT NULL,
    "resourceId" BIGINT NOT NULL,
    "exchangeId" BIGINT NOT NULL,

    CONSTRAINT "exchangedResources_pkey" PRIMARY KEY ("exResId")
);

-- CreateTable
CREATE TABLE "exchanges" (
    "exchangeId" BIGSERIAL NOT NULL,
    "offeredResource" BIGINT NOT NULL,
    "desiredResource" BIGINT NOT NULL,
    "exchangeDate" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "exchanges_pkey" PRIMARY KEY ("exchangeId")
);

-- CreateTable
CREATE TABLE "favorites" (
    "favoriteId" BIGSERIAL NOT NULL,
    "userId" BIGINT NOT NULL,
    "resourceId" BIGINT NOT NULL,

    CONSTRAINT "favorites_pkey" PRIMARY KEY ("favoriteId")
);

-- CreateTable
CREATE TABLE "followers" (
    "followId" BIGSERIAL NOT NULL,
    "followerUserId" BIGINT NOT NULL,
    "followedUserId" BIGINT NOT NULL,

    CONSTRAINT "followers_pkey" PRIMARY KEY ("followId")
);

-- CreateTable
CREATE TABLE "images" (
    "imageId" BIGSERIAL NOT NULL,
    "resoruceId" BIGINT NOT NULL,
    "imgage" BYTEA NOT NULL,

    CONSTRAINT "images_pkey" PRIMARY KEY ("imageId")
);

-- CreateTable
CREATE TABLE "locationResources" (
    "locResId" BIGSERIAL NOT NULL,
    "resourceId" BIGINT NOT NULL,
    "locationId" BIGINT NOT NULL,

    CONSTRAINT "locationResources_pkey" PRIMARY KEY ("locResId")
);

-- CreateTable
CREATE TABLE "locations" (
    "locationId" BIGSERIAL NOT NULL,
    "locationName" TEXT NOT NULL,
    "latitude" DECIMAL NOT NULL,
    "longitude" DECIMAL NOT NULL,

    CONSTRAINT "locations_pkey" PRIMARY KEY ("locationId")
);

-- CreateTable
CREATE TABLE "messages" (
    "messageId" BIGSERIAL NOT NULL,
    "senderId" BIGINT NOT NULL,
    "receiverId" BIGINT NOT NULL,
    "content" TEXT NOT NULL,
    "sentDate" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "messages_pkey" PRIMARY KEY ("messageId")
);

-- CreateTable
CREATE TABLE "notifications" (
    "notificationId" BIGSERIAL NOT NULL,
    "userId" BIGINT NOT NULL,
    "message" TEXT NOT NULL,
    "sentDate" TIMESTAMPTZ(6) NOT NULL,
    "read" BOOLEAN NOT NULL,

    CONSTRAINT "notifications_pkey" PRIMARY KEY ("notificationId")
);

-- CreateTable
CREATE TABLE "reports" (
    "reportId" BIGSERIAL NOT NULL,
    "userId" BIGINT NOT NULL,
    "resourceId" BIGINT NOT NULL,
    "reason" TEXT NOT NULL,
    "description" TEXT NOT NULL,

    CONSTRAINT "reports_pkey" PRIMARY KEY ("reportId")
);

-- CreateTable
CREATE TABLE "resources" (
    "resourceId" BIGSERIAL NOT NULL,
    "userId" BIGINT NOT NULL,
    "resourceName" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "category" TEXT NOT NULL,
    "state" TEXT NOT NULL,
    "available" BOOLEAN NOT NULL,

    CONSTRAINT "resources_pkey" PRIMARY KEY ("resourceId")
);

-- CreateTable
CREATE TABLE "review" (
    "reviewId" BIGSERIAL NOT NULL,
    "userId" BIGINT NOT NULL,
    "exchangeId" BIGINT NOT NULL,
    "stars" INTEGER NOT NULL,
    "comment" TEXT,

    CONSTRAINT "review_pkey" PRIMARY KEY ("reviewId")
);

-- CreateTable
CREATE TABLE "roles_by_user" (
    "rbu_id" BIGSERIAL NOT NULL,
    "id" BIGINT NOT NULL,
    "user_role_id" BIGINT NOT NULL,

    CONSTRAINT "rolesByUser_pkey" PRIMARY KEY ("rbu_id")
);

-- CreateTable
CREATE TABLE "tagResources" (
    "tagResId" BIGSERIAL NOT NULL,
    "tagId" BIGINT NOT NULL,
    "resourceId" BIGINT NOT NULL,

    CONSTRAINT "tagResources_pkey" PRIMARY KEY ("tagResId")
);

-- CreateTable
CREATE TABLE "tags" (
    "tagId" BIGSERIAL NOT NULL,
    "tagName" TEXT NOT NULL,

    CONSTRAINT "tags_pkey" PRIMARY KEY ("tagId")
);

-- CreateTable
CREATE TABLE "userCommunity" (
    "userCommunityId" BIGSERIAL NOT NULL,
    "userId" BIGINT NOT NULL,
    "communityId" BIGINT NOT NULL,

    CONSTRAINT "userCommunity_pkey" PRIMARY KEY ("userCommunityId")
);

-- CreateTable
CREATE TABLE "user_role" (
    "user_role_id" BIGSERIAL NOT NULL,
    "role_name" TEXT NOT NULL,

    CONSTRAINT "userRole_pkey" PRIMARY KEY ("user_role_id")
);

-- CreateTable
CREATE TABLE "Post" (
    "id" BIGSERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "title" VARCHAR(255) NOT NULL,
    "content" TEXT,
    "published" BOOLEAN NOT NULL DEFAULT false,
    "authorId" BIGINT NOT NULL,

    CONSTRAINT "Post_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Profile" (
    "id" BIGSERIAL NOT NULL,
    "bio" TEXT,
    "userId" BIGINT NOT NULL,

    CONSTRAINT "Profile_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "users" (
    "id" BIGSERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "username" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "register_date" DATE NOT NULL,

    CONSTRAINT "user_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Profile_userId_key" ON "Profile"("userId");

-- AddForeignKey
ALTER TABLE "communitiesResources" ADD CONSTRAINT "communitiesResources_communityId_fkey" FOREIGN KEY ("communityId") REFERENCES "communities"("communityId") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "communitiesResources" ADD CONSTRAINT "communitiesResources_resourceId_fkey" FOREIGN KEY ("resourceId") REFERENCES "resources"("resourceId") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "exchangedResources" ADD CONSTRAINT "exchangedResources_exchangeId_fkey" FOREIGN KEY ("exchangeId") REFERENCES "exchanges"("exchangeId") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "exchangedResources" ADD CONSTRAINT "exchangedResources_resourceId_fkey" FOREIGN KEY ("resourceId") REFERENCES "resources"("resourceId") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "exchanges" ADD CONSTRAINT "exchanges_desiredResource_fkey" FOREIGN KEY ("desiredResource") REFERENCES "resources"("resourceId") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "exchanges" ADD CONSTRAINT "exchanges_offeredResource_fkey" FOREIGN KEY ("offeredResource") REFERENCES "resources"("resourceId") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "favorites" ADD CONSTRAINT "favorites_resourceId_fkey" FOREIGN KEY ("resourceId") REFERENCES "resources"("resourceId") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "favorites" ADD CONSTRAINT "favorites_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "followers" ADD CONSTRAINT "followers_followedUserId_fkey" FOREIGN KEY ("followedUserId") REFERENCES "users"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "followers" ADD CONSTRAINT "followers_followerUserId_fkey" FOREIGN KEY ("followerUserId") REFERENCES "users"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "images" ADD CONSTRAINT "images_resoruceId_fkey" FOREIGN KEY ("resoruceId") REFERENCES "resources"("resourceId") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "locationResources" ADD CONSTRAINT "locationResources_locationId_fkey" FOREIGN KEY ("locationId") REFERENCES "locations"("locationId") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "locationResources" ADD CONSTRAINT "locationResources_resourceId_fkey" FOREIGN KEY ("resourceId") REFERENCES "resources"("resourceId") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "messages" ADD CONSTRAINT "messages_receiverId_fkey" FOREIGN KEY ("receiverId") REFERENCES "users"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "messages" ADD CONSTRAINT "messages_senderId_fkey" FOREIGN KEY ("senderId") REFERENCES "users"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "notifications" ADD CONSTRAINT "notifications_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "reports" ADD CONSTRAINT "reports_resourceId_fkey" FOREIGN KEY ("resourceId") REFERENCES "resources"("resourceId") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "reports" ADD CONSTRAINT "reports_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "resources" ADD CONSTRAINT "resources_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "review" ADD CONSTRAINT "review_exchangeId_fkey" FOREIGN KEY ("exchangeId") REFERENCES "exchanges"("exchangeId") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "review" ADD CONSTRAINT "review_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "roles_by_user" ADD CONSTRAINT "rolesByUser_userId_fkey" FOREIGN KEY ("id") REFERENCES "users"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "roles_by_user" ADD CONSTRAINT "rolesByUser_userRoleId_fkey" FOREIGN KEY ("user_role_id") REFERENCES "user_role"("user_role_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "tagResources" ADD CONSTRAINT "tagResources_resourceId_fkey" FOREIGN KEY ("resourceId") REFERENCES "resources"("resourceId") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "tagResources" ADD CONSTRAINT "tagResources_tagId_fkey" FOREIGN KEY ("tagId") REFERENCES "tags"("tagId") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "userCommunity" ADD CONSTRAINT "userCommunity_communityId_fkey" FOREIGN KEY ("communityId") REFERENCES "communities"("communityId") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "userCommunity" ADD CONSTRAINT "userCommunity_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "Post" ADD CONSTRAINT "Post_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Profile" ADD CONSTRAINT "Profile_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
