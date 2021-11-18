package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DbConnection {
    private static final String URL ="jdbc:postgresql://127.0.0.1:5432/sql_project";
    private static final String USR ="postgres";
    private static final String PWD ="arcenciel";
    public Connection connection;


    public DbConnection() throws Exception {

        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            throw new Exception("DB_DRIVER_NOT_FOUND");
        }
        try {
            connection = DriverManager.getConnection(URL, USR, PWD);
        } catch (SQLException e) {
            throw new Exception("DB_NOT_FOUND");
        }
    }
}
