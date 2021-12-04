package centrale;

import centrale.db.PaeService;

import java.util.Scanner;

public class Main {

        public static void main(String[] args) throws Exception {

            Scanner scanner = new Scanner(System.in);

            System.out.println("Faites un choix : \n" +
                    "1) Créer une UE  \n" +
                    "2) Ajouter un prerequis a une UE \n" +
                    "3) Créer un étudiant \n" +
                    "4) Encoder une UE validée pour un étudiant \n" +
                    "5) Visualiser les étudiants d'un bloc \n" +
                    "6) Visualiser les crédits des étudiants \n" +
                    "7) Visualiser les étudiants qui n'ont pas validé leur PAE \n" +
                    "8) Visualier les UE d'un bloc");

            int choix = Integer.parseInt(scanner.nextLine());
            int bloc;
            PaeService ps = new PaeService();
            while(choix >= 1 && choix <= 8) {
                switch (choix) {
                    case 1: // créer une nouvelle UE
                        System.out.println("Entrer le code de l'UE :");
                        String codeUe = scanner.nextLine();
                        System.out.println("Entrer le nom de l'UE : ");
                        String nomUe = scanner.nextLine();
                        System.out.println("Entrer le bloc de l'UE : ");
                        bloc  = Integer.parseInt(scanner.nextLine());
                        System.out.println("Entrer le nombre de credits : ");
                        int nbrCredits = Integer.parseInt(scanner.nextLine());

                        ps.creerUe(codeUe, nomUe, bloc, nbrCredits);
                        break;
                    case 2: // ajouter un prerequis
                        System.out.println("Entrer le code de l'UE prerequise");
                        String uePrerequise = scanner.nextLine();
                        System.out.println("Entrer le code de l'UE principale");
                        String uePrincipale = scanner.nextLine();
                        ps.ajouter_prerequis(uePrerequise, uePrincipale);
                        break;
                    case 3: // ajouter un nouvel étudiant
                        System.out.println("Entrer le nom : ");
                        String nom = scanner.nextLine();
                        System.out.println("Entrer le prénom : ");
                        String prenom = scanner.nextLine();
                        System.out.println("Entrer l'adresse email : ");
                        String email = scanner.nextLine();
                        System.out.println("Entrer le mot de passe : ");
                        String pwd = scanner.nextLine();
                        System.out.println("Entre le bloc : ");
                        bloc = Integer.parseInt(scanner.nextLine());
                        ps.ajouter_etudiant(nom, prenom, email, pwd, bloc);
                        break;
                    case 4: //valider une UE pour un étudiant
                        System.out.println("Entrer l'email de l'étudiant");
                        email = scanner.nextLine();
                        System.out.println("Entrer le code de l'ue à ajouter");
                        codeUe = scanner.nextLine();
                        ps.encoderUeVal(email, codeUe);
                        break;
                    case 5: //visualiser tous les étudiants d'un bloc
                        System.out.println("Entrer le bloc : ");
                        bloc = Integer.parseInt(scanner.nextLine());
                        ps.visualiserTousEtudiantDUnBloc(bloc);
                        break;
                    case 6:
                        ps.visualiserCreditsEtudiants();
                        break;
                    case 7:
                        ps.visualiserEtudiantsNonValides();
                        break;
                    case 8 :
                        System.out.println("Entrer le numero de bloc ");
                        bloc = Integer.parseInt(scanner.nextLine());
                        ps.visualiserUesDUnBloc(bloc);
                        break;
                }
            }


        }
}
