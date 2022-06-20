CREATE TABLE IF NOT EXISTS Words(
    WordId          BIGINT NOT NULL AUTO_INCREMENT,
    InitWord        VARCHAR(200),
    RevWord         VARCHAR(200),
    PRIMARY KEY(WordId)
)