#!/bin/sh

cd /tmp

if [[ ! -f llvm-gcc ]]; then
    echo "ERROR: LLVM 3.0 or 3.2+ must be installed on your platform to proceed."
    exit 1
fi


echo "Downloading GHC for iOS devices..."

curl -OL https://www.haskell.org/ghc/dist/7.8.3/ghc-7.8.3-arm-apple-ios.tar.xz
tar xvf ghc-7.8.3-arm-apple-ios.tar.xz && mv ghc-7.8.3 ghc-7.8.3-arm
rm ghc-7.8.3-arm-apple-ios.tar.xz
cd ghc-7.8.3-arm

# Remove befuddling inclusion of my local paths
LC_CTYPE=C 
LANG=C
find . -type f -not -name .DS_Store -not -name "*.a" -print0 | xargs -0 sed -i '' 's|/Users/lukexi/Code/ghc-ios-scripts/||g'

./configure
# Fix the settings file to point to the right scripts and clang versions
sed -i '' 's|/usr/bin/gcc|arm-apple-darwin10-clang|g' settings
sed -i '' 's|/usr/bin/ld|arm-apple-darwin10-ld|g' settings
sed -i '' 's|"opt"|"/usr/local/clang-3.0/bin/opt"|g' settings
sed -i '' 's|"llc"|"/usr/local/clang-3.0/bin/llc"|g' settings
make install
cd ..
rm -r ghc-7.8.3-arm

echo "Downloading GHC for the iOS simulator..."
cd /tmp
curl -OL https://www.haskell.org/ghc/dist/7.8.3/ghc-7.8.3-i386-apple-ios.tar.xz
tar xvf ghc-7.8.3-i386-apple-ios.tar.xz && mv ghc-7.8.3 ghc-7.8.3-i386
rm ghc-7.8.3-i386-apple-ios.tar.xz
cd ghc-7.8.3-i386

# ditto above
LC_CTYPE=C 
LANG=C
find . -type f -not -name .DS_Store -not -name "*.a" -print0 | xargs -0 sed -i '' 's|/Users/lukexi/Code/ghc-ios-scripts/||g'

./configure
# Fix the settings file to point to the right scripts and clang versions
sed -i '' 's|/usr/bin/gcc|i386-apple-darwin11-clang|g' settings
sed -i '' 's|/usr/bin/ld|i386-apple-darwin11-ld|g' settings
sed -i '' 's|"opt"|"/usr/local/clang-3.0/bin/opt"|g' settings
sed -i '' 's|"llc"|"/usr/local/clang-3.0/bin/llc"|g' settings
make install
cd ..
rm -r ghc-7.8.3-i386
