From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Depreciated spi_master.transfer and "prepared spi messages" for
 an optimized pipelined-SPI-DMA-driver
Date: Sat, 16 Nov 2013 12:56:21 +0000
Message-ID: <20131116125621.GW15393@sirena.org.uk>
References: <20131108180934.GQ2493@sirena.org.uk>
 <C375DEE6-1AEC-4AFB-A9D6-583DCB4476A3@sperl.org>
 <20131109183056.GU2493@sirena.org.uk>
 <6C7903B3-8563-490E-AD7D-BA5D65FFB9BC@sperl.org>
 <20131112011954.GH2674@sirena.org.uk>
 <52823E73.503@sperl.org>
 <20131114015009.GB26614@sirena.org.uk>
 <9640F4C7-7F82-453E-9D83-5875A1559A20@sperl.org>
 <20131115133312.GE26614@sirena.org.uk>
 <0BA2243C-2F22-492A-B517-76E243535549@sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/U0GMd1Pus0mbMSS"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <0BA2243C-2F22-492A-B517-76E243535549-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--/U0GMd1Pus0mbMSS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2013 at 03:52:42PM +0100, Martin Sperl wrote:

> Well - we first need to see what is the real "common denominator" of
> boards, that can do DMA to configure SPI itself. So we would need at
> least 2 or 3 to figure that out (and also all the bugs we may expect to=
=20
> see and find work-arrounds for those)

There's a bunch of fairly clear patterns for drivers here - the main
constraints are going to be having to punt to task context for sleeping
operations and DMA controllers that just can't have transfers to or from
the register space mixed in with the command stream (all of which fits
into the general patterns we've got already).

> But my guess is that you would not even allow to get something generic as
> this merged unless there are multiple drivers that would be using that
> interface.

> So we would be in a chicken/egg from this direction as well...

We're already going in this direction, that's why I'm going through
splitting up the operations that actually talk to the hardware from the
bits that implement generic logic and queue driving.  The major blocker
previously was that I didn't know what you were proposing to do in your
driver.

> > Or in the async case we just punt the prepare to the thread.

> again: that means an uneccessary delay
> especially when you think about running the message_pump without
> real-time priority introduces 10us additional delay...

For the cases you're concerned about this shouldn't be an issue, the
thread should be behind the I/O or the client driver will have prepared.
I'd also expect to be able to fall back to PIO (which I suspect we'll
want to keep as an option for idle cases anyway).

> > Right, and the big concern with the way you're currently proposing to
> > implement the optimisation is that it's leaving essentially the whole
> > thing up to the individual driver.  This is going to result in limited
> > adoption and is going to mean there's no sharing of learning and fixes
> > between drivers.

> Well, any driver that is using spi_sync can not get improved without a=20
> rewrite anyway - the context switching becomes prohibitive.

No, I'm talking about requiring things to be done on the master side not
the client side.  That's key for making it worthwhile for client drivers
to use things like preparing messages and makes it much easier to do the
adaptions required in the master drivers.

> Well - as I understand this, it means that:
> If there were more bus-drivers that could drive the whole SPI transfer of
> a message via DMA, then it would become acceptable to get that API in=20
> place until then if there is only a single bus and device driver, then it
> is not acceptable.

No, like I said in an earlier e-mail now that I understand how it can be
generally useful rather than just being a driver specific thing I'm OK
with adding the user visible prepare API (but not the calls into the
master driver).  It's the master driver interface that still needs work
so the logic isn't open coded in individual drivers.

--/U0GMd1Pus0mbMSS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSh2tyAAoJELSic+t+oim9RbkQAI8yd6fG3IkaDRyTSy8Xp6ah
Si5whjxuyAQ/f8JkPBVWZU5ZsUg1ghYV2PON/5USsSMnijSFX1WpDQxjodPcZBaP
nLmWGHyPSdrUe5fqA2GWlVvqOZOlUfmS+C04BdZaNOJIszruw1jHkKux6asvUNYc
XSGtUmEJuy2zdlmLhYQXKcIovuhIXcU9LCy8qrDqf4ZiQCdc4tNscGN0rL5SxaOB
oje8qtERb3cdv/+Zmsh/WPVtxC+xup7hOQUzOBQMdZo3LCWKyYHTh2lEuTScQW53
Kc0CxrUD7BrN4jkf6Cvp/zisz4vW2XgfZhs2ZfWCCGN0r0FYPzk0GjHSwZwn+uTt
uCl+yDyDbQejqBg3K1G9PP1sirsTxde/gSmY9aQQ6uncm6sZg4kPs03Va3ONGlVm
TiExo0raTrKs4qk0r39e41DwhCllcdNpsbhKP4ZUj5OOp47+mJrCLg88SWNc4nVl
x+slHPjrHqMa6nyzOd52yYAPJI/SBvZTiZED6Nm/fZ9Xfa1lYdjiUTV4KTPGUOmJ
yvBaGOaDxNf3ieVVf1HZbz2sUTmBU7Yh2dU8YEy14TfjR582rzbPwCHX9k/b1m8F
XCZKJfP/FWRbtRYBr+BEl7BKwrEmARFOYyZ06qn03XwBaHUW9LGYlbw7Cr/aoGfZ
w8ZeesQMDk+kA5AHEPog
=ocnN
-----END PGP SIGNATURE-----

--/U0GMd1Pus0mbMSS--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
