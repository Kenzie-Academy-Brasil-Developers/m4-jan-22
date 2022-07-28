import User from "../../database/models/User"

const createUserService = async (userData) => {
    const user = new User({ ...userData })
    user.save(function (err) {
        if (err) return undefined
    })
    return user
}

export default createUserService