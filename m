From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: Use reinit_completion at appropriate places
Date: Mon, 10 Feb 2014 12:32:33 +0000
Message-ID: <20140210123233.GX1757@sirena.org.uk>
References: <1391915164.17493.5.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QHp3Wr1K3N9pKO2V"
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>,
	Tanguy Bouzeloc <tanguy.bouzeloc-HH44TBFINEIAvxtiuMwx3w@public.gmane.org>,
	Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1391915164.17493.5.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--QHp3Wr1K3N9pKO2V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Feb 09, 2014 at 11:06:04AM +0800, Axel Lin wrote:
> Calling init_completion() once is enough.
> For the rest of the iterations, call reinit_completion() instead.

Applied, thanks.

--QHp3Wr1K3N9pKO2V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS+MbdAAoJELSic+t+oim9yGAP/2fbr/WxQEm1JrzLZn502NyB
B0l6xG09EiZY9M68fxtfqLktm2UchNTJzqAyq+FkzybwyzJI4yMQwiswzvTA1D71
Dq4hyhE6HtdnMCPb56MdznmrBVnTBHuxS3YUy+IdAZ9/Fs4JnYxLJH+eLBLXMXnL
pVEsb8avV9Z08F95bIiSu4ua3WQZcm8pFBrdPCTm/p7SpquoCfeabVSPocljVmZh
3rexB7rvVzHGL6+aB7aNvjZsGLNUC4JqVBDFL/aJaHDSSzXJjOcpnbcYidOf6ga0
L2FFRXuxc1GhqJd47oUwwpPrXZ7tMJGEUUqBU/dkZu5kiT1PdDPmKOUH+k/tEo5q
4+bKZlUl/utcxEQWJzAposUxDJQpIKKTyw51u9wgjP4hWgAhnf9BQad5IlbAqK6m
r9tJhqzg+PT9PdkBBp9jy1RCnOoPpDxOz+5nmDM35l5m8kE+SqcteBCrYRPPIYvW
gler/Wff18qcAxT0mgsu6PnJth9InK9mitxMEMP2a5ZRq9xxxeo68jxd53Lmci8M
FSexYo9yvcO5HJnMFIpff3oFvEEvqwc0oqa9NWIkdDK/86bNlfeOUP0fm9imOdkP
lxazyHTTw4dis5XIAEJTPHG6Mr7kV6zTSl+p+eIKh5jntMxfZrcVmBLF5TGzKV/t
sgiF5mtgv37OsRrSFWDg
=5/zf
-----END PGP SIGNATURE-----

--QHp3Wr1K3N9pKO2V--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
