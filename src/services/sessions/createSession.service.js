import database from "../../database"
import jwt from "jsonwebtoken"
import { compare } from "bcryptjs"
import "dotenv/config"

const createSessionService = async ({email, password}) => {

    try {
        let user = await database.query(
            `SELECT
                *
            FROM
                users
            WHERE email = $1;`,
            [email]
        )
    
        user = user.rows[0]
    
        if(!user){
            throw new Error("Invalid email or password")
        }
    
        const passwordMatch = await compare(password, user.password)
    
        if(!passwordMatch){
            throw new Error("Invalid email or password")
        }
    
        const token = jwt.sign({
            email: user.email,
            isAdm: user.isadm
        },
        process.env.SECRET_KEY,
        {
            expiresIn: "1h",
            subject: user.id
        })
    
        return token
    } catch (error) {
        throw new Error(error)        
    }

}

export default createSessionService