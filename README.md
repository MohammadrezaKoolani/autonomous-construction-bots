# autonomous-construction-bots

### Features

- Autonomous robots for construction site monitoring
- Implements navigation, inspection, data collection, processing, decision-making, and reporting
- Fully functional PDDL domain and problem definitions
- Supports real-time updates to a Building Information Monitoring (BIM) system
- Compatible with PDDL planners like Fast Downward and Metric-FF
- Modular and extensible for future improvements

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
- [How to Run](#how-to-run)
- [Installation](#installation)
- [Lists](#lists)
- [Tables](#tables)
- [Flowchart](#flowchart)
- [License](#license)
- [Acknowledgments](#acknowledgments)

# Overview
## Introduction
This project models an autonomous robotic system for monitoring construction sites using **Planning Domain Definition Language (PDDL)**. Robots navigate the site, conduct inspections, collect data, and report findings to ensure efficient progress tracking.

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

```flow
st=>start: Start
op=>operation: Inspect site
cond=>condition: Inspection complete?
e=>end: Report results

st->op->cond
cond(yes)->e
cond(no)->op
```

# License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

# Acknowledgments

Special thanks to the AI4Ro2 course and Professor Fulvio Mastrogiovanni for guidance and materials.

