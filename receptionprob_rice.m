function RPnoise_rician = receptionprob_rice(d,n)

numpaths = 3;
Fc = 2500e6; %carrier frequency
Fs = 4*Fc; %sampling frequency
Ts = 1/Fs; %sampling period
t = [0:Ts:1999*Ts]; %time array
wc = 2*pi*Fc; %radian frequency

rice = zeros(1,length(t)); %received signal

for i = 1:numpaths-1
   	wd = 2*pi*Fc*cos(unifrnd(0,2*pi))/3e8;
	a = wblrnd(1,3,1,length(t));%weibrnd(1,3,1,length(t)); 
	rice = rice + a.*cos((wc)*t+unifrnd(0,2*pi,1,length(t)));
end;

rice = rice + 4.5*cos((wc)*t);

[ricei riceq] = demod(rice,Fc,Fs,'qam'); %demodulated signal 
env_rice = sqrt(ricei.^2+riceq.^2); %envelope of received signal 

y = sort(env_rice);

b = sqrt((std(ricei)^2 + std(riceq)^2)/2); %Rician parameter
a = mean(ricei); %Rician parameter
I = besseli(0,y.*(a/b^2));
fyrice = (y./b^2).*exp(-(a^2+y.^2)./(2*b^2)).*I;
power_rice=env_rice.^2;
powerdB=10*log10(power_rice);
mean_power=10*log10(mean(env_rice.^2));

LightSpeedC=3e8;
BlueTooth=2400*1000000;%hz    
Freq=BlueTooth;
TXAntennaGain=1;%db
RXAntennaGain=1;%db
Dref=0.5;%Meter
PTx=0.001;%watt
PathLossExponent=2.5;%Line Of sight
Wavelength=LightSpeedC/Freq;
PTxdBm=10*log10(PTx*1000);

M = Wavelength / (4 * pi * (Dref));
Pr0=PTxdBm + TXAntennaGain + RXAntennaGain- (20*log10(1/M));
recpower = Pr0 - (10*PathLossExponent* log10((d/Dref))) - mean_power;

MinimumSNR=15;
MS=db2pow(MinimumSNR);
ReceiverSensitivity=-75;

SNR = -1*ReceiverSensitivity + recpower;
SNR_u = db2pow(SNR);

K = (a.^2)./(2*(b.^2));

RPnoise_rician = marcumq(sqrt(2*K),sqrt(2*(K+1)*MS)/SNR_u);%from the communications toolbox

