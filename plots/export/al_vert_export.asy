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

real sfa = 0.3;

yTicksDef = RightTicks(0.5, 0.1);

xSizeDef = 40cm;

xTicksDef = LeftTicks(rotate(90)*Label(""), FillTickLabels, Step=1, step=0);

//----------------------------------------------------------------------------------------------------

NewPad(false, 1, 1);

// TODO
/*
AddToLegend(format("xangle = %u", xangle));

for (int sai : sample_labels.keys)
{
	AddToLegend(sample_labels[sai], sample_pens[sai]);
}

AttachLegend();
*/

//----------------------------------------------------------------------------------------------------

for (int rpi : rps.keys)
{
	write(rps[rpi]);

	NewRow();

	NewPad("fill", "vertical shift $\ung{mm}$");

	for (int fdi : fill_data.keys)
	{
		write(format("    %i", fill_data[fdi].fill));

		int fill = fill_data[fdi].fill; 
		int rp_id = rp_ids[rpi];

		for (int dsi : fill_data[fdi].datasets.keys)
		{
			string dataset = fill_data[fdi].datasets[dsi].tag;

			write("        " + dataset);
	
			mark m = mCi+3pt;

			for (int sai : sample_labels.keys)
			{
				for (int cfgi : cfg_xangles.keys)
				{
					if (fill_data[fdi].datasets[dsi].xangle != cfg_xangles[cfgi])
						continue;

					string f = topDir + dataset + "/" + sample_labels[sai] + "/y_alignment.root";
					RootObject results = RootGetObject(f, rps[rpi] + "/g_results", error=false);

					if (!results.valid)
						continue;

					real ax[] = { 0. };
					real ay[] = { 0. };
					results.vExec("GetPoint", 2, ax, ay); real sh_y = ax[0], sh_y_unc = ay[0];

					real x = fdi;
					pen p = black;

					if (sh_y_unc > 0 && sh_y_unc < 1)
					{
						draw((x, sh_y), m + p);
						draw((x, sh_y - sh_y_unc)--(x, sh_y + sh_y_unc), p);
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
				if (!arc[ri].results.initialized(rp_ids[rpi]))
					continue;

				AlignmentResult r = arc[ri].results[rp_ids[rpi]];
				draw((fdi, r.sh_y), mCi + 3pt + red);
			}
		}
	}

	real y_mean = GetMeanVerticalAlignment(rps[rpi]);
	//draw((-1, y_mean)--(fill_data.length, y_mean), black);

	limits((-1, y_mean-1), (fill_data.length, y_mean+1), Crop);

	AttachLegend("{\SetFontSizesXX " + rp_labels[rpi] + "}");
}

//----------------------------------------------------------------------------------------------------

GShipout(hSkip=5mm, vSkip=1mm);
