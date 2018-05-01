clear
clc

n=2;
xmin=-20;
xmax=20;
step=(xmax-xmin)/100; % шаг
x=xmin:step:xmax;
N=100; % мощность популяции
a1=randi([0 2^15],1,N); % популяция 1 - матрица 1x100 из случайных целых чисел в диапазоне от 0 до 2^15
a2=randi([0 2^15],1,N); % популяция 2 - матрица 1x100 из случайных целых чисел в диапазоне от 0 до 2^15
if(n==3)
    a3=randi([0 2^15],1,N); % популяция 3 - матрица 1x100 из случайных целых чисел в диапазоне от 0 до 2^15
end
brCount=0;
a=20;
b=0.2;
c=2*pi;

for j=1:length(x)
    for i=1:length(x)
        if(n==2)
            Fp(i)=-a*exp(-b*sqrt((1/n)*sum(x(j)^2+x(i)^2)))-exp((1/n)*sum(cos(c*x(j))+cos(c*x(i))))+a+exp(1);
        elseif(n==3)
            Fp(i)=-a*exp(-b*sqrt((1/n)*sum(x(j)^2+x(i)^2+x(i)^2)))-exp((1/n)*sum(cos(c*x(j))+cos(c*x(i))+cos(c*x(i))))+a+exp(1);
        end
    end
    Fp_surf(j,:)=Fp;
end
[x,y]=meshgrid(x);
surf(x,y,Fp_surf);
hold on;
for it=1:2000
    x1=0;
    x2=0;
    if(n==3)
        x3=0;
    end
    count=0;
    for i=1:length(a1)
        x1(i)=-1+a1(i)*(2)/(2^15);
        x2(i)=-1+a2(i)*(2)/(2^15);
        if(n==3)
            x3(i)=-1+a3(i)*(2)/(2^15);  
        end
    end
	% фитнес-функция определяющая меру близости к оптимальному решению
    for i=1:length(x1)
        if(n==2)
            F(i)=-a*exp(-b*sqrt((1/n)*sum(x1(i)^2+x2(i)^2)))-exp((1/n)*sum(cos(c*x1(i))+cos(c*x2(i))))+a+exp(1);
        elseif(n==3)
            F(i)=-a*exp(-b*sqrt((1/n)*sum(x1(i)^2+x2(i)^2+x3(i)^2)))-exp((1/n)*sum(cos(c*x1(i))+cos(c*x2(i))+cos(c*x3(i))))+a+exp(1);
        end
        if(F(i)>0.1) % оценка особей в популяции
            count=0;
        else
            count=count+1;
        end
    end
    % Критерий  остановки  вычислений
    % повторение  лучшего результата 5 раз или достижение популяцией 2000 генераций 
    if(count==length(F)) % если вся популяция подходит под критерий
        brCount=brCount+1;
    else
        brCount=0;
    end
    if(brCount==5 || it==2000)
        if(n==2)
            plot3(x1,x2,F,'*')
        elseif(n==3)
            plot3((x1+x2)/2,(x2+x3)/2,F,'*')
        end
        fprintf('Глобальный минимум функции %f\n', min(F));
        fprintf('Число поколений (генераций) равно %i\n', it);
        break;
    end
	% операция репродукции
    F1=F-max(F); % хромосомы копируются в промежуточную популяцию для дальнейшего "размножения"
    Mf=round(F1/mean(mean(F1))); % округление до целого числа
    k=1;
    for i=1:length(a1)
        for j=1:Mf(i) 
            a12(k)=a1(i); % создание новой популяции хромосом
            a22(k)=a2(i);
            if(n==3)
                a32(k)=a3(i);
            end
            k=k+1;
        end
    end
	% инициализация новой популяции хромосом
    a1=a12;
    a2=a22;
    if(n==3)
        a3=a32;
    end
	% перевод десятичного представления чисел двоичное
    b1=dec2bin(a1,15);
    b2=dec2bin(a2,15);
    if(n==3)
        b3=dec2bin(a3,15);
    end
	% операция кроссинговера
    j=0;
    for i=1:2:length(b1)-1
        p=randi([0,1]);
        if (p==1)
            k=randi([1,15]); % определение бита
            j=b1(i,k:15);
            b1(i,k:15)=b1(i+1,k:15);
            b1(i+1,k:15)=j;
            j=b2(i,k:15);
            b2(i,k:15)=b2(i+1,k:15);
            b2(i+1,k:15)=j;
            if(n==3)
                j=b3(i,k:15);
                b3(i,k:15)=b3(i+1,k:15);
                b3(i+1,k:15)=j;
            end
        end
    end
	% операция мутации
    for i=1:1:length(b1)-1
        p2=randi([0,100]);
        if (p2==1)
            k=randi([1,15]); % определение бита
            if (b1(i,k)=='0')
                b1(i,k)='1';
            else
                b1(i,k)='0';
            end
            if (b2(i,k)=='0')
                b2(i,k)='1';
            else
                b2(i,k)='0';
            end
            if(n==3)
                if (b3(i,k)=='0')
                    b3(i,k)='1';
                else
                    b3(i,k)='0';
                end
            end
        end
    end
	% перевод двоичного представления чисел в десятичное
    a1=bin2dec(b1);
    a2=bin2dec(b2);
    if(n==3)
        a3=bin2dec(b3);
    end
end