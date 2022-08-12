import { v4 as uuidv4 } from "uuid"
import database from "../../database"
import { hash } from "bcryptjs"

const createUserService = async (userData) => {
    
    try {
        const user = userData
    
        const hashedPassword = await hash(userData.password, 10)
    
        user.password = hashedPassword

        const res = await database.query(
            `INSERT INTO
                users(name, email, password, isadm)
            VALUES
                ($1, $2, $3, $4)
            RETURNING id, name, email, isadm;`,
            [user.name, user.email, user.password, user.isAdm]
        )
    
        return res.rows[0]
        
    } catch (error) {
        throw new Error(error)
    }
}

export default createUserService