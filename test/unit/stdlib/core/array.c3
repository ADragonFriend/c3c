module arraytests @test;

fn void contains()
{
	int[3] a = { 1, 2, 3 };
	assert(array::contains(a, 2) == true);
	assert(array::contains(a, 15) == false);
}

fn void find()
{
	int[3] a = { 1, 2, 3 };
	assert(array::index_of(a, 2)!! == 1);
	assert(array::index_of(a, 1)!! == 0);
	assert(array::index_of(a, 3)!! == 2);
	assert(@catch(array::index_of(a, 4)) == NOT_FOUND);
}

fn void find_subarray()
{
	int[] a = { 1, 2, 3 };
	assert(array::index_of(a, 2)!! == 1);
	assert(array::index_of(a, 1)!! == 0);
	assert(array::index_of(a, 3)!! == 2);
	assert(@catch(array::index_of(a, 4)) == NOT_FOUND);
}

fn void concat()
{
	int[3] a = { 1, 2, 3 };
	free(array::concat(mem, a, a));
	free(array::concat(mem, a[..], a[..]));
	free(array::concat(mem, a[:0], a[:0]));
	free(array::concat(mem, (int[2]) { 1, 2 }, a[:0]));
	free(array::concat(mem, a[:0], (int[2]) { 1, 2 }));
	int[] c = array::concat(mem, a[1..2], a);
	defer free(c);
	assert (c == (int[]){ 2, 3, 1, 2, 3 });
}
