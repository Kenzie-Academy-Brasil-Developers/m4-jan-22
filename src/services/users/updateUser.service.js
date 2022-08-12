import database from '../../database'

const updateUserService = async(userId, userData) => {

    try {

        if(userData.id){
            delete userData['id']
        }
        
        let query = 'UPDATE users SET '
        const keys = Object.keys(userData)
        const values = Object.values(userData)

        keys.forEach((key, index) => {
            query += `${key} = \$${index+=1}, `
        })

        query = query.slice(0, -2)

        query += ` WHERE id = \$${keys.length+=1} RETURNING *;`

        const res = await database.query(
            query,
            [...values, userId]
        )

        if(res.rowCount === 0){
            throw new Error('User not found')
        }

        return res.rows[0]
        
    } catch (error) {
        throw new Error(error)
    }

}

export default updateUserService