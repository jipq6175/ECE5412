load(fullfile(matlabroot,'examples','stats','readmissiontimes.mat'))
clearvars Weight Age

%% male and female
n = 10000;
tm = ReadmissionTime(Sex==0);
cm = Censored(Sex==0);
x_male = gibbs(tm, cm, rand(), n);

tf = ReadmissionTime(Sex==1);
cf = Censored(Sex==1);
x_female = gibbs(tf, cf, rand(), n); 

%% smoker and non-smoker
ts = ReadmissionTime(Smoker==1);
cs = Censored(Smoker==1);
x_smoker = gibbs(ts, cs, rand(), n);

tns = ReadmissionTime(Smoker==0);
cns = Censored(Smoker==0);
x_nonsmoker = gibbs(tns, cns, rand(), n); 

%% combined Effect
x_male_smoker = gibbs(ReadmissionTime((Smoker==1) & (Sex==0)), Censored((Smoker==1) & (Sex==0)), rand(), n);
x_male_nonsmoker = gibbs(ReadmissionTime((Smoker==0) & (Sex==0)), Censored((Smoker==0) & (Sex==0)), rand(), n);
x_female_smoker = gibbs(ReadmissionTime((Smoker==1) & (Sex==1)), Censored((Smoker==1) & (Sex==1)), rand(), n);
x_female_nonsmoker = gibbs(ReadmissionTime((Smoker==0) & (Sex==1)), Censored((Smoker==0) & (Sex==1)), rand(), n);

%% Plotting

figure(1);

subplot(1,3,1);
histogram(x_male(2:n+1), 'BinWidth', 0.2, 'Normalization', 'probability');
hold on;
histogram(x_female(2:n+1), 'BinWidth', 0.2, 'Normalization', 'probability'); 
legend('Male, n = 47, x = 2.37(0.12)', 'Female, n = 53, x = 6.77(0.19)'); 
xlabel('x (Poisson Parameter)');
ylabel('Probability');
title('Gender Effect')

subplot(1,3,2);
histogram(x_smoker(2:n+1), 'BinWidth', 0.1, 'Normalization', 'probability');
hold on;
histogram(x_nonsmoker(2:n+1), 30, 'BinWidth', 0.1, 'Normalization', 'probability'); 
legend('Smoker, n = 34, x = 3.56(0.18)', 'Nonsmoker, n = 66, x = 5.30(0.15)'); 
xlabel('x (Poisson Parameter)');
title('Smoking Effect');

subplot(1,3,3); 
histogram(x_male_smoker(2:n+1), 'BinWidth', 0.2, 'Normalization', 'probability');
hold on;
histogram(x_male_nonsmoker(2:n+1), 30, 'BinWidth', 0.2, 'Normalization', 'probability'); 
histogram(x_female_smoker(2:n+1), 'BinWidth', 0.2, 'Normalization', 'probability');
histogram(x_female_nonsmoker(2:n+1), 30, 'BinWidth', 0.2, 'Normalization', 'probability'); 
legend('Male Smoker, n = 21, x = 1.93(0.17)', 'Male Nonsmoker, n = 26, x = 2.65(0.16)',...
    'Female Smoker, n = 13, x = 5.91(0.34)', 'Female Nonsmoker, n = 40, x = 7.03(0.23)'); 
xlabel('x (Poisson Parameter)');
title('Individual');