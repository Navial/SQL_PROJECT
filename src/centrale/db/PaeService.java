package centrale.db;

import java.sql.*;
import java.util.ArrayList;

import org.springframework.security.crypto.bcrypt.BCrypt;

public class PaeService {

    private final Connection connection;
    private static final String SEL = BCrypt.gensalt();

    public PaeService() throws Exception {
        connection = new DbConnection().connection;
    }

    //case 1
    public void creerUe(String codeUe, String nomUe, int bloc, int nbrCredits) throws Exception {
        try {
            if(bloc > 3 || bloc < 1) throw new IllegalArgumentException("Le bloc doit être entre 1 et 3");
            PreparedStatement ps = connection.prepareStatement
                    ("SELECT projet_sql.ajouter_UE_central(?, ?, ?, ?) AS id_ue");
            ps.setString(1,codeUe);
            ps.setString(2, nomUe);
            ps.setInt(3, nbrCredits);
            ps.setInt(4, bloc);
            ResultSet rs = ps.executeQuery();

            rs.next();
            System.out.println(codeUe + " a bien été ajoutée");
        } catch (Exception se) {
            System.out.println(se.getMessage());
            throw new Exception();
        }
    }

    //case 2
    public void ajouter_prerequis(String uePrerequise, String ueSuivante) throws Exception {
        try {
            PreparedStatement ps = connection.prepareStatement
                    ("SELECT projet_sql.ajouter_prerequis_a_une_UE(?, ?) AS code_ue");
            ps.setString(1,uePrerequise);
            ps.setString(2, ueSuivante);
            ResultSet rs = ps.executeQuery();
            // TODO affichage de la réponse
            rs.next();
            System.out.println("Le prérequis a bien été ajouté.");
        } catch (Exception se) {
            System.out.println(se.getMessage());
            throw new Exception();
        }
    }

    //case 3
    public void ajouter_etudiant(String nom, String prenom, String email, String pwd, int bloc) throws Exception{
        try {
                if(bloc > 3 || bloc < 1) throw new IllegalArgumentException("Le bloc doit être entre 1 et 3");
                String pwdHash = BCrypt.hashpw(pwd, SEL);
                PreparedStatement ps = connection.prepareStatement
                        ("SELECT projet_sql.ajouter_etudiant(?, ?, ?, ?, ?) ");
                ps.setString(1, nom);
                ps.setString(2, prenom);
                ps.setString(3, email);
                ps.setString(4, pwdHash);
                ps.setInt(5, bloc);

                ResultSet rs = ps.executeQuery();
            // TODO affichage de la réponse
            rs.next();
            System.out.println("L'étudiant a bien été ajouté");
        }catch (Exception se){
            System.out.println(se.getMessage());
            throw new Exception();
        }
    }

    //case 4
    public void encoderUeVal(String email, int idUe) throws Exception{
        try {

            PreparedStatement ps = connection.prepareStatement
                    ("SELECT projet_sql.encoder_UE_validee(?, ?) ");
            ps.setString(1, email);
            ps.setInt(2, idUe);

            ResultSet rs = ps.executeQuery();
            rs.next();
            // TODO affichage de la réponse
            System.out.println("L'ue a bien été encodée");
        }catch (Exception se){
            System.out.println(se.getMessage());
            throw new Exception();
        }
    }
    //case 5 visualiserTousEtudiantDUnBloc(bloc)
    public void visualiserTousEtudiantDUnBloc(int bloc) throws Exception{
        try {
            if(bloc > 3 || bloc < 1) throw new IllegalArgumentException("Le bloc doit être entre 1 et 3");
            PreparedStatement ps = connection.prepareStatement
                    ("SELECT projet_sql.visualiser_tous_etudiants_d_un_bloc (?) ");
            ps.setInt(1, bloc);
            // Print du record renvoye par la procedure
            ResultSet rs = ps.executeQuery();
            ResultSetMetaData rsmd = rs.getMetaData();
            int columnsNumber = rsmd.getColumnCount();
            while (rs.next()) {
                for (int i = 1; i <= columnsNumber; i++) {
                    if (i > 1) System.out.print(",  ");
                    String columnValue = rs.getString(i);
                    System.out.print(columnValue + " " + rsmd.getColumnName(i));
                }
                System.out.println("");
            }
        }catch (Exception se){
            System.out.println(se.getMessage());
            throw new Exception();
        }
    }

    // case 6
    public void visualiserCreditsEtudiants() throws Exception{
        try {

            PreparedStatement ps = connection.prepareStatement
                    ("SELECT projet_sql.visualiser_credits_etudiants()");
            ResultSet rs = ps.executeQuery();
            // Print du record renvoye par la procedure
            ResultSetMetaData rsmd = rs.getMetaData();
            int columnsNumber = rsmd.getColumnCount();
            while (rs.next()) {
                for (int i = 1; i <= columnsNumber; i++) {
                    if (i > 1) System.out.print(",  ");
                    String columnValue = rs.getString(i);
                    System.out.print(columnValue + " " + rsmd.getColumnName(i));
                }
                System.out.println("");
            }
        }catch (Exception se){
            System.out.println(se.getMessage());
            throw new Exception();
        }
    }
    //case 7
    public void visualiserEtudiantsNonValides() throws Exception{
        try {

            PreparedStatement ps = connection.prepareStatement
                    ("SELECT projet_sql.visualiser_etudiants_non_valides()  AS code_ue");
            ResultSet rs = ps.executeQuery();
            // Print du record renvoye par la procedure
            ResultSetMetaData rsmd = rs.getMetaData();
            int columnsNumber = rsmd.getColumnCount();
            while (rs.next()) {
                for (int i = 1; i <= columnsNumber; i++) {
                    if (i > 1) System.out.print(",  ");
                    String columnValue = rs.getString(i);
                    System.out.print(columnValue + " " + rsmd.getColumnName(i));
                }
                System.out.println("");
            }
        }catch (Exception se){
            System.out.println(se.getMessage());
            throw new Exception();
        }
    }
    // case 8
    public void visualiserCreditsEtudiantsBloc( int bloc ) throws Exception{
        try {
            if(bloc > 3 || bloc < 1) throw new IllegalArgumentException("Le bloc doit être entre 1 et 3");

            PreparedStatement ps = connection.prepareStatement
                    ("SELECT projet_sql.visualiser_credits_etudiants (?)  AS code_ue");
            ps.setInt(1, bloc);
            ResultSet rs = ps.executeQuery();
            // Print du record renvoye par la procedure
            ResultSetMetaData rsmd = rs.getMetaData();
            int columnsNumber = rsmd.getColumnCount();
            while (rs.next()) {
                for (int i = 1; i <= columnsNumber; i++) {
                    if (i > 1) System.out.print(",  ");
                    String columnValue = rs.getString(i);
                    System.out.print(columnValue + " " + rsmd.getColumnName(i));
                }
                System.out.println("");
            }
        }catch (Exception se){
            System.out.println(se.getMessage());
            throw new Exception();
        }
    }


}
