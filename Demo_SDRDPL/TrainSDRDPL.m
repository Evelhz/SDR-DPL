function [ DictMat , P_Mat ,Sal_Mat, Coef ] = TrainDPL( Data, Label, DictSize, tau, lambda, gamma )
% This is the DPL training function

% Initilize D and P, precompute the inverse matrix used in Eq. (10), update A for one time 
[ DataMatX, DataMatY, DictMat, P_Mat, DataInvMat, RlxA , RlxB, Sal_Mat, DataC] = Initilization( Data , Label, DictSize, tau, lambda, gamma );
% Alternatively update P, D and A
for i=1:20
    [ P_Mat ]   = UpdateP(  RlxA, RlxB, DataInvMat, P_Mat, DataMatX, DataMatY, tau );
%     [ DictMat ] = UpdateD(  RlxA, DataMatX, DictMat);
%     [ DictMat ] = UpdateD_DR(  RlxA, RlxB, DataMatX, DictMat);
    [ DictMat] = UpdateD_Sal(  RlxA, RlxB, Sal_Mat, DataMatX, DictMat);
    [ RlxA ] = UpdateA(  DictMat, DataMatX, P_Mat, Sal_Mat, tau, DictSize ); 
    [ RlxB ] = UpdateB(  DictMat, DataMatX, DataMatY, P_Mat, Sal_Mat, tau, DictSize ); 
    [ Sal_Mat ]  = UpdateS(  DictMat, DataMatX, DataMatY, RlxA, RlxB, DataInvMat, lambda);
%     X = DataMatX;
%     Y = DataMatY;
%     A = RlxA;
%     B = RlxB;
%     D = DictMat;
%     P = P_Mat;
%     S = Sal_Mat;
%     XC = DataC;
%     sum1 = 0;
%     sum2 = 0;
%     sum3 = 0;
%     sum4 = 0;
%     sum5 = 0;
%     for io = 1 : size(P_Mat,2)
%         sum1 = sum1 + norm(X{io} - D{io}*A{io}-S{io}*X{io})^2 + norm(X{io} - D{io}*B{io}-S{io}*Y{io});
%         sum2 = sum2 + tau*(norm(A{io}-P{io}*X{io})^2 + norm(B{io}-P{io}*Y{io})^2);
%         sum3 = sum3 + lambda*(norm(P{io}*XC{io})^2+norm(S{io}*XC{io})^2);
%     end
%     ob1(i) = sum1;
%     ob2(i) = sum2;
%     ob3(i) = sum3;
%     ob(i) = ob1(i) + ob2(i) + ob3(i);    
end
% plot(linspace(1,20,20),ob,'-ob');
% xlabel('Iteration Number')
% ylabel('Objective Function Value')
% set(gcf,'color','white');
% set(gca,'FontName','Times New Roman','FontSize',14,'LineWidth',1);

% Reorganize the P matrix to make the classification fast
% for i=1:size(P_Mat,2)
%     EncoderMat((i-1)*DictSize+1:i*DictSize,:) = P_Mat{i};
% end

Coef = cell2mat(RlxA);

    
