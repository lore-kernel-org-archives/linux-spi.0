From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 2/2] spi: spi-pic32: Add PIC32 SPI master driver
Date: Wed, 30 Mar 2016 08:48:39 -0700
Message-ID: <20160330154839.GZ2350@sirena.org.uk>
References: <1458740576-9168-1-git-send-email-purna.mandal@microchip.com>
 <1458740576-9168-2-git-send-email-purna.mandal@microchip.com>
 <20160328192629.GG2350@sirena.org.uk>
 <56FA6EE1.3000405@microchip.com>
 <20160329162501.GP2350@sirena.org.uk>
 <56FBAF2C.9090401@microchip.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5LK7OEqpP/xdrAG9"
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>,
	Joshua Henderson <digitalpeer-icZdIMMiY0PM6KjX8ROVJw@public.gmane.org>,
	Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: Purna Chandra Mandal <purna.mandal-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56FBAF2C.9090401-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--5LK7OEqpP/xdrAG9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 30, 2016 at 04:19:16PM +0530, Purna Chandra Mandal wrote:
> On 03/29/2016 09:55 PM, Mark Brown wrote:
> > On Tue, Mar 29, 2016 at 05:32:41PM +0530, Purna Chandra Mandal wrote:

> >> MMC_SPI will have to terminate on-going MMC transactions and it is
> >> done by calling setup(). It is assumed that setup() will always leave
> >> the chip-select deactivated.

> > No, this is just completely broken - that's quite simply not what
> > setup() does.  See spi-summary.  There is *no* code in the core that
> > terminates ongoing transfers as a result of calling setup(), if that's
> > happening it's a result of triggering error handling.

> Description of spi_setup() in spi.c clearly mentions that "When this
> function returns, the spi device is deselected" and this is only
> possible if (at least) chip-select is deactivated.

This doesn't say anything about any ongoing operations!  Trying to do a
setup() with active transfers on the device is just not sensible, it is
intended to be used on an idle device.  I would not expect it to work
reliably on an active device.

--5LK7OEqpP/xdrAG9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW+/VWAAoJECTWi3JdVIfQMWYH/i7A8Ehf3fPcdsl2l1VSJKgy
cLfPNo1m7Ffqe8VArYS7DAnRBE+wedQ1CuFqZF3BYmBjUr9kQ2+QKTTtkb0ocp3Z
AcM14vTQYHMVeJBa+FQqZQEtdC+tU8SX53wkBKtNxf9Y0AaMCf918hSw9TmTz2df
iwqYu13PECCKAfm0hgthDZTpJRDZx49CkHQKYuuCEsXDMBTlbBGO48ocqRlICcJo
yTbgib6aAazz4JrdWpqgbVtTP2XgPiUaedcfM/LxwbnrT106OjI10XsULLrmkXVf
hu/5vvTixkkfrk66Ly4ZlkeIOjFag57zvu8KLBPhdqjSQlFSFXuq7G1GtCGmhGM=
=VU9y
-----END PGP SIGNATURE-----

--5LK7OEqpP/xdrAG9--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
