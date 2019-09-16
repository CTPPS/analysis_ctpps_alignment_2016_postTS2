import root;
import pad_layout;

include "../common.asy";
include "../io_alignment_format.asy";

string topDir = "../../data/phys-version1/";

string fn_export = "../../export/fit_alignments_2019_09_16.out";
AlignmentResults arc[];
LoadAlignmentResults(fn_export, arc);

string sample_labels[];
sample_labels.push("ALL");

yTicksDef = RightTicks(0.2, 0.1);

xSizeDef = 40cm;

xTicksDef = LeftTicks(rotate(90)*Label(""), FillTickLabels, Step=1, step=0);

//----------------------------------------------------------------------------------------------------

NewPad(false, 1, 1);

//TODO
/*
AddToLegend("(" + sample + ")");
AddToLegend(format("(xangle %u)", xangle));

AddToLegend("method fit", mCi+2pt + p_meth_fit);
AddToLegend("method s-curve", mCi+2pt + p_meth_s_curve);

AttachLegend();
*/

//----------------------------------------------------------------------------------------------------

for (int ai : a_sectors.keys)
{
	write(a_sectors[ai]);

	NewRow();

	NewPad("fill", "$y_F - y_N\ung{mm}$");

	for (int fdi : fill_data.keys)
	{
		write(format("    %i", fill_data[fdi].fill));

		int fill = fill_data[fdi].fill; 

		for (int dsi : fill_data[fdi].datasets.keys)
		{
			string dataset = fill_data[fdi].datasets[dsi].tag;

			write("        " + dataset);
	
			mark m = mCi+3pt;

			real x = fdi;

			for (int sai : sample_labels.keys)
			{
				for (int cfgi : cfg_xangles.keys)
				{
					if (fill_data[fdi].datasets[dsi].xangle != cfg_xangles[cfgi])
						continue;
			
					real ax[] = {0.};
					real ay[] = {0.};

					{
						string f = topDir + dataset + "/" + sample_labels[sai] + "/y_alignment.root";
						RootObject results_N = RootGetObject(f, a_nr_rps[ai] + "/g_results", error=false);
						RootObject results_F = RootGetObject(f, a_fr_rps[ai] + "/g_results", error=false);
				
						if (results_N.valid && results_F.valid)
						{
							results_N.vExec("GetPoint", 2, ax, ay); real sh_y_N = ax[0], sh_y_N_unc = ay[0];
							results_F.vExec("GetPoint", 2, ax, ay); real sh_y_F = ax[0], sh_y_F_unc = ay[0];

							real diff = sh_y_F - sh_y_N;
							real diff_unc = sqrt(sh_y_F_unc*sh_y_F_unc + sh_y_N_unc*sh_y_N_unc);

							bool valid = (sh_y_N_unc > 0 && sh_y_F_unc > 0);

							if (valid)
							{
								draw((x, diff), m + black);
								draw((x, diff - diff_unc)--(x, diff + diff_unc), black);
							}
						}
					}
				}
			}
		}

		// plot export data
		for (int ri : arc.keys)
		{
			string label = format("fill %u", fill);
			if (arc[ri].label == label)
			{
				if (!arc[ri].results.initialized(a_nr_rp_ids[ai]) || !arc[ri].results.initialized(a_fr_rp_ids[ai]))
					continue;

				AlignmentResult r_N = arc[ri].results[a_nr_rp_ids[ai]];
				AlignmentResult r_F = arc[ri].results[a_fr_rp_ids[ai]];

				draw((fdi, r_F.sh_y - r_N.sh_y), mCi + 3pt + red);
			}
		}
	}

	real y_mean = GetMeanVerticalRelativeAlignment(a_sectors[ai]);
	//draw((-1, y_mean)--(fill_data.length, y_mean), black);

	limits((-1, y_mean-0.5), (fill_data.length, y_mean+0.5), Crop);

	AttachLegend("{\SetFontSizesXX " + a_labels[ai] + "}");
}

//----------------------------------------------------------------------------------------------------

GShipout(hSkip=5mm, vSkip=1mm);
