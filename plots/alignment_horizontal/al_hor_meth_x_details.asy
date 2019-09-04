import root;
import pad_layout;

include "../common.asy";

string topDir = "../../";

xSizeDef = 7cm;
ySizeDef = 5cm;

//----------------------------------------------------------------------------------------------------

NewPad(false, -1, 0);

AddToLegend("version = " + version_phys);
AddToLegend("ref = " + replace(ref, "_", "\_"));
AddToLegend("fill = " + fill);
AddToLegend("xangle = " + xangle);
AddToLegend("beta = " + beta);
AddToLegend("sample = " + sample);

AttachLegend();

//----------------------------------------------------------------------------------------------------

string f = topDir + "data/" + version_phys + "/fill_" + fill + "/xangle_" + xangle + "_beta_" + beta + "/" + sample + "/match.root";

for (int rpi : rps.keys)
	NewPadLabel(rp_labels[rpi]);

NewRow();

for (int rpi : rps.keys)
{
	NewPad("$x\ung{mm}$", "entries (scaled)");
	currentpad.xTicks = LeftTicks(2., 1.);
	//currentpad.yTicks = RightTicks(0.5, 0.1);

	string p_base = ref + "/" + rps[rpi] + "/method x/c_cmp";

	RootObject o_base = RootGetObject(f, p_base, error=false);
	if (!o_base.valid)
		continue;

	draw(RootGetObject(f, p_base + "|h_ref_sel"), "d0,eb", black);
	draw(RootGetObject(f, p_base + "|h_test_bef"), "d0,eb", blue);
	draw(RootGetObject(f, p_base + "|h_test_aft"), "d0,eb", red);

	//limits((2, 0), (15, 3), Crop);
	xlimits(3, 16, Crop);
}

//----------------------------------------------------------------------------------------------------

NewRow();

xTicksDef = LeftTicks(1., 0.2);

for (int rpi : rps.keys)
{
	NewPad("shift$\ung{mm}$", "bins in overlap");
	
	string p_base = ref + "/" + rps[rpi] + "/method x";

	RootGetObject(f, p_base + "/g_results");
	real ax[] = { 0. };
	real ay[] = { 0. };
	robj.vExec("GetPoint", 0, ax, ay); real sh_best = ay[0];
	robj.vExec("GetPoint", 1, ax, ay); real sh_best_unc = ay[0];

	draw(RootGetObject(f, p_base + "/g_n_bins"), "p", magenta, mCi+1pt+magenta);

	//limits((-5, 0), (+0, 80), Crop);
	/*
	yaxis(XEquals(sh_best - sh_best_unc, false), dashed);
	yaxis(XEquals(sh_best, false), solid);
	yaxis(XEquals(sh_best + sh_best_unc, false), dashed);
	*/
}

//----------------------------------------------------------------------------------------------------

NewRow();

for (int rpi : rps.keys)
{
	NewPad("shift$\ung{mm}$", "$S^2 / N$");
	
	string p_base = ref + "/" + rps[rpi] + "/method x";

	RootGetObject(f, p_base + "/g_results");
	real ax[] = { 0. };
	real ay[] = { 0. };
	robj.vExec("GetPoint", 0, ax, ay); real sh_best = ay[0];
	robj.vExec("GetPoint", 1, ax, ay); real sh_best_unc = ay[0];

	draw(RootGetObject(f, p_base + "/g_chi_sq_norm"), "p", heavygreen, mCi+1pt+heavygreen);

	//limits((-5, 0), (+0, 200), Crop);
	//xlimits(-5, 0, Crop);
	/*
	yaxis(XEquals(sh_best - sh_best_unc, false), dashed);
	yaxis(XEquals(sh_best, false), solid);
	yaxis(XEquals(sh_best + sh_best_unc, false), dashed);
	*/

	AddToLegend(format("%.2f", sh_best), black);
	AttachLegend();
}

GShipout(hSkip=1mm, vSkip=1mm);
