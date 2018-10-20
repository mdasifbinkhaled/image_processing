function filter=gaussianBlurFilter(m,n,sigma)
%applying 2k+1==>k=(m-1)/2 to get span of m and 2l+1==>l=(n-1)/2 to get
%span of n
k=(m-1)/2;
l=(n-1)/2;
[x y]=meshgrid(-k:k,-l:l);
exponentialComponent=-(x.*x+y.*y)/(2*sigma*sigma)
filter=exp(exponentialComponent)/(2*pi*sigma*sigma);
end