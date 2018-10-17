From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: Make GPIO CSs honour the SPI_NO_CS flag
Date: Wed, 17 Oct 2018 10:42:08 +0100
Message-ID: <20181017094208.GA24097@sirena.org.uk>
References: <1539336198-84179-1-git-send-email-phil@raspberrypi.org>
 <1539628457.30311.5.camel@impinj.com>
 <20181016090310.GA7449@sirena.org.uk>
 <1539718160.30311.10.camel@impinj.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "phil@raspberrypi.org" <phil@raspberrypi.org>
To: Trent Piepho <tpiepho@impinj.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1539718160.30311.10.camel@impinj.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 16, 2018 at 07:29:21PM +0000, Trent Piepho wrote:
> On Tue, 2018-10-16 at 10:03 +0100, Mark Brown wrote:
> > On Mon, Oct 15, 2018 at 06:34:18PM +0000, Trent Piepho wrote:

> > > I imagine it depends on what set_cs needs to do, which might not be
> > > solely related to changing the CS line.

> > It should be.  If something is hanging other work on set_cs() then it's
> > going to break.

> IIRC, for spi-dw setting CS is the only way to trigger the master to do
> anything.  I think orion is the same way.  Even if you don't want a CS
> line the driver still needs to assert one.  Which CS to use as the
> dummy CS is a challenge that has come up before.

> bcm2835_spi_set_cs() does check SPI_NO_CS, but it still does a lot of
> other stuff even if that is set, likely because of the above issue.

For hardware that's that broken I'd recommend deferring the actual CS
setting operation to the transfer operation instead; that way we can
guarantee it happens for any pattern of access to the chip select (or
error out if we can't represent it properly, though obviously a lot of
such systems use a GPIO for the chip select to work around the broken
hardware).

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvHA+wACgkQJNaLcl1U
h9D7iAf1E+tEL/0/m02X3vYOi4VSrh4lRPpsHO7rts6ytFWFkd2if6GN5KTNI921
CGCgTeiqOm6csLuUi9LBJ65ccwenslCgyo8/ik8PsHOS722dUg4UCqCeBpCVE9CR
B3nsnAvJfa3uAk53a8I4OR0iDTtOauGugTs6oPLF1CU2QsJSevLgJeZP5cgg14Pn
RR5OnK99UQXzMuTThTagDkPhg4lfXrodYGJ4ZpxhlY1ebE1mLhwQ9wqXKGBFKfdT
nTNmTY0zP5Kl6rPT3M2NvIXaML747kQjqrJOv6rh1uIimZD1kejxXfMTqHIX3aXy
pncogI5DiwuHvRwgaM9LbeHalGwQ
=XpV0
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
