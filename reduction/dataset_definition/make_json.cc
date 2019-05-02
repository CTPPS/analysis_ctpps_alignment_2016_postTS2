#include "../../export/fills_runs.h"

using namespace std;

int main()
{
	InitFillsRuns();

	for (const auto &fi : fills_runs)
	{
		//printf("%u\n", fi.first);

		char buf[100];
		sprintf(buf, "json/fill_%u_xangle_140_betast_0.30.json", fi.first);

		FILE *f_out = fopen(buf, "w");

		fprintf(f_out, "{\n");

		bool first = true;
		for (const auto &run : fi.second)
		{
			if (!first)
				fprintf(f_out, ",\n");
			first = false;

			fprintf(f_out, "  \"%u\": [[1, 9999999]]", run);
		}
		fprintf(f_out, "\n");

		fprintf(f_out, "}\n");

		fclose(f_out);
	}

	return 0;
}
