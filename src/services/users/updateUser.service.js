import mongoose from "mongoose"
import User from "../../database/models/User"

const updateUserService = async (userId) => {
    await User.updateOne({_id: userId}, {name: "teste"}).exec()
    const user = await User.findById(userId).exec()
    return user
}

export default updateUserService