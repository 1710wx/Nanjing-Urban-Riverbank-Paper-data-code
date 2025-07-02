clear;clc;close;
figure;set(gcf,'Position',[100,100,500,350],'color','w');
tmp_D = readmatrix('HRLB.csv', 'OutputType', 'string');
time_D=tmp_D(1,5:end);
def_D=str2double(tmp_D(2,5:end));

time_insar=datenum(time_D,'yyyy-mm-dd')-datenum(time_D(1),'yyyy-mm-dd')+1;
time_insar=transpose(time_insar);
time_inter=[1:12:time_insar(end)];
def_interp=interp1(time_insar,def_D,time_inter);

time_notrend=time_inter-1+datenum(time_D(1),'yyyy-mm-dd');

%%去线性趋势
def_D_notrend=detrend(def_interp,1);
% def_D_notrend=def_interp;
% def_D_notrend=detrend(def_interp,1);

%%
figure;set(gcf,'Position',[100,100,500,350],'color','w');
[cab,f]=cwt(def_D_notrend);
imagesc(abs(cab))
wt(def_D_notrend);
time=[64 128 256 512];
y_cwt_true = log2(time / 12);
yticks(y_cwt_true);
cell_y_cwt = cellfun(@num2str, num2cell(time), 'UniformOutput', false);
str_yt_cwt = string(cell_y_cwt);
yticklabels(str_yt_cwt);
date_index=[1 xticks];
set(gca,'XTick',date_index);
xticklabels(datestr(time_notrend(date_index+1),'mm.yyyy'));
% ylabel('Period (days)','Color','black');
% xlabel('Time');
set(gca,'fontsize',10,'FontName','Times New Roman');


%% 温度xwt
temp_D = readmatrix('Temp_final.csv', 'OutputType', 'string');
time_temp=temp_D(1,:);
temp=str2double(temp_D(2,:));
[~, idx] = ismember(time_notrend, datenum(time_temp,'yyyy-mm-dd'));  % idx 是日期相同的索引
figure;set(gcf,'Position',[100,100,500,350],'color','w');
xwt(temp(idx),def_D_notrend);
[Wxy,period,scale,coi,sig95]=xwt(temp(idx),def_D_notrend,'MakeFigure',1);
%%
time=[64 128 256 512];
y_xwt_true = log2(time / 12);
yticks(y_xwt_true);
cell_y_xwt = cellfun(@num2str, num2cell(time), 'UniformOutput', false);
str_yt_xwt = string(cell_y_xwt);
yticklabels(str_yt_xwt);
date_index=[1 xticks];
set(gca,'XTick',date_index);
xticklabels(datestr(time_notrend(date_index+1),'mm.yyyy'));
% ylabel('Period (days)','Color','black');
% xlabel('Time');
set(gca,'fontsize',10,'FontName','Times New Roman');
figure;imagesc(abs(Wxy));
y_axis_cankao1=log2(period);
angle1=angle(Wxy);
angle1_deg=angle1/2/pi*360;
time_lag1=angle1/(2*pi);
%%
figure;set(gcf,'Position',[100,100,500,350],'color','w');
wtc(temp(idx),def_D_notrend);
time=[64 128 256 512];
y_wtc_true = log2(time / 12);
yticks(y_wtc_true);
cell_y_wtc = cellfun(@num2str, num2cell(time), 'UniformOutput', false);
str_yt_wtc = string(cell_y_wtc);
yticklabels(str_yt_wtc);
date_index=[1 xticks];
set(gca,'XTick',date_index);
xticklabels(datestr(time_notrend(date_index+1),'mm.yyyy'));
set(gca,'fontsize',10,'FontName','Times New Roman');