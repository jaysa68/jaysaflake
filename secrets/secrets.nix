let
  jaysa = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDY6tiLriB8L3kTdhv0fHmQrB7RGaLAL3VWkbv04GnTh";
  tiffany = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOi3OXpGyQY8yLcjYHUlFse1w8MJk31aEdFCjBIFGyK6";
in
{
  "miniflux-admin.age".publicKeys = [
    jaysa
    tiffany
  ];
}
