# FPGA-Based Automatic Fuel Measurement and Pumping System

## 📌 Overview
This project implements an automatic fuel measurement and pumping system on FPGA.
The system measures fuel level using an ultrasonic sensor, processes data in real time,
and controls pumping and display based on FSM-based control logic.
All modules are implemented using Verilog HDL and verified through simulation.

## 🎯 Key Features
- Ultrasonic-based fuel level measurement
- FSM-based control for pumping operation
- Real-time fuel volume and cost calculation
- LCD1602 display via I2C interface
- LED and buzzer status indication
- Fully hardware-based implementation on FPGA

## 🛠 Hardware Platform
- FPGA Board: **DE10-Standard (Cyclone V)**
- Sensor: Ultrasonic sensor (HC-SR04)
- Display: LCD1602 (I2C) , Seven Segments 


## 🧠 System Architecture
The system consists of multiple functional modules including sensor data processing,
control logic, display handling, and timing generation. All modules are integrated
in a top-level Verilog design.

## 📂 Project Structure


## 🧩 Source Code Description
All Verilog source files are located in the `src/` directory.  
Each module is named according to its functionality for clarity and maintainability.

Main modules include:
- Sensor data processing and conversion
- Binary-to-BCD and ASCII conversion
- Clock divider and timing control
- LCD1602 and I2C communication
- FSM-based control logic


## 🧪 Simulation & Verification
- Testbench files are provided in the `sim/` directory
- Functional verification is performed using waveform-based simulation
- Key simulation results are included in the `images/` directory

## 🎓 Project Context
- Project type: FPGA / Embedded Systems Project
- Implementation language: **Verilog HDL**
- Focus areas: Digital design, FSM, hardware control, and verification

## 👤 Author
- Name: Viet Hoang
- GitHub: https://github.com/viethoang2k3fov

## 📎 Notes
This repository is intended for academic, learning, and portfolio demonstration purposes.
Build artifacts and auto-generated tool files are intentionally excluded.

