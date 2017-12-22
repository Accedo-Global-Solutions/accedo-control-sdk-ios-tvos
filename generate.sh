cd HelperProject



pod install

xcodebuild -verbose -workspace GenerateSymbols.xcworkspace/ -scheme GenerateSymbols ONLY_ACTIVE_ARCH=NO -sdk iphonesimulator  

cd ..
pwd


mkdir AccedoOneiOS/Libraries/
mkdir AccedoOneiOS/Libraries/Symbols
mkdir AccedoOneiOS/Libraries/AFNetworking
mkdir AccedoOneiOS/Libraries/PINCache

mkdir AccedoOnetvOS/Libraries/
mkdir AccedoOnetvOS/Libraries/Symbols
mkdir AccedoOnetvOS/Libraries/AFNetworking
mkdir AccedoOnetvOS/Libraries/PINCache



mkdir AccedoOneiOS/AccedoOneiOS/Libraries/
mkdir AccedoOneiOS/AccedoOneiOS/Libraries/Symbols
mkdir AccedoOneiOS/AccedoOneiOS/Libraries/AFNetworking
mkdir AccedoOneiOS/AccedoOneiOS/Libraries/PINCache

mkdir AccedoOnetvOS/AccedoOnetvOS/Libraries/
mkdir AccedoOnetvOS/AccedoOnetvOS/Libraries/Symbols
mkdir AccedoOnetvOS/AccedoOnetvOS/Libraries/AFNetworking
mkdir AccedoOnetvOS/AccedoOnetvOS/Libraries/PINCache



cp HelperProject/Pods/AFNetworking/AFNetworking/* AccedoOneiOS/AccedoOneiOS/Libraries/AFNetworking/
cp HelperProject/Pods/PINCache/PINCache/* AccedoOneiOS/AccedoOneiOS/Libraries/PINCache/
cp HelperProject/Pods/AFNetworking/AFNetworking/* AccedoOneiOS/Libraries/AFNetworking/
cp HelperProject/Pods/PINCache/PINCache/* AccedoOneiOS/Libraries/PINCache/
cp HelperProject/AFNetworkingDependencies.h AccedoOneiOS/AccedoOneiOS/Libraries/Symbols/
cp HelperProject/PINCacheDependencies.h AccedoOneiOS/AccedoOneiOS/Libraries/Symbols/
cp HelperProject/AFNetworkingDependencies.h AccedoOneiOS/Libraries/Symbols/
cp HelperProject/PINCacheDependencies.h AccedoOneiOS/Libraries/Symbols/


cp HelperProject/Pods/AFNetworking/AFNetworking/* AccedoOnetvOS/AccedoOnetvOS/Libraries/AFNetworking/
cp HelperProject/Pods/PINCache/PINCache/* AccedoOnetvOS/AccedoOnetvOS/Libraries/PINCache/
cp HelperProject/Pods/AFNetworking/AFNetworking/* AccedoOnetvOS/Libraries/AFNetworking/
cp HelperProject/Pods/PINCache/PINCache/* AccedoOnetvOS/Libraries/PINCache/
cp HelperProject/AFNetworkingDependencies.h AccedoOnetvOS/AccedoOnetvOS/Libraries/Symbols/
cp HelperProject/PINCacheDependencies.h AccedoOnetvOS/AccedoOnetvOS/Libraries/Symbols/
cp HelperProject/AFNetworkingDependencies.h AccedoOnetvOS/Libraries/Symbols/
cp HelperProject/PINCacheDependencies.h AccedoOnetvOS/Libraries/Symbols/



./addsources.rb

rm -rf AccedoOneiOS/Libraries/
rm -rf AccedoOnetvOS/Libraries/