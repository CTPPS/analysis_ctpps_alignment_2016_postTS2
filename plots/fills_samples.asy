struct Dataset
{
	string tag;
}

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

	bool found = false;
	for (FillData fd : fill_data)
	{
		if (fd.fill == fill)
		{
			found = true;
			Dataset ds;
			ds.tag = p;
			fd.datasets.push(ds);
		}
	}

	if (!found)
	{
		FillData fd;
		fd.fill = fill;
		Dataset ds;
		ds.tag = p;
		fd.datasets.push(ds);

		fill_data.push(fd);
	}
}

//----------------------------------------------------------------------------------------------------

void InitDataSets()
{
	AddDataSet("fill_5393");
	AddDataSet("fill_5401");
	AddDataSet("fill_5405");
	AddDataSet("fill_5406");
	AddDataSet("fill_5418");
	AddDataSet("fill_5421");
	AddDataSet("fill_5423");
	AddDataSet("fill_5424");
	AddDataSet("fill_5427");
	AddDataSet("fill_5433");
	AddDataSet("fill_5437");
	AddDataSet("fill_5439");
	AddDataSet("fill_5441");
	AddDataSet("fill_5442");
	AddDataSet("fill_5443");
	AddDataSet("fill_5446");
	AddDataSet("fill_5448");
	AddDataSet("fill_5450");
	AddDataSet("fill_5451");
}
