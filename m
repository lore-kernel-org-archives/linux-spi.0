From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH 0/2] spi: add dual parallel & stacked mode support in
 Zynq MPSoC GQSPI controller
Date: Mon, 13 Jul 2015 15:59:07 +0100
Message-ID: <20150713145907.GF11162@sirena.org.uk>
References: <1436445895-25504-1-git-send-email-ranjit.waghmode@xilinx.com>
 <559F824B.70409@topic.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kK9AL8AnBmMfbzhN"
Cc: Ranjit Waghmode <ranjit.waghmode-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org,
	dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	marex-ynQEQJNshbs@public.gmane.org, shijie.huang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org,
	ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org, harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, punnaia-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org,
	ran27jit-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Mike Looijmans <mike.looijmans-Oq418RWZeHk@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <559F824B.70409-Oq418RWZeHk@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--kK9AL8AnBmMfbzhN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2015 at 10:28:59AM +0200, Mike Looijmans wrote:
> =EF=BB=BFOn 09-07-15 14:44, Ranjit Waghmode wrote:

> >ZynqMP GQSPI controller supports stacked mode with following functionali=
ties:
> >1) The Generic Quad-SPI controller also supports two SPI flash memories
> >    in a shared bus arrangement to reduce IO pin count.
> >2) Separate chip select lines
> >3) Shared I/O lines
> >4) This mode is targeted for increasing the flash memory and no performa=
nce
> >    improvement when compared with single.

> One could also model the stacked mode as having two distinct flash chips
> with separate chip selects and shared lines.

Well, quite.  I'm confused about how the above differs from a just a SPI
controller with two chip selects which is perfectly standard.

--kK9AL8AnBmMfbzhN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVo9I7AAoJECTWi3JdVIfQio4H/1o3jKiZR03QWE+n+6/R2X3E
9Rgqw1W8K63XeTcpVnO0E5mLv+OQ4WdRg/8CvUExZxkOW5Wm+YGWNjTJ3xzedvtF
JrgKNNa/a0U/w9xscFX+x9fhkL7oSVLRg/w3k5s/skDNtfhfGwplzJ5sOxz7jP/5
0H5r6aTuLgchSWzUiSt2mZqwtHRMW0b5WLBR2gil9ez8LtaUZEozOw7wss+RPAH0
MaFFrvC2kr+o+FyVaGfqEjxTWpOCAtEHbvrrfElx4AK7tiUFJ8FoGi+jNmjWA8f7
AdSP+H2QHDkhHCSyGwFxCpAfP72U0fQXLS1EKXCcCQwBSc5jMvtfWSHV5EuuRME=
=MTwl
-----END PGP SIGNATURE-----

--kK9AL8AnBmMfbzhN--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
