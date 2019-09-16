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

string method = "method o";


yTicksDef = RightTicks(0.2, 0.1);

xSizeDef = 40cm;

xTicksDef = LeftTicks(rotate(90)*Label(""), FillTickLabels, Step=1, step=0);

//----------------------------------------------------------------------------------------------------

NewPad(false, 1, 1);

// TODO
/*
AddToLegend("(" + method + ")");
AddToLegend(format("(xangle %u)", xangle));

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

	NewPad("fill", "horizontal shift$\ung{mm}$");

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

					string f = topDir + dataset + "/" + sample_labels[sai] + "/x_alignment_meth_o.root";
					RootObject obj = RootGetObject(f, cfg_refs[cfgi] + "/" + rps[rpi] + "/g_results", error = false);

					if (!obj.valid)
						continue;

					real ax[] = { 0. };
					real ay[] = { 0. };
					obj.vExec("GetPoint", 0, ax, ay); real bsh = ax[0], bsh_unc = ay[0];

					real x = fdi;
					if (sample_labels.length > 1)
						x += sai * sfa / (sample_labels.length - 1) - sfa/2;

					bool pointValid = (bsh == bsh && bsh_unc == bsh_unc && fabs(bsh) > 0.01);
		
					pen p = black;

					if (pointValid)
					{
						draw((x, bsh), m + p);
						draw((x, bsh-bsh_unc)--(x, bsh+bsh_unc), p);
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
				draw((fdi, r.sh_x), mCi + 3pt + red);
			}
		}
	}

	real y_mean = GetMeanHorizontalAlignment(rps[rpi]);
	//draw((-1, y_mean)--(fill_data.length, y_mean), black);

	limits((-1, y_mean-1), (fill_data.length, y_mean+1), Crop);

	AttachLegend("{\SetFontSizesXX " + rp_labels[rpi] + "}");
}

//----------------------------------------------------------------------------------------------------

GShipout(hSkip=5mm, vSkip=1mm);
