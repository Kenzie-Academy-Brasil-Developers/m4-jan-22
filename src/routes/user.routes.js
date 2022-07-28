import { Router } from "express";
import { createUserController, listUserController, retrieveUserController, filterUserController, deleteUserController, updateUserController } from "../controllers/user.controllers";
import userExists from "../middlewares/userExists.middleware";
import userSchema from "../database/schemas/user.schema"
import schemaValidation from "../middlewares/schemaValidation.middleware";

const userRoutes = Router()

userRoutes.post('', schemaValidation(userSchema), createUserController)
userRoutes.get('', listUserController)
userRoutes.get('/id/:id', userExists, retrieveUserController)
userRoutes.patch('/id/:id', userExists, updateUserController)
userRoutes.delete('/id/:id', userExists, deleteUserController)
userRoutes.get('/filter/:word', filterUserController)

export default userRoutes