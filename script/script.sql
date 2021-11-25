DROP SCHEMA IF EXISTS projet_sql CASCADE;
CREATE SCHEMA projet_sql;

CREATE TABLE projet_sql.blocs (
    num_bloc SERIAL PRIMARY KEY
);
CREATE TABLE projet_sql.etudiants(
                                     id_etudiant SERIAL PRIMARY KEY,
                                     nom VARCHAR(100) NOT NULL CHECK (nom<>''),
                                     prenom VARCHAR(100) NOT NULL CHECK (prenom<>''),
                                     email VARCHAR(100) NOT NULL CHECK (email<>''),
                                     mot_de_passe VARCHAR(100) NOT NULL CHECK (mot_de_passe<>''),
                                     bloc INTEGER REFERENCES projet_sql.blocs (num_bloc)
);
CREATE TABLE projet_sql.ues (
                                code_ue SERIAL PRIMARY KEY,
                                nom VARCHAR(100) NOT NULL CHECK (nom<>''),
                                nombre_credits INTEGER NOT NULL CHECK (nombre_credits>0),
                                nombre_inscrits INTEGER NOT NULL CHECK (nombre_inscrits>0),
                                num_bloc INTEGER REFERENCES projet_sql.blocs (num_bloc)
);
CREATE TABLE projet_sql.ues_valide (
                                       id_etudiant INTEGER NOT NULL REFERENCES projet_sql.etudiants (id_etudiant),
                                       code_ue INTEGER NOT NULL REFERENCES projet_sql.ues (code_ue),
                                       CONSTRAINT id_ue_valid PRIMARY KEY (id_etudiant, code_ue)
);
CREATE TABLE projet_sql.acces_ue (
                                     id_acces_ue SERIAL PRIMARY KEY,
                                     ue_prerequise INTEGER NULL REFERENCES projet_sql.ues (code_ue),
                                     ue_suivante INTEGER NULL REFERENCES projet_sql.ues (code_ue)
);
CREATE TABLE projet_sql.paes (
                                 id_pae SERIAL PRIMARY KEY,
                                 est_valide BOOLEAN DEFAULT(FALSE),
                                 id_etudiant INTEGER NOT NULL REFERENCES projet_sql.etudiants (id_etudiant)
);
CREATE TABLE projet_sql.lignes_ue (
                                      id_pae INTEGER NOT NULL REFERENCES projet_sql.paes (id_pae),
                                      code_ue INTEGER NOT NULL REFERENCES projet_sql.ues (code_ue),
                                      CONSTRAINT id_ligne PRIMARY KEY (id_pae, code_ue)
);

INSERT INTO projet_sql.etudiants(nom, prenom, email, mot_de_passe)
VALUES ('Denis',
        'Victor',
        'victor.denis@gmail.com',
        '$2a$10$huvh1guzV.TQAASWdTnP5u4OwuSRiF13wRhZ1cjWLiSd0rZSpi4rO');

SELECT id_etudiant, nom, prenom, bloc, email, mot_de_passe FROM projet_sql.etudiants WHERE email = 'victor.denis@gmail.com';

-- procedure 1
/*CREATE OR REPLACE FUNCTION projet_sql.ajouter_UE (
    projet_sql.ues.code_ue%TYPE,
    projet_sql.etudiants.id_etudiant%TYPE)
    RETURNS projet_sql.ues.code_ue%TYPE
AS $$
DECLARE
    code_ue_param ALIAS FOR $1;
    id_etudiant_param ALIAS FOR $2;
    id_pae INTEGER := 0;
    pae_est_valide BOOLEAN := 0;
    nb_credits_valides INTEGER := 0;
    id_ue INTEGER := 0;
BEGIN
    id_pae := (SELECT id_pae FROM projet_sql.paes WHERE id_etudiant = id_etudiant_param);
    pae_est_valide := (SELECT est_valide FROM projet_sql.paes WHERE id_etudiant = id_etudiant_param);
    nb_credits_valides := (SELECT sum(nombre_credits) FROM ues u, ues_valide v WHERE u.code_ue = code_ue_param AND u.code_ue = v.code_ue AND v.id_etudiant = id_etudiant_param);
    IF pae_est_valide THEN
        RAISE 'Votre PAE est deja valide';
        IF EXISTS(SELECT id_etudiant, code_ue FROM projet_sql.ues_valide WHERE id_etudiant = id_etudiant_param AND code_ue = code_ue_param) THEN
            RAISE 'Cette UE est deja valide';
            IF EXISTS(SELECT ue_prerequise
                      FROM projet_sql.acces_ue
                      WHERE ue_suivante = code_ue_param
                        AND ue_prerequise NOT IN (SELECT code_ue FROM ues_valide WHERE id_etudiant=id_etudiant_param)) THEN
                RAISE 'Cette UE a des prerequis a valider';
                IF (nb_credits_valides < 30) AND (SELECT num_bloc FROM blocs b, ues u WHERE b.num_bloc = u.num_bloc AND u.code_ue = code_ue_param) <> 1 THEN
                    RAISE 'Moins de 30 credits ont ete valides, vous ne pouvez que choisir une UE du bloc 1';
                    INSERT INTO projet_sql.lignes_ue VALUES(DEFAULT, code_ue_param, @id_pae) RETURNING code_ue INTO id_ue;

                    RETURN id_ue;
                END ;
$$ LANGUAGE plpgsql;
*/