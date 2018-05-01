function Y=fun(X)
    n=2;
    
    x1=X(1,1);
    x2=X(1,2);
    if(n==3)
        x3=X(1,3);
    end

    a=20;
    b=0.2;
    c=2*pi;
    
    if(n==2)
        Y=-a*exp(-b*sqrt((1/2)*sum(x1.^2+x2.^2)))-exp((1/2)*sum(cos(x1.*c)+cos(x2.*c)))+a+exp(1);
    elseif(n==3)
        Y=-a*exp(-b*sqrt((1/3)*sum(x1.^2+x2.^2+x3.^2)))-exp((1/3)*sum(cos(x1.*c)+cos(x2.*c)+cos(x3.*c)))+a+exp(1);
    end
end

