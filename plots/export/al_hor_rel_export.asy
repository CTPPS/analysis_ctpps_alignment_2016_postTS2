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

real mfa = 0.3;

yTicksDef = RightTicks(0.2, 0.1);

xSizeDef = 40cm;

xTicksDef = LeftTicks(rotate(90)*Label(""), FillTickLabels, Step=1, step=0);

//----------------------------------------------------------------------------------------------------

NewPad(false, 1, 1);

// TODO
/*
AddToLegend("(" + sample + ")");
AddToLegend(format("(xangle %u)", xangle));

for (int mi : abs_methods.keys)
	AddToLegend(abs_methods[mi], mCi + 3pt + am_pens[mi]);

AddToLegend("method rel (fs)", mSq+4pt+magenta);

AttachLegend();
*/

//----------------------------------------------------------------------------------------------------

for (int ai : a_sectors.keys)
{
	write(a_sectors[ai]);

	NewRow();

	NewPad("fill", "$x_N - x_F\ung{mm}$");

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

					// relative methods
					{
						string f = topDir + dataset + "/" + sample_labels[sai] + "/x_alignment_relative.root";	
						RootObject obj = RootGetObject(f, a_sectors[ai] + "/g_results", error = false);

						if (!obj.valid)
							continue;
						
						real ax[] = { 0. };
						real ay[] = { 0. };
						
						obj.vExec("GetPoint", 1, ax, ay); real b = ax[0], b_unc = ay[0];
						obj.vExec("GetPoint", 2, ax, ay); real b_fs = ax[0], b_fs_unc = ay[0];

						if (b_fs == b_fs && b_fs_unc == b_fs_unc)
						{
							pen p = black;
							draw((x, b_fs), mCi+3pt + p);
							draw((x, b_fs - b_fs_unc)--(x, b_fs + b_fs_unc), p);
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

				draw((fdi, - r_F.sh_x + r_N.sh_x), mCi + 3pt + red);
			}
		}
	}

	real y_mean = GetMeanHorizontalRelativeAlignment(a_sectors[ai]);
	//draw((-1, y_mean)--(fill_data.length, y_mean), black);

	limits((-1, y_mean-0.5), (fill_data.length, y_mean+0.5), Crop);

	AttachLegend("{\SetFontSizesXX " + a_labels[ai] + "}");
}

//----------------------------------------------------------------------------------------------------

GShipout(hSkip=5mm, vSkip=1mm);
