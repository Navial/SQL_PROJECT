DROP SCHEMA IF EXISTS projet_sql CASCADE;
CREATE SCHEMA projet_sql;

--GRANT CONNECT ON DATABASE dbvictordenis TO alexendrewalwis;
--GRANT USAGE ON SCHEMA projet_sql TO alexendrewalwis;
--GRANT SELECT ON projet_sql.paes, projet_sql.ues_valide, projet_sql.acces_ue, projet_sql.blocs, projet_sql.ues, projet_sql.lignes_ue TO alexendrewalwis;
--GRANT INSERT ON projet_sql.lignes_ue TO alexendrewalwis;
--GRANT UPDATE ON projet_sql.etudiants, projet_sql.ues  TO alexendrewalwis;
--GRANT DELETE ON projet_sql.lignes_ue TO alexendrewalwis;

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
                                id_ue SERIAL PRIMARY KEY,
                                code_ue VARCHAR(10) NOT NULL check(code_ue<>''),
                                nom VARCHAR(100) NOT NULL CHECK (nom<>''),
                                nombre_credits INTEGER NOT NULL CHECK (nombre_credits>0),
                                nombre_inscrits INTEGER CHECK (nombre_inscrits>=0),
                                num_bloc INTEGER REFERENCES projet_sql.blocs (num_bloc)
);
CREATE TABLE projet_sql.ues_valide (
                                       id_etudiant INTEGER NOT NULL REFERENCES projet_sql.etudiants (id_etudiant),
                                       id_ue INTEGER NOT NULL REFERENCES projet_sql.ues (id_ue),
                                       CONSTRAINT id_ue_valid PRIMARY KEY (id_etudiant, id_ue)
);
CREATE TABLE projet_sql.acces_ue (
                                     id_acces_ue SERIAL PRIMARY KEY,
                                     ue_prerequise INTEGER REFERENCES projet_sql.ues (id_ue),
                                     ue_suivante INTEGER REFERENCES projet_sql.ues (id_ue)
);
CREATE TABLE projet_sql.paes (
                                 id_pae SERIAL PRIMARY KEY,
                                 est_valide BOOLEAN DEFAULT(FALSE),
                                 id_etudiant INTEGER NOT NULL REFERENCES projet_sql.etudiants (id_etudiant)
);
CREATE TABLE projet_sql.lignes_ue (
                                      CONSTRAINT id_ligne PRIMARY KEY(id_pae, id_ue),
                                      id_pae INTEGER NOT NULL REFERENCES projet_sql.paes (id_pae),
                                      id_ue INTEGER NOT NULL REFERENCES projet_sql.ues (id_ue)
);

--- Creation 3 bloc

INSERT INTO projet_sql.blocs VALUES (DEFAULT);
INSERT INTO projet_sql.blocs VALUES (DEFAULT);
INSERT INTO projet_sql.blocs VALUES (DEFAULT);
--
INSERT INTO projet_sql.etudiants VALUES (DEFAULT,'Damas','Christophe','christophe.damas@student.vinci.be','$2a$10$M3Y5g8QegSS1bJt17r67ne4yeG6JeohsshjslS/1RZT3RPqFqPbXW',1);
INSERT INTO projet_sql.etudiants VALUES (DEFAULT,'Ferneew','Stephanie','stephanie.ferneew@student.vinci.be','$2a$10$M3Y5g8QegSS1bJt17r67ne4yeG6JeohsshjslS/1RZT3RPqFqPbXW',1);
INSERT INTO projet_sql.etudiants VALUES (DEFAULT,'Vander Meulen','Jose','vandermeulen.jose@student.vinci.be','$2a$10$M3Y5g8QegSS1bJt17r67ne4yeG6JeohsshjslS/1RZT3RPqFqPbXW',1);
INSERT INTO projet_sql.etudiants VALUES (DEFAULT,'Leconte','Emeline','leconte.emeline@student.vinci.be','$2a$10$M3Y5g8QegSS1bJt17r67ne4yeG6JeohsshjslS/1RZT3RPqFqPbXW',1);

INSERT INTO projet_sql.ues VALUES (DEFAULT,'BINV11','BD1',31,DEFAULT,1);
INSERT INTO projet_sql.ues VALUES (DEFAULT,'BINV13','Algo',13,DEFAULT,1);
INSERT INTO projet_sql.ues VALUES (DEFAULT,'BINV12','APOO',16,DEFAULT,1);

INSERT INTO projet_sql.ues VALUES (DEFAULT,'BINV21','BD2',42,DEFAULT,2); -- 14

INSERT INTO projet_sql.ues VALUES (DEFAULT,'BINV311','Anglais 3',16,DEFAULT,3); -- 30
INSERT INTO projet_sql.ues VALUES (DEFAULT,'BINV32','Stage',44,DEFAULT,3); -- 30

INSERT INTO projet_sql.ues_valide VALUES (1,3);
INSERT INTO projet_sql.ues_valide VALUES (1,2);
INSERT INTO projet_sql.ues_valide VALUES (2,1);
INSERT INTO projet_sql.ues_valide VALUES (2,3);
INSERT INTO projet_sql.ues_valide VALUES (3,1);
INSERT INTO projet_sql.ues_valide VALUES (3,3);
INSERT INTO projet_sql.ues_valide VALUES (3,2);
INSERT INTO projet_sql.ues_valide VALUES (4,1);
INSERT INTO projet_sql.ues_valide VALUES (4,3);
INSERT INTO projet_sql.ues_valide VALUES (4,2);
INSERT INTO projet_sql.ues_valide VALUES (4,4);
INSERT INTO projet_sql.ues_valide VALUES (4,6);

INSERT INTO projet_sql.acces_ue VALUES (DEFAULT, 1,4); -- BD1 - BD2
INSERT INTO projet_sql.acces_ue VALUES (DEFAULT, 4,6); -- BD2 - Stage

--INSERT INTO projet_sql.etudiants VALUES (DEFAULT,'Poppe','Nicolas','p_nicolas@student.vinci.be',       '$2a$10$M3Y5g8QegSS1bJt17r67ne4yeG6JeohsshjslS/1RZT3RPqFqPbXW',1);
--INSERT INTO projet_sql.etudiants VALUES (DEFAULT,'Mircovici','Stefan','m_stefan@student.vinci.be',     '$2a$10$M3Y5g8QegSS1bJt17r67ne4yeG6JeohsshjslS/1RZT3RPqFqPbXW',2);
--INSERT INTO projet_sql.etudiants VALUES (DEFAULT,'Pirlot','Antoine','p_antoine@student.vinci.be',      '$2a$10$M3Y5g8QegSS1bJt17r67ne4yeG6JeohsshjslS/1RZT3RPqFqPbXW',2);
--INSERT INTO projet_sql.etudiants VALUES (DEFAULT,'Gobbe','Mehdi','g_mehdi@student.vinci.be',           '$2a$10$M3Y5g8QegSS1bJt17r67ne4yeG6JeohsshjslS/1RZT3RPqFqPbXW',2);
--INSERT INTO projet_sql.etudiants VALUES (DEFAULT,'Bardijn','François','b_francois@student.vinci.be',   '$2a$10$M3Y5g8QegSS1bJt17r67ne4yeG6JeohsshjslS/1RZT3RPqFqPbXW',3);
--INSERT INTO projet_sql.etudiants VALUES (DEFAULT,'Denis','Victor','victor.denis@student.vinci.be',     '$2a$10$M3Y5g8QegSS1bJt17r67ne4yeG6JeohsshjslS/1RZT3RPqFqPbXW',2);
--INSERT INTO projet_sql.etudiants VALUES (DEFAULT,'Rayan','Abarkhan','rayan.abarkhan@student.vinci.be', '$2a$10$M3Y5g8QegSS1bJt17r67ne4yeG6JeohsshjslS/1RZT3RPqFqPbXW',3);
--INSERT INTO projet_sql.etudiants VALUES (DEFAULT,'Monkey','Luffy','luffy.monkey@student.vinci.be',     '$2a$10$M3Y5g8QegSS1bJt17r67ne4yeG6JeohsshjslS/1RZT3RPqFqPbXW',3);
--INSERT INTO projet_sql.etudiants VALUES (DEFAULT,'Nazarian','Nora','nora.nazarian@student.vinci.be',   '$2a$10$M3Y5g8QegSS1bJt17r67ne4yeG6JeohsshjslS/1RZT3RPqFqPbXW',1);
--
--
---- Values (id_ue , code_ue, nom, nbr_credit, nbr_etudiants_inscrits, num_bloc)
--
--
----- UE du bloc 1
--INSERT INTO projet_sql.ues VALUES (DEFAULT,'BINV1114-1','Langage Machine',4,DEFAULT,1); -- 5
--INSERT INTO projet_sql.ues VALUES (DEFAULT,'BINV1800','Anglais 1',4,DEFAULT,1); -- 6
--INSERT INTO projet_sql.ues VALUES (DEFAULT,'BINV1400-1','HTML',2,DEFAULT,1); -- 7
--INSERT INTO projet_sql.ues VALUES (DEFAULT,'BINV1600','PHP',3,DEFAULT,1); -- 8
--INSERT INTO projet_sql.ues VALUES (DEFAULT,'BINV1200-1','Linux',3,DEFAULT,1); -- 9
--INSERT INTO projet_sql.ues VALUES (DEFAULT,'BINV1200-2','OS',3,DEFAULT,1); -- 10
--INSERT INTO projet_sql.ues VALUES (DEFAULT,'BINV1400-2','Projet-web HTML',3,DEFAULT,1); -- 11
--INSERT INTO projet_sql.ues VALUES (DEFAULT,'BINV1600-2','Projet-web PHP',4,DEFAULT,1); -- 12
--INSERT INTO projet_sql.ues VALUES (DEFAULT,'BINV1114-2','DO',3,DEFAULT,1); -- 13
--
---- UE du bloc 2s
--
--INSERT INTO projet_sql.ues VALUES (DEFAULT,'BINV21','Langage C',5,DEFAULT,2); -- 15
--INSERT INTO projet_sql.ues VALUES (DEFAULT,'BINV2478','Analyse et modélisation',6,DEFAULT,2); -- 16
--INSERT INTO projet_sql.ues VALUES (DEFAULT,'BINV2687','Gestion des données : avancé',6,DEFAULT,2); -- 17
--INSERT INTO projet_sql.ues VALUES (DEFAULT,'BINV2114','Programmation Java : avancé',4,DEFAULT,2); -- 18
--INSERT INTO projet_sql.ues VALUES (DEFAULT,'BINV2800','Développement Web : avancé',4,DEFAULT,2); -- 19
--INSERT INTO projet_sql.ues VALUES (DEFAULT,'BINV2400-1','DevOps',2,DEFAULT,2); -- 20
--INSERT INTO projet_sql.ues VALUES (DEFAULT,'BINV2600','Structure de données : avancé',4,DEFAULT,2); -- 21
--INSERT INTO projet_sql.ues VALUES (DEFAULT,'BINV2200-1','Organisation des entreprises',5,DEFAULT,2); -- 22
--INSERT INTO projet_sql.ues VALUES (DEFAULT,'BINV2200-2','Conception d''applications d''entreprise',4,DEFAULT,2); -- 23
--INSERT INTO projet_sql.ues VALUES (DEFAULT,'BINV2400-2','Linux : Programmation distribuée',4,DEFAULT,2); -- 24
--INSERT INTO projet_sql.ues VALUES (DEFAULT,'BINV2600-2','Informatique Mobile',6,DEFAULT,2); -- 25
--INSERT INTO projet_sql.ues VALUES (DEFAULT,'BINV2458-2','Anglais 2',4,DEFAULT,2); -- 26
--
----- UE du bloc s3
--INSERT INTO projet_sql.ues VALUES (DEFAULT,'BINV3458-1','Sécurité',4,DEFAULT,3); -- 27
--INSERT INTO projet_sql.ues VALUES (DEFAULT,'BINV3789','Administration infrastructure',5,DEFAULT,3); -- 28
--INSERT INTO projet_sql.ues VALUES (DEFAULT,'BINV3478','Organisation des entreprises',5,DEFAULT,3); -- 29

--INSERT INTO projet_sql.ues VALUES (DEFAULT,'BINV3114','Programmation : questions spéciales',8,DEFAULT,3); -- 31
--INSERT INTO projet_sql.ues VALUES (DEFAULT,'BINV3800','Développement web : questions spéciales',8,DEFAULT,3); -- 32
--INSERT INTO projet_sql.ues VALUES (DEFAULT,'BINV3400-1','Project de fin d''étude',15,DEFAULT,3); -- 33
--INSERT INTO projet_sql.ues VALUES (DEFAULT,'BINV3600','Intégration en milieu professionel',5,DEFAULT,3); -- 34
--INSERT INTO projet_sql.ues VALUES (DEFAULT,'BINV3200-1','Intelligence Artificielle',5,DEFAULT,3); -- 35
--INSERT INTO projet_sql.ues VALUES (DEFAULT,'BINV3200-2','Progiciel de gestion intégré',5,DEFAULT,3); -- 36
--INSERT INTO projet_sql.ues VALUES (DEFAULT,'BINV3369-2','Développement à l''aide d''un moteur de jeux Unity',5,DEFAULT,3); -- 37
--
----Values(ue_valside,id_etudiant)
--

--INSERT INTO projet_sql.ues_valide VALUES (2,1);
--INSERT INTO projet_sql.ues_valide VALUES (3,1);
--INSERT INTO projet_sql.ues_valide VALUES (4,1);
--INSERT INTO projet_sql.ues_valide VALUES (5,1);
--INSERT INTO projet_sql.ues_valide VALUES (6,1);
--INSERT INTO projet_sql.ues_valide VALUES (7,1);
--
--INSERT INTO projet_sql.ues_valide VALUES (1,2);
--INSERT INTO projet_sql.ues_valide VALUES (2,2);
--INSERT INTO projet_sql.ues_valide VALUES (3,2);
--INSERT INTO projet_sql.ues_valide VALUES (4,2);
--INSERT INTO projet_sql.ues_valide VALUES (5,2);
--INSERT INTO projet_sql.ues_valide VALUES (6,2);
--INSERT INTO projet_sql.ues_valide VALUES (7,2);
--INSERT INTO projet_sql.ues_valide VALUES (8,2);
--
--INSERT INTO projet_sql.ues_valide VALUES (1,3);
--INSERT INTO projet_sql.ues_valide VALUES (2,3);
--INSERT INTO projet_sql.ues_valide VALUES (3,3);
--INSERT INTO projet_sql.ues_valide VALUES (4,3);
--INSERT INTO projet_sql.ues_valide VALUES (5,3);
--INSERT INTO projet_sql.ues_valide VALUES (6,3);
--INSERT INTO projet_sql.ues_valide VALUES (7,3);
--INSERT INTO projet_sql.ues_valide VALUES (8,3);
--INSERT INTO projet_sql.ues_valide VALUES (9,3);
--INSERT INTO projet_sql.ues_valide VALUES (10,3);
--
--INSERT INTO projet_sql.ues_valide VALUES (1,4);
--INSERT INTO projet_sql.ues_valide VALUES (2,4);
--INSERT INTO projet_sql.ues_valide VALUES (3,4);
--INSERT INTO projet_sql.ues_valide VALUES (4,4);
--INSERT INTO projet_sql.ues_valide VALUES (5,4);
--INSERT INTO projet_sql.ues_valide VALUES (6,4);
--INSERT INTO projet_sql.ues_valide VALUES (8,4);
--INSERT INTO projet_sql.ues_valide VALUES (9,4);
--INSERT INTO projet_sql.ues_valide VALUES (10,4);
--
---- Values (id_use , id_prerequis)
--
--INSERT INTO projet_sql.acces_ue VALUES (DEFAULT, 26,6); -- Anglais 2 - Anglais 1
--INSERT INTO projet_sql.acces_ue VALUES (DEFAULT, 24,9); -- Linux 2 - Linux 1
--INSERT INTO projet_sql.acces_ue VALUES (DEFAULT, 25,3); -- Informatique Mobile - Algo
--INSERT INTO projet_sql.acces_ue VALUES (DEFAULT, 25,5); -- Informatique Mobile - LM
--INSERT INTO projet_sql.acces_ue VALUES (DEFAULT, 18,3); -- Dev. Java - Algo
--INSERT INTO projet_sql.acces_ue VALUES (DEFAULT, 16,4); -- Analyse données - APOO
--INSERT INTO projet_sql.acces_ue VALUES (DEFAULT, 17,1); -- Gestion des données - BD1
--INSERT INTO projet_sql.acces_ue VALUES (DEFAULT, 17,4); -- Gestion des données - APOO
--INSERT INTO projet_sql.acces_ue VALUES (DEFAULT, 21,2); -- SD avancé - SD1
--INSERT INTO projet_sql.acces_ue VALUES (DEFAULT, 27,20); -- Sécurité - DevOps
--INSERT INTO projet_sql.acces_ue VALUES (DEFAULT, 27,15); -- Sécurité - Langage C
--INSERT INTO projet_sql.acces_ue VALUES (DEFAULT, 30,26); -- Anglais 3 - Anglais 2
--INSERT INTO projet_sql.acces_ue VALUES (DEFAULT, 29,22); -- Orga Entr. 2  - Orga Entr. 1
--INSERT INTO projet_sql.acces_ue VALUES (DEFAULT, 35,18); -- IA - Java avancé
--INSERT INTO projet_sql.acces_ue VALUES (DEFAULT, 35,17); -- IA - Gestion des données
--INSERT INTO projet_sql.acces_ue VALUES (DEFAULT, 35,15); -- IA - Langage C
--INSERT INTO projet_sql.acces_ue VALUES (DEFAULT, 32,19); -- Dev. Web : spécial - Dev Web : Avancé
--
---- INSERT INTO PAE
--INSERT INTO  projet_sql.paes VALUES (DEFAULT, DEFAULT, 1);
--INSERT INTO  projet_sql.paes VALUES (DEFAULT, DEFAULT, 3);
--INSERT INTO  projet_sql.paes VALUES (DEFAULT, DEFAULT, 2);
--INSERT INTO  projet_sql.paes VALUES (DEFAULT, DEFAULT, 5);
--INSERT INTO  projet_sql.paes VALUES (DEFAULT, DEFAULT, 4);
--INSERT INTO  projet_sql.paes VALUES (DEFAULT, DEFAULT, 6);
--INSERT INTO  projet_sql.paes VALUES (DEFAULT, DEFAULT, 7);
--INSERT INTO  projet_sql.paes VALUES (DEFAULT, DEFAULT, 8);
--INSERT INTO  projet_sql.paes VALUES (DEFAULT, DEFAULT, 9);
--INSERT INTO  projet_sql.paes VALUES (DEFAULT, DEFAULT, 10);
--
---- VALUES( id_ue , id_etudiant)
--INSERT INTO projet_sql.lignes_ue VALUES (1,1);
--INSERT INTO projet_sql.lignes_ue VALUES (2,2);
--INSERT INTO projet_sql.lignes_ue VALUES (3,4);
--INSERT INTO projet_sql.lignes_ue VALUES (5,6);
--INSERT INTO projet_sql.lignes_ue VALUES (6,3);
--
--
--SELECT id_etudiant, nom, prenom, bloc, email, mot_de_passe FROM projet_sql.etudiants WHERE email = 'victor.denis@gmail.com';


-- PROCEDURE ETUDIANT --
-- procedure 1

CREATE OR REPLACE FUNCTION projet_sql.ajouter_ue (
    code_ue_param VARCHAR,
    id_etudiant_param INTEGER)
    RETURNS projet_sql.ues.id_ue%TYPE
    language plpgsql
AS $$
DECLARE
    code_ue_param ALIAS FOR $1;
    id_etudiant_var ALIAS FOR $2;
    id_ue_var INTEGER :=0;
    id_pae_var INTEGER := 0;
    pae_est_valide BOOLEAN := 0;
    nb_credits_valides INTEGER := 0;
    id_ue_v INTEGER := 0;
BEGIN
    id_ue_var := (SELECT id_ue FROM projet_sql.ues WHERE code_ue = code_ue_param);
    id_pae_var := (SELECT id_pae FROM projet_sql.paes WHERE id_etudiant = id_etudiant_param);
    pae_est_valide := (SELECT est_valide FROM projet_sql.paes WHERE id_etudiant = id_etudiant_param);
    nb_credits_valides := (SELECT sum(nombre_credits) FROM projet_sql.ues u, projet_sql.ues_valide v WHERE u.id_ue = id_ue_var AND u.id_ue = v.id_ue AND v.id_etudiant = id_etudiant_param);
    IF pae_est_valide THEN
        RAISE 'Votre PAE est deja valide';
    END IF;
    IF EXISTS(SELECT id_etudiant, id_ue FROM projet_sql.ues_valide WHERE id_etudiant = id_etudiant_param AND id_ue = id_ue_var) THEN
        RAISE 'Cette UE est deja valide';
    END IF;
    IF EXISTS   (SELECT ue_prerequise
                 FROM projet_sql.acces_ue
                 WHERE ue_suivante = id_ue_var
                   AND ue_prerequise NOT IN (SELECT id_ue FROM projet_sql.ues_valide WHERE id_etudiant=id_etudiant_param)) THEN
        RAISE 'Cette UE a des prerequis a valider';
    END IF;
    IF (nb_credits_valides < 30) AND (SELECT u.num_bloc FROM projet_sql.blocs b, projet_sql.ues u WHERE b.num_bloc = u.num_bloc AND u.id_ue = id_ue_var) <> 1 THEN
        RAISE 'Moins de 30 credits ont ete valides, vous ne pouvez que choisir une UE du bloc 1';
    END IF;
    INSERT INTO projet_sql.lignes_ue (id_pae, id_ue) VALUES(id_pae_var, id_ue_var) RETURNING id_ue INTO id_ue_v;
    RETURN id_ue_v;
END ;
$$ ;

-- procedure 2
CREATE OR REPLACE function projet_sql.enlever_ue(varchar, integer) returns character varying
    language plpgsql
as
$$
DECLARE
    code_ue_param ALIAS FOR $1;
    id_etudiant_param ALIAS FOR $2;
    id_ue_var INTEGER;
    id_pae_var INTEGER;
    pae_est_valide BOOLEAN;
BEGIN
    id_ue_var := (SELECT id_ue FROM projet_sql.ues WHERE code_ue = code_ue_param);
    id_pae_var := (SELECT id_pae FROM projet_sql.paes WHERE id_etudiant = id_etudiant_param);
    pae_est_valide := (SELECT est_valide FROM projet_sql.paes WHERE id_etudiant = id_etudiant_param);
    IF pae_est_valide THEN
        RAISE 'Votre PAE est deja valide';
    END IF;
    DELETE FROM projet_sql.lignes_ue WHERE id_ue = id_ue_var AND id_pae = id_pae_var;
    RETURN id_ue_var;
END;
$$;


-- procedure 3
CREATE OR REPLACE function projet_sql.valider_pae(integer) returns integer
    language plpgsql
as
$$
DECLARE
    id_etudiant_param ALIAS FOR $1;
    id_pae_var INTEGER;
    somme_credits_valide INTEGER;
    somme_credits_pae INTEGER;
    est_valide_var BOOLEAN;
BEGIN
    somme_credits_valide := (SELECT sum(nombre_credits)
                             FROM projet_sql.ues u, projet_sql.ues_valide v
                             WHERE u.id_ue = v.id_ue AND id_etudiant = id_etudiant_param);
    id_pae_var := (SELECT id_pae
                   FROM projet_sql.paes
                   WHERE id_etudiant = id_etudiant_param);
    somme_credits_pae := (SELECT sum(nombre_credits)
                          FROM projet_sql.ues u, projet_sql.lignes_ue l
                          WHERE u.id_ue = l.id_ue AND id_pae = id_pae_var);
    est_valide_var := (SELECT est_valide FROM projet_sql.paes WHERE id_pae = id_pae_var);
    -- EXCEPTIONS
    IF((somme_credits_pae+somme_credits_valide)>=180 AND somme_credits_pae>74) THEN
        RAISE 'Votre PAE ne peut pas depasser 74 credits';
    END IF;
    IF ((somme_credits_valide<45) AND (somme_credits_pae>60)) THEN
        RAISE 'Votre PAE ne peut pas depasser 60 credits';
    END IF;
    IF ((somme_credits_pae>74) OR (somme_credits_pae<55)) THEN
        RAISE 'Votre PAE ne peut pas etre en dessous de 55 credits ou au-dessus de 74 credits';
    END IF;
    --RAISE notice 'est_valide_var %', est_valide_var;
    IF (est_valide_var) THEN
        RAISE 'Votre PAE est deja valide';
    end if;
    -- RETURNS
    --RAISE NOTICE 'somme_credits_pae: %', somme_credits_pae;
    --RAISE NOTICE 'somme_credits_valide: %', somme_credits_valide;

    UPDATE projet_sql.paes SET est_valide = true WHERE id_pae = id_pae_var;

    IF (@somme_credits_pae+ @somme_credits_valide)>=180 THEN
        UPDATE projet_sql.etudiants SET bloc = 3 WHERE id_etudiant = id_etudiant_param;
        RETURN 3;
    END IF;
    IF (@somme_credits_valide<45) THEN
        UPDATE projet_sql.etudiants SET bloc = 1 WHERE id_etudiant = id_etudiant_param;
        RETURN 1;
    END IF;
    UPDATE projet_sql.etudiants SET bloc = 2 WHERE id_etudiant = id_etudiant_param;
    RETURN 2;
END;
$$;

-- procedure 4

CREATE OR REPLACE function projet_sql.afficher_ues(id_etudiant_param integer) returns text[]
    language plpgsql
as
$$
DECLARE
    ues_var text[];
BEGIN
    ues_var := array(
            select code_ue
            from projet_sql.ues
                     inner join projet_sql.ues_valide on ues.id_ue = ues_valide.id_ue
            where ues_valide.id_etudiant = id_etudiant_param);
    return ues_var;
END ;
$$;


-- procedure 5
CREATE OR REPLACE function projet_sql.visualiser_pae(id_etudiant_param integer) returns text[]
    language plpgsql
as
$$
DECLARE
    ues_var text[];
BEGIN
    ues_var := array(
            select code_ue
            from projet_sql.ues, projet_sql.lignes_ue lu, projet_sql.paes
            where ues.id_ue = lu.id_ue AND
                    lu.id_pae = paes.id_pae AND
                    paes.id_etudiant = id_etudiant_param);
    return ues_var;
END ;
$$ ;

-- procedure 6
CREATE OR REPLACE function projet_sql.reinitialiser_pae(integer) returns integer
    language plpgsql
as
$$
DECLARE
    id_etudiant_param ALIAS FOR $1;
    id_pae_var INTEGER;
    pae_est_valide BOOLEAN;
BEGIN
    id_pae_var = (SELECT id_pae FROM projet_sql.paes WHERE id_etudiant = id_etudiant_param);
    pae_est_valide = (SELECT est_valide FROM projet_sql.paes WHERE id_etudiant = id_etudiant_param);
    IF pae_est_valide THEN
        RAISE 'Votre PAE est deja valide';
    END IF;
    DELETE FROM projet_sql.lignes_ue WHERE id_pae = id_pae_var;
    RETURN 0;
END ;
$$;

-- PROCEDURES CENTRALE --
-- procedure 1
CREATE OR REPLACE FUNCTION projet_sql.ajouter_UE_central (
    projet_sql.ues.code_ue%TYPE,
    projet_sql.ues.nom%TYPE,
    projet_sql.ues.nombre_credits%TYPE,
    projet_sql.ues.num_bloc%TYPE)
    RETURNS projet_sql.ues.code_ue%TYPE
AS $$
DECLARE
    id_ue_param ALIAS FOR $1;
    nom_param ALIAS FOR $2;
    nombre_credits_param ALIAS FOR $3;
    num_bloc_param ALIAS FOR $4;
    code_ue_param VARCHAR;
BEGIN
    INSERT INTO projet_sql.ues VALUES(DEFAULT, id_ue_param, nom_param, nombre_credits_param, 0, num_bloc_param) RETURNING code_ue INTO code_ue_param;
    RETURN code_ue_param;
END;
$$ LANGUAGE plpgsql;

-- procedure 2
CREATE OR REPLACE FUNCTION projet_sql.ajouter_prerequis_a_une_UE (
    projet_sql.ues.code_ue%TYPE,
    projet_sql.ues.code_ue%TYPE)
    RETURNS projet_sql.ues.code_ue%TYPE
AS $$
DECLARE
    code_ue_prerequise_param ALIAS FOR $1;
    code_ue_suivante_param ALIAS FOR $2;
    id_ue_prerequise INTEGER;
    id_ue_suivante INTEGER;
    bloc_ue_prerequise INTEGER;
    bloc_ue_suivante INTEGER;
    id_access_ue_ret INTEGER;
BEGIN
    id_ue_prerequise := (SELECT id_ue FROM projet_sql.ues u WHERE code_ue = code_ue_prerequise_param);
    id_ue_suivante := (SELECT id_ue FROM projet_sql.ues u WHERE code_ue = code_ue_suivante_param);
    bloc_ue_prerequise := (SELECT u.num_bloc FROM projet_sql.acces_ue a, projet_sql.ues u WHERE a.ue_prerequise=id_ue_prerequise AND a.ue_prerequise = u.id_ue);
    bloc_ue_suivante := (SELECT u.num_bloc FROM projet_sql.acces_ue a, projet_sql.ues u WHERE a.ue_suivante=id_ue_suivante AND a.ue_suivante = u.id_ue);
    IF bloc_ue_prerequise>=bloc_ue_suivante THEN
        RAISE 'Le bloc de l_ue prerequise ne peut pas etre superieur a celui de l_ue concernee';
    END IF;
    INSERT INTO projet_sql.acces_ue VALUES(DEFAULT, id_ue_prerequise, id_ue_suivante) RETURNING id_acces_ue INTO id_access_ue_ret;
    RETURN id_access_ue_ret;
END ;
$$ LANGUAGE plpgsql;

-- procedure 3
CREATE OR REPLACE FUNCTION projet_sql.ajouter_etudiant (
    projet_sql.etudiants.nom%TYPE,
    projet_sql.etudiants.prenom%TYPE,
    projet_sql.etudiants.email%TYPE,
    projet_sql.etudiants.mot_de_passe%TYPE,
    projet_sql.etudiants.bloc%TYPE)
    RETURNS INTEGER
AS $$
DECLARE
    nom_param ALIAS FOR $1;
    prenom_param ALIAS FOR $2;
    email_param ALIAS FOR $3;
    mot_de_passe_param ALIAS FOR $4;
    bloc_param ALIAS FOR $5;
    id_etudiant_ret INTEGER;
BEGIN
    INSERT INTO projet_sql.etudiants VALUES(DEFAULT, nom_param, prenom_param, email_param, mot_de_passe_param, bloc_param) RETURNING id_etudiant INTO id_etudiant_ret;
    INSERT INTO projet_sql.paes VALUES (DEFAULT, DEFAULT, id_etudiant_ret);
    RETURN id_etudiant_ret;
END ;
$$ LANGUAGE plpgsql;
-- procedure 4
CREATE OR REPLACE FUNCTION projet_sql.encoder_UE_validee (
    projet_sql.etudiants.email%TYPE,
    projet_sql.ues.code_ue%TYPE)
    RETURNS RECORD
AS $$
DECLARE
    email_etudiant_param ALIAS FOR $1;
    code_ue_param ALIAS FOR $2;
    id_etudiant_var INTEGER;
    id_ue_var INTEGER;
    ue_valide RECORD;
BEGIN
    id_etudiant_var := (SELECT e.id_etudiant FROM projet_sql.etudiants e WHERE e.email = email_etudiant_param);
    id_ue_var := (SELECT u.id_ue FROM projet_sql.ues u WHERE u.code_ue = code_ue_param);
    INSERT INTO projet_sql.ues_valide VALUES(id_etudiant_var, id_ue_var) RETURNING id_etudiant, id_ue INTO ue_valide;
    RETURN ue_valide;
END ;
$$ LANGUAGE plpgsql;


-- Vue pour etudiants
create view visualiser_etudiants(id_etudiant, nom, prenom, bloc, somme_credits, est_valide) as
SELECT e.id_etudiant,
       e.nom,
       e.prenom,
       e.bloc,
       sum(u.nombre_credits) AS somme_credits,
       p.est_valide
FROM projet_sql.etudiants e
         LEFT JOIN projet_sql.paes p ON e.id_etudiant = p.id_etudiant
         LEFT JOIN projet_sql.lignes_ue l ON p.id_pae = l.id_pae
         LEFT JOIN projet_sql.ues u ON l.id_ue = u.id_ue
         AND e.id_etudiant = p.id_etudiant
         AND p.id_pae = l.id_pae
         AND l.id_ue = u.id_ue
GROUP BY e.id_etudiant, e.nom, e.prenom, p.est_valide;



-- vue pour somme crédits valide

CREATE OR REPLACE VIEW projet_sql.visualiser_credits_valide
AS
SELECT e.nom,
       e.prenom,
       p.est_valide,
       sum(u.nombre_credits) AS somme_credits_valide
FROM projet_sql.etudiants e,
     projet_sql.ues u,
     projet_sql.ues_valide uv,
     projet_sql.paes p
WHERE e.id_etudiant = uv.id_etudiant
  AND u.id_ue = uv.id_ue
  AND p.id_etudiant = e.id_etudiant
GROUP BY e.id_etudiant, e.nom, e.prenom, p.est_valide;


-- procedure 8 TODO: TEST
CREATE OR REPLACE VIEW projet_sql.visualiser_ue AS
SELECT u.code_ue , u.nom ,  u.nombre_inscrits , u.num_bloc
FROM projet_sql.ues u;

INSERT INTO projet_sql.paes VALUES (DEFAULT, DEFAULT, 1);
INSERT INTO projet_sql.paes VALUES (DEFAULT, DEFAULT, 2);
INSERT INTO projet_sql.paes VALUES (DEFAULT, DEFAULT, 3);
INSERT INTO projet_sql.paes VALUES (DEFAULT, DEFAULT, 4);
INSERT INTO projet_sql.etudiants VALUES (DEFAULT, 'Cambron', 'Isabelle', 'cambron.isabelle@studetn.vinci.be', '$2a$10$M3Y5g8QegSS1bJt17r67ne4yeG6JeohsshjslS/1RZT3RPqFqPbXW');
INSERT INTO projet_sql.paes VALUES (DEFAULT, DEFAULT, 5);

