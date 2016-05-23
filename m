From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 10/12] spi: add driver for J-Core SPI controller
Date: Mon, 23 May 2016 16:30:37 +0100
Message-ID: <20160523153037.GV8206@sirena.org.uk>
References: <cover.1463708766.git.dalias@libc.org>
 <2e287ca758002621ef8eed3db9df37678e26af5e.1463708766.git.dalias@libc.org>
 <20160520102317.GH8206@sirena.org.uk>
 <20160520232414.GY21636@brightrain.aerifal.cx>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tYlHSoJ8Aop8eNG2"
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-spi@vger.kernel.org
To: Rich Felker <dalias@libc.org>
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160520232414.GY21636@brightrain.aerifal.cx>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--tYlHSoJ8Aop8eNG2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 20, 2016 at 07:24:14PM -0400, Rich Felker wrote:
> On Fri, May 20, 2016 at 11:23:17AM +0100, Mark Brown wrote:

> > This is *extremely* late for a first posting of a driver for v4.7 (you
> > missed the list as well as the maintainers).

> I'm sorry for the mix-up. The kernel workflow is still fairly new to
> me and I've been fighting with git format-patch/send-email and
> get_maintainer.pl to get big patch series prepared the way I want and
> sent to the right people/lists. I think I've got it right now though.

One question here is why this is even part of a series - it's adding a
new controller driver which wouldn't normally have any sort of direct
build or other dependency on anything else or have other things
depending on it.  Unless there are dependencies it is generally best to
send separate changes separately as far as possible so that there is no
need to worry about issues with one part of the series slowing down
other parts of the series.

If it does make sense to send a series you need to communicate what's
going on with dependencies with all the maintainers, normally at least
the cover letter if not the entire series should go to everyone.

You should never rely on get_maintainers, you need to think about what
it's telling you.  It both misses people and generates false positives
(especially when it looks at git history).  It's useful to look at since
it normally gets you most of the way there but=20

> > > +	hw->csReg =3D ( JCORE_SPI_CTRL_ACS | JCORE_SPI_CTRL_CCS | JCORE_SPI=
_CTRL_DCS )
> > > +		^ (!value << 2*spi->chip_select);

> > Why the xor here and not an or?  The coding style is also weird, a mix
> > of extra spaces around the () and missing ones around *.  I'm finding
> > the intent of the code confusing here.

> The intent is to set all chipselect bits (the 3 macro values) high
> except possibly spi->chip_select. The xor is to turn off a bit, not
> turn it on. &~ would also have worked; would that be more idiomatic?

No, the reader has to be able to tell what the code is doing.  If this
made sense the thing to do would be to write out the logic operations
explicitly to make it clear that every step is deliberate.  However in
this case it sounds like the code is just plain buggy, though - the
driver is being asked to set a specific chip select to a specific value
but instead of just doing that it is also trying to also change some
other settings.  Don't do that, just have the function do what it was
asked.  If the calling code has problems it'll need fixing anyway and if
some feature you hadn't anticipated ends up meaning the combination of
operations makes sense then things will just work.

> > > +#if !USE_MESSAGE_MODE
> > > +	spi_finalize_current_transfer(master);
> > > +#endif

> > I'm not sure what the if is about but it doesn't belong upstream, you
> > shouldn't be open coding bits of the framework.

> I can explain the motivation and see what you think is best to do. I'd
> like to be able to provide just the transfer_one operation, and use
> the generic transfer_one_message. However, at 50 MHz cpu clock, the
> stats collection and other overhead in spi.c's generic
> spi_transfer_one_message takes up so much time between the end of one
> SD card transfer and the beginning of the next that the overall
> transfer rate is something like 15-20% higher with my version.

No, this is just not a good approach.  If the generic code isn't working
for you improve the generic code, don't just copy it and open code the
bits you like.  The reason Linux has all these great framework is that
people collaborate to make the generic code as good and fully featured
as they can rather than open coding everything in drivers.  Doing things
in drivers results in lots of code duplication which increases the cost
of maintaining things and requires that everyone waste time copying code
in order to keep the feature set consistent between drivers.

Drivers should do things specific to a given piece of hardware, anything
in the generic code should be dealt with in the generic code.

> Another consideration is that DMA support is being added to the
> hardware right now, and I think we're going to want to be able to
> queue up whole messages for DMA rather than just individual transfers;
> in that case, spi_transfer_one_message is probably not suitable
> anyway. So we'll probably have to end up having our own
> transfer_one_message function anyway.

This is again a simple generic optimisation which would be best
implemented in generic code - it's not just this device which would
benefit from the ability to coalesce compatible transfers.  There is no
reason for individual drivers to even think about such an optimisation,
the core should just be handling them a transfer with a coalesced DMA
transfer in it.  We're not doing it at present because someone needs to
take the time to write the code that figures out if adjacent transfers
are compatible and merges them if they are.

> If that's not actually needed, a possible alternative for fixing the
> performance problem might be adding a Kconfig option to turn off all
> the unnecessary overhead (stats, etc.) in spi_transfer_one_message. I
> could work on that instead (or in addition), and I wouldn't consider
> it critical to get in for this merge window.

This driver is *not* going in during this merge window, sorry.  You need
to get code into maintainer trees before the merge window opens but this
was only sent to maintainers after the merge window was already open.
This isn't the end of the world, there will be another kernel release in
a few months.

> > > +	platform_set_drvdata(dev, NULL);
> > > +	spi_master_put(master);
> > > +	return 0;
> > > +}

> > This can be removed entirely.

> OK. Does using the devm register function cause removal to be handled
> generically, or is there another reason it's not needed?

Yes.

> > > +static const struct of_device_id jcore_spi_of_match[] =3D {
> > > +	{ .compatible =3D "jcore,spi2" },
> > > +	{},
> > > +};

> > This is adding a DT binding with no binding document.  All new DT
> > bindings need to be documented.

> The DT binding was in patch 05/12. Should linux-spi have been added to
> the Cc list for it? get_maintainer.pl didn't include it.

Yes, the documentation and the code need to be reviewed together.  It's
hard to tell if the code implements the bindings without seeing both.

--tYlHSoJ8Aop8eNG2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXQyIcAAoJECTWi3JdVIfQgmkH+wRFpn4gh6vPaMjdc9mK87Ss
M8AToh5O2BAMZgEJX+ZV96TlTbGNTfRtAtI8+GwcEL53T4HR5p/8C4Nq+g28iV4c
RtwGqOufD81rrrrvtpGw5fIJEq8z2mehTUntMU53PuV8OS8ijIJE06h5AJGLr+Yk
tdD82UPOA/lBS9SxcdwNXTJ3FVS1OYx9MjEUDuF8N+9Y85Db0oXQWVjflcaeet4n
9kW2NLrWO1wwCg4QPGcbe26E6jxXcczECg49LeXOz4Y023zms2Llk4NetPPnet/w
Gu9L0Vzq3bnrKIujnZTjrGD++fBxCtqOSds3OJ9C02i2MYNPy3zmewaobW/oUDM=
=TZcr
-----END PGP SIGNATURE-----

--tYlHSoJ8Aop8eNG2--
