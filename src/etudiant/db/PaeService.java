package etudiant.db;


import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PaeService {

    private final Connection connection;

    public PaeService() throws Exception {
        connection = new DbConnection().connection;
    }

    public void ajouterUE(int idEtudiant,String codeUe) throws Exception {
        try {

            PreparedStatement ps = connection.prepareStatement
                    ("SELECT projet_sql.ajouter_ue(?, ?) AS code_ue");
            ps.setString(1,codeUe);
            ps.setInt(2,idEtudiant);
            ResultSet rs = ps.executeQuery();

            if(rs.next()) {
                System.out.println("L'UE a bien été ajoutée à votre PAE");
            }else{
                System.out.println("L'UE n'a pas pu être ajoutée à votre PAE");
            }
        } catch (SQLException se) {
            System.out.println(se.getMessage());
        }
    }

    public void enleverUE(int idEtudiant, String codeUe) throws Exception {
        try{
            PreparedStatement ps = connection.prepareStatement
                    ("SELECT projet_sql.enlever_UE(?, ?) AS code_ue");
            ps.setString(1,codeUe);
            ps.setInt(2,idEtudiant);
            ResultSet rs = ps.executeQuery();
            if (rs.next())
                System.out.println("L'UE " + codeUe + " à bien été enlevée de votre PAE.");
            else
                System.out.println("Une erreur s'est produite");
        }catch (SQLException se){
            System.out.println(se.getMessage());
        }
    }

    public void validerPAE(int idEtudiant) throws Exception {
        try{
            PreparedStatement ps = connection.prepareStatement
                    ("SELECT projet_sql.valider_pae(?) AS est_valide");
            ps.setInt(1,idEtudiant);

            ResultSet rs = ps.executeQuery();
            rs.next();
            if(rs.getBoolean("est_valide")){
                System.out.println("Votre PAE à bien été validée.");
            }else{
                System.out.println("Votre PAE n'a pas pu être validée");
            }
        }catch (SQLException se){
            System.out.println(se.getMessage());
        }
    }

    public void afficherUEs(int idEtudiant) throws Exception {

        try{
            String uesDisponible;
            PreparedStatement ps = connection.prepareStatement
                    ("SELECT * FROM projet_sql.visualier_ues_suivantes WHERE id_etudiant = ? ");
            ps.setInt(1, idEtudiant);
            ResultSet rs = ps.executeQuery();

            System.out.println("Voici les UE disponible : ");
            while(rs.next()) {
                System.out.println("code ue : " + rs.getString("code_ue") + ", nom : "
                        + rs.getString("nom") + ", nombre de credits : "
                        + rs.getString("nombre_credits") + ", numero du bloc : "
                        + rs.getString("num_bloc"));
            }
            }catch (SQLException se){
            System.out.println(se.getMessage());
        }

    }

    public void visualiser_PAE(int idEtudiant) throws Exception {
        try{
            String pae = "";
            PreparedStatement ps = connection.prepareStatement
                    ("SELECT projet_sql.visualiser_PAE(?) AS code_ue");
            ps.setInt(1, idEtudiant);
            ResultSet rs = ps.executeQuery();
            rs.next();
            pae = rs.getString(1);
            if(pae.equals("{}")){
                System.out.println("Votre PAE est vide.");
            }else{
                System.out.println("Voici les UEs présente dans votre PAE : \n" + pae.toString());
            }
        }catch (SQLException se){
            System.out.println(se.getMessage());
        }
    }

    public void reinitialiser_PAE(int idEtudiant) throws Exception {
        try{
            PreparedStatement ps = connection.prepareStatement
                    ("SELECT projet_sql.reinitialiser_PAE(?) AS est_valide");
            ps.setInt(1, idEtudiant);
            ResultSet rs = ps.executeQuery();
            rs.next();
            if(rs.getBoolean("est_valide")) {
                System.out.println("Votre UE est déjà validée, vous ne pouvez plus la réinitialiser.");
            }else{
                System.out.println("Votre UE a bien été réinitialisée.");
            }
        }catch (SQLException se){
            System.out.println(se.getMessage());
        }
    }

}
