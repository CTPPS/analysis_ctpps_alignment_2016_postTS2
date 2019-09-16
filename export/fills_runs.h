#include <map>
#include <vector>

std::map<unsigned int, std::vector<unsigned int>> fills_runs;

std::vector<unsigned int> fills;

struct FillReference
{
	unsigned int sector45 = 0, sector56 = 0;
};

std::map<unsigned int, FillReference> fills_reference;

void InitFillsRuns(bool /*useExceptionList*/ = true)
{
	// mapping fill -> runs, from DAS
	fills_runs[5451] = {284025, 284029, 284035, 284036, 284037, 284038, 284039, 284040, 284041, 284042, 284043, 284044};
	fills_runs[5450] = {284006, 284014};
	fills_runs[5448] = {283946, 283964};
	fills_runs[5446] = {283933, 283934};
	fills_runs[5443] = {283884, 283885};
	fills_runs[5442] = {283876, 283877, 283878};
	fills_runs[5441] = {283863, 283865};
	fills_runs[5439] = {283820, 283830, 283834, 283835};
	fills_runs[5437] = {283672, 283675, 283676, 283680, 283681, 283682, 283685};
	fills_runs[5433] = {283548, 283549, 283550, 283551, 283553, 283560};
	fills_runs[5427] = {283478, 283481};
	fills_runs[5426] = {283469};
	fills_runs[5424] = {283453};
	fills_runs[5423] = {283407, 283408, 283413, 283414, 283415, 283416};
	fills_runs[5422] = {283387};
	fills_runs[5421] = {283353, 283358, 283359};
	fills_runs[5418] = {283305, 283306, 283307, 283308};
	fills_runs[5416] = {283270, 283283};
	fills_runs[5412] = {283171};
	fills_runs[5406] = {283049, 283050, 283052, 283059, 283067};
	fills_runs[5405] = {283040, 283041, 283042, 283043};
	fills_runs[5401] = {282917, 282918, 282919, 282920, 282921, 282922, 282923, 282924};
	fills_runs[5395] = {282842};
	fills_runs[5394] = {282799, 282800, 282807, 282814};
	fills_runs[5393] = {282730, 282731, 282732, 282733, 282734, 282735};

	// fills to process (all fills with some data)
	// TODO: review, remove those not in CMS JSON ??
	fills.push_back(5393);
	//fills.push_back(5394);	// no data
	fills.push_back(5395);
	fills.push_back(5401);
	fills.push_back(5405);
	fills.push_back(5406);
	//fills.push_back(5416);	// no data
	fills.push_back(5418);
	fills.push_back(5421);
	fills.push_back(5423);
	fills.push_back(5424);
	//fills.push_back(5426);	// no data
	fills.push_back(5427);
	fills.push_back(5433);
	fills.push_back(5437);
	fills.push_back(5439);
	fills.push_back(5441);
	fills.push_back(5442);
	fills.push_back(5443);
	fills.push_back(5446);
	fills.push_back(5448);
	fills.push_back(5450);
	fills.push_back(5451);


	// build fill reference
	for (const auto &fill : fills)
	{
		FillReference ref = { fill, fill };

		/*
		if (useExceptionList)
		{
			if (fill == 5946) ref = { 5950, 5950 };
		}
		*/

		fills_reference[fill] = ref;
	}
}

//----------------------------------------------------------------------------------------------------

void PrintFillRunMapping()
{
	for (const auto &p : fills_runs)
	{
		printf("fillInfoCollection.push_back(FillInfo(%u, false, %u, %u, \"fill %u\"));\n", p.first, p.second.front(), p.second.back(), p.first);
	}
}
