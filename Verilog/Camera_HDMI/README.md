# Camera OV2640 to HDMI
- [Camera OV2640 to HDMI](#camera-ov2640-to-hdmi)
  - [Objective](#objective)
  - [Specifications](#specifications)
  - [Block diagram](#block-diagram)


## Objective
This project will read data image from camera OV2640, then transfering it to monitor through HDMI port. The video image will be processed by bilinear or nearest neighbor interpolaration algorithm. The resolution will be fixed at 800x600 pixel (SVGA).
## Specifications
1. **Inputs**:
   - External input clock: 27MHz
   - Reset: active low
2. **Output**:
   - Resolution: 800x600 @ 60Hz
   - Pixel clock: 39.79MHz
   - SCCB clock: 400kHz

|           |Active<br>video|Front<br>porch |Syn<br>pulse   |Back<br>porch  |
|-          |-              |-              |-              |-              |
|Horizontal |800            |40             |128            |88             |
|Vertical   |600            |1              |4              |23             |

3. **Camera parameters**:
   - Bayer filter type: BGGR
   - Analog amplifier gain (AGC): Auto
   - White balance (AWB): Auto
   - Window size: 800x600
   - Output resolution mode: SVGA mode
   - Output frame rate: 30Hz
   - Output data bus width: 10-bit

## Block diagram
![Camera-HDMI-diagram](https://github.com/GSXAM/LearningFPGA/blob/master/images/camera-hdmi-diagram.svg)