-- board 테이블
CREATE TABLE board (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    content TEXT,
    create_date TIMESTAMP DEFAULT NOW(),
    update_date TIMESTAMP DEFAULT NOW()
);

-- board 테이블 주석
COMMENT ON TABLE board IS '게시판';
COMMENT ON COLUMN board.id IS '번호';
COMMENT ON COLUMN board.title IS '제목';
COMMENT ON COLUMN board.content IS '내용';
COMMENT ON COLUMN board.create_date IS '작성일';
COMMENT ON COLUMN board.update_date IS '수정일';

-- member 테이블
CREATE TABLE member (
    id SERIAL PRIMARY KEY,
    userid VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    name VARCHAR(100),
    create_date TIMESTAMP DEFAULT NOW(),
    update_date TIMESTAMP DEFAULT NOW()
);

-- member 테이블 주석
COMMENT ON TABLE member IS '회원';
COMMENT ON COLUMN member.id IS '번호';
COMMENT ON COLUMN member.userid IS '아이디';
COMMENT ON COLUMN member.password IS '비밀번호';
COMMENT ON COLUMN member.name IS '이름';
COMMENT ON COLUMN member.create_date IS '작성일';
COMMENT ON COLUMN member.update_date IS '수정일';

-- 테스트 사용자
INSERT INTO member (userid, password, name) VALUES ('admin', '1234', '관리자');