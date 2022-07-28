import createUserService from "../services/users/createUser.service"
import listUserService from "../services/users/listUser.service"
import retrieveUserService from "../services/users/retrieveUser.service"
import filterUserService from "../services/users/filterUser.service"
import User from "../database/models/User"
import deleteUserService from "../services/users/deleteUser.service"
import updateUserService from "../services/users/updateUser.service"

const createUserController = async (request, response) => {
    const user = request.body
    const newUser = await createUserService(user)
    if (!newUser) return response.status(400).json({
        message: "The user already exists"
    })
    return response.status(201).json(newUser) 
}

const listUserController = async (request, response) => {
    const users = await listUserService()
    return response.json(users)
}

const retrieveUserController = async (request, response) => {
    const { id } = request.params
    const user = await retrieveUserService(id)
    return response.json(user)
}

const filterUserController = async (request, response) => {
    const { word } = request.params
    const user = await filterUserService(word)
    return response.json(user)
}

const updateUserController = async (request, response) => {
    const { id } = request.params
    const user = await updateUserService(id)  
    return response.send(200).json(user)
}

const deleteUserController = async (request, response) => {
    const { id } = request.params
    await deleteUserService(id)  
    return response.sendStatus(204)
}

export { createUserController, listUserController, retrieveUserController, filterUserController, deleteUserController, updateUserController }