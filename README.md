# BPC-DE1-project

## Team members
* Martin Ťavoda
* Vojtěch Drtina
* Jan Gadas
* Slávek Kužela

## Theoretical description and explanation

Our project is focused on transmitting and receiving letters using MORSE code via IR signal between 2 FPGA borads. 

## Hardware description of demo application

### Transmitter

In our external transmitter we used IR-LED with LED diode and buzzer in paralel, for better visualision. We used npn transistor (BC337) to amplify signal from digital PMOD port.

### Receiver

In our external receiver we used IR-phototransistor, but we needed to overcome problem with slow slew rate, so we come with solution with Sziklai pair, where we connected 2 of these pairs in series. So our slew rate has improved a lot. For example ramp of rising edge lasts 50ns. 

## Software description

Put flowchats/state diagrams of your algorithm(s) and direct links to source/testbench files in `src` and `sim` folders. 

### Component(s) simulation

Write descriptive text and simulation screenshots of your components.

## Instructions

Write an instruction manual for your application, including photos or a link to a video.
[Working demonstration video](https://youtu.be/yEXXWRQE4EQ)

## References

1. Put here the literature references you used.
2. ...

## Transmitter Circuit

![img1](images/Transmitter_block.png)
![img2](images/Transmitter_schematic.png)

## Receiver Circuit

![img1](images/Receiver_block.png)
![img2](images/Receiver_schematic.png)


