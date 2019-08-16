import FWCore.ParameterSet.Config as cms

config = cms.PSet(
    fill = cms.uint32(0),
    xangle = cms.uint32(0),
    beta = cms.double(0),
    dataset = cms.string(""),

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

    sector_45 = cms.PSet(
	  cut_h_apply = cms.bool(True),
	  cut_h_a = cms.double(-1),
	  cut_h_c = cms.double(0.),
	  cut_h_si = cms.double(0.2),

	  cut_v_apply = cms.bool(True),
	  cut_v_a = cms.double(-1.07),
	  cut_v_c = cms.double(0.),
	  cut_v_si = cms.double(0.15),

      nr_x_slice_min = cms.double(7),
      nr_x_slice_max = cms.double(19),
      nr_x_slice_w = cms.double(0.2),

      fr_x_slice_min = cms.double(46),
      fr_x_slice_max = cms.double(58),
      fr_x_slice_w = cms.double(0.2),
    ),

    sector_56 = cms.PSet(
	  cut_h_apply = cms.bool(False),
	  cut_h_a = cms.double(-1),
	  cut_h_c = cms.double(0.),
	  cut_h_si = cms.double(0.2),

	  cut_v_apply = cms.bool(False),
	  cut_v_a = cms.double(-1.07),
	  cut_v_c = cms.double(0.),
	  cut_v_si = cms.double(0.15),

      nr_x_slice_min = cms.double(6),
      nr_x_slice_max = cms.double(17.),
      nr_x_slice_w = cms.double(0.2),

      fr_x_slice_min = cms.double(45),
      fr_x_slice_max = cms.double(57.),
      fr_x_slice_w = cms.double(0.2),
    ),

    matching = cms.PSet(
      reference_datasets = cms.vstring("default"),

      rp_L_1_F = cms.PSet(
        sh_min = cms.double(-43),
        sh_max = cms.double(-41)
      ),
      rp_L_1_N = cms.PSet(
        sh_min = cms.double(-4.2),
        sh_max = cms.double(-2.4)
      ),
      rp_R_1_N = cms.PSet(
        sh_min = cms.double(-3.6),
        sh_max = cms.double(-1.8)
      ),
      rp_R_1_F = cms.PSet(
        sh_min = cms.double(-43.2),
        sh_max = cms.double(-41.2)
      )
    ),

    x_alignment_meth_x = cms.PSet(
      rp_L_1_F = cms.PSet(
        x_min = cms.double(49),
        x_max = cms.double(57.),
      ),
      rp_L_1_N = cms.PSet(
        x_min = cms.double(11.),
        x_max = cms.double(18.),
      ),
      rp_R_1_N = cms.PSet(
        x_min = cms.double(7.5),
        x_max = cms.double(18.),
      ),
      rp_R_1_F = cms.PSet(
        x_min = cms.double(47.),
        x_max = cms.double(57.),
      )
    ),

    x_alignment_meth_y = cms.PSet(
      rp_L_1_F = cms.PSet(
        x_min = cms.double(46.),
        x_max = cms.double(49.),
      ),
      rp_L_1_N = cms.PSet(
        x_min = cms.double(7.5),
        x_max = cms.double(10.5),
      ),
      rp_R_1_N = cms.PSet(
        x_min = cms.double(6),
        x_max = cms.double(9.),
      ),
      rp_R_1_F = cms.PSet(
        x_min = cms.double(45.),
        x_max = cms.double(49.),
      )
    ),

    x_alignment_meth_o = cms.PSet(
      rp_L_1_F = cms.PSet(
        x_min = cms.double(47.),
        x_max = cms.double(56.5),
      ),
      rp_L_1_N = cms.PSet(
        x_min = cms.double(9.),
        x_max = cms.double(18.5),
      ),
      rp_R_1_N = cms.PSet(
        x_min = cms.double(7.),
        x_max = cms.double(15.),
      ),
      rp_R_1_F = cms.PSet(
        x_min = cms.double(46.),
        x_max = cms.double(54.),
      )
    ),

    x_alignment_relative = cms.PSet(
      rp_L_1_F = cms.PSet(
        x_min = cms.double(0.),
        x_max = cms.double(0.),
      ),
      rp_L_1_N = cms.PSet(
        x_min = cms.double(7.5),
        x_max = cms.double(12.),
      ),
      rp_R_1_N = cms.PSet(
        x_min = cms.double(6.),
        x_max = cms.double(10.),
      ),
      rp_R_1_F = cms.PSet(
        x_min = cms.double(0.),
        x_max = cms.double(0.),
      )
    ),

    y_alignment = cms.PSet(
      rp_L_1_F = cms.PSet(
        x_min = cms.double(4.0),
        x_max = cms.double(14.0),
      ),
      rp_L_1_N = cms.PSet(
        x_min = cms.double(4.5),
        x_max = cms.double(14.5),
      ),
      rp_R_1_N = cms.PSet(
        x_min = cms.double(0),
        x_max = cms.double(0),
      ),
      rp_R_1_F = cms.PSet(
        x_min = cms.double(4.),
        x_max = cms.double(13.0),
      )
    ),

    y_alignment_alt = cms.PSet(
      rp_L_1_F = cms.PSet(
        x_min = cms.double(0.),
        x_max = cms.double(0.),
      ),
      rp_L_1_N = cms.PSet(
        x_min = cms.double(7.),
        x_max = cms.double(19.),
      ),
      rp_R_1_N = cms.PSet(
        x_min = cms.double(6),
        x_max = cms.double(17.),
      ),
      rp_R_1_F = cms.PSet(
        x_min = cms.double(0.),
        x_max = cms.double(0.),
      )
    )
)

#----------------------------------------------------------------------------------------------------

def ApplyDefaultSettingsAlignmentSeptember():
  config.sector_45.cut_h_a = cms.double(-1)
  config.sector_45.cut_h_c = cms.double(+0.33)
  config.sector_45.cut_h_si = cms.double(0.2)

  config.sector_45.cut_v_a = cms.double(-1.13)
  config.sector_45.cut_v_c = cms.double(-0.13)
  config.sector_45.cut_v_si = cms.double(0.15)

# TODO: if needed...
#def ApplyDefaultSettings1():
