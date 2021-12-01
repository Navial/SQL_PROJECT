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

INSERT INTO projet_sql.etudiants VALUES (DEFAULT,'Vandermeeersch','Laurent','laurent@student.vinci.be','$2a$10$M3Y5g8QegSS1bJt17r67ne4yeG6JeohsshjslS/1RZT3RPqFqPbXW',1);
INSERT INTO projet_sql.etudiants VALUES (DEFAULT,'Poppe','Nicolas','p_nicolas@student.vinci.be',       '$2a$10$M3Y5g8QegSS1bJt17r67ne4yeG6JeohsshjslS/1RZT3RPqFqPbXW',1);
INSERT INTO projet_sql.etudiants VALUES (DEFAULT,'Mircovici','Stefan','m_stefan@student.vinci.be',     '$2a$10$M3Y5g8QegSS1bJt17r67ne4yeG6JeohsshjslS/1RZT3RPqFqPbXW',2);
INSERT INTO projet_sql.etudiants VALUES (DEFAULT,'Pirlot','Antoine','p_antoine@student.vinci.be',      '$2a$10$M3Y5g8QegSS1bJt17r67ne4yeG6JeohsshjslS/1RZT3RPqFqPbXW',2);
INSERT INTO projet_sql.etudiants VALUES (DEFAULT,'Gobbe','Mehdi','g_mehdi@student.vinci.be',           '$2a$10$M3Y5g8QegSS1bJt17r67ne4yeG6JeohsshjslS/1RZT3RPqFqPbXW',2);
INSERT INTO projet_sql.etudiants VALUES (DEFAULT,'Bardijn','François','b_francois@student.vinci.be',   '$2a$10$M3Y5g8QegSS1bJt17r67ne4yeG6JeohsshjslS/1RZT3RPqFqPbXW',3);
INSERT INTO projet_sql.etudiants VALUES (DEFAULT,'Denis','Victor','victor.denis@student.vinci.be',     '$2a$10$M3Y5g8QegSS1bJt17r67ne4yeG6JeohsshjslS/1RZT3RPqFqPbXW',2);
INSERT INTO projet_sql.etudiants VALUES (DEFAULT,'Rayan','Abarkhan','rayan.abarkhan@student.vinci.be', '$2a$10$M3Y5g8QegSS1bJt17r67ne4yeG6JeohsshjslS/1RZT3RPqFqPbXW',3);
INSERT INTO projet_sql.etudiants VALUES (DEFAULT,'Monkey','Luffy','luffy.monkey@student.vinci.be',     '$2a$10$M3Y5g8QegSS1bJt17r67ne4yeG6JeohsshjslS/1RZT3RPqFqPbXW',3);
INSERT INTO projet_sql.etudiants VALUES (DEFAULT,'Nazarian','Nora','nora.nazarian@student.vinci.be',   '$2a$10$M3Y5g8QegSS1bJt17r67ne4yeG6JeohsshjslS/1RZT3RPqFqPbXW',1);


-- Values (id_ue , code_ue, nom, nbr_credit, nbr_etudiants_inscrits, num_bloc)


--- UE du bloc 1
INSERT INTO projet_sql.ues VALUES (DEFAULT,'BINV1458-1','BD1',4,DEFAULT,1); -- 1
INSERT INTO projet_sql.ues VALUES (DEFAULT,'BINV1789','SD1',5,DEFAULT,1); -- 2
INSERT INTO projet_sql.ues VALUES (DEFAULT,'BINV1478','Algo',5,DEFAULT,1); -- 3
INSERT INTO projet_sql.ues VALUES (DEFAULT,'BINV1687','APOO',5,DEFAULT,1); -- 4
INSERT INTO projet_sql.ues VALUES (DEFAULT,'BINV1114-1','Langage Machine',4,DEFAULT,1); -- 5
INSERT INTO projet_sql.ues VALUES (DEFAULT,'BINV1800','Anglais 1',4,DEFAULT,1); -- 6
INSERT INTO projet_sql.ues VALUES (DEFAULT,'BINV1400-1','HTML',2,DEFAULT,1); -- 7
INSERT INTO projet_sql.ues VALUES (DEFAULT,'BINV1600','PHP',3,DEFAULT,1); -- 8
INSERT INTO projet_sql.ues VALUES (DEFAULT,'BINV1200-1','Linux',3,DEFAULT,1); -- 9
INSERT INTO projet_sql.ues VALUES (DEFAULT,'BINV1200-2','OS',3,DEFAULT,1); -- 10
INSERT INTO projet_sql.ues VALUES (DEFAULT,'BINV1400-2','Projet-web HTML',3,DEFAULT,1); -- 11
INSERT INTO projet_sql.ues VALUES (DEFAULT,'BINV1600-2','Projet-web PHP',4,DEFAULT,1); -- 12
INSERT INTO projet_sql.ues VALUES (DEFAULT,'BINV1114-2','DO',3,DEFAULT,1); -- 13

-- UE du bloc 2s

INSERT INTO projet_sql.ues VALUES (DEFAULT,'BINV2458-1','BD2',6,DEFAULT,2); -- 14
INSERT INTO projet_sql.ues VALUES (DEFAULT,'BINV2789','Langage C',5,DEFAULT,2); -- 15
INSERT INTO projet_sql.ues VALUES (DEFAULT,'BINV2478','Analyse et modélisation',6,DEFAULT,2); -- 16
INSERT INTO projet_sql.ues VALUES (DEFAULT,'BINV2687','Gestion des données : avancé',6,DEFAULT,2); -- 17
INSERT INTO projet_sql.ues VALUES (DEFAULT,'BINV2114','Programmation Java : avancé',4,DEFAULT,2); -- 18
INSERT INTO projet_sql.ues VALUES (DEFAULT,'BINV2800','Développement Web : avancé',4,DEFAULT,2); -- 19
INSERT INTO projet_sql.ues VALUES (DEFAULT,'BINV2400-1','DevOps',2,DEFAULT,2); -- 20
INSERT INTO projet_sql.ues VALUES (DEFAULT,'BINV2600','Structure de données : avancé',4,DEFAULT,2); -- 21
INSERT INTO projet_sql.ues VALUES (DEFAULT,'BINV2200-1','Organisation des entreprises',5,DEFAULT,2); -- 22
INSERT INTO projet_sql.ues VALUES (DEFAULT,'BINV2200-2','Conception d''applications d''entreprise',4,DEFAULT,2); -- 23
INSERT INTO projet_sql.ues VALUES (DEFAULT,'BINV2400-2','Linux : Programmation distribuée',4,DEFAULT,2); -- 24
INSERT INTO projet_sql.ues VALUES (DEFAULT,'BINV2600-2','Informatique Mobile',6,DEFAULT,2); -- 25
INSERT INTO projet_sql.ues VALUES (DEFAULT,'BINV2458-2','Anglais 2',4,DEFAULT,2); -- 26

--- UE du bloc s3
INSERT INTO projet_sql.ues VALUES (DEFAULT,'BINV3458-1','Sécurité',4,DEFAULT,3); -- 27
INSERT INTO projet_sql.ues VALUES (DEFAULT,'BINV3789','Administration infrastructure',5,DEFAULT,3); -- 28
INSERT INTO projet_sql.ues VALUES (DEFAULT,'BINV3478','Organisation des entreprises',5,DEFAULT,3); -- 29
INSERT INTO projet_sql.ues VALUES (DEFAULT,'BINV3687','Anglais 3',5,DEFAULT,3); -- 30
INSERT INTO projet_sql.ues VALUES (DEFAULT,'BINV3114','Programmation : questions spéciales',8,DEFAULT,3); -- 31
INSERT INTO projet_sql.ues VALUES (DEFAULT,'BINV3800','Développement web : questions spéciales',8,DEFAULT,3); -- 32
INSERT INTO projet_sql.ues VALUES (DEFAULT,'BINV3400-1','Project de fin d''étude',15,DEFAULT,3); -- 33
INSERT INTO projet_sql.ues VALUES (DEFAULT,'BINV3600','Intégration en milieu professionel',5,DEFAULT,3); -- 34
INSERT INTO projet_sql.ues VALUES (DEFAULT,'BINV3200-1','Intelligence Artificielle',5,DEFAULT,3); -- 35
INSERT INTO projet_sql.ues VALUES (DEFAULT,'BINV3200-2','Progiciel de gestion intégré',5,DEFAULT,3); -- 36
INSERT INTO projet_sql.ues VALUES (DEFAULT,'BINV3369-2','Développement à l''aide d''un moteur de jeux Unity',5,DEFAULT,3); -- 37

--Values(ue_valside,id_etudiant)

INSERT INTO projet_sql.ues_valide VALUES (1,1);
INSERT INTO projet_sql.ues_valide VALUES (2,1);
INSERT INTO projet_sql.ues_valide VALUES (3,1);
INSERT INTO projet_sql.ues_valide VALUES (4,1);
INSERT INTO projet_sql.ues_valide VALUES (5,1);
INSERT INTO projet_sql.ues_valide VALUES (6,1);
INSERT INTO projet_sql.ues_valide VALUES (7,1);

INSERT INTO projet_sql.ues_valide VALUES (1,2);
INSERT INTO projet_sql.ues_valide VALUES (2,2);
INSERT INTO projet_sql.ues_valide VALUES (3,2);
INSERT INTO projet_sql.ues_valide VALUES (4,2);
INSERT INTO projet_sql.ues_valide VALUES (5,2);
INSERT INTO projet_sql.ues_valide VALUES (6,2);
INSERT INTO projet_sql.ues_valide VALUES (7,2);
INSERT INTO projet_sql.ues_valide VALUES (8,2);

INSERT INTO projet_sql.ues_valide VALUES (1,3);
INSERT INTO projet_sql.ues_valide VALUES (2,3);
INSERT INTO projet_sql.ues_valide VALUES (3,3);
INSERT INTO projet_sql.ues_valide VALUES (4,3);
INSERT INTO projet_sql.ues_valide VALUES (5,3);
INSERT INTO projet_sql.ues_valide VALUES (6,3);
INSERT INTO projet_sql.ues_valide VALUES (7,3);
INSERT INTO projet_sql.ues_valide VALUES (8,3);
INSERT INTO projet_sql.ues_valide VALUES (9,3);
INSERT INTO projet_sql.ues_valide VALUES (10,3);

INSERT INTO projet_sql.ues_valide VALUES (1,4);
INSERT INTO projet_sql.ues_valide VALUES (2,4);
INSERT INTO projet_sql.ues_valide VALUES (3,4);
INSERT INTO projet_sql.ues_valide VALUES (4,4);
INSERT INTO projet_sql.ues_valide VALUES (5,4);
INSERT INTO projet_sql.ues_valide VALUES (6,4);
INSERT INTO projet_sql.ues_valide VALUES (8,4);
INSERT INTO projet_sql.ues_valide VALUES (9,4);
INSERT INTO projet_sql.ues_valide VALUES (10,4);

-- Values (id_use , id_prerequis)

INSERT INTO projet_sql.acces_ue VALUES (DEFAULT, 14,1); -- BD2 - BD1
INSERT INTO projet_sql.acces_ue VALUES (DEFAULT, 26,6); -- Anglais 2 - Anglais 1
INSERT INTO projet_sql.acces_ue VALUES (DEFAULT, 24,9); -- Linux 2 - Linux 1
INSERT INTO projet_sql.acces_ue VALUES (DEFAULT, 25,3); -- Informatique Mobile - Algo
INSERT INTO projet_sql.acces_ue VALUES (DEFAULT, 25,5); -- Informatique Mobile - LM
INSERT INTO projet_sql.acces_ue VALUES (DEFAULT, 18,3); -- Dev. Java - Algo
INSERT INTO projet_sql.acces_ue VALUES (DEFAULT, 16,4); -- Analyse données - APOO
INSERT INTO projet_sql.acces_ue VALUES (DEFAULT, 17,1); -- Gestion des données - BD1
INSERT INTO projet_sql.acces_ue VALUES (DEFAULT, 17,4); -- Gestion des données - APOO
INSERT INTO projet_sql.acces_ue VALUES (DEFAULT, 21,2); -- SD avancé - SD1
INSERT INTO projet_sql.acces_ue VALUES (DEFAULT, 27,20); -- Sécurité - DevOps
INSERT INTO projet_sql.acces_ue VALUES (DEFAULT, 27,15); -- Sécurité - Langage C
INSERT INTO projet_sql.acces_ue VALUES (DEFAULT, 30,26); -- Anglais 3 - Anglais 2
INSERT INTO projet_sql.acces_ue VALUES (DEFAULT, 29,22); -- Orga Entr. 2  - Orga Entr. 1
INSERT INTO projet_sql.acces_ue VALUES (DEFAULT, 35,18); -- IA - Java avancé
INSERT INTO projet_sql.acces_ue VALUES (DEFAULT, 35,17); -- IA - Gestion des données
INSERT INTO projet_sql.acces_ue VALUES (DEFAULT, 35,15); -- IA - Langage C
INSERT INTO projet_sql.acces_ue VALUES (DEFAULT, 32,19); -- Dev. Web : spécial - Dev Web : Avancé

-- INSERT INTO PAE
INSERT INTO  projet_sql.paes VALUES (DEFAULT, DEFAULT, 1);
INSERT INTO  projet_sql.paes VALUES (DEFAULT, DEFAULT, 3);
INSERT INTO  projet_sql.paes VALUES (DEFAULT, DEFAULT, 2);
INSERT INTO  projet_sql.paes VALUES (DEFAULT, DEFAULT, 5);
INSERT INTO  projet_sql.paes VALUES (DEFAULT, DEFAULT, 4);
INSERT INTO  projet_sql.paes VALUES (DEFAULT, DEFAULT, 6);
INSERT INTO  projet_sql.paes VALUES (DEFAULT, DEFAULT, 7);
INSERT INTO  projet_sql.paes VALUES (DEFAULT, DEFAULT, 8);
INSERT INTO  projet_sql.paes VALUES (DEFAULT, DEFAULT, 9);
INSERT INTO  projet_sql.paes VALUES (DEFAULT, DEFAULT, 10);

-- VALUES( id_ue , id_etudiant)
INSERT INTO projet_sql.lignes_ue VALUES (1,1);
INSERT INTO projet_sql.lignes_ue VALUES (2,2);
INSERT INTO projet_sql.lignes_ue VALUES (3,4);
INSERT INTO projet_sql.lignes_ue VALUES (5,6);
INSERT INTO projet_sql.lignes_ue VALUES (6,3);


SELECT id_etudiant, nom, prenom, bloc, email, mot_de_passe FROM projet_sql.etudiants WHERE email = 'victor.denis@gmail.com';



-- procedure 1

CREATE OR REPLACE FUNCTION projet_sql.ajouter_ue (
    id_ue_param INTEGER,
    id_etudiant_param INTEGER)
    RETURNS projet_sql.ues.id_ue%TYPE
    language plpgsql
AS $$
DECLARE
    --id_ue_param ALIAS FOR $1;
    --id_etudiant_param ALIAS FOR $2;
    id_pae_var INTEGER := 0;
    pae_est_valide BOOLEAN := 0;
    nb_credits_valides INTEGER := 0;
    id_ue_v INTEGER := 0;
BEGIN
    id_pae_var := (SELECT id_pae FROM projet_sql.paes WHERE id_etudiant = id_etudiant_param);
    pae_est_valide := (SELECT est_valide FROM projet_sql.paes WHERE id_etudiant = id_etudiant_param);
    nb_credits_valides := (SELECT sum(nombre_credits) FROM projet_sql.ues u, projet_sql.ues_valide v WHERE u.id_ue = id_ue_param AND u.id_ue = v.id_ue AND v.id_etudiant = id_etudiant_param);
    IF pae_est_valide THEN
        RAISE 'Votre PAE est deja valide';
END IF;
    IF EXISTS(SELECT id_etudiant, id_ue FROM projet_sql.ues_valide WHERE id_etudiant = id_etudiant_param AND id_ue = id_ue_param) THEN
        RAISE 'Cette UE est deja valide';
END IF;
    IF EXISTS   (SELECT ue_prerequise
                FROM projet_sql.acces_ue
                WHERE ue_suivante = id_ue_param
                AND ue_prerequise NOT IN (SELECT id_ue FROM projet_sql.ues_valide WHERE id_etudiant=id_etudiant_param)) THEN
        RAISE 'Cette UE a des prerequis a valider';
END IF;
    IF (nb_credits_valides < 30) AND (SELECT u.num_bloc FROM projet_sql.blocs b, projet_sql.ues u WHERE b.num_bloc = u.num_bloc AND u.id_ue = id_ue_param) <> 1 THEN
        RAISE 'Moins de 30 credits ont ete valides, vous ne pouvez que choisir une UE du bloc 1';
END IF;
INSERT INTO projet_sql.lignes_ue (id_pae, id_ue) VALUES(id_pae_var, id_ue_param) RETURNING id_ue INTO id_ue_v;
RETURN id_ue_v;
END ;
$$ ;

-- procedure 2
CREATE OR REPLACE function projet_sql.enlever_ue(integer, integer) returns character varying
    language plpgsql
as
$$
DECLARE
    id_ue_param ALIAS FOR $1;
    id_etudiant_param ALIAS FOR $2;
    id_pae_var INTEGER;
    pae_est_valide BOOLEAN;
BEGIN
    id_pae_var := (SELECT id_pae FROM projet_sql.paes WHERE id_etudiant = id_etudiant_param);
    pae_est_valide := (SELECT est_valide FROM projet_sql.paes WHERE id_etudiant = id_etudiant_param);
    IF pae_est_valide THEN
        RAISE 'Votre PAE est deja valide';
    END IF;
    DELETE FROM projet_sql.lignes_ue WHERE id_ue = id_ue_param AND id_pae = id_pae_var;
    RETURN id_ue_param;
END;
$$;

-- procedure 3
CREATE OR REPLACE function projet_sql.alider_pae(integer) returns integer
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


