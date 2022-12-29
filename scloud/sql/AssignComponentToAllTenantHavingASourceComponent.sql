/*
 * Assign target component to all tenants that have source component.
 * This script requires target component to haves isRequireTenantLink='Y'. 
 */
DO $tasksql$
DECLARE
	p_TargetEntityType varchar := 'SROR';
	p_SourceEntityType varchar := 'SRPD';
	v_AD_Sequence_ID bigint;
	v_AD_ClientComponent_ID bigint;
	v_CurrentNext bigint;
	v_Count bigint := 0;
	v_SourceEntityTypeRequireTenantLink char := 'Y';
	r Record;
BEGIN
	
	IF NOT EXISTS (SELECT * FROM AD_EntityType WHERE EntityType = p_TargetEntityType AND IsRequireTenantLink = 'Y') THEN
		RETURN;
	END IF;

	IF NOT EXISTS (SELECT * FROM AD_EntityType WHERE EntityType = p_TargetEntityType) THEN
		RETURN;
	END IF;

	SELECT IsRequireTenantLink INTO v_SourceEntityTypeRequireTenantLink
	FROM AD_EntityType 
	WHERE EntityType = p_SourceEntityType;

	SELECT AD_Sequence_ID INTO v_AD_Sequence_ID
  FROM AD_Sequence
  WHERE IsTableID = 'Y' 
 		AND Name = 'AD_ClientComponent';

 	/*
 	 * Update sequence (if necessary) with the max sequence CurrentNext and max AD_ClientComponent_ID from table.
 	 * This is necessary in case some inserts were previosuly made via the scripts ran before this script.
 	 */
 	UPDATE AD_Sequence 
 	SET CurrentNext = (SELECT GREATEST(max(AD_ClientComponent_ID) + 1, CurrentNext) FROM AD_ClientComponent WHERE AD_ClientComponent_ID < 2140000000) 
 	WHERE AD_Sequence_ID = v_AD_Sequence_ID;

	SELECT CurrentNext INTO v_CurrentNext 
	FROM AD_Sequence
	WHERE AD_Sequence_ID = v_AD_Sequence_ID FOR UPDATE;

 	FOR r IN (
 		WITH tenantsWithSourceComponent AS (
 			SELECT cc.AD_ClientInclude_ID AS AD_Client_ID 
			FROM AD_ClientComponent cc 
			WHERE cc.EntityTypeValue = p_SourceEntityType 
				AND cc.IsActive = 'Y'
				AND v_SourceEntityTypeRequireTenantLink = 'Y'
			UNION ALL
			SELECT AD_Client_ID
			FROM AD_Client
			WHERE v_SourceEntityTypeRequireTenantLink = 'N'
 		)
 		SELECT c.AD_Client_ID, c.QuotaManagementTenant_ID
 		FROM AD_Client c
 		JOIN tenantsWithSourceComponent t ON t.AD_Client_ID = c.AD_Client_ID
 		WHERE c.IsActive = 'Y'
 			AND NOT EXISTS (SELECT * FROM AD_ClientComponent cc WHERE cc.AD_ClientInclude_ID = c.AD_Client_ID AND cc.EntityTypeValue = p_TargetEntityType)
 		)
 	LOOP

		INSERT INTO AD_ClientComponent (AD_ClientComponent_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,EntityTypeValue,IsActive,Updated,UpdatedBy,AD_ClientInclude_ID) VALUES
		(v_currentnext + v_Count, COALESCE(r.QuotaManagementTenant_ID,0), 0,
			statement_timestamp()::timestamp, 0, p_TargetEntityType, 'Y',
			statement_timestamp()::timestamp, 0, r.AD_Client_ID);
	
		v_Count := v_Count + 1;
 	END LOOP;
 	
	UPDATE AD_Sequence SET CurrentNext = v_CurrentNext + v_Count WHERE ad_sequence_id = v_AD_Sequence_ID;

END $tasksql$;


SELECT * FROM ad_clientcomponent WHERE entitytypevalue = 'SEMS';
SELECT * FROM ad_clientcomponent WHERE entitytypevalue = 'SROR';

SELECT * FROM AD_EntityType WHERE EntityType = 'SEMS' AND IsRequireTenantLink = 'Y';

SELECT * FROM AD_EntityType WHERE IsRequireTenantLink = 'N';

SELECT c.AD_Client_ID, c.QuotaManagementTenant_ID
 		FROM AD_Client c
 		WHERE c.IsActive = 'Y'
 			AND EXISTS (SELECT * FROM AD_ClientComponent cc WHERE cc.AD_ClientInclude_ID = c.AD_Client_ID AND cc.EntityTypeValue = 'SRPD' AND cc.IsActive = 'Y')
 			AND NOT EXISTS (SELECT * FROM AD_ClientComponent cc WHERE cc.AD_ClientInclude_ID = c.AD_Client_ID AND cc.EntityTypeValue = 'SROR')

