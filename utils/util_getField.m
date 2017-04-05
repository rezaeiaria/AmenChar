function s = util_getField(s)

splt = strsplit(s, '/');
s = splt(end);

for i='0':'9'
    s = strrep(s, i, '');
end

end