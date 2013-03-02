From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH -next] spi: fix return value check in ce4100_spi_probe()
Date: Sat, 2 Mar 2013 11:58:28 +0800
Message-ID: <20130302035825.GG6610@opensource.wolfsonmicro.com>
References: <CAPgLHd-PhE2igUQOeg90H98Ni55DwfYdp0D52uaBK0=J3M1V+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HB4mHL4PVvkpZAgW"
Cc: eric.y.miao@gmail.com, linux@arm.linux.org.uk,
	haojian.zhuang@gmail.com, grant.likely@secretlab.ca,
	yongjun_wei@trendmicro.com.cn,
	linux-arm-kernel@lists.infradead.org,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPgLHd-PhE2igUQOeg90H98Ni55DwfYdp0D52uaBK0=J3M1V+g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--HB4mHL4PVvkpZAgW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 22, 2013 at 10:52:35AM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>=20
> In case of error, the function platform_device_register_full()
> returns ERR_PTR() and never returns NULL. The NULL test in the
> return value check should be replaced with IS_ERR().

Applied, thanks.

--HB4mHL4PVvkpZAgW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRMXjaAAoJELSic+t+oim9DEsP/3UW9sJZ3GaPtY0dexitRsZ1
BCpg99cQJfRPUWpUyEvQWBxaR0EH8xyWO+qzibN0qgbNAzwLzuDg2Df2bIPiC2x1
vH5yEdvs0gejJFHj33zoxQj/IxtjRQCHmSAGpBaj9ojS/UnfhcZBRoC6NJbtcVCJ
HWyDrUvKoAiQQBXaowPGLeGrDUM68/nozS5UfSyi7aKC7T5ANcs3WKaWqmf0eu2i
SciDEhlcjohAevCT/olAVCq+WPt5iPf6c5QN1aYQmaXctANg3SXQ0gSzVq8ldFxy
RTiLOaSJEF3XlJz/1za1Eo7N79PzBilLh+Fd9GfaFMbKkvCsd+x/H7u9V1KIRDN7
vtV4qMhifXhcNYmE4VksD70PJNzj+NyG4fPyXEAJlihmq2Fyr1179oQePvh3J6TF
4vy+itTpEvJ9SKQe1fKW/hfNEJTz+XAJAMmFns3tMeApAj7uVvJFoAkzKgGG/S6+
0hODSgTJg6+SW6CZ8QkxhMFqBc7Dk2GNThrRgwfJx6ngrCsXZmP8Abjdx8bBN1uW
hWV7sK6EMMtOkDjQ7TVuknAGC3zhjtgRXZ8t+mLijWCmYb0x1bLvTOU0EmUm582O
pBZPpeMy9xGd40x3Gh/+xW8pd/RK/BuPaUBi25NkKySr+6tW51nwP+3MbHbNXlqh
EMGjRYSrSgHAM1BF2JtW
=oR2p
-----END PGP SIGNATURE-----

--HB4mHL4PVvkpZAgW--
