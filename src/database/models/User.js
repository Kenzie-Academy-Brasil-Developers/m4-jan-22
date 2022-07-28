import mongoDB from "../mongo.config"

const User = mongoDB.model('User', {
    name: {
        type: String,
        required: true
    }, 
    email: {
        type: String,
        unique: true,
        required: true
    }
})

export default User
