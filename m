From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/6] spi: bcm2835: fill FIFO before enabling interrupts to
Date: Tue, 7 Apr 2015 17:28:57 +0100
Message-ID: <20150407162857.GM6023@sirena.org.uk>
References: <3628E5E2-7EA9-488F-AF5F-A2E43D2D1E3E@martin.sperl.org>
 <551A1185.6060502@wwwdotorg.org>
 <20150331052519.GZ2869@sirena.org.uk>
 <552094B5.3050109@wwwdotorg.org>
 <20150406172130.GU6023@sirena.org.uk>
 <B9B4E3CA-D9F2-4A79-BC78-C3BD4B3844F2@martin.sperl.org>
 <5523FA17.6040009@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xyVbWWff76yUiXzJ"
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>, lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5523FA17.6040009-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--xyVbWWff76yUiXzJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 07, 2015 at 09:39:03AM -0600, Stephen Warren wrote:
> On 04/07/2015 12:25 AM, Martin Sperl wrote:

> >As the CS register contains the interrupt flags as well as the
> >control for the native-chip-selects this is impacting the chip select
> >lines in native mode.

> Is the driver simply programming the HW incorrectly then? I would expect the
> driver to do something roughly like:

> * Set up the HW to execute the transaction; everything except enabling IRQs
> and telling the HW to "go"
> * Clear stale IRQ status (perhaps do this right at the start)
> * Enable IRQs
> * Tell the HW to "go"

> ... then not touch any CS-related register for the entire transfer. There
> shouldn't be a need to enable/disable IRQs during the transfer; just leave
> them enabled the entire time, until all bytes have been transferred.

We will need to make sure /CS is kept asserted between transfers in a
message too.

--xyVbWWff76yUiXzJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVJAXIAAoJECTWi3JdVIfQOWUH/izw/OPHqBoLqUqjAuyN86fo
oTucZ8lmDmbVJslYWhLcqOxLDrR/ySIpfXOgSh8LokuV4JrkwhK0nbzcifuaVzfv
QtYR3eLpMN3k/H55YQMmgFS9AAaMZCNsN3pAyh3LLGoZ93qNDMJ1gsQzF+nlav09
lnKK1/z+YEn3ZnubNY9UeX8qmKRcOFQhyOHUx2hMC0f+BKfTkvqw0HXW+3NH7tSX
iWl1j9ZZ98U8AEjAVhBj046veHVl5+3oDicNCJcKducARxzhqYVxAliQiSixc0Lb
BrKIyoybd0ZDX6RVsn8hBlUWgGHN9GAAiZRXBD14Fk/QeLwVfeoPL7FVTR5XAbM=
=3K93
-----END PGP SIGNATURE-----

--xyVbWWff76yUiXzJ--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
