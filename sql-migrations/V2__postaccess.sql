CREATE SEQUENCE public.posthits_seq
    INCREMENT BY 1
    MINVALUE 1
    START 1
    CACHE 1
    NO CYCLE;

CREATE TABLE public.posthits (
    id bigint NOT NULL DEFAULT nextval('posthits_seq'),
    guid uuid NOT NULL,
    accessed timestamptz default now(),
    CONSTRAINT posthits_pk PRIMARY KEY (id)
);

CREATE INDEX posthits_guid_idx ON public.posthits (guid);