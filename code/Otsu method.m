
close all;clear all;clc
%%================================================================================================
I=imread('chandu.jpg'); % Read the Image
figure(1),imshow(I); % display the  Original Image
figure(2),imhist(I); % display the Histogram
%%=================================================================================================
n=imhist(I); % Compute the histogram
N=sum(n); % sum the values of all the histogram values
max=0; %initialize maximum to zero
%%================================================================================================
%abcd=zeros(size(n))
for i=1:256
    P(i)=n(i)/N; %Computing the probability of each intensity level
    
end
n
%%================================================================================================
for T=2:255      % step through all thresholds from 2 to 255
    w0=sum(P(1:T)); % Probability of class 1 (separated by threshold)
    w1=sum(P(T+1:256)); %probability of class2 (separated by threshold)
    u0=dot([0:T-1],P(1:T))/w0; % class mean u0
    u1=dot([T:255],P(T+1:256))/w1; % class mean u1
    sigma=w0*w1*((u1-u0)^2); % compute sigma i.e variance(between class)
    if sigma>max % compare sigma with maximum 
        max=sigma; % update the value of max i.e max=sigma
        threshold=T-1; % desired threshold corresponds to maximum variance of between class
    end
end
%%====================================================================================================
threshold
n(threshold)
bw=im2bw(I,threshold/255); % Convert to Binary Image
figure(4),imshow(bw); % Display the Binary Image
figure(5),imshow(abcd);
%%====================================================================================================