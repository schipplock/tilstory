CREATE SEQUENCE public.post_seq
    INCREMENT BY 1
    MINVALUE 1
    START 1
    CACHE 1
    NO CYCLE;

CREATE SEQUENCE public.file_seq
    INCREMENT BY 1
    MINVALUE 1
    START 1
    CACHE 1
    NO CYCLE;

CREATE TABLE public.users (
    user_name varchar(15) not null primary key,
    user_pass varchar(255) not null
);

CREATE TABLE user_roles (
    user_name varchar(15) not null,
    role_name varchar(15) not null,
    primary key (user_name, role_name)
);

CREATE TABLE public.posts (
    id bigint NOT NULL DEFAULT nextval('post_seq'),
    guid uuid NOT NULL,
    subject varchar(255) NOT NULL,
    body text NOT NULL,
    draft boolean default true,
    created timestamptz default now(),
    updated timestamptz,
    CONSTRAINT posts_pk PRIMARY KEY (id)
);

CREATE TABLE public.files (
    id bigint NOT NULL DEFAULT nextval('file_seq'),
    post_id bigint NOT NULL,
    filename text NOT NULL,
    CONSTRAINT files_un UNIQUE (filename,post_id),
    CONSTRAINT files_fk FOREIGN KEY (post_id) REFERENCES public.posts(id)
);

CREATE TABLE public.settings (
    key varchar(255) NOT NULL,
    value text,
    CONSTRAINT settings_pk PRIMARY KEY (key)
);

INSERT INTO public.users (user_name, user_pass) VALUES
('admin', '10c1a3be7b993eee6463dd03e83987f5c160af6552107bc53623426f3eb07e128b3cdd4865df74c506338e9fbd2de141857cc72b2cabb4eb315b3fb3d7d35af1');

INSERT INTO public.user_roles (user_name, role_name) VALUES
('admin', 'admin');

INSERT INTO public.settings (key, value) VALUES
('application.baseurl', 'https://localhost'),
('application.name', 'TILStory'),
('post.author', 'John Doe'),
('imprint', ''),
('privacy.policy', ''),
('phone', ''),
('email', '');
