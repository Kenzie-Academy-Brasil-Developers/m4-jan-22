import createUserService from "../services/users/createUser.service"
import listUserService from "../services/users/listUser.service"
import retrieveUserService from "../services/users/retrieveUser.service"
import deleteUserService from "../services/users/deleteUser.service"
import updateUserService from "../services/users/updateUser.service"

const createUserController = async (request, response) => {
    try {
        const user = request.body
        const newUser = await createUserService(user)
        return response.status(201).json(newUser)
    } catch (error) {
        return response.status(400).json({
            message: error.message
        })
    }
}

const listUserController = async (request, response) => {
    try {
        const users = await listUserService()
        return response.json(users)
    } catch (error) {
        return response.status(400).json({
            message: error.message
        })
    }
}

const retrieveUserController = async (request, response) => {
    try {
        const { id } = request.params
        const user = await retrieveUserService(id)
        return response.json(user)
    } catch (error) {
        return response.status(400).json({
            message: error.message
        })
    }
}

const deleteUserController = async (request, response) => {
    try {
        const id = request.params.id
        await deleteUserService(id)
        return response.status(204).send()
    } catch (error) {
        return response.status(400).json({
            message: error.message
        })
    }
}

const updateUserController = async (request, response) => {
    try {
        const id = request.params.id
        const userData = request.body
        const user = await updateUserService(id, userData)
        return response.json(user)
    } catch (error) {
        return response.status(400).json({
            message: error.message
        })
    }
}

export { createUserController, listUserController, retrieveUserController, deleteUserController, updateUserController }