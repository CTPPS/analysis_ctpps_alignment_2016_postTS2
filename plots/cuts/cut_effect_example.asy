import root;
import pad_layout;

string topDir = "../../";

string dataset = "data/phys-version1/fill_5427/xangle_140_beta_0.30/ALL";

string sector = "sector 45";
string rp = "L_1_F";

TH2_palette = Gradient(blue, heavygreen, yellow, red);

//----------------------------------------------------------------------------------------------------

string f = topDir + "/" + dataset + "/distributions.root";

NewPad("$x\ung{mm}$", "$y\ung{mm}$");
scale(Linear, Linear, Log);
draw(RootGetObject(f, sector + "/before selection/" + rp + "/h2_y_vs_x"));
limits((5, -15), (20, +15), Crop);
AttachLegend("before");

NewPad("$x\ung{mm}$", "$y\ung{mm}$");
scale(Linear, Linear, Log);
draw(RootGetObject(f, sector + "/after selection/" + rp + "/h2_y_vs_x"));
limits((5, -15), (20, +15), Crop);
AttachLegend("after");
