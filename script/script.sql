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
CREATE OR REPLACE FUNCTION projet_sql.ajouter_UE (
    projet_sql.ues.code_ue%TYPE,
    projet_sql.etudiants.id_etudiant%TYPE)
    RETURNS projet_sql.ues.code_ue%TYPE
AS $$
DECLARE
code_ue_param ALIAS FOR $1;
    id_etudiant_param ALIAS FOR $2;
    id_pae_var INTEGER := 0;
    pae_est_valide BOOLEAN := 0;
    nb_credits_valides INTEGER := 0;
    id_ue INTEGER := 0;
BEGIN
    id_pae_var := (SELECT id_pae FROM projet_sql.paes WHERE id_etudiant = id_etudiant_param);
    pae_est_valide := (SELECT est_valide FROM projet_sql.paes WHERE id_etudiant = id_etudiant_param);
    nb_credits_valides := (SELECT sum(nombre_credits) FROM ues u, ues_valide v WHERE u.code_ue = code_ue_param AND u.code_ue = v.code_ue AND v.id_etudiant = id_etudiant_param);
    IF pae_est_valide THEN
        RAISE 'Votre PAE est deja valide';
END IF;
    IF EXISTS(SELECT id_etudiant, code_ue FROM projet_sql.ues_valide WHERE id_etudiant = id_etudiant_param AND code_ue = code_ue_param) THEN
        RAISE 'Cette UE est deja valide';
END IF;
    IF EXISTS   (SELECT ue_prerequise
                FROM projet_sql.acces_ue
                WHERE ue_suivante = code_ue_param
                AND ue_prerequise NOT IN (SELECT code_ue FROM ues_valide WHERE id_etudiant=id_etudiant_param)) THEN
        RAISE 'Cette UE a des prerequis a valider';
END IF;
    IF (nb_credits_valides < 30) AND (SELECT num_bloc FROM blocs b, ues u WHERE b.num_bloc = u.num_bloc AND u.code_ue = code_ue_param) <> 1 THEN
        RAISE 'Moins de 30 credits ont ete valides, vous ne pouvez que choisir une UE du bloc 1';
END IF;
INSERT INTO projet_sql.lignes_ue VALUES(DEFAULT, code_ue_param, id_pae_var) RETURNING code_ue INTO id_ue;
RETURN id_ue;
END ;
$$ LANGUAGE plpgsql;

-- procedure 2
CREATE OR REPLACE FUNCTION projet_sql.enlever_UE (
    projet_sql.ues.code_ue%TYPE,
    projet_sql.etudiants.id_etudiant%TYPE)
    RETURNS projet_sql.ues.code_ue%TYPE
AS $$
DECLARE
code_ue_param ALIAS FOR $1;
    id_etudiant_param ALIAS FOR $2;
    id_pae_var INTEGER;
    pae_est_valide BOOLEAN;
BEGIN
    id_pae_var := (SELECT id_pae FROM paes WHERE id_etudiant = id_etudiant_param);
    pae_est_valide := (SELECT est_valide FROM projet_sql.paes WHERE id_etudiant = id_etudiant_param);
    IF pae_est_valide THEN
        RAISE 'Votre PAE est deja valide';
END IF;
DELETE FROM lignes_ue WHERE code_ue = code_ue_param AND id_pae = id_pae_var;
RETURN code_ue_param;
END;
$$ LANGUAGE plpgsql;

-- procedure 3
CREATE OR REPLACE FUNCTION projet_sql.valider_PAE (
    projet_sql.etudiants.id_etudiant%TYPE)
    RETURNS INTEGER
AS $$
DECLARE
id_etudiant_param ALIAS FOR $1;
    id_pae_var INTEGER;
    somme_credits_valide INTEGER;
    somme_credits_pae INTEGER;
BEGIN
    somme_credits_valide := (SELECT sum(nombre_credits) FROM ues u, ues_valide v WHERE u.code_ue = v.code_ue AND id_etudiant = id_etudiant_param);
    id_pae_var := (SELECT id_pae FROM paes WHERE id_etudiant = id_etudiant_param);
    somme_credits_pae := (SELECT sum(nombre_credits) FROM ues u, lignes_ue l WHERE u.code_ue = l.code_ue AND id_pae = id_pae_var);
    -- EXCEPTIONS
    IF((somme_credits_pae+somme_credits_valide)=180 AND somme_credits_pae>74) THEN
        RAISE 'Votre PAE ne peut pas depasser 74 credits';
END IF;
    IF ((@somme_credits_valide<45) AND (@somme_credits_pae>60)) THEN
        RAISE 'Votre PAE ne peut pas depasser 60 credits';
END IF;
    IF ((@somme_credits_pae>74) OR (@somme_credits_pae<55)) THEN
        RAISE 'Votre PAE ne peut pas etre en dessous de 55 credits ou au-dessus de 74 credits';
END IF;
        -- RETURNS
    IF (@somme_credits_pae+@somme_credits_valide)=180 THEN
UPDATE projet_sql.etudiants SET bloc = '3' WHERE id_etudiant = id_etudiant_param;
RETURN 3;
END IF;
    IF (@somme_credits_valide<45) THEN
UPDATE projet_sql.etudiants SET bloc = '1' WHERE id_etudiant = id_etudiant_param;
RETURN 1;
END IF;
UPDATE projet_sql.etudiants SET bloc = '2' WHERE id_etudiant = id_etudiant_param;
RETURN 2;
END;
$$ LANGUAGE plpgsql;

-- procedure 5
CREATE OR REPLACE FUNCTION projet_sql.visualiser_PAE (
    projet_sql.etudiants.id_etudiant%TYPE)
    RETURNS RECORD
AS $$
DECLARE
id_etudiant_param ALIAS FOR $1;
    id_pae_var INTEGER;
    ret RECORD;
BEGIN
    id_pae_var := (SELECT id_pae FROM paes WHERE id_etudiant = id_etudiant_param);
SELECT u.code_ue as "Code", u.nom as "Nom", u.nombre_credits as "Nombre de crédits",  u.num_bloc as "Bloc"
FROM projet_sql.ues u, projet_sql.lignes_ue l
WHERE u.code_ue = l.code_ue AND id_pae = id_pae_var
ORDER BY u.code_ue INTO ret;
RETURN ret;
END;
$$ LANGUAGE plpgsql;

-- procedure 6
CREATE OR REPLACE FUNCTION projet_sql.reinitialiser_PAE (
    projet_sql.etudiants.id_etudiant%TYPE)
    RETURNS INTEGER
AS $$
DECLARE
id_etudiant_param ALIAS FOR $1;
     id_pae_var INTEGER;
     pae_est_valide BOOLEAN;
BEGIN
    id_pae_var = (SELECT id_pae FROM paes WHERE id_etudiant = id_etudiant_param);
     pae_est_valide = (SELECT est_valide FROM projet_sql.paes WHERE id_etudiant = id_etudiant_param);
     IF pae_est_valide THEN
          RAISE 'Votre PAE est deja valide';
END IF;
DELETE FROM projet_sql.lignes_ue WHERE id_pae = id_pae_var;
RETURN 0;
END ;
$$ LANGUAGE plpgsql;