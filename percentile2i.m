
function I=percentile2i(h,p)
if p<0 || p>1
    error('The percentile must be in the range [0,1].')
end
h=h/sum(h);
C=cumsum(h);
idx=find(C>=p,1,'first');
I=(idx-1)/(numel(h)-1);