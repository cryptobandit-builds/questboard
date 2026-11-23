# gnokey cheat sheet for the onyx-1 testnet

```sh
REMOTE=https://rpc.onyx.testnets.gno.land:443
CHAINID=onyx-1
```

| Task | Command |
|---|---|
| New key | `gnokey add mykey` |
| Show address | `gnokey list` |
| Balance | `gnokey query bank/balances/<g1addr> -remote $REMOTE` |
| Gas price | `gnokey query auth/gasprice -remote $REMOTE` |
| Send GNOT | `gnokey maketx send -to <g1addr> -send 1000000ugnot -gas-fee 1000000ugnot -gas-wanted 2000000 -broadcast -chainid $CHAINID -remote $REMOTE mykey` |
| Deploy a realm | `gnokey maketx addpkg -pkgpath gno.land/r/<g1addr>/name -pkgdir . -gas-fee 10000000ugnot -gas-wanted 200000000 -max-deposit 20000000ugnot -broadcast -chainid $CHAINID -remote $REMOTE mykey` |
| Call a function | `gnokey maketx call -pkgpath <pkg> -func Name -args a -args b -gas-fee 1000000ugnot -gas-wanted 20000000 -broadcast -chainid $CHAINID -remote $REMOTE mykey` |
| Call with coins | add `-send 1000000ugnot` |
| Read a page | `gnokey query vm/qrender -data "<pkg>:<path>" -remote $REMOTE` |
| Evaluate an expression | `gnokey query vm/qeval -data "<pkg>.Func(1)" -remote $REMOTE` |
| List a package's files | `gnokey query vm/qfile -data "<pkg>" -remote $REMOTE` |

Notes

- 1 GNOT = 1,000,000 ugnot. Onyx's gas price is 1ugnot per 1,000 gas, and storage locks 100ugnot per byte.
- Use `-max-deposit` to cap the storage deposit a transaction may lock.
- New packages are parked until the testnet's package approver enables them. Check https://gpas.latest.testnets.gno.land.
- Faucet: https://faucet.gno.land (pick Onyx).
