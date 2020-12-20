%   i
clc;
Fo = input('Please enter the sampling frequency of signal :') ;%take from user sampling frequency
while 1     %check for validity of the sampling frequency 
    if Fo >0
        break
    end
    Fo = input('Please enter the sampling frequency of signal > 0 :') ;
end 
S = input( 'Please enter the start point :');%take from user the start point
E = input('Please enter the End piont :') ;%take from user the end point
while 1   %check for validity of the end and start point (end point must be bigger than end point )
    if E > S
        break
    end
    E = input('Please enter the End piont > start point :') ;
end 
Max_Nb = (1/3)*Fo *(E - S) -1 ;%Calculate the maximum number of break points 
Nb = input ('Please enter the number of break points :');%take from user the number of break point 
while 1   %check for validity of the number of break points 
    if (Max_Nb > Nb )&&(mod(Nb,1) == 0)
        break
    end
    if Max_Nb < Nb %Check if the number of break point less than or equal the maximum number of break point that allowed
        fprintf('the maximum number of break points =%i',Max_Nb);%print to user the maximum number of break points 
        Nb = input('Please enter the number of break points < the maximum number of break points :') ;
    else  % That will appear when user enter nonintiger number of break points  
        fprintf('The Number of break points must be intiger ')
         Nb = input('Please enter the intiger number of break points  :') ;
    end 
end
disp('the position of break points should be bigger than start point and smaller than End point');
a = zeros(1,Nb+2);%definite matrix of statrt point ,end point and break points 
a(1,1)= S ;
a(1,Nb+2) =E ;
for i=2 : Nb+1 %take the values of break point and check its validity  
    fprintf('Please enter the position of break points number %i :', (i-1));%take from user the position of each break point
    a (1,i)=input(''); 
    while 1 %check the vilidity of the positions of break points     
        if (E > a(1,i))&&(a(1,i)> a(1,i-1)) 
            break
        end       
        if a(1,i)< S %that comment will appearto user when user enter break point less than start point         
            fprintf('Please enter the position of break points number %i  > Start point :', (i-1));
            a (1,i)=input('');
        end        
        if a(1,i)> E %that comment will appear to user when user enter break point more than end points 
            fprintf('Please enter the position of break points number %i   < End point :', (i-1));
            a (1,i)=input('');
        end         
        if a(1,i)< a(1,i-1)  %that comment will appear to user  when user enter break point less than the last break point
            fprintf('Please enter the position of break points number %i  > the last break point :', (i-1));
            a (1,i)=input('');            
        end     
    end
end
N_samples = (E -S )*Fo ;%calculate the number of samples 
t =linspace(S,E,N_samples);%define the whole period of all the functions
%%%%%%%%%%%%%%%%%% ii
y=zeros(1,N_samples);%define all regions by zeroes 
for i=1:Nb+1 %At this loop  , user will choose the type of the functions and its variables for each region 
    disp('DC signal "Y = C "enter 1');
    disp('Ramp signal "Y = Slope *t +intercept" enter 2');
    disp('General order polynomial"Y = A*t.^n +b" enter 3');
    disp('Exponential signal"Y = A*e.^(n*t)" enter 4');
    disp('Sinusoidal signal"Y = A*cos(2*pi*f*t+ phase shift )" enter 5');
    %{
    fprintf('DC signal "Y = C "enter 1\nRamp signal "Y = Slope *t +intercept" enter 2\n
    General order polynomial"Y = A*t.^n +b" enter 3\n Exponential signal"Y = A*e.^(n*t)" enter 4 \n
    Sinusoidal signal"Y = A*cos(2*pi*f*t+phase shift " enter 5')
    %}   
    signal = input('please enter the number for the signal at this region :');
    switch(signal)
   case 1 %When user choose DC signal
      T = (a(1,i+1)-a(1,i))*Fo ;%Define the region that we need to draw      
      Amplitude= input('enter the Amplitude "C":');%Take amplitude from the user
      x=zeros(1,T) + Amplitude ;%Create our dc function at this region  
    
   case 2  %When user choose Ramp signal 
      T =linspace(a(1,i),a(1,i+1),(a(1,i+1)-a(1,i))*Fo);  %Define the region that we need to draw  
      slope = input('enter the slope:'); %Take the slope from user      
      intercept = input('enter the intercept:');%Take the intercept from the user
      x =  slope*T + intercept ;%the shape of our function 
   case 3   %When user choose General order polynomial signal    
      Amplitude =  input('enter the Amplitude "A":');  %The same as case 1 and 2   
      power = input('enter the power "n":');      
      intercept =input('enter the intercept "b":');
      T =linspace(a(1,i),a(1,i+1),(a(1,i+1)-a(1,i))*Fo);
      x= Amplitude*(T.^(power)) + intercept ;
   case 4 %When user choose Exponential signal
       T =linspace(a(1,i),a(1,i+1),(a(1,i+1)-a(1,i))*Fo);%The same as case 1,2 and 3
      Amplitude =  input('enter the Amplitude "A":');   
      exponent = input('enter the exponent "n":');
      x = Amplitude* exp(exponent*T);
   case 5 %When user choose Sinusoidal signal
       T =linspace(a(1,i),a(1,i+1),(a(1,i+1)-a(1,i))*Fo);  %The same as case 1,2,3 and 4   
      Amplitude =  input('enter the Amplitude "A":');      
      f =input('enter the frequency "f":');
      while 1  %Check the validity of frequency of the sinusoidal signal (must be greater than 0 )    
       if f >0
           break
       end
       f =input('enter the frequency "f" > 0:');
      end  
      phase = input('enter the phase shift:');
      x = Amplitude* cos(2*pi*f*T + phase);
        otherwise %When users chooose number isn't exist in the choises
          disp('The number is wrong');
          break 
    end
    if i == 1 %When i=1, that means it is the first region, so we have to put the other regions by zeroes and add it with the first region and put it at"Y" signal
    Region_After = E - a(1,i+1) ;   
     x_After = zeros(1, Region_After *Fo);
     x_total= [x x_After];
     y = y + x_total ;%Updating the main signal "Y"
    elseif i ==Nb+1 %When i=Nb+1, that means it is the last region, so we have to put the other regions by zeroes and add it with the last region and put it at"Y" signal
        Region_Before = a(1,i) - S ;
         x_Before = zeros(1, Region_Before*Fo);
         x_total= [x_Before x ];
         y = y + x_total ;%Updating the main signal "Y"
    else %when 1<i>(Nb+1),that means this region is between two or more than two regions, so we have to put the other regions by zeroes and add it with this region and put it at"Y" signal
        Region_Before = a(1,i) - S ;
        Region_After = E - a(1,i+1) ;
         x_Before = zeros(1, Region_Before*Fo);
         x_After = zeros(1, Region_After *Fo);
         x_total= [x_Before x x_After];
         y = y + x_total ;%Updating the main signal "Y"
    end
end
figure;
plot(t,y);
while 1
    %We show to the users the operations that they can do 
disp('Amplitude Scaling "A*Y"enter 1');
disp('Time  reversal "-t" enter 2');
disp('Time  shift "(t+shift)"enter 3');
disp('Expanding the signal"(t*expanding)" enter 4');
disp('Compressing the signal "(t/compressing)" enter 5');
disp('For None enter 6');
operation = input( 'please enter the number to perform any operation on the signal :');
switch(operation)%The users choose the number of operations that they need to do and put it at variable "operation"
   case 1 %When users chooese Amplitude Scaling operation 
      Amplitude= input('enter the Amplitude:');%Take the amplitude from the users
      y_n =y * Amplitude ;
      figure;
    plot(t,y_n);
   case 2 %When users chooese Time  reversal operation
     t_n = (-1)*t;
     figure;
    plot(t_n,y);
   case 3 %When users chooese Time  shift operation
      shift = input('enter the  shift value (to shift to the right enter a positive number , and to shift to the lift enter a negative number :'); %Take the shift value     
      t_n=t+shift ;
      figure;
        plot(t_n,y);
      case 4 %When users chooese Expanding the signal
      expanding = input('enter the expanding value > 1 :');
      t_n=expanding*t ;
      figure;
     plot(t_n,y);
         case 5    %When users chooese Compressing the signal
      compressing =input('enter the compressing value > 1 :');
      t_n=t/compressing ;
      figure;
      plot(t_n,y);
        case 6 %When users chooose to do nothing to the signals 
      break
    otherwise%when user choose meaningless number 
          disp('The number is wrong');
          break 
end
end
