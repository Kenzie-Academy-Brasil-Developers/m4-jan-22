import User from "../../database/models/User"

const filterUserService = async (word) => {
    const user = await User.find({name: RegExp(word, "i")}).exec()
    return user
}

export default filterUserService