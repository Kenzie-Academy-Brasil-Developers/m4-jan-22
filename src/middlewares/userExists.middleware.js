import mongoose from "mongoose"
import User from "../database/models/User"

const userExists = async (request, response, next) => {
    const { id } = request.params
    const user = await User.findById(id).exec()

    if(user){
        request.user = user
        return next()
    }

    return response.status(404).json({
        message: 'User not found'
    })
}

export default userExists