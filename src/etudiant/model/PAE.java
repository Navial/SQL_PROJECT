package etudiant.model;

public class PAE {

    private String idPae;
    private boolean estValide;
    private String idEtudiant;

    public PAE(String idPae, boolean estValide, String idEtudiant){
        this.idPae = idPae;
        this.estValide = estValide;
        this.idEtudiant = idEtudiant;
    }

    public String getIdPae() {
        return idPae;
    }

    public void setIdPae(String idPae) {
        this.idPae = idPae;
    }

    public boolean isEstValide() {
        return estValide;
    }

    public void setEstValide(boolean estValide) {
        this.estValide = estValide;
    }

    public String getIdEtudiant() {
        return idEtudiant;
    }

    public void setIdEtudiant(String idEtudiant) {
        this.idEtudiant = idEtudiant;
    }

}
