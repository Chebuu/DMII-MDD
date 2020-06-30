DROP MATERIALIZED VIEW IF EXISTS study_population CASCADE;
CREATE MATERIALIZED VIEW study_population AS

WITH dxdmii AS (
    -- DM type II with or without complication
    SELECT DISTINCT ON (subject_id) 
		subject_id,
		1 AS DMII,
		icd9_code AS dm_icd9
    FROM diagnoses_icd
    WHERE icd9_code LIKE ANY ( ARRAY [ '250%1', '250%3' ] )
)

,dxmdd AS (
    SELECT DISTINCT ON (subject_id) 
		subject_id,
		1 AS MDD,
		icd9_code AS dd_icd9 
    FROM diagnoses_icd
    WHERE icd9_code ILIKE ANY( ARRAY [
        '2962%', -- Major depressive disorder, single episode
        '2963%'  -- Major depressive disorder, recurrent episode
        -- '29682'  -- Atypical depressive disorder
    ])
)

SELECT 
    pts.subject_id,
    pts.gender,
    pts.dob,
    pts.dod,
    pts.expire_flag,
	dm.dm_icd9,
	dm.dmii,
	dd.dd_icd9,
	dd.mdd
FROM patients pts
LEFT JOIN dxdmii dm
    ON pts.subject_id = dm.subject_id
LEFT JOIN dxmdd dd
    ON pts.subject_id = dd.subject_id
LEFT JOIN icustays icu
    ON icu.subject_id = pts.subject_id
GROUP BY
	pts.subject_id,
    pts.gender,
    pts.dob,
    pts.dod,
    pts.expire_flag,
	dm.dm_icd9,
	dd.dd_icd9,
    dm.dmii,
	dd.mdd

; -- LANGUAGE plpgsql;
