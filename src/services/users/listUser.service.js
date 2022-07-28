import User from "../../database/models/User"

const listUserService = async () => {
    const users = await User.find({})
    return users
}

export default listUserService