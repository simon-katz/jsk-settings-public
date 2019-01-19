#!/usr/bin/env bash -e

# TODO Want an option that isn't about dirtiness, but about whether there is
#      any output to see (for any branch).
#      That will need more effort -- moving logic around.


#### Options and usage

script=$(basename ${BASH_SOURCE[0]})

usage() {
    echo "Usage:"
    echo ""
    echo "$(basename ${BASH_SOURCE[0]}) [options]"
    echo ""
    echo "options:"
    echo "-h                Show brief help"
    echo "-d                Only report on dirty Git dirs"
}


ONLY_DIRTY=

while getopts "hd" o; do
    case "${o}" in
        h)
            usage
            exit 0
            ;;
        d)
            shift
            ONLY_DIRTY="YES" # ${OPTARG}  # Leave OPTARG here as a reminder.
            ;;
        ?)
            usage 1>&2
            exit 1
            ;;
    esac
done

shift $((OPTIND-1))


#### Main functionality

# Leave this here as a reminder:
# echo ONLY_DIRTY: $ONLY_DIRTY
# echo rest: $@

if [[ "$ONLY_DIRTY" ]] ; then
    nomis-do-to-all-git-dirty-repos.sh nomis-git-info.sh
else
    nomis-do-to-all-git-repos.sh nomis-git-info.sh
fi
