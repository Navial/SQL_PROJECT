package db;

import model.Etudiant;
import org.springframework.security.crypto.bcrypt.BCrypt;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class PaeService {

    private final Connection connection;

    public PaeService() throws Exception {
        connection = new DbConnection().connection;
    }

    public boolean ajoutUE(String codeUE) throws Exception {
        try {

            PreparedStatement ps = connection.prepareStatement
                    ("UPDATE code_ue table lignes_ue " +
                            "SET ;");
            ps.setString(1,codeUE);
            ResultSet rs = ps.executeQuery();

        } catch (SQLException se) {
            throw new Exception("AUTH_FAIL");
        }

        return false;
    }

}
