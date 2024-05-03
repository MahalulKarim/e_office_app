String rupiah(value,
    {String separator = '.', String trailing = '', String leading = ''}) {
  return leading +
      value.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]}$separator') +
      trailing;
}
