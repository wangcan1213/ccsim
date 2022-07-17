[data, flag] = open_csv(fullname_ent_csv, 4, varnames, varstring)

        %ÈýÁÐ£¬TAZID, Mu, Sigma
        varnames = {'TAZID', 'Mu', 'Sigma'};
        varstring = {'TAZ ID', 'Mu', 'Sigma'};
        [exp_distr_para, flag] = open_csv(fullname, 3, varnames, varstring);
        if flag == 0
            return
        end