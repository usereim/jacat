-- 2.0 : 9. 게시판 파일 테이블 PK 오타 수정
-- 3.0 : 5. 자격증 시험일정 테이블 관리번호 컬럼 추가 및 impl_seq, jmcd PK 해제
-- 4.0 : 5. 자격증 시험일정 테이블 누락된 prac_reg_end_dt 추가, 4. 자격증별 시험장 테이블 addno auto_increment 속성 추가
-- 5.0 : 10,15 댓글 테이블, 자격증 댓글 테이블 parent_comment_num 기본값 0으로 수정, 15. 자격증 댓글 테이블 parent_comment -> parent_comment_num으로 컬럼명 수정
-- 6.0 : 자격증 댓글 테이블에 delyn컬럼 추가, 상단에 db계정 생성,권한부여 명령어 추가, db 생성 명령어 추가
-- 7.0 : 자격증 신고 테이블 report_date 컬럼 기본값 생성일로 추가

-- db 계정 생성
create user 'jacat_admin'@'localhost' identified by 'jacat1234';

-- db 계정
grant insert,select,update,delete on jacat_db.* to 'jacat_admin'@'localhost';

flush privileges;

create database jacat_db;

show databases;

use jacat_db;

show tables;

-- --------------------------------------------------------------------------------
-- 공공데이터에서 자료를 받아 오는 테이블
-- --------------------------------------------------------------------------------

-- 1. 자격증 목록 테이블
create table license_list(
jmcd varchar(255) primary key,
qualgbcd varchar(255) not null,
qualgbnm varchar(255) not null,
seriescd varchar(255) not null,
seriesnm varchar(255) not null,
jmfldnm varchar(255) not null,

obligfldcd varchar(255) not null,
obligfldnm varchar(255) not null,
mdobligfldcd varchar(255) not null,
mdobligfldnm varchar(255) not null,
licensing_authority varchar(255) not null
);

-- 2. 자격증별 출제과목 테이블
create table license_test(
license_num int primary key,
license_list_jmcd varchar(255),
subject_name varchar(255) not null,
test_type varchar(255) not null,
test_count varchar(255) not null,
test_version varchar(255) not null,
test_time varchar(255) not null,
foreign key (license_list_jmcd) references license_list(jmcd)
);

-- 3 자격증별 응시자격 테이블
create table license_eligibility(
emqual_cd varchar(255) primary key,
emqual_disp_nm text not null,
grd_cd varchar(255) not null,
grd_nm varchar(255) not null,
qualgb_cd varchar(255) not null,
qualgb_nm varchar(255) not null
);

-- 4 자격증별 시험장 테이블
create table license_test_center(
addno int primary key auto_increment,
-- addno 컬럼 auto_increment 추가
address varchar(255) not null,
brch_cd varchar(255) not null,
brch_nm varchar(255) not null,
exam_area_gb_nm varchar(255) not null,
exam_area_nm varchar(255) not null,
plce_loct_gid varchar(255) not null,
tel_no varchar(255) not null
);

drop table license_test_date;

-- 5 자격증별 시험일정 테이블
create table license_test_date(
ltd_num int primary key auto_increment,
-- 관리번호 추가
impl_seq int not null,
license_list_jmcd varchar(255),
impl_yy varchar(255) not null,
description varchar(255) not null,
doc_reg_start_dt varchar(255) not null,
doc_reg_end_dt varchar(255) not null,
doc_exam_start_dt varchar(255) not null,
doc_exam_end_dt varchar(255) not null,
doc_pass_dt varchar(255) not null,
prac_reg_start_dt varchar(255) not null,
prac_reg_end_dt varchar(255) not null,
-- 누락된 prac_reg_end_dt 추가
prac_exam_start_dt varchar(255) not null,
prac_exam_end_dt varchar(255) not null,
prac_pass_dt varchar(255) not null,
foreign key (license_list_jmcd) references license_list(jmcd)
);

-- --------------------------------------------------------------------------------
-- 실 사용 테이블
-- --------------------------------------------------------------------------------

-- 6. users 테이블
-- 테이블명 user -> users 로 변경
-- users_id -> id로 변경
create table users(
id varchar(255) primary key,
pw varchar(255) not null,
nick varchar(255) unique key not null,
email varchar(255) unique key not null,
grade char(1) default 'G',
create_date timestamp default now(),
real_file_name varchar(255),
file_name varchar(255),
path varchar(255),
type varchar(255)
);

-- 7. 게시판 테이블
-- boards로 테이블 명 변경
create table boards(
board_num int primary key auto_increment,
users_id varchar(255),
title varchar(255) not null,
content text not null,
w_date timestamp not null default now(),
modify_date timestamp,
delyn char(1) default 'N',
board_type char(1),
foreign key (users_id) references users(id)
);

-- 8. 게시판 조회수 테이블
create table visit_board(
boards_board_num int,
users_id varchar(255),
primary key (boards_board_num, users_id),
foreign key (boards_board_num) references boards(board_num),
foreign key (users_id) references users(id)
);

-- 9. 게시판 파일 테이블
create table file_board(
file_num int primary key auto_increment,
boards_board_num int,
real_file_name varchar(255) not null,
file_name varchar(255) not null,
path varchar(255) not null,
w_date timestamp not null default now(),
type varchar(255) not null,
foreign key (boards_board_num) references boards(board_num)
);

drop table file_board;


-- 10. 게시판 댓글 테이블
-- comments로 테이블 명 변경
-- content varchar(512)로 변경
create table comments(
comment_num int primary key auto_increment,
users_id varchar(255),
boards_board_num int,
parent_comment_num int not null default 0,
-- parent_comment -> parent_comment_num 컬럼명 수정, 기본값 0으로 수정
content varchar(512) not null,
w_date timestamp not null default now(),
modify_date timestamp,
delyn char(1) not null default 'N'
);

-- 11. 게시판 신고 테이블
create table board_report(
report_num int primary key auto_increment,
users_id varchar(255),
boards_board_num int,
report_date timestamp not null default now(),
report_category varchar(255) not null,
report_content varchar(255) not null,
foreign key (users_id) references users(id),
foreign key (boards_board_num) references boards(board_num)
);

-- 12. 자격증 게시판 테이블
create table license_boards(
board_num int primary key auto_increment,
users_id varchar(255),
license_list_jmcd varchar(255),
title varchar(255) not null,
content text not null,
w_date timestamp not null default now(),
modify_date timestamp,
delyn char(1) not null default 'N',
board_type char(1) not null,
foreign key (users_id) references users(id),
foreign key (license_list_jmcd) references license_list(jmcd)
);

-- 13. 자격증 게시판 조회수 테이블
create table visit_license_board(
users_id varchar(255),
license_board_num int,
primary key(users_id,license_board_num),
foreign key (users_id) references users(id),
foreign key (license_board_num) references license_boards(board_num)
);

-- 14. 자격증 게시판 파일 테이블
create table file_license_board(
file_num int primary key auto_increment,
license_boards_board_num int,
real_file_name varchar(255) not null,
file_name varchar(255) not null,
path varchar(255) not null,
w_date timestamp not null default now(),
type varchar(255) not null,
foreign key (license_boards_board_num) references license_boards(board_num)
);

-- 15. 자격증 게시판 댓글 테이블
-- license_board_bno -> license_boards_board_num 으로 컬럼 수정
-- content varchar(255) -> varchar(512)로 수정
-- delyn 컬럼 추가
create table license_comment(
comment_num int primary key auto_increment,
license_boards_board_num int,
users_id varchar(255),
parent_comment_num int not null default 0,
-- parent_comment -> parent_comment_num 컬럼명 수정, 기본값 0으로 수정
content varchar(512) not null,
w_date timestamp not null default now(),
modify_date timestamp,
delyn char(1) not null default 'N',
foreign key (license_boards_board_num) references license_boards(board_num),
foreign key (users_id) references users(id)
);

-- 16. 자격증 게시판 신고 테이블
create table license_board_report(
report_num int primary key auto_increment,
users_id varchar(255),
license_boards_board_num int,
-- 기본값 추가
report_date timestamp not null default now(),
report_category varchar(255) not null,
report_content varchar(255),
foreign key (users_id) references users(id),
foreign key (license_boards_board_num) references license_boards(board_num)
);

-- 17. 일정 테이블
create table calendar(
date_num int primary key auto_increment,
users_id varchar(255),
start_date timestamp not null,
end_date timestamp not null,
title varchar(255) not null,
content varchar(512),
foreign key (users_id) references users(id)
);

-- 18. 관심 자격증 테이블
-- users_favorites -> users_favorites_license로 테이블 명 변경
create table users_favorites_license(
users_id varchar(255),
license_list_jmcd varchar(255),
w_date timestamp not null default now(),
primary key(users_id,license_list_jmcd),
foreign key (users_id) references users(id),
foreign key (license_list_jmcd) references license_list(jmcd)
);

-- --------------------------------------------------------------------------------

-- 관리자 계정 생성
SELECT * FROM jacat_db.users;

insert into jacat_db.users(id,pw,nick,email,grade)
values('admin','jacat1234','관리자','jacatAd@naver.com','A');
