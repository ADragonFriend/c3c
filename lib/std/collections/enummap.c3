<*
 @require Enum.kindof == TypeKind.ENUM : "Only enums may be used with an enummap"
*>
module std::collections::enummap{Enum, ValueType};
import std::io;

struct EnumMap (Printable)
{
	ValueType[Enum.len] values;
}

fn void EnumMap.init(&self, ValueType init_value)
{
	foreach (&a : self.values)
	{
		*a = init_value;
	}
}

fn usz? EnumMap.to_format(&self, Formatter* formatter) @dynamic
{
	usz n = formatter.print("{ ")!;
	foreach (i, &value : self.values)
	{
		if (i != 0) formatter.print(", ")!;
		n += formatter.printf("%s: %s", Enum.from_ordinal(i), *value)!;
	}
	n += formatter.print(" }")!;
	return n;
}

<*
 @return "The total size of this map, which is the same as the number of enum values"
 @pure
*>
fn usz EnumMap.len(&self) @operator(len) @inline
{
	return self.values.len;
}

<*
 @return "Retrieve a value given the underlying enum, if there is no entry, then the zero value for the value is returned."
*>
fn ValueType EnumMap.get(&self, Enum key) @operator([]) @inline
{
	return self.values[key.ordinal];
}

fn ValueType* EnumMap.get_ref(&self, Enum key) @operator(&[]) @inline
{
	return &self.values[key.ordinal];
}

fn void EnumMap.set(&self, Enum key, ValueType value) @operator([]=) @inline
{
	self.values[key.ordinal] = value;
}