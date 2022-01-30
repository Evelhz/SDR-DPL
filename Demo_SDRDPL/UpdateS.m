function [ Sal ]  = UpdateS(Dict, DataX, DataY, RlxA, RlxB, DataInvMat, lambda)
ClassNum = size(DataX,2);
for i = 1 : ClassNum
    TempDict        = Dict{i};
    TempDataX       = DataX{i};
    TempDataY       = DataY{i};
    TempRlxA        = RlxA{i};
    TempRlxB        = RlxB{i};
    Inv             = DataInvMat{i};
    Sal{i} = (TempDataX*TempDataX'+TempDataX*TempDataY'-TempDict*TempRlxA*TempDataX'-TempDict*TempRlxB*TempDataY')...
        /(TempDataX*TempDataX'+TempDataY*TempDataY'+lambda*Inv);
end