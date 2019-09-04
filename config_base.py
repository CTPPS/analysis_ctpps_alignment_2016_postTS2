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
	  cut_h_c = cms.double(-0.88),
	  cut_h_si = cms.double(0.2),

      cut_v_apply = cms.bool(True),
      cut_v_a = cms.double(-1.13),
	  cut_v_c = cms.double(-0.48),
      cut_v_si = cms.double(0.15),

      nr_x_slice_min = cms.double(7),
      nr_x_slice_max = cms.double(17),
      nr_x_slice_w = cms.double(0.2),

      fr_x_slice_min = cms.double(7),
      fr_x_slice_max = cms.double(17),
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

      nr_x_slice_min = cms.double(7),
      nr_x_slice_max = cms.double(19.),
      nr_x_slice_w = cms.double(0.2),

      fr_x_slice_min = cms.double(7),
      fr_x_slice_max = cms.double(19.),
      fr_x_slice_w = cms.double(0.2),
    ),

    matching = cms.PSet(
      reference_datasets = cms.vstring("default"),

      rp_L_1_F = cms.PSet(
        sh_min = cms.double(-5.5),
        sh_max = cms.double(-2.5)
      ),
      rp_L_1_N = cms.PSet(
        sh_min = cms.double(-5),
        sh_max = cms.double(-2)
      ),
      rp_R_1_N = cms.PSet(
        sh_min = cms.double(-5),
        sh_max = cms.double(-2)
      ),
      rp_R_1_F = cms.PSet(
        sh_min = cms.double(-5.5),
        sh_max = cms.double(-2.5)
      )
    ),

    x_alignment_meth_x = cms.PSet(
      rp_L_1_F = cms.PSet(
        x_min = cms.double(10),
        x_max = cms.double(16),
      ),
      rp_L_1_N = cms.PSet(
        x_min = cms.double(9),
        x_max = cms.double(15),
      ),
      rp_R_1_N = cms.PSet(
        x_min = cms.double(0),
        x_max = cms.double(0),
      ),
      rp_R_1_F = cms.PSet(
        x_min = cms.double(8.8),
        x_max = cms.double(15),
      )
    ),

    x_alignment_meth_y = cms.PSet(
      rp_L_1_F = cms.PSet(
        x_min = cms.double(8),
        x_max = cms.double(15),
      ),
      rp_L_1_N = cms.PSet(
        x_min = cms.double(8),
        x_max = cms.double(14.),
      ),
      rp_R_1_N = cms.PSet(
        x_min = cms.double(0),
        x_max = cms.double(0),
      ),
      rp_R_1_F = cms.PSet(
        x_min = cms.double(7),
        x_max = cms.double(10),
      )
    ),

    x_alignment_meth_o = cms.PSet(
      rp_L_1_F = cms.PSet(
        x_min = cms.double(8.5),
        x_max = cms.double(16),
      ),
      rp_L_1_N = cms.PSet(
        x_min = cms.double(8.5),
        x_max = cms.double(15.),
      ),
      rp_R_1_N = cms.PSet(
        x_min = cms.double(0),
        x_max = cms.double(0),
      ),
      rp_R_1_F = cms.PSet(
        x_min = cms.double(5),
        x_max = cms.double(15),
      )
    ),

    x_alignment_relative = cms.PSet(
      rp_L_1_F = cms.PSet(
        x_min = cms.double(9.5),
        x_max = cms.double(11),
      ),
      rp_L_1_N = cms.PSet(
        x_min = cms.double(9.5),
        x_max = cms.double(11.),
      ),
      rp_R_1_N = cms.PSet(
        x_min = cms.double(0),
        x_max = cms.double(0),
      ),
      rp_R_1_F = cms.PSet(
        x_min = cms.double(7),
        x_max = cms.double(15),
      )
    ),

    y_alignment = cms.PSet(
      rp_L_1_F = cms.PSet(
        x_min = cms.double(7.5),
        x_max = cms.double(13.0),
      ),
      rp_L_1_N = cms.PSet(
        x_min = cms.double(7.5),
        x_max = cms.double(13.0),
      ),
      rp_R_1_N = cms.PSet(
        x_min = cms.double(0),
        x_max = cms.double(0),
      ),
      rp_R_1_F = cms.PSet(
        x_min = cms.double(7.),
        x_max = cms.double(15.0),
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
  config.sector_45.cut_h_c = cms.double(0.)
  config.sector_45.cut_h_si = cms.double(0.2)

  config.sector_45.cut_v_a = cms.double(-1.13)
  config.sector_45.cut_v_c = cms.double(0.)
  config.sector_45.cut_v_si = cms.double(0.15)

  config.sector_45.nr_x_slice_min = cms.double(2)
  config.sector_45.nr_x_slice_max = cms.double(14)

  config.sector_45.fr_x_slice_min = cms.double(2)
  config.sector_45.fr_x_slice_max = cms.double(14)


  config.x_alignment_meth_x.rp_L_1_N.x_min = cms.double(2)
  config.x_alignment_meth_x.rp_L_1_N.x_max = cms.double(20.)

  config.x_alignment_meth_x.rp_L_1_F.x_min = cms.double(2.)
  config.x_alignment_meth_x.rp_L_1_F.x_max = cms.double(20.)

  config.x_alignment_meth_x.rp_R_1_F.x_min = cms.double(2.)
  config.x_alignment_meth_x.rp_R_1_F.x_max = cms.double(20.)


  config.x_alignment_meth_y.rp_L_1_N.x_min = cms.double(2)
  config.x_alignment_meth_y.rp_L_1_N.x_max = cms.double(15.)

  config.x_alignment_meth_y.rp_L_1_F.x_min = cms.double(2.)
  config.x_alignment_meth_y.rp_L_1_F.x_max = cms.double(15.)

  config.x_alignment_meth_y.rp_R_1_F.x_min = cms.double(2.)
  config.x_alignment_meth_y.rp_R_1_F.x_max = cms.double(15.)


  config.x_alignment_meth_o.rp_L_1_N.x_min = cms.double(6)
  config.x_alignment_meth_o.rp_L_1_N.x_max = cms.double(15.)

  config.x_alignment_meth_o.rp_L_1_F.x_min = cms.double(5.)
  config.x_alignment_meth_o.rp_L_1_F.x_max = cms.double(15.)
