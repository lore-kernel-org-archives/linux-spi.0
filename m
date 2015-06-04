From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 10/11] spi: add more debug prints in s3c64xx
Date: Thu, 4 Jun 2015 11:56:53 +0100
Message-ID: <20150604105653.GD14071@sirena.org.uk>
References: <cover.1433364398.git.hramrach@gmail.com>
 <305830ebf9c0ae98c4f6e0ebbdec7414d6762b36.1433364398.git.hramrach@gmail.com>
 <20150604091634.GY14071@sirena.org.uk>
 <CAOMqctQxn6UY2DJ9Syp6Ay9SYKLgdU+8EjiTK_48-R3dZ8PcvA@mail.gmail.com>
 <20150604102621.GB14071@sirena.org.uk>
 <CAOMqctRFXWT3m8H4YBH0tzQAL3Y2NUs6XCo2LiF1R0Xz+iWUzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jNp2UUAAd0DeWbgM"
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
	Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Han Xu <han.xu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>,
	Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Alison Chaiken <alison_chaiken-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>,
	Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Ben Hutchings <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>,
	Knut Wohlrab <knut.wohlrab-V5te9oGctAVWk0Htik3J/w@public.gmane.org>,
	Bean Huo =?utf-8?B?6ZyN5paM5paMIChiZWFuaHVvKQ==?=
	<beanhuo-AL4WhLSQfzjQT0dZR+AlfA@public.gmane.org>, "grmoore-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org" <g
To: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAOMqctRFXWT3m8H4YBH0tzQAL3Y2NUs6XCo2LiF1R0Xz+iWUzw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--jNp2UUAAd0DeWbgM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 04, 2015 at 12:52:19PM +0200, Michal Suchanek wrote:

> There is no code interdependency with the other patches so if it's
> preferred I can send patches like this separately.

Yes, that's better practice.

--jNp2UUAAd0DeWbgM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVcC71AAoJECTWi3JdVIfQBj8H/2IDwTMKds4nyc0wJHt1b/zn
r2Xjn1gr2EEPJL71yeJewRKgUFS3df/m3czmwxQ1bLcweAhoDVnHjDQ/DMB0Aqmh
UYbI1tuqCf83hxyDqlNcKsxkZ4hvvtDHxNKQtsVU1LNGsVb+yHFMLDmtQktZtycF
BjLTw15SNHyixdXHrMej+qZt+NjozC7Y38ff9jdo4AAp3B65yokISIVatc93S6iy
wow+h4THuzm+DMrKCXaUwtkqx6kmTEZ1DaxXf8QcKkXyKTzXL1b1riP/0Q1vA+rT
SYgloqyo4pbXTmiyQkOwhARysxqNBpuQ/mesUvlqIS+f60HvJvrTaVgzEIbokVk=
=giwp
-----END PGP SIGNATURE-----

--jNp2UUAAd0DeWbgM--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
