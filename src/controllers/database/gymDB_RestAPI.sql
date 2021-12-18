--
-- PostgreSQL database dump
--

-- Dumped from database version 13.4
-- Dumped by pg_dump version 13.3

-- Started on 2021-12-18 09:13:38 UTC

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

--
-- TOC entry 234 (class 1255 OID 22138)
-- Name: create_guestmember(character varying, character varying, timestamp without time zone, timestamp without time zone); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.create_guestmember(character varying, character varying, timestamp without time zone, timestamp without time zone)
    LANGUAGE plpgsql
    AS $_$

BEGIN
INSERT INTO guest_member (name, surname, login, logout) VALUES ($1, $2, $3, $4 );
COMMIT;

END;
$_$;


ALTER PROCEDURE public.create_guestmember(character varying, character varying, timestamp without time zone, timestamp without time zone) OWNER TO postgres;

--
-- TOC entry 233 (class 1255 OID 22134)
-- Name: create_member(character varying, character varying, integer, integer, character varying, character varying, character varying, integer); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.create_member(character varying, character varying, integer, integer, character varying, character varying, character varying, integer)
    LANGUAGE plpgsql
    AS $_$

BEGIN
INSERT INTO members (name, surname, height, weight, sex, tel, adress, membership_id) VALUES ($1, $2, $3, $4, $5, $6, $7, $8 );
COMMIT;

END;
$_$;


ALTER PROCEDURE public.create_member(character varying, character varying, integer, integer, character varying, character varying, character varying, integer) OWNER TO postgres;

--
-- TOC entry 235 (class 1255 OID 22139)
-- Name: create_product(integer, money, character varying, timestamp without time zone); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.create_product(integer, money, character varying, timestamp without time zone)
    LANGUAGE plpgsql
    AS $_$

BEGIN
INSERT INTO products ( weight, price, name, last_use_date ) VALUES ( $1, $2, $3, $4 );
COMMIT;

END;
$_$;


ALTER PROCEDURE public.create_product(integer, money, character varying, timestamp without time zone) OWNER TO postgres;

--
-- TOC entry 236 (class 1255 OID 22140)
-- Name: create_product(character varying, integer, money, timestamp without time zone, integer, integer); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.create_product(character varying, integer, money, timestamp without time zone, integer, integer)
    LANGUAGE plpgsql
    AS $_$

BEGIN
INSERT INTO product_series ( name, quantity, price, last_use_date, barcode,  seller ) VALUES ( $1, $2, $3, $4, $5, $6 );
COMMIT;

END;
$_$;


ALTER PROCEDURE public.create_product(character varying, integer, money, timestamp without time zone, integer, integer) OWNER TO postgres;

--
-- TOC entry 230 (class 1255 OID 22120)
-- Name: totalmember(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.totalmember() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
	update totals_member set total = total + 1;
return new;
end;
$$;


ALTER FUNCTION public.totalmember() OWNER TO postgres;

--
-- TOC entry 231 (class 1255 OID 22123)
-- Name: totalmemberdelete(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.totalmemberdelete() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
	update totals_member set total = total - 1;
return new;
end;
$$;


ALTER FUNCTION public.totalmemberdelete() OWNER TO postgres;

--
-- TOC entry 232 (class 1255 OID 22130)
-- Name: totalmemberguest(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.totalmemberguest() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
	update totals_guestmember set total = total + 1;
return new;
end;
$$;


ALTER FUNCTION public.totalmemberguest() OWNER TO postgres;

--
-- TOC entry 229 (class 1255 OID 22115)
-- Name: totalsalaries(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.totalsalaries() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare
total_salary money;
begin 
total_salary:=(select sum(salary) from employees);
update totals_salary set total = total_salary;
return new;
end;
$$;


ALTER FUNCTION public.totalsalaries() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 201 (class 1259 OID 19804)
-- Name: employees; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employees (
    emp_id integer NOT NULL,
    name character varying(40) NOT NULL,
    surname character varying(40) NOT NULL,
    salary money NOT NULL
);


ALTER TABLE public.employees OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 19802)
-- Name: employees_emp_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.employees_emp_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.employees_emp_id_seq OWNER TO postgres;

--
-- TOC entry 3805 (class 0 OID 0)
-- Dependencies: 200
-- Name: employees_emp_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.employees_emp_id_seq OWNED BY public.employees.emp_id;


--
-- TOC entry 203 (class 1259 OID 19812)
-- Name: guest_member; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.guest_member (
    guest_id integer NOT NULL,
    name character varying(40) NOT NULL,
    surname character varying(40) NOT NULL,
    login timestamp without time zone NOT NULL,
    logout timestamp without time zone NOT NULL
);


ALTER TABLE public.guest_member OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 19810)
-- Name: guest_member_guest_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.guest_member_guest_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.guest_member_guest_id_seq OWNER TO postgres;

--
-- TOC entry 3806 (class 0 OID 0)
-- Dependencies: 202
-- Name: guest_member_guest_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.guest_member_guest_id_seq OWNED BY public.guest_member.guest_id;


--
-- TOC entry 205 (class 1259 OID 19820)
-- Name: members; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.members (
    member_id integer NOT NULL,
    name character varying(40) NOT NULL,
    surname character varying(40) NOT NULL,
    height integer NOT NULL,
    weight integer NOT NULL,
    sex character varying(20) NOT NULL,
    tel character varying(15) NOT NULL,
    adress character varying(150) NOT NULL,
    membership_id integer NOT NULL
);


ALTER TABLE public.members OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 19818)
-- Name: members_member_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.members_member_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.members_member_id_seq OWNER TO postgres;

--
-- TOC entry 3807 (class 0 OID 0)
-- Dependencies: 204
-- Name: members_member_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.members_member_id_seq OWNED BY public.members.member_id;


--
-- TOC entry 207 (class 1259 OID 19828)
-- Name: membership; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.membership (
    ship_id integer NOT NULL,
    category character varying(40) NOT NULL,
    price money NOT NULL
);


ALTER TABLE public.membership OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 19834)
-- Name: membership_packets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.membership_packets (
    ship_id integer NOT NULL,
    packet_id integer NOT NULL
);


ALTER TABLE public.membership_packets OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 19826)
-- Name: membership_ship_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.membership_ship_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.membership_ship_id_seq OWNER TO postgres;

--
-- TOC entry 3808 (class 0 OID 0)
-- Dependencies: 206
-- Name: membership_ship_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.membership_ship_id_seq OWNED BY public.membership.ship_id;


--
-- TOC entry 209 (class 1259 OID 19839)
-- Name: membership_sport_category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.membership_sport_category (
    ship_id integer NOT NULL,
    sport_id integer NOT NULL
);


ALTER TABLE public.membership_sport_category OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 19844)
-- Name: packets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.packets (
    packet_id integer NOT NULL,
    name character varying(40) NOT NULL
);


ALTER TABLE public.packets OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 19851)
-- Name: product_series; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_series (
    series_id integer NOT NULL,
    name character varying NOT NULL,
    quantity integer NOT NULL,
    price money NOT NULL,
    "lastUseDate" timestamp without time zone NOT NULL,
    seller integer NOT NULL
);


ALTER TABLE public.product_series OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 19849)
-- Name: product_series_series_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.product_series_series_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.product_series_series_id_seq OWNER TO postgres;

--
-- TOC entry 3809 (class 0 OID 0)
-- Dependencies: 211
-- Name: product_series_series_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.product_series_series_id_seq OWNED BY public.product_series.series_id;


--
-- TOC entry 213 (class 1259 OID 19860)
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    barcode integer NOT NULL,
    weight integer NOT NULL,
    price money NOT NULL,
    name character varying(40) NOT NULL,
    last_use_date timestamp without time zone NOT NULL,
    series_id integer
);


ALTER TABLE public.products OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 19867)
-- Name: sales; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sales (
    member_id integer NOT NULL,
    barcode integer NOT NULL,
    date timestamp without time zone NOT NULL
);


ALTER TABLE public.sales OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 19865)
-- Name: sales_member_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sales_member_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sales_member_id_seq OWNER TO postgres;

--
-- TOC entry 3810 (class 0 OID 0)
-- Dependencies: 214
-- Name: sales_member_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sales_member_id_seq OWNED BY public.sales.member_id;


--
-- TOC entry 217 (class 1259 OID 19875)
-- Name: seller; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.seller (
    seller_id integer NOT NULL,
    name character varying(40) NOT NULL,
    adress character varying(40) NOT NULL
);


ALTER TABLE public.seller OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 19873)
-- Name: seller_seller_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seller_seller_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seller_seller_id_seq OWNER TO postgres;

--
-- TOC entry 3811 (class 0 OID 0)
-- Dependencies: 216
-- Name: seller_seller_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.seller_seller_id_seq OWNED BY public.seller.seller_id;


--
-- TOC entry 219 (class 1259 OID 19883)
-- Name: servants; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.servants (
    emp_id integer NOT NULL,
    name character varying(40) NOT NULL,
    surname character varying(40) NOT NULL,
    salary money NOT NULL
);


ALTER TABLE public.servants OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 19881)
-- Name: servant_emp_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.servant_emp_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.servant_emp_id_seq OWNER TO postgres;

--
-- TOC entry 3812 (class 0 OID 0)
-- Dependencies: 218
-- Name: servant_emp_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.servant_emp_id_seq OWNED BY public.servants.emp_id;


--
-- TOC entry 221 (class 1259 OID 19891)
-- Name: sport_category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sport_category (
    sport_id integer NOT NULL,
    "Category" character varying(40) NOT NULL
);


ALTER TABLE public.sport_category OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 19889)
-- Name: sport_category_sport_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sport_category_sport_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sport_category_sport_id_seq OWNER TO postgres;

--
-- TOC entry 3813 (class 0 OID 0)
-- Dependencies: 220
-- Name: sport_category_sport_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sport_category_sport_id_seq OWNED BY public.sport_category.sport_id;


--
-- TOC entry 228 (class 1259 OID 22126)
-- Name: totals_guestmember; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.totals_guestmember (
    total integer
);


ALTER TABLE public.totals_guestmember OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 22117)
-- Name: totals_member; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.totals_member (
    total integer
);


ALTER TABLE public.totals_member OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 22100)
-- Name: totals_salary; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.totals_salary (
    total money
);


ALTER TABLE public.totals_salary OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 20030)
-- Name: trainers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.trainers (
    emp_id integer,
    name character varying(40),
    surname character varying(40),
    salary money
)
INHERITS (public.employees);


ALTER TABLE public.trainers OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 20028)
-- Name: trainers_emp_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.trainers_emp_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.trainers_emp_id_seq OWNER TO postgres;

--
-- TOC entry 3814 (class 0 OID 0)
-- Dependencies: 224
-- Name: trainers_emp_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.trainers_emp_id_seq OWNED BY public.trainers.emp_id;


--
-- TOC entry 222 (class 1259 OID 19905)
-- Name: trainers_members; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.trainers_members (
    member_id integer NOT NULL,
    emp_id integer NOT NULL
);


ALTER TABLE public.trainers_members OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 19910)
-- Name: trainers_sport_category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.trainers_sport_category (
    emp_id integer NOT NULL,
    sport_id integer NOT NULL
);


ALTER TABLE public.trainers_sport_category OWNER TO postgres;

--
-- TOC entry 3577 (class 2604 OID 19807)
-- Name: employees emp_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees ALTER COLUMN emp_id SET DEFAULT nextval('public.employees_emp_id_seq'::regclass);


--
-- TOC entry 3578 (class 2604 OID 19815)
-- Name: guest_member guest_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.guest_member ALTER COLUMN guest_id SET DEFAULT nextval('public.guest_member_guest_id_seq'::regclass);


--
-- TOC entry 3579 (class 2604 OID 19823)
-- Name: members member_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.members ALTER COLUMN member_id SET DEFAULT nextval('public.members_member_id_seq'::regclass);


--
-- TOC entry 3580 (class 2604 OID 19831)
-- Name: membership ship_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.membership ALTER COLUMN ship_id SET DEFAULT nextval('public.membership_ship_id_seq'::regclass);


--
-- TOC entry 3581 (class 2604 OID 19854)
-- Name: product_series series_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_series ALTER COLUMN series_id SET DEFAULT nextval('public.product_series_series_id_seq'::regclass);


--
-- TOC entry 3582 (class 2604 OID 19870)
-- Name: sales member_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales ALTER COLUMN member_id SET DEFAULT nextval('public.sales_member_id_seq'::regclass);


--
-- TOC entry 3583 (class 2604 OID 19878)
-- Name: seller seller_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.seller ALTER COLUMN seller_id SET DEFAULT nextval('public.seller_seller_id_seq'::regclass);


--
-- TOC entry 3584 (class 2604 OID 19886)
-- Name: servants emp_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.servants ALTER COLUMN emp_id SET DEFAULT nextval('public.servant_emp_id_seq'::regclass);


--
-- TOC entry 3585 (class 2604 OID 19894)
-- Name: sport_category sport_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sport_category ALTER COLUMN sport_id SET DEFAULT nextval('public.sport_category_sport_id_seq'::regclass);


--
-- TOC entry 3586 (class 2604 OID 20033)
-- Name: trainers emp_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trainers ALTER COLUMN emp_id SET DEFAULT nextval('public.trainers_emp_id_seq'::regclass);


--
-- TOC entry 3772 (class 0 OID 19804)
-- Dependencies: 201
-- Data for Name: employees; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.employees (emp_id, name, surname, salary) VALUES (1, 'samet', 'samet', '$50.00');
INSERT INTO public.employees (emp_id, name, surname, salary) VALUES (2, 'samet2', 'samet', '$50.00');
INSERT INTO public.employees (emp_id, name, surname, salary) VALUES (3, 'samet3', 'samet', '$50.00');
INSERT INTO public.employees (emp_id, name, surname, salary) VALUES (4, 'samet4', 'samet', '$50.00');
INSERT INTO public.employees (emp_id, name, surname, salary) VALUES (5, 'samet5', 'samet', '$50.00');
INSERT INTO public.employees (emp_id, name, surname, salary) VALUES (6, 'samet6', 'samet', '$50.00');


--
-- TOC entry 3774 (class 0 OID 19812)
-- Dependencies: 203
-- Data for Name: guest_member; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.guest_member (guest_id, name, surname, login, logout) VALUES (1, 'samet', 'karakurt', '2004-10-19 10:23:54', '2004-10-19 10:24:54');
INSERT INTO public.guest_member (guest_id, name, surname, login, logout) VALUES (2, 'ariffff', 'karakkırt', '2021-01-01 00:00:00', '2021-01-01 00:00:00');


--
-- TOC entry 3776 (class 0 OID 19820)
-- Dependencies: 205
-- Data for Name: members; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.members (member_id, name, surname, height, weight, sex, tel, adress, membership_id) VALUES (10, 'ariffff', 'karakkırt', 85, 193, 'male', '5055555555', 'asdasdasdasdasd', 1);
INSERT INTO public.members (member_id, name, surname, height, weight, sex, tel, adress, membership_id) VALUES (9, 'ariffff', 'karakkırt', 85, 193, 'male', '5055555555', 'asdasdasdasdasd', 1);


--
-- TOC entry 3778 (class 0 OID 19828)
-- Dependencies: 207
-- Data for Name: membership; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.membership (ship_id, category, price) VALUES (1, 'bronz', '$50.00');
INSERT INTO public.membership (ship_id, category, price) VALUES (2, 'silver', '$70.00');
INSERT INTO public.membership (ship_id, category, price) VALUES (3, 'gold', '$100.00');
INSERT INTO public.membership (ship_id, category, price) VALUES (4, 'premium', '$150.00');


--
-- TOC entry 3779 (class 0 OID 19834)
-- Dependencies: 208
-- Data for Name: membership_packets; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3780 (class 0 OID 19839)
-- Dependencies: 209
-- Data for Name: membership_sport_category; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3781 (class 0 OID 19844)
-- Dependencies: 210
-- Data for Name: packets; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.packets (packet_id, name) VALUES (1, 'sauna');
INSERT INTO public.packets (packet_id, name) VALUES (2, 'Turkish Bath');
INSERT INTO public.packets (packet_id, name) VALUES (3, 'Finnish Bath');
INSERT INTO public.packets (packet_id, name) VALUES (4, 'pool');


--
-- TOC entry 3783 (class 0 OID 19851)
-- Dependencies: 212
-- Data for Name: product_series; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3784 (class 0 OID 19860)
-- Dependencies: 213
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.products (barcode, weight, price, name, last_use_date, series_id) VALUES (1, 800, '$80.00', 'protein powder', '2022-10-12 21:22:23', NULL);
INSERT INTO public.products (barcode, weight, price, name, last_use_date, series_id) VALUES (2, 300, '$30.00', 'creatin', '2022-10-12 21:22:23', NULL);
INSERT INTO public.products (barcode, weight, price, name, last_use_date, series_id) VALUES (3, 200, '$15.00', 'L-carnitine', '2022-10-12 21:22:23', NULL);
INSERT INTO public.products (barcode, weight, price, name, last_use_date, series_id) VALUES (4, 50, '$5.00', 'BCAA', '2022-10-12 21:22:23', NULL);


--
-- TOC entry 3786 (class 0 OID 19867)
-- Dependencies: 215
-- Data for Name: sales; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3788 (class 0 OID 19875)
-- Dependencies: 217
-- Data for Name: seller; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3790 (class 0 OID 19883)
-- Dependencies: 219
-- Data for Name: servants; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3792 (class 0 OID 19891)
-- Dependencies: 221
-- Data for Name: sport_category; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3799 (class 0 OID 22126)
-- Dependencies: 228
-- Data for Name: totals_guestmember; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3798 (class 0 OID 22117)
-- Dependencies: 227
-- Data for Name: totals_member; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.totals_member (total) VALUES (11);


--
-- TOC entry 3797 (class 0 OID 22100)
-- Dependencies: 226
-- Data for Name: totals_salary; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.totals_salary (total) VALUES ('$300.00');


--
-- TOC entry 3796 (class 0 OID 20030)
-- Dependencies: 225
-- Data for Name: trainers; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.trainers (emp_id, name, surname, salary) VALUES (1, 'samet
', 'samet', '$50.00');


--
-- TOC entry 3793 (class 0 OID 19905)
-- Dependencies: 222
-- Data for Name: trainers_members; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3794 (class 0 OID 19910)
-- Dependencies: 223
-- Data for Name: trainers_sport_category; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3815 (class 0 OID 0)
-- Dependencies: 200
-- Name: employees_emp_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.employees_emp_id_seq', 7, true);


--
-- TOC entry 3816 (class 0 OID 0)
-- Dependencies: 202
-- Name: guest_member_guest_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.guest_member_guest_id_seq', 2, true);


--
-- TOC entry 3817 (class 0 OID 0)
-- Dependencies: 204
-- Name: members_member_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.members_member_id_seq', 10, true);


--
-- TOC entry 3818 (class 0 OID 0)
-- Dependencies: 206
-- Name: membership_ship_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.membership_ship_id_seq', 5, true);


--
-- TOC entry 3819 (class 0 OID 0)
-- Dependencies: 211
-- Name: product_series_series_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.product_series_series_id_seq', 1, false);


--
-- TOC entry 3820 (class 0 OID 0)
-- Dependencies: 214
-- Name: sales_member_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sales_member_id_seq', 1, false);


--
-- TOC entry 3821 (class 0 OID 0)
-- Dependencies: 216
-- Name: seller_seller_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seller_seller_id_seq', 1, false);


--
-- TOC entry 3822 (class 0 OID 0)
-- Dependencies: 218
-- Name: servant_emp_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.servant_emp_id_seq', 1, false);


--
-- TOC entry 3823 (class 0 OID 0)
-- Dependencies: 220
-- Name: sport_category_sport_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sport_category_sport_id_seq', 1, false);


--
-- TOC entry 3824 (class 0 OID 0)
-- Dependencies: 224
-- Name: trainers_emp_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.trainers_emp_id_seq', 1, false);


--
-- TOC entry 3588 (class 2606 OID 19809)
-- Name: employees employees_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (emp_id);


--
-- TOC entry 3590 (class 2606 OID 19817)
-- Name: guest_member guest_member_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.guest_member
    ADD CONSTRAINT guest_member_pkey PRIMARY KEY (guest_id);


--
-- TOC entry 3592 (class 2606 OID 19825)
-- Name: members members_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.members
    ADD CONSTRAINT members_pkey PRIMARY KEY (member_id);


--
-- TOC entry 3596 (class 2606 OID 19838)
-- Name: membership_packets membership_packets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.membership_packets
    ADD CONSTRAINT membership_packets_pkey PRIMARY KEY (packet_id, ship_id);


--
-- TOC entry 3594 (class 2606 OID 19833)
-- Name: membership membership_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.membership
    ADD CONSTRAINT membership_pkey PRIMARY KEY (ship_id);


--
-- TOC entry 3598 (class 2606 OID 19843)
-- Name: membership_sport_category membership_sport_category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.membership_sport_category
    ADD CONSTRAINT membership_sport_category_pkey PRIMARY KEY (ship_id, sport_id);


--
-- TOC entry 3600 (class 2606 OID 19848)
-- Name: packets packets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.packets
    ADD CONSTRAINT packets_pkey PRIMARY KEY (packet_id);


--
-- TOC entry 3602 (class 2606 OID 19859)
-- Name: product_series product_series_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_series
    ADD CONSTRAINT product_series_pkey PRIMARY KEY (series_id);


--
-- TOC entry 3604 (class 2606 OID 19864)
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (barcode);


--
-- TOC entry 3606 (class 2606 OID 19872)
-- Name: sales sales_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales
    ADD CONSTRAINT sales_pkey PRIMARY KEY (member_id, barcode);


--
-- TOC entry 3608 (class 2606 OID 19880)
-- Name: seller seller_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.seller
    ADD CONSTRAINT seller_pkey PRIMARY KEY (seller_id);


--
-- TOC entry 3610 (class 2606 OID 19888)
-- Name: servants servant_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.servants
    ADD CONSTRAINT servant_pkey PRIMARY KEY (emp_id);


--
-- TOC entry 3612 (class 2606 OID 19896)
-- Name: sport_category sport_category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sport_category
    ADD CONSTRAINT sport_category_pkey PRIMARY KEY (sport_id);


--
-- TOC entry 3614 (class 2606 OID 19909)
-- Name: trainers_members trainers_members_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trainers_members
    ADD CONSTRAINT trainers_members_pkey PRIMARY KEY (member_id, emp_id);


--
-- TOC entry 3618 (class 2606 OID 20035)
-- Name: trainers trainers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trainers
    ADD CONSTRAINT trainers_pkey PRIMARY KEY (emp_id);


--
-- TOC entry 3616 (class 2606 OID 19914)
-- Name: trainers_sport_category trainers_sport_category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trainers_sport_category
    ADD CONSTRAINT trainers_sport_category_pkey PRIMARY KEY (sport_id, emp_id);


--
-- TOC entry 3639 (class 2620 OID 22122)
-- Name: members membertrigg; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER membertrigg AFTER INSERT ON public.members FOR EACH ROW EXECUTE FUNCTION public.totalmember();


--
-- TOC entry 3634 (class 2620 OID 22116)
-- Name: employees salarytrigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER salarytrigger AFTER INSERT ON public.employees FOR EACH ROW EXECUTE FUNCTION public.totalsalaries();


--
-- TOC entry 3635 (class 2620 OID 22125)
-- Name: employees salarytriggerdelete; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER salarytriggerdelete AFTER INSERT ON public.employees FOR EACH ROW EXECUTE FUNCTION public.totalmemberdelete();


--
-- TOC entry 3638 (class 2620 OID 22121)
-- Name: members totalmember; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER totalmember AFTER INSERT ON public.members FOR EACH ROW EXECUTE FUNCTION public.totalmember();


--
-- TOC entry 3640 (class 2620 OID 22124)
-- Name: members totalmemberdelete; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER totalmemberdelete AFTER DELETE ON public.members FOR EACH ROW EXECUTE FUNCTION public.totalmemberdelete();


--
-- TOC entry 3636 (class 2620 OID 22131)
-- Name: guest_member totalmemberguest; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER totalmemberguest AFTER DELETE ON public.guest_member FOR EACH ROW EXECUTE FUNCTION public.totalmemberguest();


--
-- TOC entry 3637 (class 2620 OID 22132)
-- Name: guest_member triggerguest; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER triggerguest AFTER INSERT ON public.guest_member FOR EACH ROW EXECUTE FUNCTION public.totalmemberguest();


--
-- TOC entry 3630 (class 2606 OID 20036)
-- Name: trainers_members emp_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trainers_members
    ADD CONSTRAINT emp_id FOREIGN KEY (emp_id) REFERENCES public.trainers(emp_id) NOT VALID;


--
-- TOC entry 3633 (class 2606 OID 20046)
-- Name: trainers emp_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trainers
    ADD CONSTRAINT emp_id FOREIGN KEY (emp_id) REFERENCES public.employees(emp_id) NOT VALID;


--
-- TOC entry 3619 (class 2606 OID 19915)
-- Name: members members_membership_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.members
    ADD CONSTRAINT members_membership_id_fkey FOREIGN KEY (membership_id) REFERENCES public.membership(ship_id) NOT VALID;


--
-- TOC entry 3620 (class 2606 OID 19920)
-- Name: membership_packets membership_packets_packet_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.membership_packets
    ADD CONSTRAINT membership_packets_packet_id_fkey FOREIGN KEY (packet_id) REFERENCES public.packets(packet_id) NOT VALID;


--
-- TOC entry 3621 (class 2606 OID 19925)
-- Name: membership_packets membership_packets_ship_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.membership_packets
    ADD CONSTRAINT membership_packets_ship_id_fkey FOREIGN KEY (ship_id) REFERENCES public.membership(ship_id) NOT VALID;


--
-- TOC entry 3622 (class 2606 OID 19930)
-- Name: membership_sport_category membership_sport_category_ship_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.membership_sport_category
    ADD CONSTRAINT membership_sport_category_ship_id_fkey FOREIGN KEY (ship_id) REFERENCES public.membership(ship_id) NOT VALID;


--
-- TOC entry 3623 (class 2606 OID 19935)
-- Name: membership_sport_category membership_sport_category_sport_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.membership_sport_category
    ADD CONSTRAINT membership_sport_category_sport_id_fkey FOREIGN KEY (sport_id) REFERENCES public.sport_category(sport_id) NOT VALID;


--
-- TOC entry 3624 (class 2606 OID 19945)
-- Name: product_series product_series_seller_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_series
    ADD CONSTRAINT product_series_seller_fkey FOREIGN KEY (seller) REFERENCES public.seller(seller_id) NOT VALID;


--
-- TOC entry 3626 (class 2606 OID 19950)
-- Name: sales sales_barcode_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales
    ADD CONSTRAINT sales_barcode_fkey FOREIGN KEY (barcode) REFERENCES public.products(barcode) NOT VALID;


--
-- TOC entry 3627 (class 2606 OID 19955)
-- Name: sales sales_member_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales
    ADD CONSTRAINT sales_member_id_fkey FOREIGN KEY (member_id) REFERENCES public.members(member_id) NOT VALID;


--
-- TOC entry 3625 (class 2606 OID 22567)
-- Name: products series_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT series_id FOREIGN KEY (series_id) REFERENCES public.product_series(series_id) NOT VALID;


--
-- TOC entry 3628 (class 2606 OID 19960)
-- Name: servants servant_emp_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.servants
    ADD CONSTRAINT servant_emp_id_fkey FOREIGN KEY (emp_id) REFERENCES public.employees(emp_id) NOT VALID;


--
-- TOC entry 3629 (class 2606 OID 19975)
-- Name: trainers_members trainers_members_member_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trainers_members
    ADD CONSTRAINT trainers_members_member_id_fkey FOREIGN KEY (member_id) REFERENCES public.members(member_id) NOT VALID;


--
-- TOC entry 3631 (class 2606 OID 19985)
-- Name: trainers_sport_category trainers_sport_category_sport_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trainers_sport_category
    ADD CONSTRAINT trainers_sport_category_sport_id_fkey FOREIGN KEY (sport_id) REFERENCES public.sport_category(sport_id) NOT VALID;


--
-- TOC entry 3632 (class 2606 OID 20052)
-- Name: trainers_sport_category trainers_sport_category_sport_id_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trainers_sport_category
    ADD CONSTRAINT trainers_sport_category_sport_id_fkey1 FOREIGN KEY (emp_id) REFERENCES public.trainers(emp_id) NOT VALID;


-- Completed on 2021-12-18 09:13:38 UTC

--
-- PostgreSQL database dump complete
--

