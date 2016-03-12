From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: propper support of 5 wire SPI (SPI_READY signal)
Date: Sat, 12 Mar 2016 14:21:32 +0700
Message-ID: <20160312072132.GA3898@sirena.org.uk>
References: <56C6DB9E.5080905@rempel-privat.de>
 <20160220195641.GE18327@sirena.org.uk>
 <56C8DD64.1070700@rempel-privat.de>
 <20160222110948.GE18327@sirena.org.uk>
 <56CAF443.8010705@rempel-privat.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lYjFa3qL1bvncypl"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dirk.behme-V5te9oGctAVWk0Htik3J/w@public.gmane.org,
	"EXTERNAL Rempel Oleksij (Brunel, CM-AI/ECO3)"
	<fixed-term.Oleksij.Rempel-V5te9oGctAVWk0Htik3J/w@public.gmane.org>
To: Oleksij Rempel <linux-YEK0n+YFykbzxQdaRaTXBw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56CAF443.8010705-YEK0n+YFykbzxQdaRaTXBw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--lYjFa3qL1bvncypl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 22, 2016 at 12:42:59PM +0100, Oleksij Rempel wrote:
> Am 22.02.2016 um 12:09 schrieb Mark Brown:

> > Oh, so this isn't SPI_READY?

> Not 100%.
> According to TI documentation, transfer initiated by master looks like:
> 1. Master: SPIx_CS (on)
> 2. Slave: SPIx_READY (on)
> 3. Master: Date transfer
> 4. Slave: SPIx_READY (off)
> 5. Master: SPIx_CS (off)

> Bosch version of 5-wire transfer initiated by master:
> 1. Master: SPIx_CS (on)
> 2. Slave: SPIx_REQUEST (on)
> 3. Master: Date transfer
> 4. Master: SPIx_CS  (off)    <----- different order.
> 5. Slave: SPIx_REQUEST (on) <-----

I can't tell the difference between these two cases.  In the first case
the device gets busy after the data is transferred, in the second case
it never changes the request line but really there's no meaningful
difference I can see.

--lYjFa3qL1bvncypl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW48N4AAoJECTWi3JdVIfQP1cH/0qpkfhdEdAGbRoAi+fhO2vb
ouMF98JPrhS/jFUZ79Amv8a/pPEBsXua+3PnN4zCJHib6fhi1tbtRN8RrDVNaOat
y2iExlCA2VnCCef4oOo0dxXscrr9mf8iwarfrrCJZsoHy8iSqc2o783mWgSG0kCX
am1DzvrX51Rr/1/+SsMZL0TmEA+nTun0KXkBP0fYrS6UdpE1BdWKgkiZ9M5JKB3C
lgNohVGIkbdHNKyRzxcxX9dOwWuqCe1G3Qly3B2CkGSGTLGbPqTm9apefwd0Vl9S
Ly/y1LX/PTF+a75LL9xpBgk1+P076/NOeb/5gRzYarvrZOD7jHpSsDMO/7z1lHs=
=vDrG
-----END PGP SIGNATURE-----

--lYjFa3qL1bvncypl--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
