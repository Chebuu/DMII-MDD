CREATE TEMPORARY TABLE heightweight AS

WITH ht AS (
    SELECT 
        cev.subject_id,
        avg(
            CASE
                WHEN cev.itemid IN (920, 1394, 4187, 3486, 226707)
                    AND cev.charttime > (pts.dob + INTERVAL '1 YEAR')
                    AND (cev.valuenum * 2.54) > 50
                    AND (cev.valuenum * 2.54) < 1000
                THEN mean(cev.valuenum)
                ELSE NULL
            END
        ) AS height
    FROM chartevents cev
    INNER JOIN patients pts
        ON cev.subject_id = pts.subject_id
            WHERE cev.valuenum IS NOT NULL
                AND cev.valuenum != 0
                AND COALESCE(cev.error, 0) = 0
                AND cev.itemid IN (920, 1394, 4187, 3486, 226707)
)

,wt AS (
    SELECT 
        subject_id,
        avg(
            CASE
                WHEN itemid IN ()
                THEN 
                    CASE
                        WHEN valueuom ILIKE ANY ( ARRAY [] )
                        THEN
                        WHEN valueuom ILIKE ANY ( ARRAY [] )
                        THEN
                ELSE NULL
            END AS wt
        ) AS wt  
    FROM chartevents
    WHERE item_id IN (

        920,	-- "Admit Ht"	"carevue"	"chartevents"
        1394,	-- "Height Inches"	"carevue"	"chartevents"
        226707,	-- "Height"	"metavision"	"chartevents"
        226730	-- "Height (cm)"	"metavision"	"chartevents"

        226512	"Admission Weight (Kg)"	"metavision"	"chartevents"
        226531	"Admission Weight (lbs.)"	"metavision"	"chartevents"
)


-- -- D_ITEMS
-- 762	"Admit Wt"	"carevue"	"chartevents"
-- -- -- ITEM_ID  |  LABEL         |  DBSOURCE                                             
-- -- -- 580    | | "carevue"    | | "Previous Weight"                                              
-- -- -- 581    | | "carevue"    | | "Previous WeightF"                                             
-- -- -- 4183   | | "carevue"    | | "Birthweight (kg)"                                             
-- -- -- 733    | | "carevue"    | | "Weight Change"                                                
-- -- -- 763    | | "carevue"    | | "Daily Weight"                                                 
-- -- -- 3580   | | "carevue"    | | "Present Weight  (kg)"                                         
-- -- -- 3581   | | "carevue"    | | "Present Weight  (lb)"                                         
-- -- -- 3582   | | "carevue"    | | "Present Weight  (oz)"                                         
-- -- -- 3583   | | "carevue"    | | "Previous Weight (kg)"                                         
-- -- -- 3692   | | "carevue"    | | "Weight Change  (gms)"                                         
-- -- -- 3693   | | "carevue"    | | "Weight Kg"                                                    
-- -- -- 3723   | | "carevue"    | | "Birth Weight    (kg)"                                         
-- -- -- 7000   | | "carevue"    | | "ideal body weight"                                            
-- -- -- 45271  | | "carevue"    | | "Chucks Pad Weight"                                            
-- -- -- 226846 | | "metavision" | | "Feeding Weight"                                               
-- -- -- 224639 | | "metavision" | | "Daily Weight"                                                 
-- -- -- 227854 | | "metavision" | | "Weight Bearing Status"                                        
-- -- -- 226512 | | "metavision" | | "Admission Weight (Kg)"                                        
-- -- -- 226531 | | "metavision" | | "Admission Weight (lbs.)"                                      
-- -- -- 225124 | | "metavision" | | "Unintentional weight loss >10 lbs."                           
-- -- -- 226740 | | "metavision" | | "APACHE II Diagnosistic weight factors - Medical"              
-- -- -- 226741 | | "metavision" | | "APACHE II Diagnosistic weight factors - Surgical emergency"   
-- -- -- 226742 | | "metavision" | | "APACHE II Diagnosistic weight factors - Surgical"
