From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: Force the registration of the spidev devices
Date: Wed, 13 May 2015 15:36:10 +0100
Message-ID: <20150513143610.GT2761@sirena.org.uk>
References: <1431462804-30467-1-git-send-email-maxime.ripard@free-electrons.com>
 <20150513112604.GI3066@sirena.org.uk>
 <20150513125102.GA2628@lukather>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IQvoI1rdlCKiYEYW"
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>,
	Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150513125102.GA2628@lukather>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--IQvoI1rdlCKiYEYW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 13, 2015 at 02:51:02PM +0200, Maxime Ripard wrote:

> I'd say we're also ok because if we delegate the device driving logic
> to userspace, we should expect it to know what it does to first drive
> the device properly, but also to open the right device for this.

> What's the worst that could happen in such a case? The data are output
> without any chipselect line being driven by the controller? Isn't that
> supposed to be ignored by the devices?

I'm more worried about the chip select line being connected to the
"make the board catch fire" signal or whatever (more realistically
causing us to drive against some other external component) if the extra
chip selects weren't pinmuxed away.

> > > This also adds an i2cdev-like feeling, where you get all the
> > > spidev devices all the time, without any modification.

> > I2C is a bit safer here since it's a shared bus so you can't do
> > anything to devices not connected to the bus by mistake.

> I'm not sure to understand what you mean here. How is SPI different
> from that aspect?

Chip select signals.

> > This still leaves us in the situation where if we do know the device
> > that is connected we have to explicitly bind it in spidev which is
> > apparently unreasonably difficult for people.

> You can still do that, but the point is that you don't have to.

Right, but that's not what I'd expect to happen (and seems to make it
easier for people to not list things in the DT at all which doesn't seem
great).  If we're going to make it available by default I'd expect to be
able to use a userspace driver with anything that doesn't have a driver
bound rather than with devices that explicitly don't have any
identification.

> > I'm also concerned about the interactions with DT overlays here -
> > what happens if a DT overlay or other dynamic hardware instantiation
> > comes along later and does bind something to this chip select?  It
> > seems like we should be able to combine the two models, and the fact
> > that we only create these devices with a Kconfig option is a bit of
> > an interesting thing here.

> I think the safe approach would be, just like I told in this thread,
> to just check whether the modalias is spidev. If it is, destroy the
> previous (spidev) device, create a new device as specified by the DT,
> you're done.

Sure, but I don't see code for that here.

--IQvoI1rdlCKiYEYW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVU2FXAAoJECTWi3JdVIfQ3msH/j28nkDo0Hdiv2GqwXIJQl+u
DVzir7diipbhKKL0f09NO5zg4be05OP4D/K37lh7x9OdiHqCEW8WZy6PM9ucPoGC
8BnJwjpS7NcS9khQ8U1lpXFeyD21YnnSpZ23IXcaQB20V3JX3X4bXqZ819xdvzUj
BoEa6qgGj3OixQxN/upCeWTK0hvob2TBVdPIVEFeSKvFNrigegmO6P8wzHSBZGZA
hQ/gLc59YhJww7uoHicuaHhdLZZ2C9nzPTxke3Du/yXq50rOMPAuxnrI+i5UgvCh
e5RQx658aFKiLqfbI4Npwu1/9EKi8c8Vaxy7kb0rJx70q/3u5WnVtHeeH1U4T7o=
=Lx1M
-----END PGP SIGNATURE-----

--IQvoI1rdlCKiYEYW--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
