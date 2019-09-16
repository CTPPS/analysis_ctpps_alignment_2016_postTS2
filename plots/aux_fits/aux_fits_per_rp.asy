import root;
import pad_layout;

include "../common.asy";

string topDir = "../../";

string f = topDir + "aux_fits/fits.root";

TGraph_errorBar = None;

real x_min = 5390, x_max = 5460;

//----------------------------------------------------------------------------------------------------

for (int rpi : rps.keys)
{
	NewRow();

	NewPadLabel(rp_labels[rpi]);

	//--------------------

	NewPad("fill", "$x$ shift $\ung{mm}$");
	for (int cfgi : cfg_xangles.keys)
	{
		string base = "xangle_" + cfg_xangles[cfgi] + "_beta_" + cfg_betas[cfgi] + "/" + rps[rpi];

		RootObject graph = RootGetObject(f, base+"/g_x_sh", error=false);
		RootObject fit = RootGetObject(f, base+"/f_x_sh", error=false);

		if (!graph.valid)
			continue;

		draw(graph, "p", blue, mCi+2pt+blue);

		TF1_x_min = x_min;
		TF1_x_max = x_max;
		draw(fit, "l", red+1pt);
	}

	xlimits(x_min, x_max, Crop);

	//--------------------

	NewPad("fill", "$y$ tilt");
	for (int cfgi : cfg_xangles.keys)
	{
		string base = "xangle_" + cfg_xangles[cfgi] + "_beta_" + cfg_betas[cfgi] + "/" + rps[rpi];

		RootObject graph = RootGetObject(f, base+"/g_y_tilt", error=false);
		RootObject fit = RootGetObject(f, base+"/f_y_tilt", error=false);

		if (!graph.valid)
			continue;

		draw(graph, "p", blue, mCi+2pt+blue);

		TF1_x_min = x_min;
		TF1_x_max = x_max;
		draw(fit, "l", red+1pt);
	}

	xlimits(x_min, x_max, Crop);
}
