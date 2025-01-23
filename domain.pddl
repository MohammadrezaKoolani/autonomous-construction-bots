(define (domain construction_monitoring)
  (:requirements :strips :typing :fluents)


  (:types
    robot location configuration sensor analysis)




  (:predicates
    (at ?r - robot ?l - location)
    (connected ?l1 - location ?l2 - location)
    (stable ?r - robot)
    (inspected ?l - location ?c - configuration ?s - sensor)
    (manipulator_extended ?r - robot)
    (manipulator_retracted ?r - robot)
    (manipulator_positioned ?r - robot ?c - configuration)
    (sensors_on ?r - robot)
    (sensors_off ?r - robot)
    (data_collected ?r - robot ?l - location ?c - configuration ?s - sensor)
    (data_transferred ?r - robot ?l - location ?c - configuration ?s - sensor)
    (data_processed_onboard ?r - robot ?l - location ?c - configuration ?s - sensor)
    (structural_integrity_analyzed ?l - location ?c - configuration ?s - sensor)
    (worker_activity_analyzed ?l - location ?c - configuration ?s - sensor)
    (temperature_variation_analyzed ?l - location ?c - configuration ?s - sensor)
    (additional_inspection_required ?l - location ?c - configuration ?s - sensor)
    (initial_inspection_done ?l - location ?c - configuration ?s - sensor)
    (inspection_done_twice ?l - location ?c - configuration ?s - sensor)
    (analysis_processing_or_transfer_done ?l - location ?c - configuration ?s - sensor)
    (another_use_sensor_done ?l - location ?c - configuration ?s - sensor)
    (data_formatted ?r - robot ?l - location ?c - configuration ?s - sensor)
    (bim_updated ?r - robot ?l - location)
    (session_closed ?r - robot ?l - location)  
  )
  
  
  (:functions
    (inspection_count ?l - location ?c - configuration ?s - sensor))

  (:action move
    :parameters  (?r - robot ?from - location ?to - location)
    :precondition 
    (and (at ?r ?from) (connected ?from ?to) (manipulator_retracted ?r)
                       (or (and (inspected ?from config camera)
                                (structural_integrity_analyzed ?from config camera)
                                (data_transferred ?r ?from config camera))
                           (and (inspected ?from config lidar)
                                (worker_activity_analyzed ?from config lidar)
                                (data_processed_onboard ?r ?from config lidar))
                           (and (inspected ?from config thermal)
                                (temperature_variation_analyzed ?from config thermal)
                                (data_processed_onboard ?r ?from config thermal))))
   
    :effect (and (not (at ?r ?from)) (at ?r ?to) (not (stable ?r)))
  )

  (:action stabilize
    :parameters (?r - robot ?l - location)
    :precondition (at ?r ?l)
    :effect (stable ?r)
  )

  (:action extend_manipulator
    :parameters  (?r - robot ?l - location)
    :precondition (and (at ?r ?l) (stable ?r) (manipulator_retracted ?r))
    :effect  (and (manipulator_extended ?r) (not (manipulator_retracted ?r)))
  )

  (:action position_endefector
    :parameters   (?r - robot ?c - configuration)
    :precondition  (and (manipulator_extended ?r) (not (manipulator_positioned ?r ?c)))
    :effect  (manipulator_positioned ?r ?c)
  )

  (:action turn_on_sensors
    :parameters (?r - robot)
    :precondition (and (manipulator_extended ?r) (sensors_off ?r))
    :effect  (and (sensors_on ?r) (not (sensors_off ?r)))
  )

  (:action use_sensor_and_collect_data
    :parameters (?r - robot ?l - location ?c - configuration ?s - sensor)
    :precondition 
    (and (at ?r ?l) (manipulator_positioned ?r ?c) (sensors_on ?r))
    :effect  (and (data_collected ?r ?l ?c ?s)
                 (increase (inspection_count ?l ?c ?s) 1))
  )

  (:action turn_off_sensors
    :parameters  (?r - robot)
    :precondition  (sensors_on ?r)
    :effect   (and (sensors_off ?r) (not (sensors_on ?r)))
  )

  (:action retract_manipulator
    :parameters (?r - robot)
    :precondition  (and (manipulator_extended ?r) (sensors_off ?r))
    :effect   (and (manipulator_retracted ?r) (not (manipulator_extended ?r))
                 (forall (?c - configuration) (not (manipulator_positioned ?r ?c))))
  )

  (:action inspect
    :parameters (?r - robot ?l - location ?c - configuration ?s - sensor)
    :precondition 
    (and (data_collected ?r ?l ?c ?s) 
                       (or (and (data_transferred ?r ?l ?c ?s) (= ?s camera))
                           (and (data_processed_onboard ?r ?l ?c ?s) (or (= ?s lidar) (= ?s thermal))))
                       (manipulator_extended ?r))
    :effect  (inspected ?l ?c ?s)
  )

  (:action analyze_structural_integrity
    :parameters (?r - robot ?l - location ?c - configuration ?s - sensor)
    :precondition (data_collected ?r ?l ?c ?s)
    :effect  (structural_integrity_analyzed ?l ?c ?s)
  )

  (:action transfer_raw_data
    :parameters (?r - robot ?l - location ?c - configuration ?s - sensor)
    :precondition (structural_integrity_analyzed ?l ?c ?s)
    :effect  (data_transferred ?r ?l ?c ?s)
  )

  (:action analyze_worker_activity
    :parameters  (?r - robot ?l - location ?c - configuration ?s - sensor)
    :precondition (data_collected ?r ?l ?c ?s)
    :effect  (worker_activity_analyzed ?l ?c ?s)
  )

  (:action process_worker_activity_onboard
    :parameters  (?r - robot ?l - location ?c - configuration ?s - sensor)
    :precondition (worker_activity_analyzed ?l ?c ?s)
    :effect  (data_processed_onboard ?r ?l ?c ?s)
  )

  (:action analyze_temperature_variation
    :parameters (?r - robot ?l - location ?c - configuration ?s - sensor)
    :precondition (data_collected ?r ?l ?c ?s)
    :effect  (temperature_variation_analyzed ?l ?c ?s)
  )

  (:action process_temperature_variation_onboard
    :parameters  (?r - robot ?l - location ?c - configuration ?s - sensor)
    :precondition (temperature_variation_analyzed ?l ?c ?s)
    :effect  (data_processed_onboard ?r ?l ?c ?s)
  )

  (:action another_inspection_required 
  
    :parameters (?r - robot ?l - location ?c - configuration ?s - sensor)
   
    :precondition 
    (and (inspected ?l ?c ?s)
                       (or (and (structural_integrity_analyzed ?l ?c ?s)
                                (data_transferred ?r ?l ?c ?s))
                           (and (worker_activity_analyzed ?l ?c ?s)
                                (data_processed_onboard ?r ?l ?c ?s))
                           (and (temperature_variation_analyzed ?l ?c ?s)
                                (data_processed_onboard ?r ?l ?c ?s))))
    :effect 
    (and (initial_inspection_done ?l ?c ?s)
                 (not (another_use_sensor_done ?l ?c ?s))))



  (:action collect_more_data
    :parameters 
    (?r - robot ?l - location ?c - configuration ?s - sensor)
    :precondition (initial_inspection_done ?l ?c ?s)
    :effect (another_use_sensor_done ?l ?c ?s))

  (:action analyze_and_process_or_transfer_data
    :parameters (?r - robot ?l - location ?c - configuration ?s - sensor)
    :precondition 
    (and (initial_inspection_done ?l ?c ?s)
                       (another_use_sensor_done ?l ?c ?s))
    :effect   (analysis_processing_or_transfer_done ?l ?c ?s))

  (:action second_inspection_done
    :parameters (?r - robot ?l - location ?c - configuration ?s - sensor)
    :precondition 
    (and (initial_inspection_done ?l ?c ?s)
                       (inspected ?l ?c ?s)
                       (analysis_processing_or_transfer_done ?l ?c ?s))
    :effect  (inspection_done_twice ?l ?c ?s))

  (:action format_data_and_analyses
    :parameters  (?r - robot ?l - location ?c - configuration ?s - sensor)
    :precondition (and (at ?r ?l) (or (inspected ?l ?c ?s) (inspection_done_twice ?l ?c ?s)))
    :effect  (data_formatted ?r ?l ?c ?s)
  )

  (:action update_bim
    :parameters  (?r - robot ?l - location ?c - configuration ?s - sensor)
    :precondition (data_formatted ?r ?l ?c ?s)
    :effect  (bim_updated ?r ?l))
    
  (:action close_session
    :parameters (?r - robot ?l - location)
    :precondition (and (at ?r ?l) (bim_updated ?r ?l))
    :effect (session_closed ?r ?l)
  )

)

