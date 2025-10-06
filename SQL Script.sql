/* 1. It is not possible to summon a player that does not belong to any of the countries participating in the match. (INSERT) */

CREATE OR ALTER TRIGGER SUMMON_PLAYERS
ON SUMMONEDS
AFTER INSERT
AS
BEGIN
	IF TRIGGER_NESTLEVEL() > 1
        RETURN;

	DELETE SUMMONEDS 
	FROM INSERTED I JOIN MATCH M ON I.IDMATCH = M.IDMATCH
                    JOIN PLAYER P ON I.IDPLAYER = P.IDPERSON
                    JOIN SUMMONEDS S ON I.IDSUMMONED = S.IDSUMMONED
					WHERE S.IDPLAYER = P.IDPERSON AND P.IDCOUNTRY <> M.IDAWAYTEAM AND P.IDCOUNTRY <> M.IDHOMETEAM

	DECLARE @RejectedPlayers INT; SET @RejectedPlayers = @@ROWCOUNT;
	DECLARE @TotalPlayers INT; SELECT @TotalPlayers = COUNT(*) FROM INSERTED;

	PRINT 'Number of records where the player is not summoned is ' + CONVERT(VARCHAR, @RejectedPlayers) + ' from a total of ' + CONVERT(VARCHAR, @TotalPlayers) + ' records.';

	IF @RejectedPlayers < @TotalPlayers
		PRINT 'There are ' +  CONVERT(VARCHAR, @TotalPlayers - @RejectedPlayers) + ' successfully summoned players.'
END;
GO		

/* 2. A referee cannot referee a match where her/his own country is participating. (INSERT/UPDATE) */

-- INSERT Trigger
CREATE OR ALTER TRIGGER INSERT_REFEREE
ON MATCH
INSTEAD OF INSERT
AS
BEGIN
	IF TRIGGER_NESTLEVEL() > 1
        RETURN;

	INSERT INTO MATCH(IDAWAYTEAM, IDTOURNAMENTPHASE, IDSTADIUM, IDHOMETEAM, IDREFEREE, STARTDATETIME)
	SELECT I.IDAWAYTEAM, I.IDTOURNAMENTPHASE, I.IDSTADIUM, I.IDHOMETEAM, I.IDREFEREE, I.STARTDATETIME
    FROM INSERTED I JOIN REFEREE R ON R.IDPERSON = I.IDREFEREE
    WHERE I.IDAWAYTEAM <> R.IDCOUNTRY AND I.IDHOMETEAM <> R.IDCOUNTRY;

    DECLARE @AcceptedReferees INT; SET @AcceptedReferees = @@ROWCOUNT; 
    DECLARE @TotalReferees INT; SELECT @TotalReferees = COUNT(*) FROM INSERTED; 

	PRINT 'Number of records where the referee can referee the match is ' + CONVERT(VARCHAR, @AcceptedReferees) + ' from a total of ' + CONVERT(VARCHAR, @TotalReferees) + ' records';

	IF @AcceptedReferees < @TotalReferees
		PRINT 'There are ' +  CONVERT(VARCHAR, @TotalReferees - @AcceptedReferees) + ' referees who cannot referee the match. They will not be inserted.'
END;
GO

-- Update Trigger
CREATE OR ALTER TRIGGER UPDATE_REFEREE
ON MATCH
AFTER UPDATE
AS
BEGIN
	IF TRIGGER_NESTLEVEL() > 1
        RETURN;

    UPDATE MATCH
	SET IDAWAYTEAM = D.IDAWAYTEAM, IDTOURNAMENTPHASE = D.IDTOURNAMENTPHASE, IDSTADIUM = D.IDSTADIUM, IDHOMETEAM = D.IDHOMETEAM, IDREFEREE = D.IDREFEREE, STARTDATETIME = D.STARTDATETIME
    FROM DELETED D JOIN REFEREE R ON R.IDPERSON = D.IDREFEREE
    WHERE D.IDAWAYTEAM = R.IDCOUNTRY AND D.IDHOMETEAM = R.IDCOUNTRY;

    DECLARE @AcceptedReferees INT; SET @AcceptedReferees = @@ROWCOUNT; 
    DECLARE @TotalReferees INT; SELECT @TotalReferees = COUNT(*) FROM INSERTED; 

	PRINT 'Number of records where the referee can referee the match is ' + CONVERT(VARCHAR, @AcceptedReferees) + ' from a total of ' + CONVERT(VARCHAR, @TotalReferees) + ' records.';

	IF @AcceptedReferees < @TotalReferees
		PRINT 'There are ' +  CONVERT(VARCHAR, @TotalReferees - @AcceptedReferees) + ' referees who cannot referee the match. They will not be updated.'
END;
GO

/* 3. When a yellow card event is inserted, it must be verified if the player already received a yellow card in the same match. If that is the case, then a new red card event must be inserted with the same data. (INSERT) */

CREATE OR ALTER TRIGGER YELLOW_CARD
ON EVENTS
AFTER INSERT
AS
BEGIN 
	INSERT INTO EVENTS(IDSUMMONEDMAINPLAYER, IDSUMMONEDPLAYEROUT, MINUTE, MATCHPART, EVENTTYPE, CARDTYPE)
	SELECT I.IDSUMMONEDMAINPLAYER, I.IDSUMMONEDPLAYEROUT, I.MINUTE, I.MATCHPART, I.EVENTTYPE, 'Red'
	FROM INSERTED I
	WHERE I.EVENTTYPE = 'Card' AND I.CARDTYPE = 'Yellow' AND 2 = (SELECT COUNT(*) FROM EVENTS E WHERE E.EVENTTYPE = 'Card' AND E.CARDTYPE = 'Yellow' AND E.IDSUMMONEDMAINPLAYER = I.IDSUMMONEDMAINPLAYER);
				
	DECLARE @RedCards INT; SET @RedCards = @@ROWCOUNT;
		
	PRINT 'Number of records where the yellow card is converted to red is ' + CONVERT(VARCHAR,@RedCards);
END;
GO

/* 4. When a 'Goal' event is inserted, it must be verified if the player that scored the goal was on the field. For a player to be on the field, either:
• She was part of the starting 11 and did not leave (was not replaced and did not receive a red card);
• She was not part of the starting 11 but replaced another player and did not leave afterwards (was not replaced and did not receive a red card).
If the scorer was not on the field, then the record must not be inserted, and a message must be displayed. (INSERT) */

/* 5. When a 'Replacement' event is inserted, it must be verified:
• If the 'player out' was on the field;
• If the 'player in' was not on the field already and was on the bench, available to replace another player (to be available to replace a player means that the person is summoned, is not in the starting 11, did not go in yet and did not receive a red card);
• If the 'player in' and the 'player out' belong to the same team;
• If the 2 players are in the same match.
If any of these points is not verified, then the record must not be inserted, and a message must be displayed. (INSERT) */

-- These two exercises were done using the same trigger

CREATE OR ALTER TRIGGER GOAL_AND_REPLACEMENT
ON EVENTS 
INSTEAD OF INSERT
AS 
BEGIN
	INSERT INTO EVENTS(IDSUMMONEDMAINPLAYER, IDSUMMONEDPLAYEROUT, MINUTE, MATCHPART, EVENTTYPE, ISPENALTY, ISOWNGOAL, CARDTYPE)
	SELECT I.IDSUMMONEDMAINPLAYER, I.IDSUMMONEDPLAYEROUT, I.MINUTE, I.MATCHPART, I.EVENTTYPE, I.ISPENALTY, I.ISOWNGOAL, I.CARDTYPE
	FROM INSERTED I 
	JOIN SUMMONEDS S ON I.IDSUMMONEDMAINPLAYER = S.IDSUMMONED
	WHERE (I.EVENTTYPE = 'Goal' AND 
		((S.STARTING11 = 1 AND I.IDSUMMONEDMAINPLAYER NOT IN (SELECT IDSUMMONEDPLAYEROUT FROM EVENTS WHERE EVENTTYPE = 'Replacement') AND I.IDSUMMONEDMAINPLAYER NOT IN (SELECT IDSUMMONEDMAINPLAYER FROM EVENTS WHERE CARDTYPE = 'Red'))
		OR
		(S.STARTING11 = 0 AND I.IDSUMMONEDMAINPLAYER IN (SELECT IDSUMMONEDMAINPLAYER FROM EVENTS WHERE EVENTTYPE = 'Replacement') AND I.IDSUMMONEDMAINPLAYER NOT IN (SELECT IDSUMMONEDMAINPLAYER FROM EVENTS WHERE CARDTYPE = 'Red'))))
		OR (I.EVENTTYPE = 'Replacement' AND
		((I.IDSUMMONEDPLAYEROUT NOT IN (SELECT IDSUMMONEDMAINPLAYER FROM EVENTS WHERE EVENTTYPE = 'Replacement') AND I.IDSUMMONEDPLAYEROUT NOT IN (SELECT IDSUMMONEDMAINPLAYER FROM EVENTS WHERE CARDTYPE = 'Red'))
		AND
		(I.IDSUMMONEDMAINPLAYER IN (SELECT IDSUMMONED FROM SUMMONEDS WHERE S.STARTING11 = 0) AND I.IDSUMMONEDMAINPLAYER NOT IN (SELECT IDSUMMONEDMAINPLAYER FROM EVENTS WHERE EVENTTYPE = 'Substitution') AND I.IDSUMMONEDMAINPLAYER NOT IN (SELECT IDSUMMONEDMAINPLAYER FROM EVENTS WHERE CARDTYPE = 'Red'))
		AND
		(I.IDSUMMONEDMAINPLAYER IN (SELECT IDPERSON FROM PLAYER WHERE IDCOUNTRY = (SELECT IDCOUNTRY FROM PLAYER WHERE IDPERSON = I.IDSUMMONEDPLAYEROUT))
		AND
		(I.IDSUMMONEDMAINPLAYER IN (SELECT IDSUMMONED FROM SUMMONEDS WHERE IDMATCH = (SELECT IDMATCH FROM SUMMONEDS WHERE IDSUMMONED = I.IDSUMMONEDPLAYEROUT)))))) 
		OR I.EVENTTYPE = 'Card'
	
	DECLARE @ValidEvent INT; SET @ValidEvent = @@ROWCOUNT;
	DECLARE @TotalEvents INT; SELECT @TotalEvents = COUNT(*) FROM INSERTED; 

	PRINT 'Number of records where the event is successfully inserted is ' + CONVERT(VARCHAR,@ValidEvent);

	IF @ValidEvent < @TotalEvents
		PRINT 'There are ' +  CONVERT(VARCHAR, @TotalEvents - @ValidEvent) + ' events that cannot happen. They will not be inserted.'

END;
GO

