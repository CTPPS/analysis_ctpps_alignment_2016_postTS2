#include "../alignment_classes.h"
#include "fills_runs.h"

#include "TGraphErrors.h"
#include "TFile.h"
#include "TF1.h"

using namespace std;

//----------------------------------------------------------------------------------------------------

struct RPGraphs
{
	TGraphErrors *g_x = NULL;
	TGraphErrors *g_x_rel;
	TGraphErrors *g_y_meth_f;
	TGraphErrors *g_y_meth_s;

	TF1 *f_x;
	TF1 *f_x_rel;
	TF1 *f_y_meth_f;
	TF1 *f_y_meth_s;

	void Init()
	{
		if (g_x)
			return;

		g_x = new TGraphErrors();
		g_x_rel = new TGraphErrors();
		g_y_meth_f = new TGraphErrors();
		g_y_meth_s = new TGraphErrors();
	}
};

//----------------------------------------------------------------------------------------------------

int main()
{
	// initialisation
	InitFillsRuns(false);
	//PrintFillRunMapping();

	string topDir = "../data/phys-version1";

	string match_reference = "data/alig-version2/fill_5322/xangle_140_beta_0.30/DS1";

	vector<string> xangles = {
		"xangle_140_beta_0.30",
	};

	vector<string> datasets = {
		"ALL"
	};

	struct ArmData {
		string name;
		unsigned int rp_id_N, rp_id_F;
	};

	vector<ArmData> armData = {
		{ "sector 45", 2, 3 },
		{ "sector 56", 102, 103 },
	};

	vector<unsigned int> rps;
 	for (const auto &ad : armData)
	{
		rps.push_back(ad.rp_id_N);
		rps.push_back(ad.rp_id_F);
	}

	// collect data
	map<unsigned int, RPGraphs> rpGraphs;

	for (const auto &fill : fills)
	{
		//printf("* %u\n", fill);

		for (const auto &xangle : xangles)
		{
			for (const auto &dataset : datasets)
			{
				vector<unsigned int> rpsWithMissingData;
				for (const auto &rp : rps)
				{
					bool rp_sector_45 = (rp / 100 == 0);
					unsigned int reference_fill = (rp_sector_45) ? fills_reference[fill].sector45 : fills_reference[fill].sector56;

					//printf("fill %u, RP %u --> ref fill %u\n", fill, rp, reference_fill);

					// path base
					char buf[100];
					sprintf(buf, "%s/fill_%u", topDir.c_str(), reference_fill);

					// try to get input
					string dir = string(buf) + "/" + xangle + "/" + dataset;
					signed int r = 0;

					AlignmentResultsCollection arc_x_method_o;
					r += 1 * arc_x_method_o.Load(dir + "/x_alignment_meth_o.out");

					AlignmentResultsCollection arc_x_method_x;
					r += 2 * arc_x_method_x.Load(dir + "/match.out");

					AlignmentResultsCollection arc_x_rel;
					r += 4 * arc_x_rel.Load(dir + "/x_alignment_relative.out");

					AlignmentResultsCollection arc_y_meth_f;
					r += 8 * arc_y_meth_f.Load(dir + "/y_alignment.out");

					//AlignmentResultsCollection arc_y_meth_s;
					//r += 16 * arc_y_meth_s.Load(dir + "/y_alignment_alt.out");

					// check all input available
					if (r != 0)
					{
						printf("WARNING: some input files invailable (%u) in directory '%s'.\n", r, dir.c_str());
						continue;
					}

					// extract corrections
					const AlignmentResults &ar_x_method_o = arc_x_method_o["x_alignment_meth_o"];
					const AlignmentResults &ar_x_method_x = arc_x_method_x[match_reference + ", method x"];
					const AlignmentResults &ar_x_rel = arc_x_rel["x_alignment_relative_sl_fix"];
					const AlignmentResults &ar_y_meth_f = arc_y_meth_f["y_alignment_sl_fix"];
					//const AlignmentResults &ar_y_meth_s = arc_y_meth_s["y_alignment_alt"];

					bool found = true;

					AlignmentResults::const_iterator rit_x;
					if (rp_sector_45)
					{
						rit_x = ar_x_method_o.find(rp);
						if (rit_x == ar_x_method_o.end())
							found = false;
					} else {
						rit_x = ar_x_method_x.find(rp);
						if (rit_x == ar_x_method_o.end())
							found = false;
					}

					AlignmentResults::const_iterator rit_x_rel;
					if (rp_sector_45)
					{
				   		rit_x_rel = ar_x_rel.find(rp);
						if (rit_x_rel == ar_x_rel.end())
							found = false;
					}

					AlignmentResults::const_iterator rit_y_meth_f;
					if (rp != 102)
					{
						rit_y_meth_f = ar_y_meth_f.find(rp);
						if (rit_y_meth_f == ar_y_meth_f.end())
							found = false;
					}

					/*
					auto rit_y_meth_s = ar_y_meth_s.find(rp);
					if (rit_y_meth_s == ar_y_meth_s.end())
						found = false;
					*/

					if (!found)
					{
						rpsWithMissingData.push_back(rp);
						continue;
					}

					int idx = 0;

					auto &g = rpGraphs[rp];
					g.Init();

					idx = g.g_x->GetN();
					g.g_x->SetPoint(idx, fill, rit_x->second.sh_x);
					g.g_x->SetPointError(idx, 0., rit_x->second.sh_x_unc);

					idx = g.g_x_rel->GetN();
					g.g_x_rel->SetPoint(idx, fill, (rp_sector_45) ? rit_x_rel->second.sh_x : 0.);
					g.g_x_rel->SetPointError(idx, 0., 0.010);

					idx = g.g_y_meth_f->GetN();
					g.g_y_meth_f->SetPoint(idx, fill, (rp != 102) ? rit_y_meth_f->second.sh_y : 0.);
					g.g_y_meth_f->SetPointError(idx, 0., (rp != 102) ? rit_y_meth_f->second.sh_y_unc : 0.);

					/*
					idx = g.g_y_meth_s->GetN();
					g.g_y_meth_s->SetPoint(idx, fill, rit_y_meth_s->second.sh_y);
					g.g_y_meth_s->SetPointError(idx, 0., rit_y_meth_s->second.sh_y_unc);
					*/
				}

				if (!rpsWithMissingData.empty())
				{
					printf("WARNING: some constantants missing for fill %u, xangle %s, dataset %s and RPs: ", fill, xangle.c_str(), dataset.c_str());
					for (const auto &rp : rpsWithMissingData)
						printf("%u, ", rp);
					printf("\n");
				}
			}
		}
	}

	// fit graphs
	for (auto &p : rpGraphs)
	{
		//printf("- %u\n", p.first);

		p.second.f_x = new TF1("", (p.first == 103) ? "[0]" : "[0] + [1]*x");
		p.second.g_x->Fit(p.second.f_x, "Q");

		p.second.f_x_rel = new TF1("", "[0] + [1]*x");
		p.second.g_x_rel->Fit(p.second.f_x_rel, "Q");

		p.second.f_y_meth_f = new TF1("", (p.first == 103) ? "(x < 5410)*([0] + [1]*x) + (x > 5410)*([2] + [3]*x)" : "[0] + [1]*x");
		p.second.g_y_meth_f->Fit(p.second.f_y_meth_f, "Q");

		//g.second.f_y_meth_s = new TF1("", "[0] + [1]*x");
		//g.second.g_y_meth_s->Fit(g.second.f_y_meth_s, "Q");
	}

	// prepare output
	AlignmentResultsCollection output;

	// interpolate output
	for (const auto &fill : fills)
	{
		// process data from all RPs
		AlignmentResults ars_combined;

		for (const auto &ad : armData)
		{
			auto &d_N = rpGraphs[ad.rp_id_N];
			auto &d_F = rpGraphs[ad.rp_id_F];

			double de_x_N = d_N.f_x->Eval(fill);
			double de_x_F = d_F.f_x->Eval(fill);

			double x_corr_rel = 0.;
			if (ad.name == "sector 45")
			{
				// b = mean (x_F - x_N) with basic correction only
				const double b = d_N.f_x_rel->Eval(fill) - d_F.f_x_rel->Eval(fill);
				x_corr_rel = b + de_x_F - de_x_N;
			}

			if (ad.name == "sector 45") x_corr_rel += 0E-3;
			if (ad.name == "sector 56") x_corr_rel += 0E-3;

			double y_corr_N = 0., y_corr_F = 0.;
			if (ad.name == "sector 45") y_corr_N += +0E-3, y_corr_F += -0E-3;
			if (ad.name == "sector 56") y_corr_N += +0E-3, y_corr_F += -0E-3;

			AlignmentResult ar_N(de_x_N + x_corr_rel/2., 150E-3, d_N.f_y_meth_f->Eval(fill) + y_corr_N, 150E-3);
			AlignmentResult ar_F(de_x_F - x_corr_rel/2., 150E-3, d_F.f_y_meth_f->Eval(fill) + y_corr_F, 150E-3);

			if (ad.name == "sector 45")
				ars_combined[ad.rp_id_N] = ar_N;
			ars_combined[ad.rp_id_F] = ar_F;
		}

		char buf[50];
		sprintf(buf, "fill %u", fill);
		output[buf] = ars_combined;
	}

	// save results
	output.Write("fit_alignments_2019_09_16.out");

	TFile *f_out = TFile::Open("fit_alignments.root", "recreate");

	for (auto &g : rpGraphs)
	{
		char buf[100];
		sprintf(buf, "rp %u", g.first);
		TDirectory *d_rp = f_out->mkdir(buf);
		gDirectory = d_rp;

		g.second.g_x->Write("g_x");
		//g.second.f_x->Write("f_x");

		g.second.g_x_rel->Write("g_x_rel");
		//g.second.f_x_rel->Write("f_x_rel");

		g.second.g_y_meth_f->Write("g_y_meth_f");
		//g.second.f_y_meth_f->Write("f_y_meth_f");

		//g.second.g_y_meth_s->Write("g_y_meth_s");
		//g.second.f_y_meth_s->Write("f_y_meth_s");
	}

	delete f_out;

	// clean up
	return 0;
}
