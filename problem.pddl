(define (problem monitor_site)
  (:domain construction_monitoring)

  (:objects
    robot - robot
    a b c d e f g h - location
    config - configuration
    camera lidar thermal - sensor
  )

  

  (:init
    (at robot a)
    (connected a b)
    (connected b c)
    (connected c d)
    (connected d e)
    (connected e f)
    (connected f g)
    (connected g h)
    (connected h a)

    (manipulator_retracted robot)
    (sensors_off robot)

    ;; Initial inspection counts
    (= (inspection_count a config camera) 0)
    (= (inspection_count b config lidar) 0)
    (= (inspection_count c config thermal) 0)
    (= (inspection_count d config camera) 0)
    (= (inspection_count e config lidar) 0)
    (= (inspection_count f config thermal) 0)
    (= (inspection_count g config camera) 0)
    (= (inspection_count h config lidar) 0)

    ;; Locations requiring additional inspections
    (additional_inspection_required a config camera)
    (additional_inspection_required c config thermal)
  )

(:goal
  (and
    ;; Location A: Camera for structural integrity (2 inspections)
    (inspection_done_twice a config camera)
    (structural_integrity_analyzed a config camera)
    (data_transferred robot a config camera)
    (data_formatted robot a config camera)
    (bim_updated robot a)
    (session_closed robot a) 

    ;; Location B: Lidar for worker activity
    (inspected b config lidar)
    (worker_activity_analyzed b config lidar)
    (data_processed_onboard robot b config lidar)
    (data_formatted robot b config lidar)
    (bim_updated robot b)
    (session_closed robot b) 

    ;; Location C: Thermal for temperature variation (2 inspections)
    (inspection_done_twice c config thermal)
    (temperature_variation_analyzed c config thermal)
    (data_processed_onboard robot c config thermal)
    (data_formatted robot c config thermal)
    (bim_updated robot c)
    (session_closed robot c) 

    ;; Location D: Camera for structural integrity
    (inspected d config camera)
    (structural_integrity_analyzed d config camera)
    (data_transferred robot d config camera)
    (data_formatted robot d config camera)
    (bim_updated robot d)
    (session_closed robot d) 

    ;; Location E: Lidar for worker activity
    (inspected e config lidar)
    (worker_activity_analyzed e config lidar)
    (data_processed_onboard robot e config lidar)
    (data_formatted robot e config lidar)
    (bim_updated robot e)
    (session_closed robot e)
    
    
    ;; Location F: Thermal for temperature variation
    (inspected f config thermal)
    (temperature_variation_analyzed f config thermal)
    (data_processed_onboard robot f config thermal)
    (data_formatted robot f config thermal)
    (bim_updated robot f)
    (session_closed robot f) 

    ;; Location G: Camera for structural integrity
    (inspected g config camera)
    (structural_integrity_analyzed g config camera)
    (data_transferred robot g config camera)
    (data_formatted robot g config camera)
    (bim_updated robot g)
    (session_closed robot g) 

    ;; Location H: Lidar for worker activity
    (inspected h config lidar)
    (worker_activity_analyzed h config lidar)
    (data_processed_onboard robot h config lidar)
    (data_formatted robot h config lidar)
    (bim_updated robot h)
    (session_closed robot h)  
    (sensors_off robot)
    (manipulator_retracted robot)

    ;; Move back to location A
    (at robot a)
  )
)
)
