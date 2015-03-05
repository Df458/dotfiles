for dir in `find . -type d`; do
    $(stow -t~ dir)
done
