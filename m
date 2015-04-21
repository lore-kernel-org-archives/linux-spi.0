From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: rb4xx: Fix set_cs logic.
Date: Tue, 21 Apr 2015 12:09:58 +0100
Message-ID: <20150421110958.GH22845@sirena.org.uk>
References: <1429538005-1985-1-git-send-email-bert@biot.com>
 <20150420203703.GG14892@sirena.org.uk>
 <CAMuHMdW=_=CJENSqNSk6Lgt8-9Ea=TmWsKmLWUKGpbM0N8MXYg@mail.gmail.com>
 <55362E02.3070309@biot.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8/pVXlBMPtxfSuJG"
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-spi <linux-spi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Bert Vermeulen <bert@biot.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55362E02.3070309@biot.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--8/pVXlBMPtxfSuJG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 21, 2015 at 01:01:22PM +0200, Bert Vermeulen wrote:
> On 04/21/2015 11:46 AM, Geert Uytterhoeven wrote:
> > On Mon, Apr 20, 2015 at 10:37 PM, Mark Brown <broonie@kernel.org> wrote:

> >> No, the enable parameter *should* refer to chip select assertion (see
> >> how we handle GPIO chip selects).  However it's possible that this
> >> device has an inverted chip select and should be registered with the
> >> SPI_CS_HIGH flag?

> > It's logic level:

> >  * @set_cs: set the logic level of the chip select line.  May be called
> >  *          from interrupt context.

> Right It's the implementation which doesn't really make sense IMHO: it
> always inverts the "enable" parameter (unless SPI_CS_HIGH is set), in
> keeping with the default active-low.

The default chip select is active low so an enebled chip select is low.

> So the docs are right, but "enable" doesn't match what it does. Chip select
> assertion would be a better API here. Is it worth fixing?

I suspect it's going to cause more breakage than it fixes with people
upstreaming things to change the sense of the paramter betwen kernel
versions - renaming the parameter to be clearer is probably about as
good as it gets.

--8/pVXlBMPtxfSuJG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVNjAGAAoJECTWi3JdVIfQOh8H/javTiHXBBKHp8zf1GMU3Vc3
EDkuwb2/jZlq55TTuAAsgJ8RecI4Jfr9B5IRiTzVc8F130Jiz2JptDr4vcxqNRYm
mboyJcVLc6R8BaHWhAwxGWcqCi+W9qRhrh89hRJ5F0ElDrLE7h5A8/mMMqUS9/7X
ONmZNxOmlXmDfjfCc9whCOxEijT3QljsSQcptzZ0GHJEtlWDpbHCvfSC4+d1Taji
VycLTyxSffxgx0yDSiawYrsJ/D7Cav8/X7IWTrnspDPcijMlbEfFB2q6TiCnyC0Z
DvsUMBhdE8yIShl2NFO/VZBFUr6xwVdpb0TI4+WcTEieDEJyZk/SMMHh6GvSVvA=
=eQLl
-----END PGP SIGNATURE-----

--8/pVXlBMPtxfSuJG--
