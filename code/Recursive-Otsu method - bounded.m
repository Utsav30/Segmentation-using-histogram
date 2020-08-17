
close all;clear all;clc
num = 5;
%%================================================================================================
I=imread('chandu.jpg'); % Read the Image
figure,imshow(I); % display the  Original Image
figure,imhist(I); % display the Histogram
[q,r,s]=size(I);
if s>1
    I=rgb2gray(I);
end
figure,imshow(I);
%%=================================================================================================
n=imhist(I); % Compute the histogram
maxf=n(1);
idx=1;
for i=2:256
    if maxf<n(i)
        maxf=n(i);
        idx=i;
    end
end
fun(maxf,idx,I,n,5);
function x = fun(maxf,idx,I,n,k)
k = k-1;
if(k<0) 
    x=1;
else
N=sum(n); % sum the values of all the histogram values
max=0; %initialize maximum to zero
%%================================================================================================

for i=1:256
    P(i)=n(i)/N; %Computing the probability of each intensity level
    
end

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
ff=0;
if threshold>idx
    ff=1;
    bw=~bw;
end
ss=0;
if ff==0
for i=1:threshold
    ss=ss+n(i);
    n(i)=0;
end
else
    for i=threshold:256
    ss=ss+n(i);
    n(i)=0;
    end
end
n(idx)=n(idx)+ss;
[q,r]=size(I);
for i=1:q
    for j=1:r
        if bw(i,j)==0
            I(i,j)=maxf;
        end
    end
end
figure,imshow(bw); % Display the Binary Image
%figure(5),imshow(abcd);
figure,imshow(I);
ff=0;
[q,r]=size(I);
for i=1:q
    for j=1:r
        if I(i,j)~=I(1,1)
            ff=1;
        end
    end
end
if ff==1
    fun(maxf,idx,I,n,k);
    x = 1;
end
end
end
%%====================================================================================================