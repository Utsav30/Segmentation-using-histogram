
close all;clear all;clc
%%================================================================================================
I=imread('chandu.jpg'); % Read the Image
figure(1),imshow(I); % display the  Original Image

figure(2),imhist(I); % display the Histogram
%%=================================================================================================
n=imhist(I); % Compute the histogram
[m,o,p]=size(I);
if p>1
    I=rgb2gray(I);
end
figure(3),imhist(I);
figure(4),imshow(I);
mult(1,256,n,I);

function mult(start,end1,n,I)
if start~=end1
   % sum=0;
    a=n;
    for i=1:size(n)
        if i<start || i>end1
            a(i)=0;
        end
    end
    
%     for i=start:end1-1 % sum the values of all the histogram values
%         sum=sum+n(i);
%     end
    N=sum(a);
    max=0; %initialize maximum to zero
    %%================================================================================================
    %abcd=zeros(256);
    for i=1:256
        P(i)=0;
    end
    for i=start:end1
        P(i)=n(i)/N; %Computing the probability of each intensity level

    end
    %%================================================================================================
    for T=start+1:end1-1      % step through all thresholds from 2 to 255
        %w0=sum(P(start:T)); % Probability of class 1 (separated by threshold)
        w0=0;
        for i=start:T
            w0=w0+P(i);
        end
        w1=0;
        for i=T+1:end1
            w1=w1+P(i);
        end
            
        %w1=sum(P(T+1:end1)); %probability of class2 (separated by threshold)
        u0=dot([start-1:T-1],P(start:T))/w0; % class mean u0
        u1=dot([T:end1-1],P(T+1:end1))/w1; % class mean u1
        sigma=w0*w1*((u1-u0)^2); % compute sigma i.e variance(between class)
        if sigma>max % compare sigma with maximum 
            max=sigma; % update the value of max i.e max=sigma
            threshold=T-1; % desired threshold corresponds to maximum variance of between class
        end
    end
    %%====================================================================================================
    threshold
    left=0;
    right=0;
    for i=start:threshold-1
        if n(i)>n(threshold)
            left=1;
        end
    end

    for i=threshold+1:end1
        if n(i)>n(threshold)
            right=1;
        end
    end
    n(threshold)
    if left==1 && right ==1
        I1=I;
        I2=I;
        [o,p]=size(I1);
        for i=1:o
            for j=1:p
                if I1(i,j)<start-1 || I1(i,j)>end1
                   I1(i,j)=255;
                end
            end
        end
        figure,imshow(I1);
        bw=im2bw(I1,(threshold-start)/(end1-start)); % Convert to Binary Image
        figure,imshow(bw);
        bw1=~bw;
        figure,imshow(bw1);% Display the Binary Image
        mult(threshold+1,end1,n,I)
        mult(start,threshold-1,n,I)
        
    end
end
end


%%====================================================================================================