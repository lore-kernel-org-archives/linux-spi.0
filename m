From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 04/25] spi: gpio: Implement LSB First bitbang support
Date: Fri, 13 Dec 2019 11:42:31 +0000
Message-ID: <20191213114231.GC4644@sirena.org.uk>
References: <20191212033952.5967-1-afaerber@suse.de>
 <20191212033952.5967-5-afaerber@suse.de>
 <CAMuHMdWdxJ9AaWhyCW-u8fCpXSDCPd-D6Dx129SF5nRssZsK=g@mail.gmail.com>
 <9b4b6287-c1d9-1b41-88a8-7ac9fe222642@suse.de>
 <20191212171922.GM4310@sirena.org.uk>
 <70bf4954-d7ab-e300-017c-c743a40162a4@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OBd5C1Lgu00Gd/Tn"
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-realtek-soc@lists.infradead.org, linux-leds@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Dan Murphy <dmurphy@ti.com>
To: Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <70bf4954-d7ab-e300-017c-c743a40162a4@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--OBd5C1Lgu00Gd/Tn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2019 at 10:08:24PM +0100, Andreas F=E4rber wrote:
> Am 12.12.19 um 18:19 schrieb Mark Brown:

> >>>> Duplicate the inline helpers bitbang_txrx_be_cpha{0,1} as LE version=
s.
> >>>> Make checkpatch.pl happy by changing "unsigned" to "unsigned int".

> > Separate patch for this?

> For the checkpatch cleanup? Or helpers preparation vs. spi-gpio.c usage?

At least the checkpatch cleanup.

> > Yeah, I don't think there's any great options here with the potential
> > performance issues - probably the nicest thing would be to autogenerate
> > lots of variants but I think that's far more trouble than it's worth.

> Maybe add another code comment to revisit that idea later then?

Sure, if you like.

--OBd5C1Lgu00Gd/Tn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3zeSYACgkQJNaLcl1U
h9BeaQf9Gwa9v/4JBqlU2EYPQesdyqtMrKKm+f5AChrzJThgZFgCyrfqTR/3uWBy
/SF8lSe7KY9OyztUKw5g+7WLB/oBrMXPlm40GKafsaKC0eEeb9is09ZCnxOkDKDU
T2DQuGVbpQ15A+764B2O2YmoZ4MOoQft6BCv/eqFHtZ7PXrE/KkR9ZkBRbNGlZdg
koWMA7InOnyM2jVONLQIkmicLLi2R/ADJjV3MMhRrfamY6xEvu7e7IrPUdFV2HHl
dPj1nFNsrgQwPG4Ns4+ohrTwtjwOycakEMqD9CwhRp8mw1XE7Ru5no3LB/zxVbqd
q00vWhYLcJ4R+sl55+bXCitUFEDGKg==
=fXQg
-----END PGP SIGNATURE-----

--OBd5C1Lgu00Gd/Tn--
