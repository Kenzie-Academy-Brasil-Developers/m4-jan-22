import mongoose from "mongoose"
import User from "../../database/models/User"

const retrieveUserService = async (userId) => {
    const user = await User.findById(userId).exec()
    return user
}

export default retrieveUserService