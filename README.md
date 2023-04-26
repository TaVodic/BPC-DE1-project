# BPC-DE1-project

## Team members
* Martin Ťavoda
* Vojtěch Drtina
* Jan Gadas
* Slávek Kužela

## Theoretical description and explanation

Our project is focused on transmitting and receiving the MORSE code via IR signal between 2 FPGA borads. 

## Hardware description of demo application

In our external receiver we used IR-phototransistor, but we needed to overcome problem with slew rate, so we come with solution with Sziklai pair, where we connected 2 of these pairs in series. So our slew rate is somwhere in range of 50ns. 

In our external transmitter we used IR-led with LED diode and buzzer in paralel, for better visualision. We used npn transistor to sent signal via digital port.

## Software description

Put flowchats/state diagrams of your algorithm(s) and direct links to source/testbench files in `src` and `sim` folders. 

### Component(s) simulation

Write descriptive text and simulation screenshots of your components.

## Instructions

Write an instruction manual for your application, including photos or a link to a video.

## References

1. Put here the literature references you used.
2. ...

## Transmitter Circuit

![img](images/transmitter.png)

## Receiver Circuit


