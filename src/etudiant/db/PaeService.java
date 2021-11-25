package etudiant.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class PaeService {

    private final Connection connection;

    public PaeService() throws Exception {
        connection = new DbConnection().connection;
    }

    public void ajouterUE(int idEtudiant,String codeUE) throws Exception {
        try {

            PreparedStatement ps = connection.prepareStatement
                    ("SELECT projet_sql.ajouter_UE(?, ?) AS code_ue");
            ps.setInt(1,idEtudiant);
            ps.setString(2,codeUE);
            ResultSet rs = ps.executeQuery();

            if(rs.getString("code_ue").equals(codeUE)) {
                System.out.println("L'UE a bien été ajoutée à votre PAE");
            }else{
                System.out.println("L'UE n'a pas pu être ajoutée à votre PAE");
            }
        } catch (SQLException se) {
            System.out.println(se.getMessage());
            throw new Exception();
        }
    }

    public void enleverUE(int idEtudiant, String codeUE) throws Exception {
        try{
            PreparedStatement ps = connection.prepareStatement
                    ("SELECT projet_sql.enlever_UE(?, ?) AS code_ue");
            ps.setInt(1,idEtudiant);
            ps.setString(2,codeUE);
            ResultSet rs = ps.executeQuery();

            if(rs.getString("code_ue").equals(codeUE))
                    System.out.println("L'UE " + codeUE + " à bien été enlevée de votre PAE.");
            else{
                System.out.println("L'UE " + codeUE + " n'a pas pu être enlevée de votre PAE.");
            };
        }catch (SQLException se){
            System.out.println(se.getMessage());
            throw new Exception();
        }
    }

    public void validerPAE() throws Exception {
        try{
            PreparedStatement ps = connection.prepareStatement
                    ("SELECT projet_sql.valider_PAE() AS est_valide");
            ResultSet rs = ps.executeQuery();

            if(rs.getInt("est_valide") == 0){
                System.out.println("Votre PAE à bien été validée.");
            }else{
                System.out.println("Votre PAE n'a pas pu être validée");
            }
        }catch (SQLException se){
            System.out.println(se.getMessage());
            throw new Exception();
        }
    }

    public void afficher_UE_disponible() throws Exception {

        try{
            ArrayList<String> uesDisponible = new ArrayList<>();
            PreparedStatement ps = connection.prepareStatement
                    ("SELECT projet_sql.afficher_UE_a_ajouter() AS code_ue");
            ResultSet rs = ps.executeQuery();
            if(rs.getFetchSize() == 0) {
                System.out.println("Aucune UE disponible");
                return;
            }
            while(rs.next()){
                uesDisponible.add(rs.getString("code_ue"));
            }
            System.out.println("Voici les UE disponible : \n" + uesDisponible.toString());
        }catch (SQLException se){
            System.out.println(se.getMessage());
            throw new Exception();
        }

    }

    public void visualiser_PAE() throws Exception {
        try{
            ArrayList<String> uesDansPae = new ArrayList<>();
            PreparedStatement ps = connection.prepareStatement
                    ("SELECT projet_sql.visualiser_PAE() AS code_ue");
            ResultSet rs = ps.executeQuery();

            while(rs.next()){
                uesDansPae.add(rs.getString("code_ue"));
            }

            if(uesDansPae.size() > 0){
                System.out.println("Voici les UEs présente dans votre PAE : \n" + uesDansPae.toString());
            }else{
                System.out.println("Votre PAE est vide.");

            }
        }catch (SQLException se){
            System.out.println(se.getMessage());
            throw new Exception();
        }
    }

    public void reinitialiser_PAE() throws Exception {
        try{
            PreparedStatement ps = connection.prepareStatement
                    ("SELECT projet_sql.reinitialiser_PAE() AS est_valide");
            ResultSet rs = ps.executeQuery();
            if(rs.getBoolean("est_valide")) {
                System.out.println("Votre UE est déjà validée, vous ne pouvez plus la réinitialiser.");
            }else{
                System.out.println("Votre UE a bien été réinitialisée.");
            }
        }catch (SQLException se){
            System.out.println(se.getMessage());
            throw new Exception();
        }
    }

}
