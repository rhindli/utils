BEGIN
  FOR r IN (SELECT OBJECT_TYPE, OBJECT_NAME FROM sys.user_objects
    WHERE OBJECT_TYPE IN ('VIEW', 'FUNCTION') ) LOOP
  BEGIN
    EXECUTE immediate 'ALTER ' || r.OBJECT_TYPE || ' ' || r.OBJECT_NAME || ' compile';
  EXCEPTION WHEN OTHERS THEN
    DBMS_Output.put_line('Failed to compile ' || r.OBJECT_TYPE || ' ' || r.OBJECT_NAME);
  END;
  END LOOP;
END;


--Check What objects depend on a specified
select * from USER_DEPENDENCIES where Upper(referenced_NAME) = '<specified object name>'