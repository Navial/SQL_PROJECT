package etudiant;

import etudiant.db.Authentication;
import etudiant.db.PaeService;
import etudiant.model.Etudiant;

import java.sql.SQLOutput;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) throws Exception {

        Scanner scanner = new Scanner(System.in);
        Etudiant etudiant = null;
        Authentication auth;
        PaeService paeService;

        System.out.println("Bonjour, veuillez vous connecter : ");
        System.out.println("Entrer votre adresse e-mail : ");
        String email = scanner.nextLine();
        System.out.println("Entrer votre adresse mot de passe: ");
        String motDePasse = scanner.nextLine();

        auth = new Authentication();
        etudiant = auth.authenticate(email, motDePasse);

        System.out.println("Bonjour " + etudiant.getPrenom() + " " + etudiant.getNom());
        int choix = 0;
        do{System.out.println("Faites un choix : \n" +
                "1) Ajouter une UE à votre PAE \n" +
                "2) Enlenver une UE à votre PAE \n" +
                "3) Valider son PAE \n" +
                "4) Vérifier les UE que vous pouvez ajouter\n" +
                "5) Visualiser son PAE\n" +
                "6) Reinitialiser PAE");

            choix = Integer.parseInt(scanner.nextLine());
            PaeService ps  = new PaeService();
            int idUe;

            switch (choix) {
                case 1:
                    System.out.println("Entrer le code de l'UE à ajouter");
                    String codeUe = scanner.nextLine();
                    ps.ajouterUE(etudiant.getId(),codeUe);
                    break;
                case 2:
                    System.out.println("Entrer le code de l'UE à enlever");
                    codeUe = scanner.nextLine();
                    ps.enleverUE(etudiant.getId(),codeUe);
                    break;
                case 3:
                    ps.validerPAE(etudiant.getId());
                    break;
                case 4:
                    ps.afficherUEs(etudiant.getId());
                    break;
                case 5:
                    ps.visualiser_PAE(etudiant.getId());
                    break;
                case 6:
                    ps.reinitialiser_PAE(etudiant.getId());
                    break;
            }
        }while (choix >= 1 && choix <= 6);

    }
}


