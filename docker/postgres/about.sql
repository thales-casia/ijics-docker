-- Adminer 4.8.1 PostgreSQL 15.2 (Debian 15.2-1.pgdg110+1) dump

DROP TABLE IF EXISTS "about";
DROP SEQUENCE IF EXISTS about_id_seq;
CREATE SEQUENCE about_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1;

CREATE TABLE "public"."about" (
    "id" integer DEFAULT nextval('about_id_seq') NOT NULL,
    "title" text NOT NULL,
    "content" text NOT NULL,
    "key" character varying(100) NOT NULL,
    "created_at" timestamp DEFAULT now() NOT NULL,
    "updated_at" timestamp,
    CONSTRAINT "about_pkey" PRIMARY KEY ("id")
) WITH (oids = false);

COMMENT ON COLUMN "public"."about"."title" IS '标题';

COMMENT ON COLUMN "public"."about"."content" IS '内容';

COMMENT ON COLUMN "public"."about"."key" IS '查询索引';

COMMENT ON COLUMN "public"."about"."created_at" IS '创建时间';

COMMENT ON COLUMN "public"."about"."updated_at" IS '修改时间';

INSERT INTO "about" ("id", "title", "content", "key", "created_at", "updated_at") VALUES
(3,	'Amis and Scope',	'<p>The coverage of this journal includes but is not limited to:</p>
<p>
C4ISR Theory and Technology, Big Data Technology, Unmanned System and Technology, Command and Control Parallel System, Cyber-Physical System (CPS), Information Fusion, System Modeling, Simulation Test, Artificial Intelligence, Deep Learning, Complex System, Virtual Reality, Cyber Space, Emergency Rescue, Aerospace Safety and Decision Control, Navigation and Positioning Technology, Smart City and Public Safety, Traffic Command and Control System, etc.
</p>',	'amis-and-scope',	'2023-02-28 09:25:31.493757',	NULL),
(5,	'Contact',	'<p>E-mail: <a href="mailto:info@agist.org">info@agist.org</a>&nbsp;Tel. 732 543 6103</p>
<p>Address: 1900 Camden Ave, San Jose, CA 95124, US</p>',	'contact',	'2023-03-02 12:32:27.98228',	NULL),
(6,	'Current Editorial Board',	'<p><strong>Editor-in-Chief</strong></p><p>Fei-Yue Wang (Founding EiC)&nbsp;</p><p><br></p><p><strong>Executive Editor-in-Chief</strong></p><p>Jirong Qin&nbsp;</p><p><br></p><p><strong>Deputy Editor-in-Chief</strong></p><table><tbody><tr class="firstRow"><td width="179" valign="top" style="word-break: break-all;">Jinhu Lv</td><td width="179" valign="top" style="word-break: break-all;">Kun Fu</td><td width="179" valign="top" style="word-break: break-all;">Dingzhu Li</td><td width="179" valign="top" style="word-break: break-all;">Weiming Zhang</td><td width="179" valign="top" style="word-break: break-all;">Guohong Zhao</td><td width="179" valign="top" style="word-break: break-all;">Xiaofeng Hu</td></tr></tbody></table><p><br></p><p><strong>Associate Editors</strong></p><table><tbody><tr class="firstRow"><td width="179" valign="top" style="word-break: break-all;">Xiao Wang</td><td width="179" valign="top" style="word-break: break-all;">Jian Wang</td><td width="179" valign="top" style="word-break: break-all;">Ying Tang</td><td width="179" valign="top" style="word-break: break-all;">Teng Long</td><td width="179" valign="top" style="word-break: break-all;">Yidong Li</td><td width="179" valign="top" style="word-break: break-all;">Long Chen</td></tr><tr><td width="179" valign="top" style="word-break: break-all;">Dongpu Cao</td><td width="179" valign="top" style="word-break: break-all;">Yisheng Lv</td><td width="179" valign="top" style="word-break: break-all;">Qinglai Wei</td><td width="179" valign="top" style="word-break: break-all;">Huijun Gao</td><td width="179" valign="top" style="word-break: break-all;">Tim Cheng</td><td width="179" valign="top" style="word-break: break-all;">Thomas Rid</td></tr><tr><td width="179" valign="top" style="word-break: break-all;">Alexander H. Levi</td><td width="179" valign="top" style="word-break: break-all;">Vincenzo Piuri</td><td width="179" valign="top" style="word-break: break-all;">Heinz Stoewer</td><td width="179" valign="top" style="word-break: break-all;">Olivier L.de Weck</td><td width="179" valign="top"><br></td><td width="179" valign="top"><br></td></tr></tbody></table>',	'editorial-board',	'2023-03-02 12:34:55.367309',	NULL),
(7,	'Information for Authors',	'<p><strong>Manuscript Requirement</strong></p><p>Manuscripts submitted to this journal should not have been published and will not be submitted or published elsewhere in English or any other languages, without the written consent of the publisher.</p><p>The contributed manuscripts should reflect the latest developments of the research area, with emphasis on academic novelty and thoughtfulness, as well as practicability. The contributions should highlight the main points, with the dull narration and ordinary derivation reduced or deleted as much as possible. The same statements should not be repeated in Abstract, Introduction and Conclusions.</p><p>The manuscripts should be in 2-column format. The writing style should be simple and straightforward, the data should be reliable, and any undue self-appraisal must be abandoned. Manuscripts of low quality, of poor English writing or with tedious quotations will be rejected without review.</p><p>&nbsp;</p><p><strong>Process for Submission</strong></p><p>All prospective authors must submit their manuscripts electronically. DOC or PDF files can be accepted and PDF files are preferred. Submitted manuscripts may be of three basic types: Reviews, Papers, and Letters.</p><p>The type "Review" includes review, survey, and tutorial. When submitting Review, please include a cover letter with the following information:</p><p>1) Description of topic and its importance, including the contribution of this review to the Community and the distinction in this review with respect to the state-of-the-art review (if any);</p><p>2) Brief biography of the author(s) who contribute(s) most on this review to highlight the qualifications for writing reviews. Previously published representative reviews and articles of the author(s) can be attached as references;</p><p>3) Background records that extend beyond author’s own work to demonstrate the appeal of the topic to a broad audience.</p><p>4) Generally, the Review should be no more than 15 pages (mainbody without the list of references) and References no more than 150 items.</p><p>&nbsp;</p><p><strong>Your file should be submitted according to the following procedure:</strong></p><p>1) Please go to: http://mc03.manuscriptcentral.com (ScholarOne Manuscripts System) and follow the instructions to upload your file. You should register a new account for the first submission.</p><p>2) Sign the Transfer of Copyright Agreement.</p><p>3) The author will receive an e-mail message acknowledging successful reception of the submission and assigning a reference number to the submission.</p><p>4) The author can inquire about the review status through email. If the manuscript needs some modification, the author will be informed by email.</p><p>&nbsp;</p><p><strong>Peer Review</strong></p><p>The articles in this journal are peer reviewed. Each published article was reviewed by a minimum of two independent reviewers using a double-blind peer review process, in which the identities of the reviewers are not known to the authors, and the identities of the authors are not known to the reviewers. Articles will be screened for plagiarism before acceptance.</p><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p><p><strong>Files&nbsp;&nbsp;</strong></p><p>1) Instructions on preparing files (for accepted papers)</p><p>2) Copyright</p><p>All authors must sign the Transfer of Copyright Agreement before the paper can be published. This agreement enables the publisher to protect the copyrighted material for the authors, without affecting the authors’ proprietary rights. Authors are responsible for obtaining permission from the copyright holder to reproduce any figures or other material included in the paper for which copyright already exists.</p><p>3) &nbsp;LaTex Template &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;WORD Template</p>',	'author',	'2023-03-02 12:37:30.312258',	NULL),
(8,	'Become a Reviewer',	'Become a Reviewer',	'reviewer',	'2023-03-02 12:38:25.778499',	NULL),
(9,	'Open Access Publishing Options',	'Open Access Publishing Options',	'access',	'2023-03-02 12:41:17.559775',	NULL),
(10,	'Submit Manuscript',	'Submit Manuscript',	'submit',	'2023-03-02 12:42:55.466575',	NULL),
(4,	'Process for Submission',	'<p>All prospective authors must submit their manuscripts electronically. DOC or PDF files can be accepted and PDF files are preferred. Submitted manuscripts may be of three basic types: Reviews, Papers, and Letters.</p>

<p>Download the template:</p>
<ul>
<li><a href="http://cdsn.j-cpsi.com/template.docx" target="_blank">Word</a></li>
<li><a href="http://cdsn.j-cpsi.com/template.zip" target="_blank">LaTex</a></li>
</ul>',	'submission',	'2023-03-01 06:38:26.766454',	NULL);

-- 2023-03-10 04:27:15.06163+00
