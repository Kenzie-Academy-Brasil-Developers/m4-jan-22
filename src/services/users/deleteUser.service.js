import mongoose from "mongoose"
import User from "../../database/models/User"

const deleteUserService = async (userId) => {
    await User.deleteOne({_id: userId}).exec()
}

export default deleteUserService