function [ Coef ] = UpdateA(  Dict, Data, P_Mat, Sal_Mat, tau, DictSize )
% Update A by Eq. (8)

    ClassNum = size(Data,2);
    I_Mat    = eye(DictSize,DictSize);
    for i=1:ClassNum
        TempDict       = Dict{i};
        TempData       = Data{i};
        TempSal        = Sal_Mat{i};
        Coef{i}        = (TempDict'*TempDict+tau*I_Mat)\(TempDict'*TempData-(TempDict'*TempSal*TempData)+tau*P_Mat{i}*TempData);
    end


