From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5 08/10] spi: expose master transfer size limitation.
Date: Tue, 1 Dec 2015 21:31:52 +0000
Message-ID: <20151201213152.GW1929@sirena.org.uk>
References: <cover.1448988089.git.hramrach@gmail.com>
 <8c34c7790244489c2ce0072c72bd9bc7c4cdb965.1448988089.git.hramrach@gmail.com>
 <20151201195816.GS1929@sirena.org.uk>
 <565E0C2B.4070504@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wGE1Wqqn9IXiFm4H"
Cc: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
	Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Han Xu <han.xu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>,
	Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
	"Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Gabor Juhos <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>,
	Bean Huo =?utf-8?B?6ZyN5paM5paM?= <beanhuo-AL4WhLSQfzjQT0dZR+AlfA@public.gmane.org>,
	Furquan Shaikh <furquan-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>,
	linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <565E0C2B.4070504-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--wGE1Wqqn9IXiFm4H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 01, 2015 at 10:07:55PM +0100, Heiner Kallweit wrote:

> Sure .. Just one inquiry:
> When you say "the naming here" you refer to Michal's or my version?

Michael's (transfer).

> Actually I like in Michal's hook that it directly takes a struct spi_device.
> This saves the caller one level of indirection as the caller usually will
> deal with a spi_device and not a spi_master.

> If you're fine with Michal's version then this is also fine with me,
> especially as the functionality is the same.

OK.

--wGE1Wqqn9IXiFm4H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWXhHHAAoJECTWi3JdVIfQGt0H/RrrYHiYZL2tii1DcolmEmVm
0Zzz54ngc0PUiDuUJO25EKlwYmDPNUNxLZBldTWnvRWifhl7pfBePTdPbELdiqi3
qSWmwsJDMVhH655vuU5a3HrU+Mm4Cu0HH3qGfyrTwhOZfNE8k0JvStuzpKnYELsU
Yt1xl/y/Fgn4gwUl6PnA5mCA8bs68gE0ouT8mK4fw60fJCK1/AkdG54Ky9bzHZed
6sjof/3B9Ld0t2X33jczI8WMn0mXlPDotXNelfOtWTADqlSxywSZhwOupHMiNWED
ULFA/mkzi0H4hsrZqeW0dbZhRQD1ZxSPDKJViZC4SPfDek05Gw5D89i2QH2WCKo=
=kDAi
-----END PGP SIGNATURE-----

--wGE1Wqqn9IXiFm4H--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
