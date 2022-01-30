function [ P_Mat ] = UpdateP(  RlxA, RlxB, DataInvMat, P_Mat, DataMatX, DataMatY, tau)
% Update P by Eq. (10)

ClassNum = size(RlxA,2);
for i=1:ClassNum
     P_Mat{i}           = (tau*RlxA{i}*DataMatX{i}'+tau*RlxB{i}*DataMatY{i}')*DataInvMat{i};
end

