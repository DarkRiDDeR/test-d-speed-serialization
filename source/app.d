import std.stdio;
import std.datetime.stopwatch;
import std.format;

import cerealed;

import std.json;

import jsonizer;
import jsonizer.jsonize;
import jsonizer.fromjson;
import jsonizer.tojson;

import drmi.sbin;

pragma(lib, "ws2_32");
import msgpack;


void printResults (long size, int itersCount, Duration serializeResult, Duration deSerializeResult)
{
    write("serialize test = ");
    write(serializeResult);
    writeln (format!(". Size = %s")(cast(long)size * cast(long)itersCount));
    write("deserialize test = ");
    writeln(deSerializeResult);
}

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
    printResults(cast(long)(serializeData.sizeof * serializeData.length), itersCount, r[0], r[1]);
}

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
    printResults(cast(long)(serializeData.sizeof * serializeData.length), itersCount, r[0], r[1]);
}

void testMsgPack(T)(T data, int itersCount)
{
    ubyte[] serializeData = pack(data);
    auto deSerializeData = msgpack.unpack(serializeData).as!(T);

    assert(deSerializeData == data);

    void serializeTest() {
        pack(data);
    }
    void deSerializeTest() {
        msgpack.unpack(serializeData).as!(T);
    }
    auto r = benchmark!(serializeTest, deSerializeTest)(itersCount);
    printResults(cast(long)(serializeData.sizeof * serializeData.length), itersCount, r[0], r[1]);
}

void testDrmi(T)(T data, int itersCount)
{
    auto serializeData = data.sbinSerialize;
    auto deSerializeData = serializeData.sbinDeserialize!T;

    assert(deSerializeData == data);

    void serializeTest() {
        data.sbinSerialize;
    }
    void deSerializeTest() {
        serializeData.sbinDeserialize!T;
    }
    auto r = benchmark!(serializeTest, deSerializeTest)(itersCount);
    printResults(cast(long)(serializeData.sizeof * serializeData.length), itersCount, r[0], r[1]);
}


void testJsonBook(StructBook data, int itersCount)
{
    JSONValue jj = ["name": data.name];
    jj.object["pageNumber"] = JSONValue(data.pageNumber);
    jj.object["published"] = JSONValue(data.published);
    jj.object["author"] = JSONValue(data.author);
    jj.object["description"] = JSONValue(data.description);

    auto serializeData = jj.toString;
    auto deSerializeData = parseJSON(serializeData);

    assert(deSerializeData["name"].str == data.name);
    assert(deSerializeData["pageNumber"].integer == data.pageNumber);
    assert(deSerializeData["published"].str == data.published);
    assert(deSerializeData["author"].str == data.author);
    assert(deSerializeData["description"].str == data.description);

    void serializeTest() {
        JSONValue jj = ["name": data.name];
        jj.object["pageNumber"] = JSONValue(data.pageNumber);
        jj.object["published"] = JSONValue(data.published);
        jj.object["author"] = JSONValue(data.author);
        jj.object["description"] = JSONValue(data.description);
        jj.toString;
    }
    void deSerializeTest() {
        deSerializeData = parseJSON(serializeData);
        deSerializeData["name"].str;
        deSerializeData["pageNumber"].integer;
        deSerializeData["published"].str;
        deSerializeData["author"].str;
        deSerializeData["description"].str;
    }
    auto r = benchmark!(serializeTest, deSerializeTest)(itersCount);
    printResults(serializeData.sizeof * serializeData.length, itersCount, r[0], r[1]);
}

void testJsonPage(StructPage data, int itersCount)
{
    JSONValue jj = ["data": data.data];
    jj.object["time"] = JSONValue(data.time);

    auto serializeData = jj.toString;
    auto deSerializeData = parseJSON(serializeData);

    assert(deSerializeData["data"].str == data.data);
    assert(deSerializeData["time"].integer == data.time);

    void serializeTest() {
        JSONValue jj = ["data": data.data];
        jj.object["time"] = JSONValue(data.time);
        jj.toString;
    }
    void deSerializeTest() {
        deSerializeData = parseJSON(serializeData);
        deSerializeData["data"].str;
        deSerializeData["time"].integer;
    }
    auto r = benchmark!(serializeTest, deSerializeTest)(itersCount);
    printResults(serializeData.sizeof * serializeData.length, itersCount, r[0], r[1]);
}


struct StructBook {
    string name = "Alice's Adventures in Wonderland";
    int pageNumber = 195;
    string published = "26 November 1865";
    string author = " 	Lewis Carroll";
    string description = "Alice's Adventures in Wonderland (commonly shortened to Alice in Wonderland) is an 1865 novel written by English author Charles Lutwidge Dodgson under the pseudonym Lewis Carroll.";
}
struct StructPage {
    string data = import("w3c.html"); // 39 kb
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
    testCerealed!StructBook(book, 10_000);
    writeln("page cache");
    testCerealed!StructPage(page, 10_000);
    writeln("long structure");
    testCerealed!StructLong(longD, 10_000);

    writeln("===JSONIZER===");
    writeln("book");
    testJsonizer!StructBookJsonizer(bookJsonizer, 10_000);
    writeln("page cache");
    testJsonizer!StructPageJsonizer(pageJsonizer, 10_000);
    writeln("long structure");
    testJsonizer!StructLongJsonizer(longDJsonizer, 10_000);

    writeln("===MessagePack===");
    writeln("book");
    testMsgPack!StructBook(book, 10_000);
    writeln("page cache");
    testMsgPack!StructPage(page, 10_000);
    writeln("long structure");
    testMsgPack!StructLong(longD, 10_000);

    writeln("===DRMI===");
    writeln("book");
    testDrmi!StructBook(book, 10_000);
    writeln("page cache");
    testDrmi!StructPage(page, 10_000);
    writeln("long structure");
    testDrmi!StructLong(longD, 10_000);

    writeln("===Json===");
    writeln("book");
    testJsonBook(book, 10_000);
    writeln("page cache");
    testJsonPage(page, 10_000);
}
