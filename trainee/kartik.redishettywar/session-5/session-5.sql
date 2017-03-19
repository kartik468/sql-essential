use [Zeus_SQL_Training]

-- 1.	Display details of quiz for which the total question count is greater than or equal to 5

-- SELECT Q.nQuizID, Q.nAssetID, Q.dtQuizStartsOn
SELECT Q.nQuizID, Q.nAssetID, Q.dtQuizStartsOn, SUM(QR.nRoundQuestionCount) 'TotalQuestionCount'
FROM tblQuiz Q
INNER JOIN tblQuizRound QR
	ON Q.nQuizID = QR.nQuizID
GROUP BY Q.nQuizID, Q.nAssetID, Q.dtQuizStartsOn
HAVING SUM(QR.nRoundQuestionCount) > 5

select top 10 * from tblQuizRoundwiseScore
select top 10 * from tblQuizRound

-- 2.	Display details of quiz for which total duration is greater than 500 and less than 720 seconds(both inclusive)
SELECT Q.nQuizID, Q.nAssetID, Q.dtQuizStartsOn, SUM(QR.nRoundDurationInSeconds) 'TotalDurationInSeconds'
FROM tblQuiz Q
INNER JOIN tblQuizRound QR
	ON Q.nQuizID = QR.nQuizID
GROUP BY Q.nQuizID, Q.nAssetID, Q.dtQuizStartsOn
HAVING SUM(QR.nRoundDurationInSeconds) BETWEEN 500 AND 720

-- 3.	Display list of participants with their total score for QuizID 355
SELECT QRS.nUserID, SUM(QRS.fPointsScored) TotalPoints
FROM tblQuiz Q
INNER JOIN tblQuizRound QR
	ON Q.nQuizID = QR.nQuizID
INNER JOIN  tblQuizRoundwiseScore QRS
	ON QR.nQuizRoundID = QRS.nQuizRoundID
WHERE Q.nQuizId = 355
GROUP BY QRS.nUserID

-- 4.	Re-write and extend above query to display ranks of users for all quizzes
SELECT Q.nQuizId, QRS.nUserID, SUM(QRS.fPointsScored) TotalScored,
	RANK() OVER (PARTITION BY Q.nQuizId ORDER BY SUM(QRS.fPointsScored) DESC) 'Rank'
FROM tblQuiz Q
INNER JOIN tblQuizRound QR
	ON Q.nQuizID = QR.nQuizID
INNER JOIN  tblQuizRoundwiseScore QRS
	ON QR.nQuizRoundID = QRS.nQuizRoundID
GROUP BY Q.nQuizId, QRS.nUserID
--order by QRS.nUserID


-- 5.	Display list of participants who have scored 50 or more points in QuizID 355

SELECT QRS.nUserID, SUM(QRS.fPointsScored) TotalPoints
FROM tblQuiz Q
INNER JOIN tblQuizRound QR
	ON Q.nQuizID = QR.nQuizID
INNER JOIN  tblQuizRoundwiseScore QRS
	ON QR.nQuizRoundID = QRS.nQuizRoundID
WHERE Q.nQuizId = 355
GROUP BY QRS.nUserID
HAVING SUM(QRS.fPointsScored) >= 50

-- 6.	Display no. of users employed under each of the employer listed in tblEmployer. Note: If any employer has no users then the count should appear as 0

SELECT E.nEmployerID, COUNT(FU.nEmployerID) AS 'Count'
FROM tblEmployer E
LEFT JOIN ForumUsers FU
	ON E.nEmployerID = FU.nEmployerID
GROUP BY E.nEmployerID
-- HAVING SUM(CASE WHEN E.nEmployerID IS NOT NULL THEN 1 ELSE 0 END) < 1

-- 7.	Display the list of the entrance tests along with the count of users who have opted for them.

SELECT ETTE.nEntranceTestTypeID, COUNT(ETTE.nEntranceTestTypeID) AS 'Count'
FROM tblEntranceTestTypeEnum ETTE
INNER JOIN tblUserEntranceTestsInterestedIn UERII
	ON ETTE.nEntranceTestTypeID = UERII.nEntranceTestTypeID
GROUP BY ETTE.nEntranceTestTypeID
ORDER BY COUNT(ETTE.nEntranceTestTypeID)