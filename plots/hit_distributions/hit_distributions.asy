import root;
import pad_layout;

include "../common.asy";

string topDir = "../../";

string selection = "before selection";

TH2_x_min = 6;
TH2_x_max = 11;

TH2_y_min = -1.5;
TH2_y_max = +0.5;

TH2_palette = Gradient(white, blue, heavygreen, yellow, red, black);

yTicksDef = RightTicks(0.5, 0.1);

//----------------------------------------------------------------------------------------------------

NewPad(false);

for (int rpi : rps.keys)
	NewPadLabel(rp_labels[rpi]);


for (int fi : fills_phys_short.keys)
{
	string fill = fills_phys_short[fi];

	NewRow();

	NewPadLabel(fill);

	string f = topDir + "data/" + version_phys + "/fill_" + fill + "/xangle_" + xangle + "_beta_" + beta + "/" + sample + "/distributions.root";

	for (int rpi : rps.keys)
	{
		NewPad("$x\ung{mm}$", "$y\ung{mm}$", axesAbove=true);
		scale(Linear, Linear, Log);

		RootObject obj = RootGetObject(f, rp_sectors[rpi] + "/" + selection + "/" + rps[rpi] + "/h2_y_vs_x");
		obj.vExec("Rebin2D", 1, 1);
		draw(obj);

		if (fill == "5393" && rps[rpi] == "L_1_F") { real x = 8.100, y = -0.300; draw(Label(format("(%.3f", x)+format(", %.3f)", y), 1, 5*E, green), (x, y), mCi+3pt+green); }
		if (fill == "5393" && rps[rpi] == "L_1_N") { real x = 7.710, y = -0.834; draw(Label(format("(%.3f", x)+format(", %.3f)", y), 1, 5*E, green), (x, y), mCi+3pt+green); }

		if (fill == "5451" && rps[rpi] == "L_1_F") { real x = 8.417, y = -0.250; draw(Label(format("(%.3f", x)+format(", %.3f)", y), 1, 5*E, green), (x, y), mCi+3pt+green); }
		if (fill == "5451" && rps[rpi] == "L_1_N") { real x = 8.160, y = -0.600; draw(Label(format("(%.3f", x)+format(", %.3f)", y), 1, 5*E, green), (x, y), mCi+3pt+green); }

		//limits((40, -20), (70, +20), Crop);
	}
}

GShipout(hSkip = 2mm, vSkip = 0mm);
