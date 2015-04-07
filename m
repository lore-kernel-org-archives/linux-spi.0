From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/6] spi: bcm2835: fill FIFO before enabling interrupts to
Date: Tue, 7 Apr 2015 19:23:27 +0100
Message-ID: <20150407182327.GP6023@sirena.org.uk>
References: <3628E5E2-7EA9-488F-AF5F-A2E43D2D1E3E@martin.sperl.org>
 <551A1185.6060502@wwwdotorg.org>
 <20150331052519.GZ2869@sirena.org.uk>
 <552094B5.3050109@wwwdotorg.org>
 <20150406172130.GU6023@sirena.org.uk>
 <B9B4E3CA-D9F2-4A79-BC78-C3BD4B3844F2@martin.sperl.org>
 <5523FA17.6040009@wwwdotorg.org>
 <1BAEDC46-354E-49F4-BC6A-6AA5C1A4A1B4@martin.sperl.org>
 <20150407174003.GN6023@sirena.org.uk>
 <BD11C8AC-F517-4120-BBD6-07618EE86604@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mHNxlnn48ELheE/j"
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <BD11C8AC-F517-4120-BBD6-07618EE86604-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--mHNxlnn48ELheE/j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 07, 2015 at 08:18:57PM +0200, Martin Sperl wrote:
> > On 07.04.2015, at 19:40, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> > For your workload perhaps.  For some workloads they are very common
> > (register reads are the most obvious example, they are typically a write
> > transfer to provide the register address followed by a read transfer for
> > the data).

> Which spi_write_then_read collapses into a single transfer.

No it doesn't.  It creates a single message with two transfers (which is
what I'd expect any user doing this to do, there are others that don't
use the SPI helper APIs).

--mHNxlnn48ELheE/j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVJCCfAAoJECTWi3JdVIfQBRcH/37ezyYiZRNVq7c4M56t01L8
5empo7CohkzE8Qs5wIvyykRESduOcEnAcediKju8/hRRW1wsHVbJwVWvEAPJB76P
upsy77LtfWP6M0xZ8r5DtTZHfRv0MeVn/JjTQv0APhYB+zzsKkJ9waXl1umAE+LH
UUlzOKWADn26y4cq0YoGgm8Yge2JlyLdMecx6KgI/uSULF3bliichEtKxZ7LCEv9
OnU/6V5Vts6nJ8dYJ/7g8ZvBrlNE4W7QPnY1ais+L0zAMOOrRjnO+nbBLivPjbY0
z0C5m9KB2mctBGKpQJfIVgwQD3r+2HrlTmLScQSFEreLWUxZlY6KO624UNh7ij0=
=IRli
-----END PGP SIGNATURE-----

--mHNxlnn48ELheE/j--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
