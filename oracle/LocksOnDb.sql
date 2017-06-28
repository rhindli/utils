SELECT O.OBJECT_NAME,
  S.SID,
  S.SERIAL#,
  P.SPID,
  S.PROGRAM,
  SQ.SQL_FULLTEXT,
  S.LOGON_TIME
FROM V$LOCKED_OBJECT L,
  DBA_OBJECTS O,
  V$SESSION S,
  V$PROCESS P,
  V$SQL SQ
WHERE L.OBJECT_ID = O.OBJECT_ID
AND L.SESSION_ID  = S.SID
AND S.PADDR       = P.ADDR
AND S.SQL_ADDRESS = SQ.ADDRESS;


SELECT s1.username || '@' || s1.machine
    || ' ( SID=' || s1.sid || ' )  is blocking '
    || s2.username || '@' || s2.machine || ' ( SID=' || s2.sid || ' ) ' AS blocking_status
    FROM v$lock l1, v$session s1, v$lock l2, v$session s2
    WHERE s1.sid=l1.sid AND s2.sid=l2.sid
    AND l1.BLOCK=1 AND l2.request > 0
    AND l1.id1 = l2.id1
    AND l1.id2 = l2.id2;
    
    

