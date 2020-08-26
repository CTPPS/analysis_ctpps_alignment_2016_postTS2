real x_size_fill_cmp = 30cm;

string arms[], a_labels[], a_sectors[], a_nr_rps[], a_fr_rps[];
int a_nr_rp_ids[], a_fr_rp_ids[];
arms.push("arm0"); a_labels.push("sector 45 (L, z+)"); a_sectors.push("sector 45"); a_nr_rps.push("L_1_N"); a_fr_rps.push("L_1_F"); a_nr_rp_ids.push(2); a_fr_rp_ids.push(3);
arms.push("arm1"); a_labels.push("sector 56 (R, z-)"); a_sectors.push("sector 56"); a_nr_rps.push("R_1_N"); a_fr_rps.push("R_1_F"); a_nr_rp_ids.push(102); a_fr_rp_ids.push(103);

string rps[], rp_labels[], rp_arms[], rp_dirs[], rp_sectors[];
int rp_ids[];
rps.push("L_1_F"); rp_labels.push("45-210-fr"); rp_arms.push("arm0"); rp_dirs.push("sector 45/F"); rp_sectors.push("sector 45"); rp_ids.push(3);
rps.push("L_1_N"); rp_labels.push("45-210-nr"); rp_arms.push("arm0"); rp_dirs.push("sector 45/N"); rp_sectors.push("sector 45"); rp_ids.push(2);
//rps.push("R_1_N"); rp_labels.push("56-210-nr"); rp_arms.push("arm1"); rp_dirs.push("sector 56/N"); rp_sectors.push("sector 56"); rp_ids.push(102);
rps.push("R_1_F"); rp_labels.push("56-210-fr"); rp_arms.push("arm1"); rp_dirs.push("sector 56/F"); rp_sectors.push("sector 56"); rp_ids.push(103);

string version_alig = "alig-version2";

string version_phys = "phys-version1";

string sample = "ALL";
string samples[];
pen s_pens[];
samples.push("ALL"); s_pens.push(red);

string xangle = "140";
string beta = "0.30";
string ref = "data_alig-version2_fill_5322_xangle_140_beta_0.30_DS1";

string cfg_xangles[], cfg_betas[], cfg_refs[];
pen cfg_pens[];
cfg_xangles.push("140"); cfg_betas.push("0.30"); cfg_refs.push("data_alig-version2_fill_5322_xangle_140_beta_0.30_DS1"); cfg_pens.push(red);

string fill = "5424";

string fills_alig[] = {
	"5322",
};

string fills_phys_short[] = {
	"5393",
	"5406",
	"5424",
	"5441",
	"5451",
};

// fills from RP-OK JSON file
string fills_phys[] = {
	"5393",
	"5394",
	"5395",
	"5401",
	"5405",
	"5406",
	"5416",
	"5418",
	"5421",
	"5423",
	"5424",
	"5426",
	"5427",
	"5433",
	"5437",
	"5439",
	"5441",
	"5442",
	"5443",
	"5446",
	"5448",
	"5450",
	"5451",
};

//----------------------------------------------------------------------------------------------------

int GetIndexBefore(int f)
{
	for (int fi : fills_phys.keys)
	{
		int fill_int = (int) fills_phys[fi];
		if (f <= fill_int)
			return fi;
	}

	return 0;
}

void DrawLine(int f, string l, pen p, bool u, real y_min, real y_max)
{
	real b = GetIndexBefore(f) - 0.5;

	draw((b, y_min)--(b, y_max), p);

	if (u)
		label("{\SetFontSizesXX " + l + "}", (b, y_max), SE, p);
	else
		label("{\SetFontSizesXX " + l + "}", (b, y_min), NE, p);
}

void DrawFillMarkers(real y_min, real y_max)
{
	// TODO
	/*
	DrawLine(6854, "TS1", magenta, true, y_min, y_max);
	DrawLine(7213, "TS2", magenta, true, y_min, y_max);

	DrawLine(6615, "2018A", magenta, false, y_min, y_max);
	DrawLine(6734, "2018B", magenta, false, y_min, y_max);
	DrawLine(6893, "2018C", magenta, false, y_min, y_max);
	DrawLine(6992, "2018D", magenta, false, y_min, y_max);
	//DrawLine(7350, "2018E", magenta, false, y_min, y_max);
	*/
}

//----------------------------------------------------------------------------------------------------

struct Dataset
{
	string tag;
	string xangle;
	string beta;
}

//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------

struct FillData
{
	int fill;
	Dataset datasets[];
};

//----------------------------------------------------------------------------------------------------

FillData fill_data[];

void AddDataSet(string p)
{
	int fill = (int) substr(p, find(p, "fill_")+5, 4);
	string xangle = substr(p, find(p, "xangle_")+7, 3);
	string beta = substr(p, find(p, "beta_")+5, 4);

	bool found = false;
	for (FillData fd : fill_data)
	{
		if (fd.fill == fill)
		{
			found = true;
			Dataset ds;
			ds.tag = p;
			ds.xangle = xangle;
			ds.beta = beta;
			fd.datasets.push(ds);
		}
	}

	if (!found)
	{
		FillData fd;
		fd.fill = fill;
		Dataset ds;
		ds.tag = p;
		ds.xangle = xangle;
		ds.beta = beta;
		fd.datasets.push(ds);

		fill_data.push(fd);
	}
}

//----------------------------------------------------------------------------------------------------

void InitDataSets()
{
	fill_data.delete();

	for (int fi : fills_phys.keys)
	{
		AddDataSet("fill_" + fills_phys[fi] + "/xangle_140_beta_0.30");
	}
}

InitDataSets();

//----------------------------------------------------------------------------------------------------

string FillTickLabels(real x)
{
	if (x >=0 && x < fill_data.length)
	{
		return format("%i", fill_data[(int) x].fill);
	} else {
		return "";
	}
}


//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------

// old stuff hereafter

//----------------------------------------------------------------------------------------------------

real GetMeanHorizontalAlignment(string rp)
{
	if (rp == "L_1_F") return -4.3;
	if (rp == "L_1_N") return -3.4;
	if (rp == "R_1_N") return 0;
	if (rp == "R_1_F") return -3.7;

	return 0;
}

//----------------------------------------------------------------------------------------------------

real GetMeanHorizontalRelativeAlignment(string sector)
{
	if (sector == "sector 45") return 0.8;
	if (sector == "sector 56") return 0.;

	return 0;
}

//----------------------------------------------------------------------------------------------------

real GetMeanVerticalAlignment(string rp)
{
	if (rp == "L_1_F") return -0.2;
	if (rp == "L_1_N") return -0.7;
	if (rp == "R_1_N") return -0.2;
	if (rp == "R_1_F") return -0.2;

	return 0;
}

//----------------------------------------------------------------------------------------------------

real GetMeanVerticalRelativeAlignment(string sector)
{
	if (sector == "sector 45") return 0.4;
	if (sector == "sector 56") return -0.2;

	return 0;
}
