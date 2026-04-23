# for java sdk from temurin:
temurin_path=/opt/temurin-jdk
if ! [[ "$PATH" =~ "$temurin_path:" ]]
then
  PATH="$temurin_path:$PATH"
fi
export PATH
