From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: Enable Cadence SPI driver for ARM64
Date: Tue, 24 Feb 2015 22:22:06 +0900
Message-ID: <20150224132206.GE6236@finisterre.sirena.org.uk>
References: <859f9c4d3fbbc5153d924d7a6e36aa3a734e1b16.1424763838.git.michal.simek@xilinx.com>
 <20150224080807.GS6236@finisterre.sirena.org.uk>
 <16fcf6871bb9482a89a5ca5827c78286@BN1BFFO11FD047.protection.gbl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+zeCMqFCsETNqUaq"
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <16fcf6871bb9482a89a5ca5827c78286-fm2tX0oQAVz65bfp4ngO8uhlVc3/7hDbVaz/vdPVXQ4@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--+zeCMqFCsETNqUaq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 24, 2015 at 09:23:29AM +0100, Michal Simek wrote:
> On 02/24/2015 09:08 AM, Mark Brown wrote:
> > On Tue, Feb 24, 2015 at 08:44:01AM +0100, Michal Simek wrote:
> >> This driver is used on new Xilinx ZynqMP SoC.

> > Why does this have an architecture dependence at all?

> Let me push this to my repo and run Fenguang's system on it if there
> is any build error on others architectures.
> I expect that this could be sufficient test, right?

Probably, yes.

--+zeCMqFCsETNqUaq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU7Hr4AAoJECTWi3JdVIfQ07YH+wehMiOS2emfGg/MKgNCzUcU
oPS1nby0VIeU4ODDhP7gWHrxlDgDT2YLwddQGDcbJC0NZwCozmNlr6rGbuhPyArh
HU/6pY11zOBpB0adegQFZAXPtV+FYz6qwTHlsL1uTCGusBbBwIGs1YHt8j5wkQkd
NbAJBrbCwS3n5sQ5zVN+AC0m9Kcxu5pb1fUFHQKMIkRqAjY51z2qSBNwiCoysD2R
toHKU1/fcJZ15HRN8VrCpEdMkqFCACTYQMiBq4phIzoRfqKD0URdrdPUDz7RvnS6
p0Fr5jX5VwSNs4bGO0TT5QcXzjyO+RpCBbwD/p5Jj3dst04niQm9tTwMw43Mp94=
=NVp+
-----END PGP SIGNATURE-----

--+zeCMqFCsETNqUaq--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
