import root;
import pad_layout;

include "../common.asy";

string topDir = "../../";

real xfa = 0.3;

yTicksDef = RightTicks(0.2, 0.1);

xSizeDef = x_size_fill_cmp;

xTicksDef = LeftTicks(rotate(90)*Label(""), FillTickLabels, Step=1, step=0);

//----------------------------------------------------------------------------------------------------

NewPad(false, 1, 1);

AddToLegend("version = " + version_phys);
AddToLegend("sample = " + sample);

for (int cfgi : cfg_xangles.keys)
{
	AddToLegend("xangle = " + cfg_xangles[cfgi] + ", beta = " + cfg_betas[cfgi], cfg_pens[cfgi]);
}

AttachLegend();

for (int rpi : rps.keys)
{
	write(rps[rpi]);

	NewRow();

	NewPad("fill", "horizontal shift$\ung{mm}$");
	
	for (int fdi : fill_data.keys)
	{
		write(format("    %i", fill_data[fdi].fill));

		int fill = fill_data[fdi].fill; 

		for (int dsi : fill_data[fdi].datasets.keys)
		{
			string dataset = fill_data[fdi].datasets[dsi].tag;

			write("        " + dataset);
	
			mark m = mCi+3pt;
	
			for (int cfgi : cfg_xangles.keys)
			{
				if (fill_data[fdi].datasets[dsi].xangle != cfg_xangles[cfgi])
					continue;

				if (fill_data[fdi].datasets[dsi].beta != cfg_betas[cfgi])
					continue;

				string f = topDir + "data/" + version_phys + "/" + dataset + "/" + sample + "/x_alignment_meth_o.root";	
				RootObject obj = RootGetObject(f, cfg_refs[cfgi] + "/" + rps[rpi] + "/g_results", error = false);
	
				if (!obj.valid)
					continue;
	
				real ax[] = { 0. };
				real ay[] = { 0. };
				obj.vExec("GetPoint", 0, ax, ay); real bsh = ax[0], bsh_unc = ay[0];

				real x = fdi;
				if (cfg_xangles.length > 1)
					x += cfgi * xfa / (cfg_xangles.length - 1) - xfa/2;

				bool pointValid = (bsh == bsh && bsh_unc == bsh_unc && fabs(bsh) > 0.01);
	
				pen p = cfg_pens[cfgi];
	
				if (pointValid)
				{
					draw((x, bsh), m + p);
					draw((x, bsh-bsh_unc)--(x, bsh+bsh_unc), p);

					if (cfg_xangles[cfgi] == "160" && cfg_betas[cfgi] == "0.30")
					{
						real sh = 0;

						if (rps[rpi] == "L_2_F") sh = -0.100;
						if (rps[rpi] == "L_1_F") sh = -0.100;
						if (rps[rpi] == "R_1_F") sh = -0.100;
						if (rps[rpi] == "R_2_F") sh = -0.100;

						draw((x, bsh + sh), mSq+3pt+black);
					}
				}
			}
		}
	}

	real y_mean = GetMeanHorizontalAlignment(rps[rpi]);
	//draw((-1, y_mean)--(fill_data.length, y_mean), black);

	real y_min = y_mean - 1;
	real y_max = y_mean + 1;

	DrawFillMarkers(y_min, y_max);

	limits((-1, y_min), (fill_data.length, y_max), Crop);

	AttachLegend("{\SetFontSizesXX " + rp_labels[rpi] + "}");
}

//----------------------------------------------------------------------------------------------------

GShipout(hSkip=5mm, vSkip=1mm);
