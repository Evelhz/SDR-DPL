function [ D_Mat ] = UpdateD_Sal(  RlxA,RlxB, Sal_Mat, DataX, D_Mat )
% Update D by Eq. (12)

[ ClassNum] = size(DataX,2);
Dim = size(DataX{1},1);
Imat= eye(size(RlxA{1},1));
for i=1:ClassNum
    TempRlxA       = RlxA{i};
    TempRlxB       = RlxB{i};
    TempDataX       = DataX{i};
    TempSal         = Sal_Mat{i};
    rho = 1;
    rate_rho = 1.2;
    TempS          = D_Mat{i};
    TempT          = zeros(size(TempS));
    previousD = D_Mat{i};
    Iter = 1;ERROR=1;
    while(ERROR>1e-8&&Iter<100)
         TempD   = (rho*(TempS-TempT)+(TempDataX*TempRlxA')-(TempSal*TempDataX*TempRlxA')...
             +(TempDataX*TempRlxB')-(TempSal*TempDataX*TempRlxB'))/(rho*Imat+TempRlxA*TempRlxA'+TempRlxB*TempRlxB');
         TempS   = normcol_lessequal(TempD+TempT);
         TempT   = TempT+TempD-TempS;
         rho     = rate_rho*rho;
         ERROR = mean(mean((previousD- TempD).^2));
         previousD = TempD;
         Iter=Iter+1;
    end     
    D_Mat{i}       = TempD;
end

