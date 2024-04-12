-- Adminer 4.8.1 PostgreSQL 15.1 (Debian 15.1-1.pgdg110+1) dump
-- CREATE DATABASE "cpsi";

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

DROP TABLE IF EXISTS "user";
CREATE TABLE "user" (
  "id" bigserial PRIMARY KEY,
  "email" character varying(200) NOT NULL UNIQUE,
  "password" character varying(200) NOT NULL,
  "is_admin" boolean DEFAULT 'f',
  "is_active" boolean DEFAULT 'f',
  "updated_at" timestamp DEFAULT NULL,
  "created_at" timestamp DEFAULT now() NOT NULL
);
COMMENT ON COLUMN "user"."email" IS '注册邮箱';
COMMENT ON COLUMN "user"."password" IS '密码';
COMMENT ON COLUMN "user"."is_admin" IS '是否管理员';
COMMENT ON COLUMN "user"."is_active" IS '是否激活';
COMMENT ON COLUMN "user"."updated_at" IS '更新时间';
COMMENT ON COLUMN "user"."created_at" IS '创建时间';


INSERT INTO "user" ("id", "email", "password", "updated_at", "created_at") VALUES
(1,	'minamoto@sina.com',	'$2b$12$wAIHpC0dcqKiQWxEjGW5weYIiTAb65TrKddOCY2SHqJbG4Rw6Wv.6',	'2023-03-31 02:36:27.230657',	'2023-03-31 02:36:27.01714'),
(2,	'jiangtai20@mails.ucas.ac.cn',	'$2b$12$CYlLkJsDOMSGY49P5FcABu3z7o/7S9VisX3Rz347hQv8snqZ29B3K',	'2023-03-31 02:44:38.399912',	'2023-03-31 02:44:38.208925');