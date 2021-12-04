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
        }
    }

    //case 4
    public void encoderUeVal(String email, String codeUE) throws Exception{
        try {

            PreparedStatement ps = connection.prepareStatement
                    ("SELECT projet_sql.encoder_UE_validee(?, ?) ");
            ps.setString(1, email);
            ps.setString(2, codeUE);

            ResultSet rs = ps.executeQuery();
            rs.next();
            // TODO affichage de la réponse
            System.out.println("L'ue a bien été encodée");
        }catch (Exception se){
            System.out.println(se.getMessage());
        }
    }
    //case 5 visualiserTousEtudiantDUnBloc(bloc)
    public void visualiserTousEtudiantDUnBloc(int bloc) throws Exception{
        try {
            if(bloc > 3 || bloc < 1) throw new IllegalArgumentException("Le bloc doit être entre 1 et 3");
            PreparedStatement ps = connection.prepareStatement
                    ("SELECT nom, prenom FROM projet_sql.visualiser_etudiants WHERE bloc = ? ");
            ps.setInt(1, bloc);

            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                System.out.println(rs.getString("nom") + " " + rs.getString("prenom"));
            }
        }catch (Exception se){
            System.out.println(se.getMessage());
        }
    }

    // case 6
    public void visualiserCreditsEtudiants() throws Exception{
        try {

            PreparedStatement ps = connection.prepareStatement
                    ("SELECT nom, prenom, somme_credits FROM projet_sql.visualiser_etudiants");

            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                System.out.println(rs.getString("nom") + " " + rs.getString("prenom") + " " + rs.getString("somme_credits"));
            }
        }catch (SQLException se){
            System.out.println(se.getMessage());
        }
    }
    //case 7
    public void visualiserEtudiantsNonValides() throws Exception{
        try {

            PreparedStatement ps = connection.prepareStatement
                    ("SELECT nom, prenom FROM projet_sql.visualiser_etudiants WHERE est_valide = false");
            ResultSet rs = ps.executeQuery();

            while(rs.next()){
                System.out.println(rs.getString("nom") + " " + rs.getString("prenom"));
            }
        }catch (Exception se){
            System.out.println(se.getMessage());
        }
    }
    // case 8
    public void visualiserUesDUnBloc(int bloc ) throws Exception{
        try {
            if(bloc > 3 || bloc < 1) throw new IllegalArgumentException("Le bloc doit être entre 1 et 3");

            PreparedStatement ps = connection.prepareStatement
                    ("SELECT * FROM projet_sql.visualiser_ue WHERE \"Bloc\" = ?");
            ps.setInt(1, bloc);
            // Print du record renvoye par la procedure
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                System.out.println(rs.getString(1) + " " + rs.getString(2) );
            }

        }catch (Exception se){
            System.out.println(se.getMessage());
        }
    }


}
