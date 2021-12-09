%% Bahattin GOK
%This is K-Means algorithm using none of matlab function.
%By the way in this algorithm used data.mat data if you don't have this file data you should take it
% or use any file data.

%Have fun!

clc
clear

load data.mat

x=z(:,1);
y=z(:,2);


n=size(z,1);
dim=size(z,2);

k=input('Kumeleme sayisini girin:');

merkezx= linspace(min(x,[],'all'),max(x,[],'all'),k);
merkezy= linspace(min(y,[],'all'),max(y,[],'all'),k);
merkez=[merkezx',merkezy'];


for j=2:k  
    maks=zeros(1,n);
    
    for i=1:n
        dist=zeros(1,j-1);
        for l=1:j-1
            dist(l)=norm(z(i,:)-merkez(l,:));
        end
        if(size(dist,2)==1) maks(i)=dist;
        else
            maks(i)=max(dist);
        end

    end
    [maksi, ind]=max(maks);
    merkez(j,:)=z(ind(1),:);
end


indeksi=zeros(1,n);

for i=1:n
    indeksi(i)=randi(k,1); %rastgele integer değer üretimi
end

itr_sayisi=input('Iterasyon sayisini girin:');
itr_sayisilkdeger=itr_sayisi;
while itr_sayisi>=1
    itr_sayisi=itr_sayisi-1;
    for i=1:n
        dist=zeros(1,k); 
        for j=1:k
            dist(j)=norm(z(i,:)-merkez(j,:));
        end
        [mini, ind]=min(dist); 
        indeksi(i)=ind(1); 
    end

    for j=1:k
        merkez(j,:)=zeros(1,dim);
        deger=0;
        for i=1:n
            if indeksi(i)==j
                merkez(j,:)=merkez(j,:)+z(i,:);
                deger=deger+1;
            end
        end
        if deger
            merkez(j,:)=merkez(j,:)/deger;
        else
            ind=randi(n, 1);
            merkez(j,:)=z(ind,:);
        end
    end
end


for i=1:n
hold on
plot(x(i), y(i),'.b')
title('2 Boyutlu Dağılım Grafiği')
end 

figure

color = 'bkrgcmbkrgcmbkrgcmbkrgcmbkrgcmbkrgcm';
for i = 1:k
    hold on
    plot(merkez(i,1),merkez(i, 2), 'marker','o','LineWidth',3,'color', color(i))
    title("Kümelenmiş Veri Grafiği, k= " + k + "  ve İterasyon Sayısı= "+ itr_sayisilkdeger)
end


for i=1:n
    hold on
    plot(x(i),y(i), 'marker','.','color', color(indeksi(i)));
   
end





