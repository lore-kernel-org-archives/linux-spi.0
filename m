From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC] spi: dw: support setting tmode dynamically
Date: Tue, 5 Jan 2016 16:12:31 +0000
Message-ID: <20160105161231.GG6588@sirena.org.uk>
References: <20151223192338.128e95a4@xhacker>
 <20151223121512.GV16023@sirena.org.uk>
 <20151223202952.28be5bab@xhacker>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fCcDWlUEdh43YKr8"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20151223202952.28be5bab@xhacker>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--fCcDWlUEdh43YKr8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 23, 2015 at 08:29:52PM +0800, Jisheng Zhang wrote:
> On Wed, 23 Dec 2015 12:15:12 +0000 Mark Brown wrote:
> > On Wed, Dec 23, 2015 at 07:23:38PM +0800, Jisheng Zhang wrote:

> > > Currently the spi-dw tmode is fixed to SPI_TMOD_TR if cs_control is N=
ULL, but we
> > > need to set it as SPI_TMOD_EPROMREAD to read nor flash, my solution i=
s to add and
> > > export one functions to set the tmode, then the nor flash driver call=
 it
> > > before reading and set back to SPI_TMOD_TR after done. =20

> > What does this mean - what is TMOD and why do we need to set it to read
> > NOR flash?  I've no information on this controller...

> TMOD is one field of DW_SPI_CTRL0. Its available value could be:

> 0: Transmit and Receive
> 1: Transmit only
> 2: Receive only
> 3: EEPROM Read

> If the one spi nor flash is connected to the SPI host, so far I can only =
succeed
> to read the nor flash content after setting the TMOD field as 3.

Why?  What does this mean in practical terms at the hardware level, what
is "EEPROM read"?  It sounds like there's some bigger issue here.

--fCcDWlUEdh43YKr8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWi+tuAAoJECTWi3JdVIfQBNgH+gJDq1/l0iZhZ+A/xtRiogUg
wAWR3LUMThNN4f7LY4o5WG0clp8MRzP3iGRLs9fhd6r+F9w3Uyj0tvw9239GHzxn
BVzDV8HtxuysNBSm4WDTW3V2otsMti657NEdCwvAjFEHdPZ1p2uMCe74kh4FCYII
X/CvAURcfcJCMjf277uEwN3Bz9I2zxMi1xRDamh83AxpzYxLuyabTraFClIqu8S6
iMO3btPSXVTxKmmAXhsAH2ytS8Uuwie8GZKoO6lv1RZsxojKFNmN1B+aso7tcZc9
KnKYROgx2rEyOJy9EHXOCh16f7SGBe2A8ZsWtHCjn2Ej7PID/bWIN4HsoBVwzP0=
=+T3A
-----END PGP SIGNATURE-----

--fCcDWlUEdh43YKr8--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
