package etudiant.model;

public class Etudiant {
    private Integer id;
    private String nom;
    private String prenom;
    private String email;
    private Integer bloc;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public void setPrenom(String prenom) {
        this.prenom = prenom;
    }

    public String getPrenom(){
        return prenom;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Integer getBloc() {
        return bloc;
    }

    public void setBloc(Integer bloc) {
        this.bloc = bloc;
    }
}
