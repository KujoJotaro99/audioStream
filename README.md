# Audio Stream

A CDC FIFO audio streaming design from CSE 225 at UCSC. Audio from the Digilent I2S2 PMOD crosses between the I2S clock domain and the 12 MHz system domain through two asynchronous FIFOs and is played back out.

## Project Specifications

Target Device: Lattice iCE40 UP5K (iCEBreaker)

Logic Cells: 701 out of 5280 used (13%)

Block RAM: 6 out of 30 blocks used (20%)

Maximum Frequency: 49.54 to 53.70 MHz in the 12 MHz domain, 46.84 to 50.34 MHz in the 22.5 MHz domain, across 5 placement seeds

Clock Source: 12 MHz external oscillator, 22.5 MHz from the PLL

Standalone `fifo_async` (8 bit, 16 deep): 72 logic cells, 1 block RAM, 61.28 to 63.76 MHz on each clock

## Critical Path Analysis

In each FIFO the critical path ends at the Gray pointer register: the binary pointer increments, converts to Gray code, and is compared against the synchronized pointer from the other domain for the full or empty flag. About two thirds of the path is routing.

## Design Features

Asynchronous FIFO with Gray coded read and write pointers

Two flop synchronizers for each pointer crossing

Full and empty flags from Gray pointer comparison

Dual clock 1R1W block RAM with registered read

Valid/ready handshake on both sides of each FIFO

## Build

```
cd syn/icebreaker
make synth place
```
