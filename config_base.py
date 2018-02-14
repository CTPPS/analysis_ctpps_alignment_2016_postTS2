import FWCore.ParameterSet.Config as cms

config = cms.PSet(
    alignment_corrections = cms.PSet(
      rp_L_1_F = cms.PSet(
        de_x = cms.double(0.)
      ),
      rp_L_1_N = cms.PSet(
        de_x = cms.double(0.)
      ),
      rp_R_1_N = cms.PSet(
        de_x = cms.double(0.)
      ),
      rp_R_1_F = cms.PSet(
        de_x = cms.double(0.)
      )
    ),

    aligned = cms.bool(False),

    n_si = cms.double(4.),

	cut1_apply = cms.bool(True),
	cut1_a = cms.double(-1),
	cut1_c = cms.double(-0.974),
	cut1_si = cms.double(0.2),

	cut2_apply = cms.bool(False), # 56-210-nr-hr did not work
	cut2_a = cms.double(-1),
	cut2_c = cms.double(0),
	cut2_si = cms.double(0.2),

	cut3_apply = cms.bool(False),
	cut3_a = cms.double(-1),
	cut3_c = cms.double(-0.5),
	cut3_si = cms.double(0.6),

	cut4_apply = cms.bool(False), # 56-210-nr-hr did not work
	cut4_a = cms.double(-1),
	cut4_c = cms.double(0.8),
	cut4_si = cms.double(0.5),

    matching_1d = cms.PSet(
      reference_datasets = cms.vstring("data/phys/fill_5393/SingleMuon"),

      rp_L_1_F = cms.PSet(
        x_min = cms.double(10.),
        x_max = cms.double(15.),
        sh_min = cms.double(-2),
        sh_max = cms.double(+2)
      ),
      rp_L_1_N = cms.PSet(
        x_min = cms.double(9.),
        x_max = cms.double(15.),
        sh_min = cms.double(-2),
        sh_max = cms.double(+2)
      ),
      rp_R_1_N = cms.PSet(
        x_min = cms.double(0.),
        x_max = cms.double(0.),
        sh_min = cms.double(-2),
        sh_max = cms.double(+2)
      ),
      rp_R_1_F = cms.PSet(
        x_min = cms.double(0.),
        x_max = cms.double(0.),
        sh_min = cms.double(-2),
        sh_max = cms.double(+2)
      )
    )
)
