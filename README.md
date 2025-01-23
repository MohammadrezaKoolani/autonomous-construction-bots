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

### Domain Model

#### Types
- `robot` - Represents the autonomous agent
- `location` - Points of interest on the site
- `configuration` - Manipulator positions
- `sensor` - Various sensors used for inspection

#### Predicates
```pddl
(at ?r - robot ?l - location)
(connected ?l1 - location ?l2 - location)
(inspected ?l - location ?c - configuration ?s - sensor)
```

#### Actions
```pddl
(:action move
    :parameters (?r - robot ?from - location ?to - location)
    :precondition (and (at ?r ?from) (connected ?from ?to))
    :effect (and (at ?r ?to) (not (at ?r ?from))))
```

# Problem Definition
## Initial State
```pddl
(at robot a)
(connected a b)
(connected b c)
(manipulator_retracted robot)
(sensors_off robot)
```

## Goal State
```pddl
(and (inspected b config lidar))
```

# Understanding the Domain and Problem Files

## Domain File
The `domain.pddl` file defines the general rules and capabilities of the robot system. It includes types, predicates, and actions that describe what the robot can do. This file consists of:

- **Types:** Specifies different entities involved (robots, locations, sensors).
- **Predicates:** Logical conditions describing relationships between entities.
- **Actions:** Define robot operations with parameters, preconditions, and effects.

## Problem File
The `problem.pddl` file specifies the initial and goal states for a particular scenario. It includes:

- **Objects:** Declares instances of the defined types.
- **Initial State:** Describes the starting conditions.
- **Goal State:** Specifies desired conditions to be achieved by the planner.

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

# Lists

- [x] Feature 1
- [x] Feature 2
- [ ] Feature 3

# Tables

| Feature  | Status |
|----------|--------|
| Navigation | ✅ |
| Inspection | ✅ |
| Reporting  | ✅ |

# Flowchart
<img src="https://github.com/MohammadrezaKoolani/autonomous-construction-bots/blob/main/AI2.png" width="300" height="600" />

# License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

# Acknowledgments

Special thanks to the AI4Ro2 course and Professor Fulvio Mastrogiovanni for guidance and materials.

