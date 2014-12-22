From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] spi: img-spfi: Enable controller before starting TX
 DMA
Date: Mon, 22 Dec 2014 17:52:14 +0000
Message-ID: <20141222175214.GD17800@sirena.org.uk>
References: <1418763946-22260-1-git-send-email-abrestic@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="e3HNah56eoWqGn2Q"
Cc: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1418763946-22260-1-git-send-email-abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--e3HNah56eoWqGn2Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 16, 2014 at 01:05:44PM -0800, Andrew Bresticker wrote:
> It is recommended that the SPFI controller be enabled (i.e. setting
> SPFI_EN in SPFI_CONTROL) before TX DMA begins.

Applied, thanks.

--e3HNah56eoWqGn2Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUmFpNAAoJECTWi3JdVIfQpusH/i4sUY5Tuaso6UIlei53YfGt
3JVfP+XfRGc2exeJNrq2pgNdFhuAOIYQ/C4ArOAgiscx4Qv8IKUWTJ3MclkPrG75
vfUoW8sYbs18PBjVWuJOdaD15hT1Wio1FNOEP8v+29KqccJBzTglzT6LFwT2ahRg
JOO68e6rfxEwRXk+gm6Op57UicuTd01btUsMlBenG6dbPHt+ESvQivGLPyNvOy25
cm1p2vndQxYqFVIWNzE6uEmjwSm04raaDinykBaTHsdf4wXYjVxgSFPitcnifwN3
TjQfgqYQlSgCCjzYLiMH2smyUUsASm8mDPQebRiUjwSohjcNORNTumisK8Ozf9E=
=ubZt
-----END PGP SIGNATURE-----

--e3HNah56eoWqGn2Q--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
