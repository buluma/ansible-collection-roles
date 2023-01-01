set -eou pipefail

PYTHON_CMD=$(command -v python3 || command -v python2 || command -v python)

# Cherry-pick a refspec
# $1 : project name e.g. keystone
# $2 : Gerrit refspec(s) to cherry pick
function cherrypick {
    local PROJ_NAME=$1
    local REFSPECS="$2"

    # check that git is installed
    if ! rpm -qi git &> /dev/null && ! rpm -qi git-core &> /dev/null; then
        echo "Please install git before using this module."
        exit 1
    fi

    if [ ! -d "$PROJ_NAME" ]; then
        git clone "https://opendev.org/openstack/$PROJ_NAME"
    fi
    cd "$PROJ_NAME"
    for REFSPEC in $REFSPECS; do
        git fetch "https://review.opendev.org/openstack/$PROJ_NAME" "$REFSPEC"
        git cherry-pick FETCH_HEAD || git cherry-pick --abort
    done

    SKIP_GENERATE_AUTHORS=1 SKIP_WRITE_GIT_CHANGELOG=1 $PYTHON_CMD setup.py sdist
    cp dist/*.tar.gz ../

}

# Copy a Python directory
# $1 : Python directory to copy and install to generate a tarball.
function copy {
    local PYTHON_DIR=$1

    rm -rf dev
    cp -r $PYTHON_DIR dev
    cd dev
    SKIP_GENERATE_AUTHORS=1 SKIP_WRITE_GIT_CHANGELOG=1 $PYTHON_CMD setup.py sdist
    cp dist/*.tar.gz ../
}

mkdir -p refspec_projects
cd refspec_projects
if [[ "$GERRIT_MODE" == 1 ]]; then
    cherrypick $1 $2
else
    copy $1
fi
