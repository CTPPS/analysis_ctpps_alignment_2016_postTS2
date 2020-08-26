import root;
import pad_layout;

string topDir = "../../";

string dataset = "data/phys-version1/fill_5427/xangle_140_beta_0.30/ALL";

string sector = "sector 45";

TH2_palette = Gradient(blue, heavygreen, yellow, red);

//----------------------------------------------------------------------------------------------------

string f = topDir + "/" + dataset + "/distributions.root";

NewPad("$x_{\rm far}\ung{mm}$", "$x_{\rm near}\ung{mm}$");
scale(Linear, Linear, Log);
string base = sector + "/cuts/cut_h/canvas_before";
draw(RootGetObject(f, base + "#0"), "p,bar");
draw(RootGetObject(f, base + "#1"), "l", magenta);
draw(RootGetObject(f, base + "#2"), "l", magenta);
limits((5, 5), (30, +30), Crop);

NewPad("$y_{\rm far}\ung{mm}$", "$y_{\rm near}\ung{mm}$");
scale(Linear, Linear, Log);
string base = sector + "/cuts/cut_v/canvas_before";
draw(RootGetObject(f, base + "#0"), "p,bar");
draw(RootGetObject(f, base + "#1"), "l", magenta);
draw(RootGetObject(f, base + "#2"), "l", magenta);
limits((-20, -20), (+20, +20), Crop);
