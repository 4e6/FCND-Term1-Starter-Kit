with import <nixpkgs> {};

stdenv.mkDerivation {
  name = "impurePythonEnv";
  buildInputs = [
    # these packages are required for virtualenv and pip to work:
    python3Full
    python3Packages.virtualenv
    python3Packages.jupyter
    python3Packages.pip
    # python deps
    python3Packages.matplotlib
    python3Packages.numpy
    python3Packages.pillow
    python3Packages.lxml
    python3Packages.scipy
    # system dependencies
    git
    stdenv
    which
  ];

  src = null;

  LANG = "en_US.UTF-8";

  shellHook = ''
    # set SOURCE_DATE_EPOCH so that we can use python wheels
    export SOURCE_DATE_EPOCH=$(date +%s)
    virtualenv --no-setuptools venv
    export PATH=$PWD/venv/bin:$PATH
    export PYTHONPATH=venv/lib/python3.6/site-packages/:$PYTHONPATH
    pip install -r requirements.txt
  '';
}
