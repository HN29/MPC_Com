A = [];
for i = 1:15
    char = int2str(i);
    char = [char,'.txt'];
    fileID1 = fopen(char,'r');
    formatSpec = '%f';
    Btemp = fscanf(fileID1,formatSpec);
    fclose(fileID1);
    B = Btemp(1:500);
%     B = B*0.25;
    A = [A, B];
end
figure(1)

boxplot(A)
ylim([0, 1]);
ylabel('Throughput');
grid on
