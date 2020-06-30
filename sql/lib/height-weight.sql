

WITH ht_stg AS (
    SELECT 
        cev.subject_id, 
        cev.icustay_id, 
        cev.charttime,
        CASE
            WHEN cev.itemid IN (920, 1394, 4187, 3486, 226707)
                THEN 
                    CASE
                        WHEN cev.charttime <= DATETIME_ADD(pts.dob, INTERVAL 1 YEAR)
                            AND (cev.valuenum * 2.54) < 80
                        THEN cev.valuenum * 2.54
                        WHEN cev.charttime >  DATETIME_ADD(pts.dob, INTERVAL 1 YEAR)
                            AND (cev.valuenum * 2.54) > 120
                            AND (cev.valuenum * 2.54) < 230
                        THEN cev.valuenum * 2.54
                        ELSE NULL 
                    END
                ELSE
                    CASE 
                        WHEN cev.charttime <= DATETIME_ADD(pts.dob, INTERVAL 1 YEAR)
                            AND cev.valuenum < 80
                        THEN cev.valuenum
                        WHEN cev.charttime >  DATETIME_ADD(pts.dob, INTERVAL 1 YEAR)
                            AND cev.valuenum > 120
                            AND cev.valuenum < 230
                        THEN cev.valuenum
                    ELSE NULL 
                END
            END 
        AS height
    FROM chartevents cev
    INNER JOIN paticu.nts pts
        ON cev.subject_id = pts.subject_id
            WHERE cev.valuenum IS NOT NULL
        AND cev.valuenum != 0
        AND COALESCE(cev.error, 0) = 0
        AND cev.itemid IN (920, 1394, 4187, 3486, 3485, 4188, 226707)
)

SELECT 
    icu.subject_id,
    icu.icustay_id,
    ROUND(CAST(wt.weight_first AS NUMERIC), 2) AS weight_first,
    ROUND(CAST(wt.weight_min AS NUMERIC), 2) AS weight_min,
    ROUND(CAST(wt.weight_max AS NUMERIC), 2) AS weight_max,
    ROUND(CAST(ht.height_first AS NUMERIC), 2) AS height_first,
    ROUND(CAST(ht.height_min AS NUMERIC), 2) AS height_min,
    ROUND(CAST(ht.height_max AS NUMERIC), 2) AS height_max
FROM icustays icu
LEFT JOIN (
    SELECT 
        icustay_id,
        MIN(CASE WHEN rn = 1 THEN weight ELSE NULL END) as weight_first,
        MIN(weight) AS weight_min,
        MAX(weight) AS weight_max
    FROM (
        SELECT
          icustay_id,
          weight,
          ROW_NUMBER() OVER (PARTITION BY icustay_id ORDER BY starttime) as rn
        FROM weightdurations
    ) wt_stg
    GROUP BY icustay_id
) wt
    ON icu.icustay_id = wt.icustay_id
LEFT JOIN (
    SELECT 
        icustay_id,
        MIN(CASE WHEN rn = 1 THEN height ELSE NULL END) as height_first,
        MIN(height) AS height_min,
        MAX(height) AS height_max
    FROM
    (
        SELECT
            icustay_id,
            height,
            ROW_NUMBER() OVER (PARTITION BY icustay_id ORDER BY charttime) as rn
        FROM ht_stg
    ) ht_stg2
    GROUP BY icustay_id
) ht
    ON icu.icustay_id = ht.icustay_id
ORDER BY icustay_id

; -- LANGUAGE plpgsql;