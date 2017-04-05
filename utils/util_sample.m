function Xs = util_sample(Xs, fraction)

n_fir = size(Xs{1},1);
n_sec = size(Xs{2},1);
n_tot = n_fir + n_sec;
k_sample = floor(fraction * n_tot);

candids = [(1:n_fir)' ones(n_fir,1); (1:n_sec)' ones(n_sec,1)*2];
chosen  = candids(randsample(n_tot, k_sample),:);

chosen_fir = chosen(chosen(:,2) == 1,1);
chosen_sec = chosen(chosen(:,2) == 2,1);

Xs{1} = Xs{1}(chosen_fir,:);
Xs{2} = Xs{2}(chosen_sec,:);

end