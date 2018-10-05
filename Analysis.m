clc;
algorithm = {'DE'; 'PSO'};
testcase = {'uf2', 'hce', 'ros', 'ef8', 'hy1'};
stopGeneration = [57, 19, 18, 41, 26, 39, 18;
                  78, 26, 32, 60, 45, 58, 38;
                  136, 14, 96, 78, 32, 76, 25;
                  89, 11, 50, 38, 23, 35, 11;
                  74, 18, 32, 58, 42, 56, 35;
                  218, 68, 136, 88, 73, 77, 160;
                  205, 163, 125, 174, 158, 150, 123;
                  256, 157, 120, 184, 168, 133, 62;
                  167, 29, 163, 66, 51, 41, 164;
                  183, 73, 81, 99, 84, 80, 168;];
strname = {'SM', 'MGBM', 'OCD', 'DQP', 'LSSC', 'CR'};
run = 30;
iter = 200;
%generate cost matrix
for i = 2:2    
    for j = 4:5
        matrix = [];
        for r = 1:run
            for k = 1:iter
                    file = sprintf('./%s/%s/%d/%s_%d_%d.txt', algorithm{i}, testcase{j}, r, testcase{j}, r, k);
                    in = load(file);
                    if(i == 2)
                        matrix(r,k) = min(in(:,1));
                    elseif(i == 1)
                        matrix(r,k) = max(in(:,1));
                    end
            end;
        end;  
        %plot figure
        figure();
        x=1:iter;
        fmatrix = mean(matrix);
        stop = 0;
        for m=1:iter
            if(fmatrix(m) == 0)
                stop = m;
                break;
            end
        end      
        semilogy(x, fmatrix,'-b','LineWidth',2);
        hold on;
        if(stop ~= 0)           
            H = semilogy([stop,iter],[0.000001,0.000001],'--b','LineWidth',3);
            text(250,250,'- - -代表y=0');
        end
        hold on;
        xlabel('迭代次数');
        ylabel('目标值');
        
        for m = 1:6
            plot(stopGeneration((i-1)*5 + j, m),fmatrix(stopGeneration((i-1)*5 + j, m)) + 0.000001, '-ro','MarkerFaceColor', 'r', 'Markersize',7);
            %str = sprintf('S%d', m);
            str = strname{m};
            text(stopGeneration((i-1)*5 + j, m),fmatrix(stopGeneration((i-1)*5 + j, m)) + 0.000002,str)
        end;
        hold off;
        %save figure
        nm = sprintf('C:/Users/apple.apple-PC/Downloads/计算机系毕业论文文件/投稿/fig/%s_%s.jpg', algorithm{i}, testcase{j});
        saveas(gcf,nm);
        %performance ratio      
        for m = 1:7
            cost((i-1)*5 + j, m) = (fmatrix(1) - fmatrix(stopGeneration((i-1)*5 + j, m))) / stopGeneration((i-1)*5 + j, m);
        if(cost((i-1)*5 + j, m) < 10)
            cost((i-1)*5 + j, m) = cost((i-1)*5 + j, m) * 10000;
        end
        end
       
    end;
end;
 %save ratio
 file = 'C:/Users/apple.apple-PC/Downloads/计算机系毕业论文文件/fig/new/cost.txt';
 fd=fopen(file,'w');
 [r,c]=size(cost);

 for ii=1:r
   for jj=1:c
       fprintf(fd,'%6.1f\t',cost(ii,jj));
       fprintf(fd,' ');
   end
       fprintf(fd,'\r\n');
 end
fclose(fd);
        