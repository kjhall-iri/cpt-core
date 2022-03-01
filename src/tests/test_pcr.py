import cpttools as ct 
from .. import principal_components_regression


from pathlib import Path 
def test_pcr():
    x = ct.open_cptdataset(Path( __file__ ).absolute().parents[0] / 'data/SEASONAL_CANCM4I_PRCP_HCST_JUN-SEP_None_2021-05.tsv').prec
    y = ct.open_cptdataset( Path( __file__).absolute().parents[0] / 'data/SEASONAL_CPCCMAPURD_PRCP_OBS_JUN-SEP_None_2021-05.tsv') .prate
    f = x.isel(T=slice(-1, None))
    x = x.isel(T=slice(None,-1))
    hcsts, dfcst, pfcst, skill, loadings = principal_components_regression(x, y, F=f, cpt_kwargs={'log':'pcr_log'})