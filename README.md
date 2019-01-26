# leonardo_ethernet_case

this repository contains information on how to inefficiently modify an existing case design

            +-----------------+
           /                 /|   
          /                 / |
         /                 /  |
        /                 /   +
       /                 /   /
      /                 /   /       
     +-----------------+   /        case for electronic pcb devices,
     |                 |  /         e.g raspberry pi, arduino and alike
     |                 | /
     |                 |/
     +-----------------+


how to reproduce:
- get inspired e.g. https://learn.adafruit.com/laser-cut-enclosure-design/overview
- download the 2D geometry file as svg (use FreeCAD or InkScape if it is in a differen format)
- open svg file with InkScape (change unit to mm, add a sample rectangle with extension 10 mm x 10 mm)
- save with relative commands, i.e only small letters in path segments.
  E.g. "M 100 50" is move to absolute position (100,50) whereas "m 100 50" is a relative move 100 units
  to the left and 50 units downwards
- ensure that all transformations (translate, matrix) are removed in the saved svg file
- identify which horizontal (h) and vertical (v) lines have to be modified to make the case fit your device
- write a script (perl, pyhton) to manipulate the svg file
  
 
remarks:
- before manipulation the svg file directly i tried to use openscad to recreate the snipping mechanism
  presented in the pi box case study (see adafruit link above). it worked but was cumbersome.
- before using the laser cuter you can just use your laser printer to verify if 2D extensions of
  the modified design fit your device
- before cutting check in the laser software after importing the svg file that the dimension of the sample
  rectangle is interpreted as 10 mm x 100 mm
- before cutting your final material, e.g. plexiglas, you can use wood with the same thickness
- to determ the necessary openings (usb connection, power, ethernet jack, etc.) in the case you can use a
  sliding caliper (perhaps a digital available arround 20 EUR). you can check the positions of the openings
  printing the 2D design on your laser printer
- in case the pcb downside is not flat you can cut appropriate spacers
- if you need to engrace logos or text, engrave it mirror inverted in an extra cuting run on the reverse side

attachments:
- raspberry_pi.svg - orginal file
- modify.pl - script to modify the original file
- leonardo_with_ethernet_shield.svg - modified file
- leonardo_with_ethernet_shield.jpg - picture of the case


