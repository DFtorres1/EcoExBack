# EcoExBack

## SetUp
Create a .env file with the following options
```
DATABASE_URL="postgresql://<postgresUser>:<password>@<dbHost>:<dbPort>/<dbName>?schema=<Schema>"
PORT=<Define the app port, default 3000>
```
Use `npm install` to install the required dependencies

## Prisma
Use `npx prisma` for a useful list of commands for Prisma

## Migrations
### Initial migration
***You must have PostgreSQL installed.***
Create a postgresql database named **`EcoExchange`**. Then run the following command for migration
`npx prisma migrate`
If the command does not work try with `npx prisma db push`

### Development migrations
When there is a change in the **`schema.prisma`** file run:
1. `npx prisma validate` To validate your Prisma schema
2. `npx prisma format` To format your Prisma schema
3. `npx prisma migrate dev --name <Migration_name>` To create a new migration and apply it to your database

## DB neccessary data
The following data is required to communicate with the frontend and should not be modified

**user_role**
1. `ADMIN`
2. `MOD`
2. `BENEF`
2. `DONOR`

## Run
Use `npm run dev` to run the application in development mode
