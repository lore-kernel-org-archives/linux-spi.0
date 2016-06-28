From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 3/3] drivers core: allow id match override when
 manually binding driver
Date: Tue, 28 Jun 2016 21:57:36 +0100
Message-ID: <20160628205736.GE17217@sirena.org.uk>
References: <cover.1467053363.git.hramrach@gmail.com>
 <15ff382f699387e2d8f23779db851d0de7e9291e.1467053363.git.hramrach@gmail.com>
 <20160627190949.GB5111@kroah.com>
 <CAOMqctQj0ftbOH9dvMPczBPeSFTvDuTKCXgYprYvtcQDYML8Kw@mail.gmail.com>
 <20160627221259.GA10054@kroah.com>
 <CAOMqctTQAY0NzTpEqyLyScu8UrSXcF82oLVMM+e2F2WQ225B7A@mail.gmail.com>
 <20160628155107.GP17217@sirena.org.uk>
 <CAOMqctQbFmWv04idz7G+dPOCg7n-E0AQdhGAyohUDBniKvrP_g@mail.gmail.com>
 <20160628183825.GS17217@sirena.org.uk>
 <CAOMqctTNmcg32PFVOZaA99GpFba9GOGOuOqmi3ujzxcHRFZsOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="p1zxN+PsucbyOM2v"
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAOMqctTNmcg32PFVOZaA99GpFba9GOGOuOqmi3ujzxcHRFZsOA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--p1zxN+PsucbyOM2v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 28, 2016 at 10:02:59PM +0200, Michal Suchanek wrote:

> Of course I could add "my-shiny-new-board" compatible to the device
> tree and spidev. Then when I build my-shiny-new-board2 and it happens
> to also use userspace driver I will not bother to update the
> compatible nor will anyone else doing this. So it's equivalent to
> having "foobar123" in there from the start. Your proposed solution is
> so complex that it will never be used as intended even if changing the
> compatible on the node and driver could be both accomplished by an
> echo to sysfs.

If you are describing the connected SPI device as the board rather than
the actual device you're doing things wrong, and if you have the same
thing on two boards then /of course/ they should list the same
compatible string so the existing software stack should work.  If people
just use some random board description that happens to work right now
even if it doesn't match their actual hardware then they're no worse off
than with your hacks but we've been pushing people to do something long
term supportable so a bunch of other people who paid attention will be
better off.

> >  If the tooling around this is too hard to use then that
> > seems like a useful thing to work on, having simple ways for people to
> > describe modules they build for maker type systems (ideally integrated
> > with schematic capture software) would be great for example.

> Again, what simple to use tooling do you use to describe the modem you
> connect to a serial port in the kernel (ideally integrated with
> schematic capture software)? I use none. I just connect the modem. I
> want to do that with all SPI devices that I do not intend to use with
> an in-kernel driver above the spi master driver that provides the
> communication channel as is the case with the serial modem.

This has been gone through repeatedly.  There's obvious differences here
- quite apart from anything else dedicated SPI connectors that are
completely fixed function and also not part of a bigger expansion
connector are rather rare and are a clear subset of the more general
plugin module case.  The way we handle serial ports is currently not
ideal anyway, and the general software stacks sitting on top of serial
ports are very different to those for SPI.

> It is not my very specific use case. It's common use case for
> devboards which have spi connectors.

That's really not that common - it *is* common to have expansion
connectors, but single function ones not so much and certainly not in
sufficient numbers that it's worth doing something that only works for
them alone (and then only in cases where spidev happens to be the best
way to control the device which is a further subset).  There's also the
fact that the limited connectors are more commonly found on the more
expensive eval boards which of course tend to have users who are more
technically experienced than the maker boards and should really not
struggle with basic tasks.

> If this particular way to solve the problem does not fit with the
> driver model does any of the previously listed ones fit better,
> perhaps with some changes?

> Or since you are familiar with the driver model perhaps you are away
> of a solution that was not mentioned so far that would accomplish this
> and fits with the driver model?

The answer remains the same, describe your module with a DT overlay and
load the overlay.  Or modify your DT directly if you like given that the
board is probably not enumerable anyway, especially if it's a flying
wire job.  If you want to bind devices at runtime you'll need new_id.

> Or if this use case does not fit into the driver model at all then
> perhaps the driver model needs updating to catch up with real world?

The problem isn't that the driver model can't cope, the problem is that
you are flat out refusing to do anything that involves describing the
hardware.

--p1zxN+PsucbyOM2v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXcuS/AAoJECTWi3JdVIfQd2wH/R3IkwUzlHLyab/0gBhWQs/Q
i1fFDfIozX+ik6nvr0Iz0vsH5YP1+YZRdf9d3XXM3Y8JTNFJvmehlYMEPDZfi4kd
Kwc7NZp1taOtV0+TZWDrCuz1J3kR+QGaE6WeHNt+MCQTB9h3Tvf1wvKVtLvrzcIT
A5eMHsl6oiHrAeqwOAI1yscejDopPt3F76FAYaV35L3DF+empv2yiJt4w52N5r67
5wsdKJAAyRkhn+DS+2eEFWy3Jkz7lIPlIwPZPLgXaXLHolsGdKyLR7V6SZ/Ic/j/
TLw4Ha3ehku/EUQzfhE+j6kTa0EL87Vzww5IByrX4RLA+8bv2qHH/uAW9QQ0LEw=
=hogG
-----END PGP SIGNATURE-----

--p1zxN+PsucbyOM2v--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
