#!/bin/sh

#  ci_post_clone.sh
#  TapDrillForKids
#
#  Created by 若江照仁 on 2023/03/17.
#  
cd $CI_WORKSPACE

# SwiftGen
brew install swiftgen
swiftgen config run --config "$CI_WORKSPACE/swiftgen.yml"
