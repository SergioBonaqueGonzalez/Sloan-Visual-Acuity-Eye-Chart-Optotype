%{ 
This script calculates a custom full-of-letters decimal Sloan eye-Chart. 
Calculations are based on an exact representation of a theoretical Sloan letter.
Inputs of the script are:
                       - distance from the eye to the eye-chart (meters).
                       - pixel size of the display (meters).
                       - Size of the display (pixels)
                       - Intended range of visual acuities to be displayed.
                       - Maximum lines of visual acuity to be displayed.
The output is a snellen visual acuity chart scaled to the defined distance
and pixel size. 

It was written by Sergio Bonaque-Gonzalez. November 2017.
sergio.bonaque@um.es
https://www.linkedin.com/in/sergiobonaque/
%}

%INPUTS
Distance=1; %Distance from the eye to the display in meters
PixelSize=100*1e-6; %pixel size in meters
Dimensions=[2500 2500]; %Size in pixels of the display area
range=0.5:0.1:1.8; %Range of decimal values to be plotted
MaxLines=7; %Maximum lines of visual acuity to be displayed


%{ 
The precise distance at which acuity is measured is not important as long 
as it is sufficiently far away and the size of the optotype on the retina 
is the same. That size is specified as a visual angle, which is the angle, 
at the eye, under which the optotype appears. For 6/6 = 1.0 acuity, the size 
of a letter on the Sloan chart or Landolt C chart is a visual angle of 5 
arc minutes (1 arc min = 1/60 of a degree). By the design of a typical 
optotype (like a Snellen E or a Landolt C), the critical gap that needs to 
be resolved is 1/5 this value, i.e., 1 arc min. The latter is the value 
used in the international definition of visual acuity:

Acuity = 1/ gap size [arc min]

Acuity is a measure of visual performance and does not relate to the 
eyeglass prescription required to correct vision.
%}
GapSize=1./range; %Critical gap Size in arc min
GapSize=GapSize*5/60; %Gap of the whole letter in degrees
GapSizeRadians=GapSize*pi/180; %Gap size of the letter in radians
SemiHeight=tan(GapSizeRadians/2)*Distance; %SemiHeight of the letter in meters
Height=SemiHeight*2; %Height of the letter in meters


%The problem is that a Sloan letter will be perfectly represented as
%theoretically defined if its size is a multiply of 5. Additionally, as pixels is a natural number, visual acuity has to be re-calculated
pixels=round( Height/PixelSize / 5 ) * 5;
pixels=pixels(1):-5:pixels(end);


%A maximum of "MaxLines" lines will be displayed
i=0;
while length(pixels) > MaxLines
    i=i+1;
    pixels=pixels(1):-5*i:pixels(end);
end


%As there is discrete pixels, the real visual acuity to be displayed has to
%be re-calculated
TrueHeight=pixels*PixelSize;
TrueSemiHeight=TrueHeight/2;
TrueGapSizeRadians=2*atan(TrueSemiHeight/Distance);
TrueGapSize=TrueGapSizeRadians*180/pi;
TrueGapSize=TrueGapSize*60/5;
Truerange=1./TrueGapSize;

[Truerange,uniquevalues]=unique(Truerange); %Remove repeated values
Truerange=round(Truerange*100)/100; %Round to 2 decimals numbers
pixels=pixels(uniquevalues);


%DRAW THE OPTOTYPE
Minimum=find(pixels<5,1); %Advise if the desired maximum VA cannot be plotted.
if isempty(Minimum)~=1
    fprintf('The maximum visual acuity that can be plotted with this configuration is %1.1f \n',Truerange(Minimum-1))
    Truerange(Minimum:end)=[];
    pixels(Minimum:end)=[];
end
g=sprintf('%1.2f ', Truerange);
fprintf('The real visual acuities displayed are: %s\n',g');


%Now the display area is divided into equi-distanced areas for drawing
%purposes
PixelsPerLine=Dimensions(1)/length(Truerange);
if any(pixels>PixelsPerLine)~=0
    error('Display area it too small for this configuration. Please increase minimum visual acuity or increase the screen size')
end
FontSize=pixels(1);
DimensionsFinal=Dimensions(2)-FontSize*3-10; %Reserve some space for titles
LetterPerColumn=floor(DimensionsFinal./(2*pixels));
Screen=ones(Dimensions)*255;
position2=[1,1];
position=zeros(length(Truerange),2);

for i=1:length(Truerange)
    for j=0:LetterPerColumn(i)-1
        VerticalWhiteSpace=floor(PixelsPerLine-pixels(i)/2);
        letter=generateLetter(pixels(i)); %Function that generates a random letter with the proper size
        letter(letter<255)=0;
        Screen(i*VerticalWhiteSpace:i*VerticalWhiteSpace+pixels(i)-1,pixels(i)+(j*pixels(i)*2):2*pixels(i)+(j*pixels(i)*2)-1)=letter;
        position(i,2) =floor(i*VerticalWhiteSpace+(pixels(i)/2))-FontSize/1.3; 
        position(i,1)=Dimensions(2)-FontSize*3;
    end
end
for i=1:length(Truerange)
    text_str{i} = [num2str(Truerange(i))];
end
text2='VISUAL ACUITY TEST. sergiob@wooptix.com';
Screen=insertText(Screen,position,text_str,'FontSize',FontSize,'BoxColor','green','BoxOpacity',1,'TextColor','black');
Screen=insertText(Screen,position2,text2,'FontSize',floor(FontSize/1.5),'BoxColor','yellow','BoxOpacity',1,'TextColor','black');

figure
imshow(Screen,[])




    