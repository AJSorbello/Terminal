--
-- PostgreSQL database dump
--

-- Dumped from database version 16.1
-- Dumped by pg_dump version 16.1

-- Started on 2023-11-29 10:44:29 PST

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 218 (class 1259 OID 16409)
-- Name: directors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directors (
    directorid integer NOT NULL,
    name character varying(50) NOT NULL,
    bio character varying(1000),
    birthyear date,
    deathyear date
);


ALTER TABLE public.directors OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16408)
-- Name: directors_directorid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.directors_directorid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.directors_directorid_seq OWNER TO postgres;

--
-- TOC entry 3640 (class 0 OID 0)
-- Dependencies: 217
-- Name: directors_directorid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.directors_directorid_seq OWNED BY public.directors.directorid;


--
-- TOC entry 216 (class 1259 OID 16400)
-- Name: genres; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.genres (
    genreid integer NOT NULL,
    name character varying(50) NOT NULL,
    description character varying(1000)
);


ALTER TABLE public.genres OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16399)
-- Name: genres_genreid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.genres_genreid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.genres_genreid_seq OWNER TO postgres;

--
-- TOC entry 3641 (class 0 OID 0)
-- Dependencies: 215
-- Name: genres_genreid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.genres_genreid_seq OWNED BY public.genres.genreid;


--
-- TOC entry 220 (class 1259 OID 16421)
-- Name: movies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.movies (
    movieid integer NOT NULL,
    title character varying(50) NOT NULL,
    description character varying(1000),
    directorid integer NOT NULL,
    genreid integer NOT NULL,
    imageurl character varying(300),
    featured boolean
);


ALTER TABLE public.movies OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16420)
-- Name: movies_movieid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.movies_movieid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.movies_movieid_seq OWNER TO postgres;

--
-- TOC entry 3642 (class 0 OID 0)
-- Dependencies: 219
-- Name: movies_movieid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.movies_movieid_seq OWNED BY public.movies.movieid;


--
-- TOC entry 224 (class 1259 OID 16454)
-- Name: user_movies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_movies (
    usermovieid integer NOT NULL,
    userid integer,
    movieid integer
);


ALTER TABLE public.user_movies OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16453)
-- Name: user_movies_usermovieid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_movies_usermovieid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_movies_usermovieid_seq OWNER TO postgres;

--
-- TOC entry 3643 (class 0 OID 0)
-- Dependencies: 223
-- Name: user_movies_usermovieid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_movies_usermovieid_seq OWNED BY public.user_movies.usermovieid;


--
-- TOC entry 222 (class 1259 OID 16447)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    userid integer NOT NULL,
    username character varying(50) NOT NULL,
    password character varying(50) NOT NULL,
    email character varying(50) NOT NULL,
    birth_date date
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16446)
-- Name: users_userid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_userid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_userid_seq OWNER TO postgres;

--
-- TOC entry 3644 (class 0 OID 0)
-- Dependencies: 221
-- Name: users_userid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_userid_seq OWNED BY public.users.userid;


--
-- TOC entry 3464 (class 2604 OID 16412)
-- Name: directors directorid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directors ALTER COLUMN directorid SET DEFAULT nextval('public.directors_directorid_seq'::regclass);


--
-- TOC entry 3463 (class 2604 OID 16403)
-- Name: genres genreid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genres ALTER COLUMN genreid SET DEFAULT nextval('public.genres_genreid_seq'::regclass);


--
-- TOC entry 3465 (class 2604 OID 16424)
-- Name: movies movieid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movies ALTER COLUMN movieid SET DEFAULT nextval('public.movies_movieid_seq'::regclass);


--
-- TOC entry 3467 (class 2604 OID 16457)
-- Name: user_movies usermovieid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_movies ALTER COLUMN usermovieid SET DEFAULT nextval('public.user_movies_usermovieid_seq'::regclass);


--
-- TOC entry 3466 (class 2604 OID 16450)
-- Name: users userid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN userid SET DEFAULT nextval('public.users_userid_seq'::regclass);


--
-- TOC entry 3628 (class 0 OID 16409)
-- Dependencies: 218
-- Data for Name: directors; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.directors (directorid, name, bio, birthyear, deathyear) VALUES (1, 'John McTiernan', 'John Campbell McTiernan Jr. is an American filmmaker. He is best known for his action films, including Predator, Die Hard, and The Hunt for Red October.', '1951-01-08', NULL);
INSERT INTO public.directors (directorid, name, bio, birthyear, deathyear) VALUES (2, 'Jonathan Demme', 'Robert Jonathan Demme was an American director, producer, and screenwriter.', '1944-01-01', '2017-01-01');
INSERT INTO public.directors (directorid, name, bio, birthyear, deathyear) VALUES (3, 'Darren Aaronofsky', 'Darren Aaronofsky is the founder and CEO of the American Institute of Motion Picture Art and Technology', '1968-02-12', NULL);
INSERT INTO public.directors (directorid, name, bio, birthyear, deathyear) VALUES (55, 'John McTiernan', 'John Campbell McTiernan Jr. is an American filmmaker. He is best known for his action films, including Predator, Die Hard, and The Hunt for Red October.', '1951-01-08', NULL);
INSERT INTO public.directors (directorid, name, bio, birthyear, deathyear) VALUES (56, 'Michael Bay', 'Michael Bay is a prominent American director and producer, famous for his dynamic and visually striking style. He''s known for directing major action blockbusters like "Bad Boys," "Armageddon," and the "Transformers" series.', '1965-02-17', NULL);
INSERT INTO public.directors (directorid, name, bio, birthyear, deathyear) VALUES (57, 'Darren Aaronofsky', 'Darren Aaronofsky is the founder and CEO of the American Institute of Motion Picture Art and Technology', '1968-02-12', NULL);
INSERT INTO public.directors (directorid, name, bio, birthyear, deathyear) VALUES (58, 'James Cameron', 'James Cameron is a highly influential Canadian filmmaker, known for his groundbreaking work in the science fiction and epic genres. He has gained fame for creating visually spectacular and technically innovative films. Cameron''s notable works include "The Abyss," "True Lies," "Titanic," and "Avatar." ', '1954-08-16', NULL);
INSERT INTO public.directors (directorid, name, bio, birthyear, deathyear) VALUES (59, 'James Mangold', 'James Mangold is an American film director, screenwriter, and producer known for his versatile filmmaking style. He has directed a variety of films across different genres, including the psychological thriller "Girl, Interrupted," the romantic comedy "Kate & Leopold," the biographical drama "Walk the Line," and the western "3:10 to Yuma." ', '1963-12-16', NULL);
INSERT INTO public.directors (directorid, name, bio, birthyear, deathyear) VALUES (60, 'Shawn Levy', ' Shawn Levy is a Canadian film director, producer, and actor. He is widely recognized for his work in the comedy and family genres. Levy''s notable directing credits include films such as "Cheaper by the Dozen," "The Pink Panther," "Night at the Museum" series, and "Real Steel." His films are known for their broad appeal, combining humor with heartwarming themes.', '1968-07-23', NULL);
INSERT INTO public.directors (directorid, name, bio, birthyear, deathyear) VALUES (61, 'Zhang Yimou', 'Zhang Yimou is a celebrated Chinese film director, producer, and cinematographer. He is one of the leading figures of the Fifth Generation of Chinese cinema, known for his visually stunning and emotionally powerful storytelling. ', '1951-11-14', NULL);
INSERT INTO public.directors (directorid, name, bio, birthyear, deathyear) VALUES (62, 'Wachowski Brothers', ' The Wachowskis are known for their imaginative storytelling and exploration of complex themes such as reality, identity, and humanity''s relationship with technology. They have also been influential in their visible transition from male to female, becoming two of the most prominent transgender figures in the film industry. Their work has significantly impacted modern science fiction and action genres.', '1965-06-21', NULL);


--
-- TOC entry 3626 (class 0 OID 16400)
-- Dependencies: 216
-- Data for Name: genres; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.genres (genreid, name, description) VALUES (129, 'Sci-Fi', 'Sci-Fi, numerous scenes, and/or the entire background for the setting of the narrative, should be based on speculative scientific discoveries or developments, environmental changes, space travel, or life on other planets.');
INSERT INTO public.genres (genreid, name, description) VALUES (130, 'Drama', 'Drama, Should contain numerous consecutive scenes of characters portrayed to effect a serious narrative throughout the title, usually involving conflicts and emotions. This can be exaggerated upon to produce melodrama.');
INSERT INTO public.genres (genreid, name, description) VALUES (7, 'Thriller', 'Thriller film, also known as suspense film or suspense thriller, is a broad film genre that involves excitement and suspense in the audience.');
INSERT INTO public.genres (genreid, name, description) VALUES (8, 'Animated', 'Animation is a method in which pictures are manipulated to appear as moving images. In traditional animation, images are drawn or painted by hand on transparent celluloid sheets to be photographed and exhibited on film.');
INSERT INTO public.genres (genreid, name, description) VALUES (9, 'Comedy', 'Comedy is a genre of film in which the main emphasis is on humor. These films are designed to make the audience laugh through amusement and most often work by exaggerating characteristics for humorous effect.');
INSERT INTO public.genres (genreid, name, description) VALUES (10, 'Action', 'Action contain numerous scenes where action is spectacular and usually destructive. Often includes non-stop motion, high energy physical stunts, chases, battles, and destructive crises (floods, explosions, natural disasters, fires, etc.)');
INSERT INTO public.genres (genreid, name, description) VALUES (11, 'Horror', 'Horror, contain numerous consecutive scenes of characters effecting a terrifying and/or repugnant narrative throughout the title.');
INSERT INTO public.genres (genreid, name, description) VALUES (12, 'Sci-Fi', 'Sci-Fi, numerous scenes, and/or the entire background for the setting of the narrative, should be based on speculative scientific discoveries or developments, environmental changes, space travel, or life on other planets.');


--
-- TOC entry 3630 (class 0 OID 16421)
-- Dependencies: 220
-- Data for Name: movies; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.movies (movieid, title, description, directorid, genreid, imageurl, featured) VALUES (22, 'The Predator', 'Dutch (Arnold Schwarzenegger), a soldier of fortune, is hired by the U.S. government to secretly rescue a group of politicians trapped in Guatemala. But when Dutch and his team, and their crew, are transported to which includes weapons expert Blain (Jesse Ventura) and CIA agent George (Carl Weathers), land in Central America, something is gravely wrong. After finding a string of dead bodies, the crew discovers they are being hunted by a brutal creature with superhuman strength and the ability to disappear into its surroundings.he jungle, an alien ship crash-lands on Earth. Man must fight to survive..', 1, 10, 'The_Predator.jpg', true);
INSERT INTO public.movies (movieid, title, description, directorid, genreid, imageurl, featured) VALUES (23, 'The Fountain', 'As a 16th-century conquistador, Tomas searches for the legendary Fountain of Youth. As a present-day scientist, he desperately struggles to cure the cancer that is killing his wife.', 3, 7, 'The_Fountain.jpg', true);
INSERT INTO public.movies (movieid, title, description, directorid, genreid, imageurl, featured) VALUES (24, 'The Predator', 'Dutch (Arnold Schwarzenegger), a soldier of fortune, is hired by the U.S. government to secretly rescue a group of politicians trapped in Guatemala. But when Dutch and his team, and their crew, are transported to which includes weapons expert Blain (Jesse Ventura) and CIA agent George (Carl Weathers), land in Central America, something is gravely wrong. After finding a string of dead bodies, the crew discovers they are being hunted by a brutal creature with superhuman strength and the ability to disappear into its surroundings.he jungle, an alien ship crash-lands on Earth. Man must fight to survive..', 1, 10, 'The_Predator.jpg', true);
INSERT INTO public.movies (movieid, title, description, directorid, genreid, imageurl, featured) VALUES (25, 'Transformers', 'Humanity''s fate hinges on a war between the Autobots and Decepticons, shape-shifting robots, on Earth. The key to ultimate power is sought after by both sides, with only young Sam Witwicky (Shia LaBeouf) able to prevent global destruction.', 3, 7, 'The_Fountain.jpg', true);
INSERT INTO public.movies (movieid, title, description, directorid, genreid, imageurl, featured) VALUES (26, 'Trandsformers 2', 'Two years after defeating the Decepticons, Sam Witwicky (Shia LaBeouf) starts college while Optimus Prime and the Autobots ally with a secret military group on Earth. Facing the threat of The Fallen, an ancient Decepticon, Sam and his girlfriend, Mikaela, must uncover the Transformers Earth history to defeat The Fallen.', 1, 10, 'The_Predator.jpg', true);
INSERT INTO public.movies (movieid, title, description, directorid, genreid, imageurl, featured) VALUES (27, 'Terminator', 'A cyborg assassin, the Terminator (Arnold Schwarzenegger), travels from 2029 to 1984 to kill Sarah Connor (Linda Hamilton). Kyle Reese (Michael Biehn) is sent to protect her, revealing the threat of Skynet, an AI that will cause a nuclear holocaust. Sarah is targeted as her unborn son will lead the resistance. She and Kyle try to evade the relentless Terminator.', 58, 10, 'The_Terminator', true);
INSERT INTO public.movies (movieid, title, description, directorid, genreid, imageurl, featured) VALUES (28, 'Terminator 2', 'Eleven years after "The Terminator," John Connor, vital for future victory over robots, is hunted by the shape-shifting T-1000, a Terminator from the future. The upgraded T-800 (Arnold Schwarzenegger) is sent to protect him. John and his mother, aided by the T-800, flee, as John unexpectedly bonds with the robot.', 58, 10, 'Terminator 1.jpg', true);
INSERT INTO public.movies (movieid, title, description, directorid, genreid, imageurl, featured) VALUES (29, 'The Wolverine', 'In Japan, the century-old mutant Wolverine (Hugh Jackman) encounters yakuza and samurai, facing physical and emotional challenges. He protects an industrialist''s daughter, confronts mortality, battles formidable enemies, and deals with his haunted past.', 59, 10, 'The_Wolverine.jpg', true);
INSERT INTO public.movies (movieid, title, description, directorid, genreid, imageurl, featured) VALUES (30, 'Hero', 'In an ancient Chinese martial arts epic, an unnamed warrior (Jet Li) is celebrated for defeating the king''s three formidable enemies. As he recounts his battles with assassins Broken Sword, Flying Snow, and Moon, the king doubts his stories and suggests alternative versions of the events.', 61, 130, 'HERO.jpg', true);
INSERT INTO public.movies (movieid, title, description, directorid, genreid, imageurl, featured) VALUES (31, 'The Matrix', '"The Matrix" is a groundbreaking sci-fi action film set in a dystopian future where humanity is unknowingly trapped in a simulated reality called the Matrix, created by intelligent machines. The story follows Thomas Anderson, a computer programmer who leads a double life as the hacker Neo. After discovering the truth about the Matrix, Neo joins a group of rebels led by Morpheus and Trinity. They fight against the machines and work to free humanity from this artificial world, while Neo grapples with his role as the prophesied "One" who can end the war.', 62, 12, 'The_Matrix.jpg', true);
INSERT INTO public.movies (movieid, title, description, directorid, genreid, imageurl, featured) VALUES (32, 'Free Guy', 'A bank teller realizes he''s a background character in a video game and decides to become the hero of his own story. In a limitless world, he aims to save the day on his terms and possibly romance the coder who created him.', 60, 9, 'free-guy.jpg', true);


--
-- TOC entry 3634 (class 0 OID 16454)
-- Dependencies: 224
-- Data for Name: user_movies; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.user_movies (usermovieid, userid, movieid) VALUES (1, 1, 22);
INSERT INTO public.user_movies (usermovieid, userid, movieid) VALUES (2, 2, 23);
INSERT INTO public.user_movies (usermovieid, userid, movieid) VALUES (3, 3, 24);


--
-- TOC entry 3632 (class 0 OID 16447)
-- Dependencies: 222
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.users (userid, username, password, email, birth_date) VALUES (2, 'cooluser456', 'password2', 'cooluser456@example.com', '1992-02-02');
INSERT INTO public.users (userid, username, password, email, birth_date) VALUES (3, 'awesome789', 'password3', 'awesome789@example.com', '1994-03-03');
INSERT INTO public.users (userid, username, password, email, birth_date) VALUES (1, 'user123', 'password1', 'changed@gmail.com', '1990-01-01');


--
-- TOC entry 3645 (class 0 OID 0)
-- Dependencies: 217
-- Name: directors_directorid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.directors_directorid_seq', 62, true);


--
-- TOC entry 3646 (class 0 OID 0)
-- Dependencies: 215
-- Name: genres_genreid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.genres_genreid_seq', 130, true);


--
-- TOC entry 3647 (class 0 OID 0)
-- Dependencies: 219
-- Name: movies_movieid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.movies_movieid_seq', 32, true);


--
-- TOC entry 3648 (class 0 OID 0)
-- Dependencies: 223
-- Name: user_movies_usermovieid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_movies_usermovieid_seq', 1, false);


--
-- TOC entry 3649 (class 0 OID 0)
-- Dependencies: 221
-- Name: users_userid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_userid_seq', 1, false);


--
-- TOC entry 3471 (class 2606 OID 16416)
-- Name: directors directors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directors
    ADD CONSTRAINT directors_pkey PRIMARY KEY (directorid);


--
-- TOC entry 3469 (class 2606 OID 16407)
-- Name: genres genres_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genres
    ADD CONSTRAINT genres_pkey PRIMARY KEY (genreid);


--
-- TOC entry 3473 (class 2606 OID 16428)
-- Name: movies movies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movies
    ADD CONSTRAINT movies_pkey PRIMARY KEY (movieid);


--
-- TOC entry 3477 (class 2606 OID 16459)
-- Name: user_movies user_movies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_movies
    ADD CONSTRAINT user_movies_pkey PRIMARY KEY (usermovieid);


--
-- TOC entry 3475 (class 2606 OID 16452)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (userid);


--
-- TOC entry 3478 (class 2606 OID 16434)
-- Name: movies directorkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movies
    ADD CONSTRAINT directorkey FOREIGN KEY (directorid) REFERENCES public.directors(directorid);


--
-- TOC entry 3479 (class 2606 OID 16429)
-- Name: movies genrekey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movies
    ADD CONSTRAINT genrekey FOREIGN KEY (genreid) REFERENCES public.genres(genreid);


--
-- TOC entry 3480 (class 2606 OID 16465)
-- Name: user_movies moviekey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_movies
    ADD CONSTRAINT moviekey FOREIGN KEY (movieid) REFERENCES public.movies(movieid);


--
-- TOC entry 3481 (class 2606 OID 16460)
-- Name: user_movies userkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_movies
    ADD CONSTRAINT userkey FOREIGN KEY (userid) REFERENCES public.users(userid);


-- Completed on 2023-11-29 10:44:29 PST

--
-- PostgreSQL database dump complete
--

