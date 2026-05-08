-- member 테이블에 role 추가
ALTER TABLE member ADD COLUMN IF NOT EXISTS role VARCHAR(20) DEFAULT 'USER';

-- term 테이블 생성
CREATE TABLE IF NOT EXISTS term (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    definition TEXT NOT NULL,
    content TEXT,
    category VARCHAR(100),
    tags VARCHAR(500),
    author_id BIGINT,
    create_date TIMESTAMP DEFAULT NOW(),
    update_date TIMESTAMP DEFAULT NOW()
);

-- term 테이블 주석
COMMENT ON TABLE term IS '용어';
COMMENT ON COLUMN term.id IS '번호';
COMMENT ON COLUMN term.title IS '용어명';
COMMENT ON COLUMN term.definition IS '정의';
COMMENT ON COLUMN term.content IS '내용';
COMMENT ON COLUMN term.category IS '카테고리';
COMMENT ON COLUMN term.tags IS '태그(쉼표로 구분)';
COMMENT ON COLUMN term.author_id IS '작성자번호';
COMMENT ON COLUMN term.create_date IS '작성일';
COMMENT ON COLUMN term.update_date IS '수정일';

-- 기존 관리자 권한 설정
UPDATE member SET role = 'ADMIN' WHERE userid = 'admin';

-- 테스트 용어
INSERT INTO term (title, definition, content, category, tags, author_id)
VALUES ('인공지능', '인간과 유사한 지능을 구현하기 위한 기술·알고리즘', '인공지능(AI)은 컴퓨터가 인간의 사고 과정을 모방하여 학습, 추론, 판단을 수행할 수 있도록 하는 기술 분야입니다.', '기술', 'AI,머신러닝,데이터', 1)
ON CONFLICT DO NOTHING;