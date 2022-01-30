function [ D_Mat ] = UpdateD(  CoefA, CoefB, Data, D_Mat )
% Update D by Eq. (12)

[ ClassNum] = size(Data,2);
Dim = size(Data{1},1);
Imat= eye(size(CoefA{1},1));
for i=1:ClassNum
    TempCoefA       = CoefA{i};
    TempCoefB       = CoefB{i};
    TempData       = Data{i};
    rho = 1;
    rate_rho = 1.2;
    TempS          = D_Mat{i};
    TempT          = zeros(size(TempS));
    previousD = D_Mat{i};
    Iter = 1;ERROR=1;
    while(ERROR>1e-8&&Iter<100)
         TempD   = (rho*(TempS-TempT)+TempData*TempCoefA'+TempData*TempCoefB')/(rho*Imat+TempCoefA*TempCoefA'+TempCoefB*TempCoefB');
         TempS   = normcol_lessequal(TempD+TempT);
         TempT   = TempT+TempD-TempS;
         rho     = rate_rho*rho;
         ERROR = mean(mean((previousD- TempD).^2));
         previousD = TempD;
         Iter=Iter+1;
    end     
    D_Mat{i}       = TempD;
end

