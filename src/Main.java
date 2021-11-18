import db.Authentication;
import db.PaeService;
import model.Etudiant;

import java.net.Authenticator;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) throws Exception {

        Scanner scanner = new Scanner(System.in);
        Etudiant etudiant = null;
        Authentication auth;
        PaeService paeService;
        boolean connected = false;

        System.out.println("1) Créer un compte \n" +
                "2) Se connecter");
        int choixConnexion = Integer.parseInt(scanner.nextLine());

        while(!connected) {
            switch (choixConnexion) {
                case 1:
                    //Creation compte avec hash
                    System.out.println("Entrer votre nom : ");
                    String nom = scanner.nextLine();
                    System.out.println("Entrer votre prénom : ");
                    String prenom = scanner.nextLine();
                    System.out.println("Entrer votre adresse email : ");
                    String email = scanner.nextLine();
                    System.out.println("Entrer votre mot de passe : ");
                    String pwd = scanner.nextLine();

                    auth = new Authentication();
                    etudiant = auth.createAccount(nom, prenom, email, pwd);
                    connected = true;
                    break;
                case 2:
                    System.out.println("Entrer votre adresse e-mail : ");
                    email = scanner.nextLine();
                    System.out.println("Entrer votre adresse mot de passe: ");
                    String motDePasse = scanner.nextLine();

                    auth = new Authentication();
                    etudiant = auth.authenticate(email, motDePasse);
                    connected = true;
                    break;
            }
        }

        System.out.println("Bonjour " + etudiant.getPrenom() + " " + etudiant.getNom());

        System.out.println("Faites un choix : \n" +
        "1) Ajouter une UE à votre PAE \n" +
        "2) Enlenver une UE à votre PAE \n" +
        "3) Valider son PAE \n" +
        "4) Vérifier les UE que vous pouvez ajouter");

        int choix = Integer.parseInt(scanner.nextLine());

        while(choix >= 1 && choix <= 4) {
            switch (choix) {
                case 1:
                    System.out.println("ajouterUe()");
                    break;
                case 2:
                    System.out.println("enleverUe()");
                    break;
                case 3:
                    System.out.println("validerPae()");
                    break;
                case 4:
                    System.out.println("verifierUeDispo()");
                    break;
            }
        }


    }
}


