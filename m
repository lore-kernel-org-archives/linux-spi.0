From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RESEND] spi: spidev: Allow matching DT compatible strings
 from ACPI
Date: Tue, 28 Jun 2016 17:18:22 +0100
Message-ID: <20160628161822.GQ17217@sirena.org.uk>
References: <1467027248-6191-1-git-send-email-mika.westerberg@linux.intel.com>
 <20160627122448.GU28202@sirena.org.uk>
 <20160628092234.GG1711@lahna.fi.intel.com>
 <20160628114742.GM17217@sirena.org.uk>
 <20160628143528.GK1711@lahna.fi.intel.com>
 <20160628150752.GO17217@sirena.org.uk>
 <20160628152338.GN1711@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ngPZezdD7QsvFaqQ"
Cc: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160628152338.GN1711-3PARRvDOhMZrdx17CPfAsdBPR1lH4CV8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--ngPZezdD7QsvFaqQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 28, 2016 at 06:23:38PM +0300, Mika Westerberg wrote:
> On Tue, Jun 28, 2016 at 04:07:52PM +0100, Mark Brown wrote:

> > If that's the case then it's definitely broken - we either always warn
> > or never warn, neither is good.

> For DT we warn if the device is used directly (by the node name) as
> previously. For ACPI we never warn because it is not possible to use the
> node name directly. We always require use of a proper compatible string.

> I don't see how that is broken.

So you're saying that it's not possible for ACPI to use anything
*except* an explicitly listed compatible string to bind?  What we want
to avoid is any ACPI tables that explicitly list spidev since that's a
total abstraction failure.

--ngPZezdD7QsvFaqQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXcqNNAAoJECTWi3JdVIfQNVIH/jv4a1Mj3XgpVbWMoONOsJ3c
SeFkfMKEHirWJ4tlcku8mDLYCAnDSoaEwpjfDyT/CTFBl0QNSAlhc7xVuF2O+l18
8/Dapje9F0Auk9ENyD+tLTEpRe5/ASfLz80kCOQVxoyCPdWtUU5KAqbS7HO1xsGy
otPdnZ//4gA5As9BP5kPYMAO70ZbQXIltq8uyR+KR/pe/8o7judRQ2dCTXqg3Gv1
DFnlRBxFEKdJq2XGhm9G6gkCLCu3FCKGuwKgP58dnTL+xRePn0Rnj5rF87xBiS+R
5bEZHnAays8kmK79OklQCAnUjjO9Y6wJjje17vxK7iNfCMAf7eHtUI+ku+diS24=
=wOUG
-----END PGP SIGNATURE-----

--ngPZezdD7QsvFaqQ--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
