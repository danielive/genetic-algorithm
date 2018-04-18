for i=1:1000
    Fp(i)=sin(xp(i))/(1+exp(-xp(i))); % получение значений для построения графика
end
plot(xp,Fp) % построение графика
ylim([-2 2]); % определение границ графика по оси y
hold on;
for i=1:1000
    if (Fp(i) == max(Fp))
        index = i;
    end
end
plot(xp(index),max(Fp),'*') % построение точки на графике
fprintf('Оптимум функции %f\n', max(Fp));