import database from '../../database'

const deleteUserService = async (userId) => {
    try {
        const res = await database.query(
            `DELETE FROM
                users
            WHERE
                id = $1
            RETURNING *;`,
            [userId]
        )

        if(res.rowCount === 0){
            throw new Error('User not found')
        }

    } catch (error) {
        throw new Error(error)
    }
}

export default deleteUserService