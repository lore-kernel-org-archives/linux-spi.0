From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] spi: orion.c: Add direct access mode
Date: Wed, 23 Mar 2016 13:36:12 +0000
Message-ID: <20160323133612.GO2566@sirena.org.uk>
References: <1458663893-13766-1-git-send-email-sr@denx.de>
 <20160322173546.40d24cc2@free-electrons.com>
 <56F17684.2010307@denx.de>
 <20160323113316.GH2566@sirena.org.uk>
 <56F2852C.5010006@denx.de>
 <20160323125448.GM2566@sirena.org.uk>
 <56F295E1.4030505@denx.de>
 <20160323132637.GC19953@lunn.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+mo68zJvr9wl4l14"
Cc: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>,
	Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>,
	Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160323132637.GC19953-g2DYL2Zd6BY@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--+mo68zJvr9wl4l14
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 23, 2016 at 02:26:37PM +0100, Andrew Lunn wrote:

> The number of windows is limited. On i think the Armada XP, if you put
> a PCIe device on every available PCIe bus, you can run out of
> windows. This is why Thomas implemented dynamic allocation of the
> Windows, so that only those that are needed are used.

> So i would not statically and globally allocate as many windows as
> possible SPI devices.

> The fact that SPI can fall back to another mechanism if there are no
> available windows, were as PCIe cannot, suggests that SPI should
> dynamically allocate a window, and be prepared for it to fail.

> Since only one SPI device can be active at once on a SPI bus, one
> window per bus makes sense, and keeps the required number of windows
> to a minimum.

If we're under pressure for windows I'd go further and say that we
should be dynamically allocating the windows only when they're actually
in use (and modifying other drivers to do the same if that makes sense
for them), unless it's somehow expensive to allocate windows that means
that we should reduce the overall pressure.

--+mo68zJvr9wl4l14
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW8pvLAAoJECTWi3JdVIfQKJkH/AwMXjMlQFRdoDQbcyX/4P7k
EGd/mAA4NyieNKaB4+oUzH6umDr6mYbrGmWsDwrcx4i0TU16XsEjLyu/xIrEY9ap
NPpur5skn4l6WPFF3bnrykZSKY09+gzPW2tRNXiFcGWaXSOu9LwKkhkcjSLu+NhU
txdFWbIb6uRpUa7qO0VA+cYWl8vxxge4GarRUwqDVQklWvUYCMwx8MXSa5Tnt/1h
NzOuaMk+Q8kYrqTD8Um3WScSO/E/+xcwQfTcuDc0QFFztgu6V2SQ5SjvJEuh6fN3
AdeThmrZ+jObSFzJautlfojO8uqMifdwwRq/MwhzAYiYX/2rXbr4C670yG20948=
=LDo2
-----END PGP SIGNATURE-----

--+mo68zJvr9wl4l14--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
