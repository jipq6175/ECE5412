load fisheriris.mat

% truncate to only binary classification
X = meas(1:100, :);
Y = [zeros([50 1]); ones([50 1])]; 

