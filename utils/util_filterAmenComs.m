function good_coms = util_filterAmenComs(coms, comSeeds, amenSeeds)

good_coms = {};
for i=1:numel(amenSeeds)
    good_coms{end+1} = coms{comSeeds == amenSeeds(i)};
end

good_coms = good_coms';

end