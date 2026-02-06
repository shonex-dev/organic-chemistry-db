# SQLite schema.sql（有機化学問題アプリDB設計）

-- =========================
-- Questions（問題マスタ）
-- =========================
CREATE TABLE Questions (
id INTEGER PRIMARY KEY AUTOINCREMENT,
question_text TEXT NOT NULL,
difficulty INTEGER,
created_at TEXT DEFAULT CURRENT_TIMESTAMP
);

-- =========================
-- Answers（答えマスタ）
-- =========================
CREATE TABLE Answers (
id INTEGER PRIMARY KEY AUTOINCREMENT,
answer_text TEXT NOT NULL,
description TEXT,
created_at TEXT DEFAULT CURRENT_TIMESTAMP
);

-- =========================
-- Tags（タグマスタ）
-- =========================
CREATE TABLE Tags (
id INTEGER PRIMARY KEY AUTOINCREMENT,
name TEXT NOT NULL,
type TEXT NOT NULL  -- category / 分類 / 官能基 / 性質 / レベル など
);

-- =========================
-- QuestionTag（問題×タグ 中間）
-- =========================
CREATE TABLE QuestionTag (
question_id INTEGER NOT NULL,
tag_id INTEGER NOT NULL,
PRIMARY KEY (question_id, tag_id),
FOREIGN KEY (question_id) REFERENCES Questions(id) ON DELETE CASCADE,
FOREIGN KEY (tag_id) REFERENCES Tags(id) ON DELETE CASCADE
);

-- =========================
-- AnswerTag（答え×タグ 中間）
-- =========================
CREATE TABLE AnswerTag (
answer_id INTEGER NOT NULL,
tag_id INTEGER NOT NULL,
PRIMARY KEY (answer_id, tag_id),
FOREIGN KEY (answer_id) REFERENCES Answers(id) ON DELETE CASCADE,
FOREIGN KEY (tag_id) REFERENCES Tags(id) ON DELETE CASCADE
);

-- =========================
-- Sources（出典マスタ）
-- =========================
CREATE TABLE Sources (
id INTEGER PRIMARY KEY AUTOINCREMENT,
name TEXT NOT NULL,
source_type TEXT, -- book / web / pdf / app
url TEXT
);

-- =========================
-- QuestionSource（問題×出典 中間）
-- =========================
CREATE TABLE QuestionSource (
question_id INTEGER NOT NULL,
source_id INTEGER NOT NULL,
PRIMARY KEY (question_id, source_id),
FOREIGN KEY (question_id) REFERENCES Questions(id) ON DELETE CASCADE,
FOREIGN KEY (source_id) REFERENCES Sources(id) ON DELETE CASCADE
);

-- =========================
-- Images（画像管理）
-- =========================
CREATE TABLE Images (
id INTEGER PRIMARY KEY AUTOINCREMENT,
related_type TEXT NOT NULL, -- question / answer
related_id INTEGER NOT NULL,
image_path TEXT NOT NULL,
description TEXT
);

-- =========================
-- Indexes（高速化用）
-- =========================
CREATE INDEX idx_questions_difficulty ON Questions(difficulty);
CREATE INDEX idx_tags_type ON Tags(type);
CREATE INDEX idx_tags_name ON Tags(name);
CREATE INDEX idx_answer_text ON Answers(answer_text);

