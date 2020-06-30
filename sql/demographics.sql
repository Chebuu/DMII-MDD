-- DROP MATERIALIZED IF EXISTS demographics CASCADE;
-- CREATE MATERIALIZED demographics AS

-- WITH admit_ht AS (
--     SELECT 
--         subject_id,
--         hadm_id,
--         coalesce(value) AS admit_ht,
--     FROM chartevents
--     WHERE item_id IN (

--         920,	-- "Admit Ht"	"carevue"	"chartevents"
--         1394,	-- "Height Inches"	"carevue"	"chartevents"
--         226707,	-- "Height"	"metavision"	"chartevents"
--         226730	-- "Height (cm)"	"metavision"	"chartevents"

--         226512	"Admission Weight (Kg)"	"metavision"	"chartevents"
-- 226531	"Admission Weight (lbs.)"	"metavision"	"chartevents"
--     )
-- )

-- wtkg AS (

-- )

-- bmi AS (

-- )

-- age AS (

-- )


-- SELECT 
--     adm.subject_id,
--     adm.hadm_id,
--     adm.insurance,
--     adm.language,
--     adm.religion,
--     adm.marital_status,
--     adm.ethnicity,
--     adm.diagnosis
-- FROM admissions adm
-- LEFT JOIN 

-- -- LANGUAGE plpgsql;

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


-- -- Male
-- -- non-Hispanic black
-- -- Hispanic
-- -- Asian
-- -- Native
-- -- Other
-- -- Age25to29
-- -- Age30to34
-- -- Age35to39
-- -- Age40to44
-- -- Age45to49
-- -- Age50to54
-- -- Age55to59
-- -- Age60to64
-- -- Age65to69
-- -- Age70to74
-- -- Age75to79
-- -- Age 80 or older
-- -- Veteran
-- -- BMI>=30
-- -- Exercise
-- -- Daily smoker
-- -- Occasional smoker
-- -- Former smoker
-- -- Divorced
-- -- Widowed
-- -- Separated
-- -- Never marricu.d
-- -- Member of an Unmarricu.d couple 
-- -- Did not graduate from high school 
-- -- Graduated high school
-- -- Some college