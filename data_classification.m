clear all;
clc;
close all;
% load database all cells in database without significancw test 
%data=load('psth_stimwise_allchannels_1ms_old.mat');
%data=data.psth_stimwise_allchannels_1ms_old;


% load database all cells in database after significance test
data= load('Sig_bon_cumu_Frms_38frms.mat');
data=data.Sig_bon_cumu_Frms_38frms;

% classify teh data into periodic and aperiodic and periodicities 
% 1. periodic whoel set0.

periodic_stimset_4=[1,2,9,10];
aperiodic_stimset_4=[11,12];
periodic_stimset_3=[3,4,5,6,7,8];
aperiodic_stimset_3=[13,14,15,16];
per_set=[1,2,3,4,5,6,7,8,9,10];
aper_set=[11,12,13,14,15,16];
% based on spectral energies
peperiodic_stimset_3_2f2f1=[3,6,8];
aperiodic_stimset_3_2f2f1=[13,14];
periodic_stimset_3_2f1f2=[4,5,7];
aperiodic_stimset_3_2f1f2=[15,16];
% plan 
%split into stimwise  and periodicity wise
%find cumulatve for 3 frames=600ms
%apply ttest and find significant cases amon=g periodic an d aperiodic

%split into stimwise  and periodicity wise
data_per_3=data(:,periodic_stimset_3);
data_per_4=data(:,periodic_stimset_4);
data_aper_3=data(:,aperiodic_stimset_3);
data_aper_4=data(:,aperiodic_stimset_4);
data_per_3_2f2f1=data(:,peperiodic_stimset_3_2f2f1);
data_aper_3_2f2f1=data(:,aperiodic_stimset_3_2f2f1);
data_per_3_2f1f2=data(:,periodic_stimset_3_2f1f2);
data_aper_3_2f1f2=data(:,aperiodic_stimset_3_2f1f2);

% stm starts from 500 to 4100 foir 3600ms 
% now classify into segments 



