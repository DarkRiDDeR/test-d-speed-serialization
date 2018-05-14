import std.stdio;
import std.datetime.stopwatch;
import std.format;

import cerealed;

import std.json;

import jsonizer;
import jsonizer.jsonize;
import jsonizer.fromjson;
import jsonizer.tojson;

import msgpack;

/*import orange.serialization._;
import orange.serialization.archives._;
*/

void testCerealed(T)(T data, int itersCount)
{
    ubyte[] serializeData = data.cerealise;
    auto deSerializeData = serializeData.decerealize!T;
    assert(deSerializeData == data);

    void serializeTest() {
        data.cerealise;
    }
    void deSerializeTest() {
        serializeData.decerealize!T;
    }
    auto r = benchmark!(serializeTest, deSerializeTest)(itersCount);

    Duration serializeResult = r[0];
    Duration deSerializeResult = r[1];

    write("serialize test = ");
    write(serializeResult);
    writeln (format!(". Size = %s")(ubyte.sizeof * serializeData.length * itersCount));
    write("deserialize test = ");
    writeln(deSerializeResult);
}


/*void testOrange(T)(T data, int itersCount)
{
    auto archive = new XmlArchive!(char); // create an XML archive
	auto serializer = new Serializer(archive); // create the serializer

	serializer.serialize(data); // serialize


    auto deSerializeData = serializer.deserialize!(T)(archive.untypedData);
    assert(deSerializeData == data);


    ubyte[] serializeData = data.cerealise;
    auto deSerializeData = serializeData.decerealize!T;
    assert(deSerializeData == data);

    void serializeTest() {
        data.cerealise;
    }
    void deSerializeTest() {
        serializeData.decerealize!T;
    }
    auto r = benchmark!(serializeTest, deSerializeTest)(itersCount);

    Duration serializeResult = r[0];
    Duration deSerializeResult = r[1];

    write("serialize test = ");
    write(serializeResult);
    writeln (format!(". Size = %s")(ubyte.sizeof * serializeData.length * itersCount));
    //write("deserialize test = ");
    //writeln(deSerializeResult);
}*/

void testJsonizer(T)(T data, int itersCount)
{
    auto serializeData = data.toJSONString;
    auto deSerializeData = serializeData.fromJSONString!T;

    assert(deSerializeData == data);

    void serializeTest() {
        data.toJSONString;
    }
    void deSerializeTest() {
        serializeData.fromJSONString!T;
    }
    auto r = benchmark!(serializeTest, deSerializeTest)(itersCount);

    Duration serializeResult = r[0];
    Duration deSerializeResult = r[1];

    write("serialize test = ");
    write(serializeResult);
    writeln (format!(". Size = %s")(serializeData.sizeof * serializeData.length * itersCount));
    write("deserialize test = ");
    writeln(deSerializeResult);
}


void testJson(T)(T data, int itersCount)
{
    auto serializeData = data.toJSONString;
    auto deSerializeData = serializeData.fromJSONString!T;

    assert(deSerializeData == data);

    void serializeTest() {
        data.toJSONString;
    }
    void deSerializeTest() {
        serializeData.fromJSONString!T;
    }
    auto r = benchmark!(serializeTest, deSerializeTest)(itersCount);

    Duration serializeResult = r[0];
    Duration deSerializeResult = r[1];

    write("serialize test = ");
    write(serializeResult);
    writeln (format!(". Size = %s")(serializeData.sizeof * serializeData.length * itersCount));
    write("deserialize test = ");
    writeln(deSerializeResult);
}

struct StructBook {
    string name = "Alice's Adventures in Wonderland";
    int pageNumber = 195;
    string published = "26 November 1865";
    string author = " 	Lewis Carroll";
    string description = "Alice's Adventures in Wonderland (commonly shortened to Alice in Wonderland) is an 1865 novel written by English author Charles Lutwidge Dodgson under the pseudonym Lewis Carroll.";
}
struct StructPage {
    string data = import("w3c.html");
    int time = 1522852522; // Epoch timestamp
}
struct StructLong {
    string str1 = "str";
    string str2 = "str";
    string str3 = "str";
    string[] strAr = ["str","str","str","str","str","str"];
    int i1 = 15;
    int i2 = 654654;
    int i3 = 155645556;
    int[] iAr = [4557,4571,457,457,457,457,457,457,457,457];
    float[] fAr = [45.646456,45.646456,45.646456,45.646456,45.646456,45.646456,45.646456 ];
}

// structs for jsonizer
struct StructBookJsonizer {
    mixin JsonizeMe;
    @jsonize {
        string name = "Alice's Adventures in Wonderland";
        int pageNumber = 195;
        string published = "26 November 1865";
        string author = " 	Lewis Carroll";
        string description = "Alice's Adventures in Wonderland (commonly shortened to Alice in Wonderland) is an 1865 novel written by English author Charles Lutwidge Dodgson under the pseudonym Lewis Carroll.";
    }
}
struct StructPageJsonizer {
    mixin JsonizeMe;
    @jsonize {
        string data = import("w3c.html");
        int time = 1522852522; // Epoch timestamp
    }
}
struct StructLongJsonizer {
    mixin JsonizeMe;
    @jsonize {
        string str1 = "str";
        string str2 = "str";
        string str3 = "str";
        string[] strAr = ["str","str","str","str","str","str"];
        int i1 = 15;
        int i2 = 654654;
        int i3 = 155645556;
        int[] iAr = [4557,4571,457,457,457,457,457,457,457,457];
        float[] fAr = [45.646456,45.646456,45.646456,45.646456,45.646456,45.646456,45.646456 ];
    }
}


void main()
{
    StructBook book;
    StructPage page;
    StructLong longD;

    StructBookJsonizer bookJsonizer;
    StructPageJsonizer pageJsonizer;
    StructLongJsonizer longDJsonizer;


    writeln("===CEREALED===");
    writeln("book");
    testCerealed!StructBook(book, 100_000);
    writeln("page cache");
    testCerealed!StructPage(page, 100_000);
    writeln("long structure");
    testCerealed!StructLong(longD, 100_000);


    /*writeln("===ORANGE===");
    writeln("book");
    testOrange!StructBook(book, 10_000);
    writeln("page cache");
    testOrange!StructPage(page, 10_000);
    writeln("long structure");
    testOrange!StructLong(longD, 10_000);*/

    writeln("===JSONIZER===");
    writeln("book");
    testJsonizer!StructBookJsonizer(bookJsonizer, 100_000);
    writeln("page cache");
    testJsonizer!StructPageJsonizer(pageJsonizer, 100_000);
    writeln("long structure");
    testJsonizer!StructLongJsonizer(longDJsonizer, 100_000);
}
