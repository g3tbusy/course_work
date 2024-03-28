--
-- PostgreSQL database dump
--

-- Dumped from database version 16.0 (Debian 16.0-1.pgdg120+1)
-- Dumped by pg_dump version 16.0 (Debian 16.0-1.pgdg120+1)

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
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories (
    category_id integer NOT NULL,
    category_name character varying(50) NOT NULL
);


ALTER TABLE public.categories OWNER TO postgres;

--
-- Name: categories_category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categories_category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.categories_category_id_seq OWNER TO postgres;

--
-- Name: categories_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categories_category_id_seq OWNED BY public.categories.category_id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    order_id integer NOT NULL,
    user_id integer NOT NULL,
    order_status character varying(30) NOT NULL,
    order_date date DEFAULT CURRENT_DATE,
    order_time time without time zone DEFAULT CURRENT_TIMESTAMP,
    product_id integer NOT NULL,
    product_name character varying(100) NOT NULL,
    delivery_address character varying(100) NOT NULL,
    order_price numeric(7,2) NOT NULL,
    order_delivery_price integer NOT NULL
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- Name: orders_order_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orders_order_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orders_order_id_seq OWNER TO postgres;

--
-- Name: orders_order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orders_order_id_seq OWNED BY public.orders.order_id;


--
-- Name: productreviews; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.productreviews (
    review_id integer NOT NULL,
    user_id integer NOT NULL,
    product_id integer NOT NULL,
    review_text character varying(500),
    review_rating numeric(2,1),
    review_date date DEFAULT CURRENT_DATE,
    CONSTRAINT productreviews_review_rating_check CHECK (((review_rating >= (1)::numeric) AND (review_rating <= (5)::numeric)))
);


ALTER TABLE public.productreviews OWNER TO postgres;

--
-- Name: productreviews_review_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.productreviews_review_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.productreviews_review_id_seq OWNER TO postgres;

--
-- Name: productreviews_review_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.productreviews_review_id_seq OWNED BY public.productreviews.review_id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    product_id integer NOT NULL,
    product_name character varying(100) NOT NULL,
    product_model character varying(60),
    product_description character varying(300),
    product_price numeric(7,2) NOT NULL,
    category_name character varying(50) NOT NULL,
    category_id integer NOT NULL,
    CONSTRAINT products_product_price_check CHECK ((product_price >= (0)::numeric))
);


ALTER TABLE public.products OWNER TO postgres;

--
-- Name: products_product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.products_product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.products_product_id_seq OWNER TO postgres;

--
-- Name: products_product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.products_product_id_seq OWNED BY public.products.product_id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    user_name character varying(20) NOT NULL,
    user_email character varying(50) NOT NULL,
    user_password character(50) NOT NULL,
    user_mobile_number character varying(11) NOT NULL,
    CONSTRAINT users_user_mobile_number_check CHECK ((length((user_mobile_number)::text) = 11))
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_user_id_seq OWNER TO postgres;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: categories category_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories ALTER COLUMN category_id SET DEFAULT nextval('public.categories_category_id_seq'::regclass);


--
-- Name: orders order_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders ALTER COLUMN order_id SET DEFAULT nextval('public.orders_order_id_seq'::regclass);


--
-- Name: productreviews review_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productreviews ALTER COLUMN review_id SET DEFAULT nextval('public.productreviews_review_id_seq'::regclass);


--
-- Name: products product_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products ALTER COLUMN product_id SET DEFAULT nextval('public.products_product_id_seq'::regclass);


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categories (category_id, category_name) FROM stdin;
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders (order_id, user_id, order_status, order_date, order_time, product_id, product_name, delivery_address, order_price, order_delivery_price) FROM stdin;
\.


--
-- Data for Name: productreviews; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.productreviews (review_id, user_id, product_id, review_text, review_rating, review_date) FROM stdin;
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products (product_id, product_name, product_model, product_description, product_price, category_name, category_id) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (user_id, user_name, user_email, user_password, user_mobile_number) FROM stdin;
2	Елена	elena456@example.com	qwerty456                                         	79234567890
3	Дмитрий	dmitriy789@example.com	abc123xyz                                         	79345678901
4	Анна	anna101112@example.com	password789                                       	79456789012
5	Сергей	sergey131415@example.com	securepwd321                                      	79567890123
6	Мария	maria161718@example.com	myp@ss789                                         	79678901234
7	Александр	alex192021@example.com	pass123word                                       	79789012345
8	Ольга	olga222324@example.com	mysecret123                                       	79890123456
9	Артем	artem252627@example.com	securepassword456                                 	79901234567
10	Екатерина	ekaterina282930@example.com	letmein789                                        	70012345678
11	Павел	pavel313233@example.com	qwertyuiop123                                     	70123456789
12	Алиса	alisa343536@example.com	password123456                                    	70234567890
13	Николай	nikolay373839@example.com	mypassword123                                     	70345678901
14	Ирина	irina404142@example.com	secure123pwd                                      	70456789012
15	Владимир	vladimir434445@example.com	pass789word                                       	70567890123
16	Евгения	evgenia464748@example.com	letmein123                                        	70678901234
17	Григорий	grigoriy495051@example.com	qwerty123456                                      	70789012345
18	Татьяна	tatyana525354@example.com	password789123                                    	70890123456
19	Максим	maxim555657@example.com	myp@ss123                                         	70901234567
20	Елена	elena585960@example.com	securepwd789                                      	71012345678
21	Андрей	andrey616263@example.com	letmein456                                        	71123456789
22	Анастасия	anastasiya646566@example.com	qwerty789                                         	71234567890
23	Дарья	darya676869@example.com	mypassword456                                     	71345678901
24	Сергей	sergey707172@example.com	secure789pwd                                      	71456789012
25	Ольга	olga737475@example.com	password123789                                    	71567890123
26	Иван	ivan767778@example.com	letmein789123                                     	71678901234
27	Наталья	natalya798081@example.com	qwerty456789                                      	71789012345
28	Алексей	alexey828384@example.com	myp@ss456                                         	71890123456
29	Екатерина	ekaterina858687@example.com	secure789pwd                                      	71901234567
30	Денис	denis1234@example.com	passw0rd123                                       	79123456780
31	Евгений	evgeniy5678@example.com	abc123def456                                      	79234567801
32	Олеся	olesya91011@example.com	qwerty7890                                        	79345678012
33	Александра	aleksandra121314@example.com	password123abc                                    	79456780123
34	Михаил	mikhail151617@example.com	securepass123                                     	79567801234
35	Елена	elena181920@example.com	myp@ssword789                                     	79678012345
36	Ирина	irina212223@example.com	letmein123456                                     	79789012356
37	Андрей	andrey242526@example.com	qwerty123abc                                      	79890123567
38	Ксения	kseniya272829@example.com	mypassword123abc                                  	79901235678
39	Виктор	viktor303132@example.com	secure789password                                 	70012356789
40	Наталья	natalya333435@example.com	letmein789abc                                     	70123467890
41	Павел	pavel363738@example.com	qwerty456abc                                      	70234578901
42	Анастасия	anastasiya394041@example.com	myp@ssword789abc                                  	70345689012
43	Георгий	georgiy424344@example.com	securepass123abc                                  	70456790123
44	Елена	elena454647@example.com	letmein123456abc                                  	70567801234
45	Валентина	valentina484950@example.com	qwerty123abc456                                   	70678012345
46	Сергей	sergey515253@example.com	mypassword789abc                                  	70789023456
47	Алиса	alisa545556@example.com	securepassword123abc                              	70890134567
48	Алексей	alexey575859@example.com	letmein789abc123                                  	70901245678
49	Мария	maria606162@example.com	qwerty123abc456                                   	71012356789
50	Дмитрий	dmitriy636465@example.com	myp@ssword789abc                                  	71123467890
51	Елена	elena666768@example.com	securepass123abc                                  	71234578901
52	Анна	anna697071@example.com	letmein123456abc                                  	71345689012
53	Иван	ivan727374@example.com	qwerty123abc456                                   	71456790123
54	Ольга	olga757677@example.com	mypassword789abc                                  	71567801234
55	Владимир	vladimir787980@example.com	securepassword123abc                              	71678012345
56	Татьяна	tatyana818283@example.com	letmein789abc123                                  	71789023456
57	София	sofia848586@example.com	qwerty123abc456                                   	71890134567
58	Никита	nikita878889@example.com	mypassword789abc                                  	71901245678
59	Артемий	artemiy901234@example.com	passw0rdabc123                                    	79123456701
60	Дарина	darina567890@example.com	abc123def456ghi                                   	79234567012
61	Василиса	vasilisa9101112@example.com	qwerty7890jkl                                     	79345670123
62	Роман	roman12131415@example.com	password123abcxyz                                 	79456701234
63	Елена	elena16171819@example.com	securepass123xyz                                  	79567012345
64	Игорь	igor20212223@example.com	myp@ssword789xyz                                  	79670123456
65	Анна	anna24252627@example.com	letmein123456xyz                                  	79701234567
66	Полина	polina28293031@example.com	qwerty123abcxyz                                   	79812345678
67	Дмитрий	dmitriy32333435@example.com	myp@ssword789abcxyz                               	79923456789
68	Маргарита	margarita36373839@example.com	securepass123abcxyz                               	70034567890
69	Андрей	andrey40414243@example.com	letmein123456abcxyz                               	70145678901
70	Евгения	evgeniya44454647@example.com	qwerty123abcxyz                                   	70256789012
71	Артем	artem48495051@example.com	myp@ssword789abcxyz                               	70367890123
72	Ольга	olga52535455@example.com	securepass123abcxyz                               	70478901234
73	Максим	maxim56575859@example.com	letmein123456abcxyz                               	70590123456
74	Алина	alina60616263@example.com	qwerty123abcxyz                                   	70601234567
75	Анастасия	anastasiya64656667@example.com	myp@ssword789abcxyz                               	70712345678
76	Иван	ivan68697071@example.com	securepass123abcxyz                               	70823456789
77	Наталья	natalya72737475@example.com	letmein123456abcxyz                               	70934567890
78	Сергей	sergey76777879@example.com	qwerty123abcxyz                                   	71045678901
79	Екатерина	ekaterina80818283@example.com	myp@ssword789abcxyz                               	71156789012
80	Владимир	vladimir84858687@example.com	securepass123abcxyz                               	71267890123
81	Елизавета	elizaveta88899091@example.com	letmein123456abcxyz                               	71378901234
82	Александр	alexandr92939495@example.com	qwerty123abcxyz                                   	71490123456
83	Антон	anton96979899@example.com	myp@ssword789abcxyz                               	71501234567
84	Татьяна	tatyana00010203@example.com	securepass123abcxyz                               	71612345678
85	Олег	oleg04050607@example.com	letmein123456abcxyz                               	71723456789
86	Дарья	darya08091011@example.com	qwerty123abcxyz                                   	71834567890
87	Ирина	irina12131415@example.com	myp@ssword789abcxyz                               	71945678901
88	Павел	pavel16171819@example.com	securepass123abcxyz                               	72056789012
89	Мария	maria20212223@example.com	letmein123456abcxyz                               	72167890123
90	Илья	ilya24252627@example.com	qwerty123abcxyz                                   	72278901234
91	Евгений	evgeniy28293031@example.com	myp@ssword789abcxyz                               	72390123456
92	Кристина	kristina32333435@example.com	securepass123abcxyz                               	72401234567
93	Валентин	valentin36373839@example.com	letmein123456abcxyz                               	72512345678
94	Елизавета	elizaveta40414243@example.com	qwerty123abcxyz                                   	72623456789
95	София	sofia44454647@example.com	myp@ssword789abcxyz                               	72734567890
96	Глеб	gleb48495051@example.com	securepass123abcxyz                               	72845678901
97	Марина	marina52535455@example.com	letmein123456abcxyz                               	72956789012
98	Никита	nikita56575859@example.com	qwerty123abcxyz                                   	73067890123
99	Александра	aleksandra60616263@example.com	myp@ssword789abcxyz                               	73178901234
100	Алексей	alexey64656667@example.com	securepass123abcxyz                               	73290123456
\.


--
-- Name: categories_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categories_category_id_seq', 1, false);


--
-- Name: orders_order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orders_order_id_seq', 1, false);


--
-- Name: productreviews_review_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.productreviews_review_id_seq', 1, false);


--
-- Name: products_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.products_product_id_seq', 1, false);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_user_id_seq', 1, false);


--
-- Name: categories categories_category_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_category_name_key UNIQUE (category_name);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (category_id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (order_id);


--
-- Name: productreviews productreviews_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productreviews
    ADD CONSTRAINT productreviews_pkey PRIMARY KEY (review_id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (product_id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: users users_user_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_user_email_key UNIQUE (user_email);


--
-- Name: users users_user_mobile_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_user_mobile_number_key UNIQUE (user_mobile_number);


--
-- Name: orders orders_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(product_id);


--
-- Name: orders orders_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: productreviews productreviews_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productreviews
    ADD CONSTRAINT productreviews_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(product_id);


--
-- Name: productreviews productreviews_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productreviews
    ADD CONSTRAINT productreviews_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: products products_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(category_id);


--
-- Name: products products_category_name_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_category_name_fkey FOREIGN KEY (category_name) REFERENCES public.categories(category_name);


--
-- PostgreSQL database dump complete
--

