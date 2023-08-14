function rec (n: number) {
  let i = n;
  console.log(i);
  rec(++i);
}

rec(0);
