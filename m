From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V2] spi: bcm53xx: driver for SPI controller on Broadcom
 bcma SoC
Date: Tue, 19 Aug 2014 11:31:06 -0500
Message-ID: <20140819163106.GM24407@sirena.org.uk>
References: <1408228864-20313-1-git-send-email-zajec5@gmail.com>
 <1408293218-32439-1-git-send-email-zajec5@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="P9KQiUGMzYCFwWCN"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1408293218-32439-1-git-send-email-zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--P9KQiUGMzYCFwWCN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 17, 2014 at 06:33:38PM +0200, Rafa=C5=82 Mi=C5=82ecki wrote:
> Broadcom 53xx ARM SoCs use bcma bus that contains various cores (AKA
> devices). If board has a serial flash, it's connected over SPI and the
> bcma bus includes a SPI controller. Example log from such a board:
> bus0: Found chip with id 53010, rev 0x00 and package 0x02
> (...)
> bus0: Core 18 found: SPI flash controller (manuf 0x4BF, id 0x50A, rev 0x0=
1, class 0x0)

Applied, thanks.

--P9KQiUGMzYCFwWCN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT83vHAAoJELSic+t+oim9pmYP/140bsOStK3B21XxseuUZF/r
6QFcaKUSIYJv3kiOAFbRdCwNOCo3euNjtRx02ZLMC6AME09MGEzPnCou/rmpaQY3
k523eaxslaObXY6zTVlQiLi7B4CQ2pNwVl8n9tudg17s64pa40rvOj7PS5ArISnI
6FBs4q+9HWh1Grn+rt3Vj/ZLAbt/hAw5B2vJqugZ/icy21wBBHPcaAp/OmgMjgoL
vBKJe9MrRPjDahXRAYsMxz54Uo6RYLOlDJ9lNDVIGOMU7Sp7qfBF2UlUsmWxQad3
V+IPhW0PAoQrnJuOA5eZFqG0aAXM6jzL3S9PEhDBTSviZG6FogFdhhYw7r5nHcnE
4GyLCi/sTU469qKgGzyGwyfeCpmvNcZ26eSgAV/7pMpo9dsBQUG5u8Ogp8XzXzPh
AG0gPBF1EhxfHN7kwA7uH0yUqQDY0HZCHo2oTUCD0OtWwbKCTNfsAqSqTDMCu0ZQ
Z5iPpy7lJvA0Rdf8gZeXr8rPhzTo3fjJnHJE4DShHeGgGK90iekAkPApAQnNvTXW
v+TJ+VIP4DQ4DPLIv06gsBnG3n7+Q+3T4YBIj+Vvoibbq5qafVjbU+Xq7Bk+/oT9
iDWtPZgzbIKo8jgzOpgL1aka65mEDKOnyHPSFAWO5VQc7xIs93GoRZCBUGioou+n
LO3gvdguyVeNgCtlYF+p
=/5NW
-----END PGP SIGNATURE-----

--P9KQiUGMzYCFwWCN--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
