From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RESEND] spi: spidev: Allow matching DT compatible strings
 from ACPI
Date: Tue, 28 Jun 2016 12:47:42 +0100
Message-ID: <20160628114742.GM17217@sirena.org.uk>
References: <1467027248-6191-1-git-send-email-mika.westerberg@linux.intel.com>
 <20160627122448.GU28202@sirena.org.uk>
 <20160628092234.GG1711@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="t5NgoZwlhlUmGr82"
Cc: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160628092234.GG1711-3PARRvDOhMZrdx17CPfAsdBPR1lH4CV8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--t5NgoZwlhlUmGr82
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 28, 2016 at 12:22:34PM +0300, Mika Westerberg wrote:
> On Mon, Jun 27, 2016 at 01:24:48PM +0100, Mark Brown wrote:

> > Please allow a reasonable time for review, especially for an invasive
> > change like this which needs a bunch of research to figure out how
> > sensible the infrastructure to shove DT into ACPI is.

> Sure.

The big thing I need to check out here is if this breaks the check for
directly listing spidev in DT so we end up with the same abstraction
failures that plague DT since people refuse to describe their hardware.

> The /dev/spi-0 then can be used analogous to /dev/i2c-0. You first need
> to program wanted chip select using those new ioctls. Then you can use
> the device as normal spidev (all existing file operations and ioctls
> still work). You can pick another chip select as needed. If there is an
> actual SPI device bound to a chip select, that cannot be used through
> /dev/spi-0.

The trouble with this is that unlike I2C using SPI devices involves
toggling signals that we don't definitively know are connected to the
bus.  It's therefore much less safe than the equivalent thing for DT.
If we went the extra step and required that a slave be listed in DT then
that is much less of a concern.

--t5NgoZwlhlUmGr82
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXcmPdAAoJECTWi3JdVIfQM5EH/RwY2P0td/IbUPGiu/6nT5ep
bDg+IQu16aSJbiJp6KOfy6D5msju9G0jQ5xBxC4qvDWN6O1hRROt+J8Jkw6kr5Te
ncNxn93du88haPgFEndDnkcufjpHgNbUqZOMpmK6kcict49omVpdGXt3Z+aDYzgk
o6OZnoDcFha+zvMYJ8SnMKNXdzHqpx1+Yx5kqTZYnIVL0ire25pRgBIlHg0quLwH
uWollMYmGajDvu3oxCyQWsKPlt9kOawP0ZelZJGT/Nx9sNbWDCPBBPa6QaSlAz0x
HmIZ/5AtVexIrSM8vubLTFbF8dAAik3GjONvAFK/pfqE7VrNiiu+kmKXNdT4H3Y=
=WIvF
-----END PGP SIGNATURE-----

--t5NgoZwlhlUmGr82--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
