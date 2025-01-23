# autonomous-construction-bots

**Table of Contents**

- [Introduction](#introduction)
- [Features](#features)
- [Domain Model](#domain-model)
  - [Types](#types)
  - [Predicates](#predicates)
  - [Actions](#actions)
- [Problem Definition](#problem-definition)
  - [Initial State](#initial-state)
  - [Goal State](#goal-state)
- [Understanding the Domain and Problem Files](#understanding-the-domain-and-problem-files)
  - [Domain File](#domain-file)
  - [Problem File](#problem-file)
- [How to Run](#how-to-run)
- [Installation](#installation)
- [Lists](#lists)
- [Tables](#tables)
- [Flowchart](#flowchart)
- [License](#license)
- [Acknowledgments](#acknowledgments)

# Overview
## Introduction
This project models an autonomous robotic system for monitoring construction sites using Planning Domain Definition Language (PDDL). Robots navigate the site, conduct inspections, collect data, and report findings to ensure efficient progress tracking.

The system defines a domain where an autonomous robot can operate within a construction site environment consisting of multiple locations, configurations, and sensors. The robot can move between locations, extend and position its manipulator for inspections, activate sensors such as cameras, LiDAR, and thermal imaging, collect and process data, and finally report its findings to a central monitoring system.

The project focuses on defining PDDL-based planning tasks where the initial conditions include the robot's starting position, available connections between locations, and the initial state of sensors and manipulators. The goal is to achieve complete site inspection by navigating through all necessary areas and collecting required data while optimizing resource utilization.

The planning tasks are implemented using domain-independent planning techniques, ensuring flexibility and adaptability across different construction site layouts. The system's goal is to enhance construction site monitoring by automating routine inspection tasks, reducing human intervention, and improving data accuracy and efficiency.

## Features
- Autonomous navigation based on a topological map
- Inspection via cameras, LiDAR, and thermal sensors
- Onboard and off-site data processing
- Decision-making for repeated inspections
- Seamless reporting to BIM systems
  
# Understanding the Domain and Problem Files

In PDDL (Planning Domain Definition Language), planning tasks are divided into two main components: **Domain** and **Problem**. These files define the rules and objectives for the autonomous robotic system.

## Domain File (`domain.pddl`)
The domain file describes the **"what can be done"**, defining the available actions, objects, and conditions that govern the system's behavior. It contains:

### Types
Specifies the different categories of objects involved in the domain, such as robots, locations, sensors, and configurations.

### Predicates
Logical statements that describe relationships and states within the environment. They help track conditions such as:
```pddl
(at ?r - robot ?l - location)
(connected ?l1 - location ?l2 - location)
(inspected ?l - location ?c - configuration ?s - sensor)
```
These predicates define where the robot is, whether locations are connected, and whether inspections have been completed.

### Actions
Defines the possible operations the robot can perform, such as moving between locations, activating sensors, or reporting data. Each action consists of:

- **Parameters:** What objects the action affects.
- **Preconditions:** What must be true before the action can execute.
- **Effects:** How the world state changes after the action is performed.

Example action to move the robot:
```pddl
(:action move
    :parameters (?r - robot ?from - location ?to - location)
    :precondition (and (at ?r ?from) (connected ?from ?to))
    :effect (and (at ?r ?to) (not (at ?r ?from))))
```

## Problem File (`problem.pddl`)
The problem file defines **"what needs to be done"**, specifying the specific scenario within the domain that we want to solve. It contains:

### Objects
Declares the instances of different types defined in the domain, such as:
```pddl
(:objects
    robot - robot
    a b c d - location
    config - configuration
    camera lidar thermal - sensor
)
```

### Initial State
Describes the starting conditions of the environment, such as the robot's initial position, available connections, and sensor states. Example:
```pddl
(:init
    (at robot a)
    (connected a b)
    (connected b c)
    (sensors_off robot)
)
```

### Goal State
Specifies the desired conditions that must be met to solve the problem. The planner will generate a sequence of actions to achieve this goal. Example:
```pddl
(:goal
    (and (inspected b config lidar))
)
```

### How the Domain and Problem Work Together
- The **domain file** defines the general rules and capabilities of the robot system.
- The **problem file** sets a specific task within the defined environment.
- A planner, such as the **BFWS planner**, takes both files and generates an optimal sequence of actions (a plan) to transition from the initial state to the goal state.

# How to Run
To run the planner with the provided PDDL files using the Planning.Domains editor:

1. Go to the [Planning Domains editor](https://editor.planning.domains/#).
2. Create a new project and upload the `domain.pddl` (domain file) and `problem.pddl` (problem file).
3. Select the **BFWS** planner from the available planners.
4. Run the planner to solve the problem.

# Installation
```bash
git clone https://github.com/yourusername/construction-site-monitoring.git
cd construction-site-monitoring
./fast-downward.py domain.pddl problem.pddl --search "astar(blind())"
```

# Flowchart
<img src="https://github.com/MohammadrezaKoolani/autonomous-construction-bots/blob/main/AI2.png" width="300" height="600" />

# License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

# Acknowledgments
Special thanks to the AI4Ro2 course and Professor Fulvio Mastrogiovanni for guidance and materials.

