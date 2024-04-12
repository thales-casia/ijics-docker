-- Adminer 4.8.1 PostgreSQL 15.1 (Debian 15.1-1.pgdg110+1) dump
-- CREATE DATABASE "cpsi";

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;


DROP TABLE IF EXISTS "about";
CREATE TABLE "about" (
  "id" SERIAL PRIMARY KEY,
  "title" text NOT NULL,
  "content" text NOT NULL,
  "key" character varying(100) NOT NULL,
  "updated_at" timestamp DEFAULT now(),
  "created_at" timestamp DEFAULT now() NOT NULL
);
COMMENT ON TABLE "about" IS '常用数据';
COMMENT ON COLUMN "about"."title" IS '标题';
COMMENT ON COLUMN "about"."content" IS '内容';
COMMENT ON COLUMN "about"."key" IS '查询索引';
COMMENT ON COLUMN "about"."updated_at" IS '修改时间';
COMMENT ON COLUMN "about"."created_at" IS '创建时间';


DROP TABLE IF EXISTS "article";
CREATE TABLE "article" (
  "id" bigserial PRIMARY KEY,
  "doi" character varying(200),
  "title" text NOT NULL,
  "abstract" text NOT NULL,
  "graphic" text,
  "status" smallint DEFAULT 0,
  "pay_status" smallint DEFAULT 0,
  "early_access" boolean DEFAULT 'f',
  "html_link" character varying(200),
  "show_html" boolean DEFAULT 'f',
  "pdf_link" character varying(200),
  "pdf_edition" character varying(200),
  "pdf_size" integer DEFAULT 0,
  "read_count" integer DEFAULT 0,
  "citation_count" integer DEFAULT 0,
  "download_count" integer DEFAULT 0,
  "order_id" bigint,
  "updated_at" timestamp DEFAULT NULL,
  "created_at" timestamp DEFAULT now() NOT NULL
);
COMMENT ON TABLE "article" IS '文章';
alter sequence article_id_seq restart with 100;

DROP TABLE IF EXISTS "keyword";
CREATE TABLE "keyword" (
  "id" bigserial PRIMARY KEY,
  "name" character varying(200) NOT NULL UNIQUE,
  "updated_user_id" bigint,
  "created_user_id" bigint,
  "updated_at" timestamp DEFAULT NULL,
  "created_at" timestamp DEFAULT now() NOT NULL
);
COMMENT ON TABLE "keyword" IS '关键词';
COMMENT ON COLUMN "keyword"."name" IS '关键词';

DROP TABLE IF EXISTS "author";
CREATE TABLE "author" (
  "id" bigserial PRIMARY KEY,
  "orcid" character varying(200),
  "email" character varying(200) NOT NULL UNIQUE,
  "first_name" character varying(200) NOT NULL,
  "last_name" character varying(200) NOT NULL,
  "updated_user_id" bigint,
  "created_user_id" bigint,
  "updated_at" timestamp DEFAULT NULL,
  "created_at" timestamp DEFAULT now() NOT NULL
);
COMMENT ON TABLE "author" IS '作者';
COMMENT ON COLUMN "author"."email" IS '作者邮箱';
COMMENT ON COLUMN "author"."first_name" IS '作者名';
COMMENT ON COLUMN "author"."last_name" IS '作者姓';


DROP TABLE IF EXISTS "author_keyword";
CREATE TABLE "author_keyword" (
  "author_id" bigint DEFAULT '0' NOT NULL,
  "keyword_id" bigint DEFAULT '0' NOT NULL,
  "sequence" smallint DEFAULT '0',
  CONSTRAINT "author_keyword_pkey" PRIMARY KEY ("author_id", "keyword_id")
) WITH (oids = false);
COMMENT ON TABLE "author_keyword" IS '作者领域';
COMMENT ON COLUMN "author_keyword"."author_id" IS '作者id';
COMMENT ON COLUMN "author_keyword"."keyword_id" IS '关键词id';
COMMENT ON COLUMN "author_keyword"."sequence" IS '关键词顺序';

ALTER TABLE ONLY "author_keyword" ADD CONSTRAINT "author_keyword_author_id_fkey" FOREIGN KEY (author_id) REFERENCES author(id) ON UPDATE CASCADE ON DELETE CASCADE NOT DEFERRABLE;
ALTER TABLE ONLY "author_keyword" ADD CONSTRAINT "author_keyword_keyword_id_fkey" FOREIGN KEY (keyword_id) REFERENCES keyword(id) ON UPDATE CASCADE ON DELETE CASCADE NOT DEFERRABLE;





DROP TABLE IF EXISTS "institution";
CREATE TABLE "institution" (
  "id" bigserial PRIMARY KEY,
  "institution" character varying(200) DEFAULT '' NOT NULL,
  "department" character varying(200),
  "address" character varying(200),
  "country" character varying(200),
  "province" character varying(200),
  "city" character varying(200),
  "postal_code" character varying(50),
  "phone" character varying(50),
  "fax" character varying(50),
  "updated_at" timestamp DEFAULT NULL,
  "created_at" timestamp DEFAULT now() NOT NULL
);
COMMENT ON TABLE "institution" IS '用户地址';
COMMENT ON COLUMN "institution".institution IS '机构';
COMMENT ON COLUMN "institution".department IS '部门';
COMMENT ON COLUMN "institution".address IS '地址';
COMMENT ON COLUMN "institution".country IS '国家';
COMMENT ON COLUMN "institution".province IS '省份';
COMMENT ON COLUMN "institution".city IS '城市';
COMMENT ON COLUMN "institution".postal_code IS '邮编';
COMMENT ON COLUMN "institution".phone IS '电话';
COMMENT ON COLUMN "institution".fax IS '传真';

DROP TABLE IF EXISTS "author_institution";
CREATE TABLE "author_institution" (
  "author_id" bigint DEFAULT '0' NOT NULL,
  "institution_id" bigint DEFAULT '0' NOT NULL,
  "sequence" smallint DEFAULT '0',
  CONSTRAINT "author_institution_pkey" PRIMARY KEY ("author_id", "institution_id")
) WITH (oids = false);
COMMENT ON TABLE "author_institution" IS '作者的机构';
COMMENT ON COLUMN "author_institution"."institution_id" IS 'institution表id';
COMMENT ON COLUMN "author_institution"."author_id" IS 'author表id';
COMMENT ON COLUMN "author_institution"."sequence" IS '作者顺序';



DROP TABLE IF EXISTS "article_author";
CREATE TABLE "article_author" (
  "article_id" bigint DEFAULT '0' NOT NULL,
  "author_id" bigint DEFAULT '0' NOT NULL,
  "sequence" smallint DEFAULT '0',
  CONSTRAINT "article_author_pkey" PRIMARY KEY ("article_id", "author_id")
) WITH (oids = false);
COMMENT ON TABLE "article_author" IS '文章的作者';
COMMENT ON COLUMN "article_author"."article_id" IS 'article表id';
COMMENT ON COLUMN "article_author"."author_id" IS 'author表id';
COMMENT ON COLUMN "article_author"."sequence" IS '作者顺序，0为通讯作者';


ALTER TABLE ONLY "article_author" ADD CONSTRAINT "article_author_article_id_fkey" FOREIGN KEY (article_id) REFERENCES article(id) ON UPDATE CASCADE ON DELETE CASCADE NOT DEFERRABLE;
ALTER TABLE ONLY "article_author" ADD CONSTRAINT "article_author_author_id_fkey" FOREIGN KEY (author_id) REFERENCES author(id) ON UPDATE CASCADE ON DELETE CASCADE NOT DEFERRABLE;



DROP TABLE IF EXISTS "article_keyword";
CREATE TABLE "article_keyword" (
  "article_id" bigint DEFAULT '0' NOT NULL,
  "keyword_id" bigint DEFAULT '0' NOT NULL,
  "sequence" smallint DEFAULT '0',
  CONSTRAINT "article_keyword_pkey" PRIMARY KEY ("article_id", "keyword_id")
) WITH (oids = false);
COMMENT ON TABLE "article_keyword" IS '文章关键词';
COMMENT ON COLUMN "article_keyword"."article_id" IS '文章id';
COMMENT ON COLUMN "article_keyword"."keyword_id" IS '关键词id';
COMMENT ON COLUMN "article_keyword"."sequence" IS '关键词顺序';

ALTER TABLE ONLY "article_keyword" ADD CONSTRAINT "article_keyword_article_id_fkey" FOREIGN KEY (article_id) REFERENCES article(id) ON UPDATE CASCADE ON DELETE CASCADE NOT DEFERRABLE;
ALTER TABLE ONLY "article_keyword" ADD CONSTRAINT "article_keyword_keyword_id_fkey" FOREIGN KEY (keyword_id) REFERENCES keyword(id) ON UPDATE CASCADE ON DELETE CASCADE NOT DEFERRABLE;



DROP TABLE IF EXISTS "issue";
CREATE TABLE "issue" (
  "id" bigserial PRIMARY KEY,
  "name" character varying(200) DEFAULT '' NOT NULL,
  "cover" text,
  "year" smallint NOT NULL,
  "date" date,
  "editorial_message" text,
  "volume" int DEFAULT '0' NOT NULL,
  "number" int DEFAULT '0' NOT NULL,
  "updated_at" timestamp DEFAULT NULL,
  "created_at" timestamp DEFAULT now() NOT NULL
);
COMMENT ON TABLE "issue" IS '期刊';
COMMENT ON COLUMN "issue"."cover" IS '封面';
COMMENT ON COLUMN "issue"."year" IS '年';
COMMENT ON COLUMN "issue"."number" IS '编号';
COMMENT ON COLUMN "issue"."date" IS '日期';


DROP TABLE IF EXISTS "issue_article";
CREATE TABLE "issue_article" (
  "issue_id" bigint,
  "article_id" bigint,
  "sequence" smallint DEFAULT '0',
  "page_start" int DEFAULT '0',
  "page_end" int DEFAULT '0',
  CONSTRAINT "issue_article_pkey" PRIMARY KEY ("issue_id", "article_id")
) WITH (oids = false);
COMMENT ON TABLE "issue_article" IS '期刊文章';
COMMENT ON COLUMN "issue_article"."article_id" IS 'article表id';
COMMENT ON COLUMN "issue_article"."issue_id" IS 'issue表id';
COMMENT ON COLUMN "issue_article"."sequence" IS '文章顺序';
ALTER TABLE ONLY "issue_article" ADD CONSTRAINT "issue_article_article_id_fkey" FOREIGN KEY (article_id) REFERENCES article(id) ON UPDATE CASCADE ON DELETE CASCADE NOT DEFERRABLE;
ALTER TABLE ONLY "issue_article" ADD CONSTRAINT "issue_article_issue_id_fkey" FOREIGN KEY (issue_id) REFERENCES issue(id) ON UPDATE CASCADE ON DELETE CASCADE NOT DEFERRABLE;



DROP TABLE IF EXISTS "role";
CREATE TABLE "role" (
  "id" bigserial PRIMARY KEY,
  "name" character varying(200) NOT NULL,
  "privileges" int[] DEFAULT '{}' NOT NULL,
  "updated_user_id" bigint,
  "created_user_id" bigint,
  "updated_at" timestamp DEFAULT NULL,
  "created_at" timestamp DEFAULT now() NOT NULL
);
COMMENT ON TABLE "role" IS '角色';
COMMENT ON COLUMN "role"."name" IS '角色名';
COMMENT ON COLUMN "role"."privileges" IS '权限';
COMMENT ON COLUMN "role"."updated_user_id" IS '更新者id';
COMMENT ON COLUMN "role"."created_user_id" IS '创建者id';
COMMENT ON COLUMN "role"."updated_at" IS '更新时间';
COMMENT ON COLUMN "role"."created_at" IS '创建时间';
SELECT setval(pg_get_serial_sequence('role', 'id'), 1000, false);


DROP TABLE IF EXISTS "role_article";
CREATE TABLE "role_article" (
  "role_id" bigint DEFAULT '0' NOT NULL,
  "article_id" bigint DEFAULT '0' NOT NULL,
  "status" smallint DEFAULT '0' NOT NULL,
  "updated_at" timestamp,
  "created_at" timestamp DEFAULT now() NOT NULL,
  CONSTRAINT "role_article_pkey" PRIMARY KEY ("article_id", "role_id")
);
COMMENT ON TABLE "role_article" IS '角色文章';
COMMENT ON COLUMN "role_article"."role_id" IS '角色id';
COMMENT ON COLUMN "role_article"."article_id" IS '文章id';
COMMENT ON COLUMN "role_article"."status" IS '状态';
ALTER TABLE ONLY "role_article" ADD CONSTRAINT "role_article_article_id_fkey" FOREIGN KEY (article_id) REFERENCES article(id) ON UPDATE CASCADE ON DELETE CASCADE NOT DEFERRABLE;
ALTER TABLE ONLY "role_article" ADD CONSTRAINT "role_article_role_id_fkey" FOREIGN KEY (role_id) REFERENCES role(id) ON UPDATE CASCADE ON DELETE CASCADE NOT DEFERRABLE;



DROP TABLE IF EXISTS "user";
CREATE TABLE "user" (
  "id" bigserial PRIMARY KEY,
  "email" character varying(200) NOT NULL UNIQUE,
  "password" character varying(200) NOT NULL,
  "author_id" bigint,
  "role_id" bigint,
  "is_admin" boolean DEFAULT 'f',
  "is_active" boolean DEFAULT 'f',
  "updated_at" timestamp DEFAULT NULL,
  "created_at" timestamp DEFAULT now() NOT NULL
);
COMMENT ON COLUMN "user"."email" IS '注册邮箱';
COMMENT ON COLUMN "user"."password" IS '密码';
COMMENT ON COLUMN "user"."author_id" IS '作者id';
COMMENT ON COLUMN "user"."role_id" IS '角色id';
COMMENT ON COLUMN "user"."is_admin" IS '是否管理员';
COMMENT ON COLUMN "user"."is_active" IS '是否激活';
COMMENT ON COLUMN "user"."updated_at" IS '更新时间';
COMMENT ON COLUMN "user"."created_at" IS '创建时间';
ALTER TABLE ONLY "user" ADD CONSTRAINT "user_author_id_fkey" FOREIGN KEY (author_id) REFERENCES author(id) ON UPDATE CASCADE ON DELETE SET NULL;
ALTER TABLE ONLY "user" ADD CONSTRAINT "user_role_id_fkey" FOREIGN KEY (role_id) REFERENCES role(id) ON UPDATE CASCADE ON DELETE SET NULL;


DROP TABLE IF EXISTS "user_article";
CREATE TABLE "user_article" (
  "user_id" bigint DEFAULT '0' NOT NULL,
  "article_id" bigint DEFAULT '0' NOT NULL,
  "updated_at" timestamp,
  "created_at" timestamp DEFAULT now() NOT NULL,
  CONSTRAINT "user_article_pkey" PRIMARY KEY ("article_id", "user_id")
);
COMMENT ON TABLE "user_article" IS '用户发表文章';
COMMENT ON COLUMN "user_article"."user_id" IS '用户id';
COMMENT ON COLUMN "user_article"."article_id" IS '文章id';
ALTER TABLE ONLY "user_article" ADD CONSTRAINT "user_article_article_id_fkey" FOREIGN KEY (article_id) REFERENCES article(id) ON UPDATE CASCADE ON DELETE CASCADE NOT DEFERRABLE;
ALTER TABLE ONLY "user_article" ADD CONSTRAINT "user_article_user_id_fkey" FOREIGN KEY (user_id) REFERENCES "user"("id") ON DELETE SET NULL ON UPDATE CASCADE;


DROP TABLE IF EXISTS "user_article_audition";
CREATE TABLE "user_article_audition" (
  "id" bigserial PRIMARY KEY,
  "user_id" bigint DEFAULT '0' NOT NULL,
  "article_id" bigint DEFAULT '0' NOT NULL,
  "status" smallint DEFAULT '0' NOT NULL,
  "message" text,
  "origin_id" bigint,
  "updated_at" timestamp,
  "created_at" timestamp DEFAULT now() NOT NULL
);
ALTER TABLE ONLY "user_article_audition" ADD CONSTRAINT "user_article_audition_article_id_fkey" FOREIGN KEY (article_id) REFERENCES article(id) ON UPDATE CASCADE ON DELETE CASCADE NOT DEFERRABLE;
ALTER TABLE ONLY "user_article_audition" ADD CONSTRAINT "user_article_audition_origin_fkey" FOREIGN KEY (origin_id) REFERENCES user_article_audition(id) ON UPDATE CASCADE ON DELETE CASCADE NOT DEFERRABLE;


DROP TABLE IF EXISTS "admin_invite";
CREATE TABLE "admin_invite" (
  "id" bigserial PRIMARY KEY,
  "email" character varying(200) NOT NULL UNIQUE,
  "article_id" bigint DEFAULT '0' NOT NULL,
  "status" smallint DEFAULT '0' NOT NULL,
  "updated_at" timestamp DEFAULT NULL,
  "created_at" timestamp DEFAULT now() NOT NULL
);
COMMENT ON TABLE "admin_invite" IS '邀请用户';
COMMENT ON COLUMN "admin_invite"."email" IS '邮箱';
COMMENT ON COLUMN "admin_invite"."status" IS '状态';
COMMENT ON COLUMN "admin_invite"."updated_at" IS '更新时间';
COMMENT ON COLUMN "admin_invite"."created_at" IS '创建时间';
ALTER TABLE ONLY "admin_invite" ADD CONSTRAINT "admin_invite_article_id_fkey" FOREIGN KEY (article_id) REFERENCES article(id) ON UPDATE CASCADE ON DELETE CASCADE NOT DEFERRABLE;



DROP TABLE IF EXISTS "review_article";
CREATE TABLE "review_article" (
  "user_id" bigint DEFAULT '0' NOT NULL,
  "article_id" bigint DEFAULT '0' NOT NULL,
  "assigned_user_id" bigint DEFAULT '0' NOT NULL,
  "status" smallint DEFAULT '0' NOT NULL,
  "score" integer[] DEFAULT '{}' NOT NULL,
  "is_revison" boolean DEFAULT 'f' NOT NULL,
  "recommendation" smallint DEFAULT '0' NOT NULL,
  "comments_editor" text,
  "comments_author" text,
  "files" character varying[] DEFAULT '{}' NOT NULL,
  "expired_at" timestamp,
  "updated_at" timestamp,
  "created_at" timestamp DEFAULT now() NOT NULL,
  CONSTRAINT "review_article_pkey" PRIMARY KEY ("article_id", "user_id")
);
COMMENT ON TABLE "review_article" IS '分配的待审核文章';
COMMENT ON COLUMN "review_article"."user_id" IS '用户id';
COMMENT ON COLUMN "review_article"."article_id" IS '文章id';
COMMENT ON COLUMN "review_article"."assigned_user_id" IS '分配者id';
COMMENT ON COLUMN "review_article"."status" IS '状态';
COMMENT ON COLUMN "review_article"."score" IS '多项打分';
COMMENT ON COLUMN "review_article"."is_revison" IS '是否修改';
COMMENT ON COLUMN "review_article"."recommendation" IS '推荐等级';
COMMENT ON COLUMN "review_article"."comments_editor" IS '评论评审员';
COMMENT ON COLUMN "review_article"."comments_author" IS '评论作者';
COMMENT ON COLUMN "review_article"."files" IS '附件';
COMMENT ON COLUMN "review_article"."expired_at" IS '过期时间';
COMMENT ON COLUMN "review_article"."updated_at" IS '更新时间';
COMMENT ON COLUMN "review_article"."created_at" IS '创建时间';

ALTER TABLE ONLY "review_article" ADD CONSTRAINT "review_article_article_id_fkey" FOREIGN KEY (article_id) REFERENCES "article"("id") ON UPDATE CASCADE ON DELETE CASCADE NOT DEFERRABLE;
ALTER TABLE ONLY "review_article" ADD CONSTRAINT "review_article_user_id_fkey" FOREIGN KEY (user_id) REFERENCES "user"("id") ON UPDATE CASCADE ON DELETE CASCADE NOT DEFERRABLE;
ALTER TABLE ONLY "review_article" ADD CONSTRAINT "review_article_assigned_user_id_fkey" FOREIGN KEY (assigned_user_id) REFERENCES "user"("id") ON UPDATE CASCADE ON DELETE CASCADE NOT DEFERRABLE;



DROP TABLE IF EXISTS "comment_article";
CREATE TABLE "comment_article" (
  "user_id" bigint DEFAULT '0' NOT NULL,
  "article_id" bigint DEFAULT '0' NOT NULL,
  "assigned_user_id" bigint DEFAULT '0' NOT NULL,
  "status" smallint DEFAULT '0' NOT NULL,
  "recommendation" smallint DEFAULT '0' NOT NULL,
  "comments_editor" text,
  "comments_author" text,
  "files" character varying[] DEFAULT '{}' NOT NULL,
  "expired_at" timestamp,
  "updated_at" timestamp,
  "created_at" timestamp DEFAULT now() NOT NULL,
  CONSTRAINT "comment_article_pkey" PRIMARY KEY ("article_id", "user_id")
);
COMMENT ON TABLE "comment_article" IS '分配的待评论的文章';
COMMENT ON COLUMN "comment_article"."user_id" IS '用户id';
COMMENT ON COLUMN "comment_article"."article_id" IS '文章id';
COMMENT ON COLUMN "comment_article"."assigned_user_id" IS '分配者id';
COMMENT ON COLUMN "comment_article"."status" IS '状态';
COMMENT ON COLUMN "comment_article"."recommendation" IS '推荐等级';
COMMENT ON COLUMN "comment_article"."comments_editor" IS '评论评审员';
COMMENT ON COLUMN "comment_article"."comments_author" IS '评论作者';
COMMENT ON COLUMN "comment_article"."files" IS '附件';
COMMENT ON COLUMN "comment_article"."expired_at" IS '过期时间';
COMMENT ON COLUMN "comment_article"."updated_at" IS '更新时间';
COMMENT ON COLUMN "comment_article"."created_at" IS '创建时间';

ALTER TABLE ONLY "comment_article" ADD CONSTRAINT "comment_article_article_id_fkey" FOREIGN KEY (article_id) REFERENCES "article"("id") ON UPDATE CASCADE ON DELETE CASCADE NOT DEFERRABLE;
ALTER TABLE ONLY "comment_article" ADD CONSTRAINT "comment_article_user_id_fkey" FOREIGN KEY (user_id) REFERENCES "user"("id") ON UPDATE CASCADE ON DELETE CASCADE NOT DEFERRABLE;
ALTER TABLE ONLY "comment_article" ADD CONSTRAINT "comment_article_assigned_user_id_fkey" FOREIGN KEY (assigned_user_id) REFERENCES "user"("id") ON UPDATE CASCADE ON DELETE CASCADE NOT DEFERRABLE;


DROP TABLE if EXISTS "gpt_key";
CREATE TABLE "gpt_key" (
  "id" bigserial PRIMARY KEY,
  "name" character varying(200) NOT NULL,
  "key" character varying(200) NOT NULL,
  "status" smallint DEFAULT '0' NOT NULL,
  "updated_at" timestamp DEFAULT NULL,
  "created_at" timestamp DEFAULT now() NOT NULL
);
COMMENT ON TABLE "gpt_key" IS 'chatgpt';
COMMENT ON COLUMN "gpt_key"."key" IS 'key of chatgpt';
COMMENT ON COLUMN "gpt_key"."status" IS '状态';
SELECT setval(pg_get_serial_sequence('gpt_key', 'id'), 1000, false);



-- CREATE SEQUENCE common_sequence START 1000;
DROP TABLE if EXISTS "merchandise";
CREATE TABLE "merchandise" (
  "id" bigserial PRIMARY KEY,
  "name" character varying(200) NOT NULL,
  "price" NUMERIC(10, 2) DEFAULT '0.00' NOT NULL,
  "currency" character varying(20) NOT NULL,
  "description" text NOT NULL,
  "updated_at" timestamp DEFAULT NULL,
  "created_at" timestamp DEFAULT now() NOT NULL
);
COMMENT ON TABLE "merchandise" IS '商品';
COMMENT ON COLUMN "merchandise"."name" IS '商品名';
COMMENT ON COLUMN "merchandise"."price" IS '价格';
COMMENT ON COLUMN "merchandise"."currency" IS '货币';
COMMENT ON COLUMN "merchandise"."description" IS '描述';
SELECT setval(pg_get_serial_sequence('merchandise', 'id'), 1000, false);

DROP TABLE if EXISTS "paypal_token";
CREATE TABLE "paypal_token" (
  "id" bigserial PRIMARY KEY,
  "token" character varying(200) NOT NULL,
  "expires_at" timestamp DEFAULT NULL,
  "updated_at" timestamp DEFAULT NULL,
  "created_at" timestamp DEFAULT now() NOT NULL
);
COMMENT ON TABLE "paypal_token" IS 'paypal token';
COMMENT ON COLUMN "paypal_token"."token" IS 'token';
COMMENT ON COLUMN "paypal_token"."expires_at" IS '过期时间';
CREATE INDEX idx_expires_at ON paypal_token (expires_at);

DROP TABLE if EXISTS "order";
CREATE TABLE "order" (
  "id" bigserial PRIMARY KEY,
  "pay_id" character varying(200) UNIQUE,
  "user_id" bigint DEFAULT '0' NOT NULL,
  "status" smallint DEFAULT '0' NOT NULL,
  "description" text DEFAULT '' NOT NULL,
  "body" jsonb DEFAULT '{}' NOT NULL,
  "updated_at" timestamp DEFAULT NULL,
  "created_at" timestamp DEFAULT now() NOT NULL,
  CONSTRAINT "order_user_id_fkey" FOREIGN KEY (user_id) REFERENCES "user"("id") ON UPDATE CASCADE ON DELETE SET NULL NOT DEFERRABLE
);
COMMENT ON TABLE "order" IS '订单';
COMMENT ON COLUMN "order"."pay_id" IS 'paypal支付id';
COMMENT ON COLUMN "order"."status" IS '状态';
COMMENT ON COLUMN "order"."description" IS '描述';
COMMENT ON COLUMN "order"."body" IS '内容';
CREATE INDEX "order_user_id" ON "public"."order" USING btree ("user_id");
SELECT setval(pg_get_serial_sequence('order', 'id'), 1000, false);



DROP TABLE if EXISTS "base_config";
CREATE TABLE "base_config" (
  "id" bigserial PRIMARY KEY,
  "comment_valid_reviewer_num" smallint DEFAULT '0' NOT NULL,
  "updated_user_id" integer DEFAULT '0' NOT NULL,
  "updated_at" timestamp DEFAULT NULL,
  "created_at" timestamp DEFAULT now() NOT NULL
);
COMMENT ON TABLE "base_config" IS '基础配置';
COMMENT ON COLUMN "base_config"."comment_valid_reviewer_num" IS '评论有效评审人数';

