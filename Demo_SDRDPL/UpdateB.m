function [ Coef ] = UpdateB(  Dict, DataX, DataY, P_Mat, Sal_Mat, tau, DictSize )
% Update A by Eq. (8)

    ClassNum = size(DataX,2);
    I_Mat    = eye(DictSize,DictSize);
    for i=1:ClassNum
        TempDict       = Dict{i};
        TempDataX       = DataX{i};
        TempDataY       = DataY{i};
        TempSal        = Sal_Mat{i};
        Coef{i}        = (TempDict'*TempDict+tau*I_Mat)\(TempDict'*TempDataX-(TempDict'*TempSal*TempDataY)+tau*P_Mat{i}*TempDataY);
    end


