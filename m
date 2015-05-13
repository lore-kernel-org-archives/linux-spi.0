From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH] spi: Force the registration of the spidev devices
Date: Wed, 13 May 2015 14:51:02 +0200
Message-ID: <20150513125102.GA2628@lukather>
References: <1431462804-30467-1-git-send-email-maxime.ripard@free-electrons.com>
 <20150513112604.GI3066@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>,
	Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150513112604.GI3066-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2015 at 12:26:04PM +0100, Mark Brown wrote:
> > Solve this by registering automatically spidev devices for all the unus=
ed chip
> > selects when a master registers itself against the spi core.
>=20
> So, aside from the concern about this being generic the other thing here
> is that we often have devices offering more chip selects than can
> physically be used in a system but not doing anything to ensure that the
> invalid ones can't be used.  It's unclear to me if that's OK or not, it
> might be since it's root only I think but I need to think it through a
> bit.

I might plead guilty here... :)

I'd say we're also ok because if we delegate the device driving logic
to userspace, we should expect it to know what it does to first drive
the device properly, but also to open the right device for this.

What's the worst that could happen in such a case? The data are output
without any chipselect line being driven by the controller? Isn't that
supposed to be ignored by the devices?

> > This also adds an i2cdev-like feeling, where you get all the
> > spidev devices all the time, without any modification.
>=20
> I2C is a bit safer here since it's a shared bus so you can't do
> anything to devices not connected to the bus by mistake.

I'm not sure to understand what you mean here. How is SPI different
=66rom that aspect?

> > +		/*
> > +		 * This is far from perfect since an addition might be
> > +		 * done between here and the call to spi_add_device,
> > +		 * but we can't hold the lock and call spi_add_device
> > +		 * either, as it would trigger a deadlock.
> > +		 *
> > +		 * If such a race occurs, spi_add_device will still
> > +		 * catch it though, as it also checks for devices
> > +		 * being registered several times on the same chip
> > +		 * select.
> > +		*/
> > +		status =3D bus_for_each_dev(&spi_bus_type, NULL, spi,
> > +					  spi_dev_check);
> > +		if (status) {
> > +			dev_dbg(&master->dev, "Chipselect already in use.. Skipping.");
> > +			spi_dev_put(spi);
> > +			continue;
> > +		}
>=20
> This still leaves us in the situation where if we do know the device
> that is connected we have to explicitly bind it in spidev which is
> apparently unreasonably difficult for people.

You can still do that, but the point is that you don't have to.

If you know what device you have, and want to use spidev on that
device, it will still work, since it will create an spidev device when
we will parse the DT.

That device will then be skipped by that logic, which is ok.

However, if you don't specify anything in your DT, and have no device
created because you don't really know what's on the other end, this
logic will create the spidev device so that you'll still get an spidev
node exported to the userspace.

> I'm also concerned about the interactions with DT overlays here -
> what happens if a DT overlay or other dynamic hardware instantiation
> comes along later and does bind something to this chip select?  It
> seems like we should be able to combine the two models, and the fact
> that we only create these devices with a Kconfig option is a bit of
> an interesting thing here.

I think the safe approach would be, just like I told in this thread,
to just check whether the modalias is spidev. If it is, destroy the
previous (spidev) device, create a new device as specified by the DT,
you're done.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVU0i2AAoJEBx+YmzsjxAgLlgP/00hOPWtXoL1txId/2mlk5JD
FtGgFCjKqcS6P+DS4EirUtBg6a346O6mhgbZWckvKVlWf/Kd4stgs4uSvuT398mI
ukOZlzcRDU7OyABmU5q3h1isXvfy3oHrkqZRqsUX4LNTr8k7X6pPKf+YB8dAWghD
89EuOu+X1Nf5mcLL6X99vgvOFZ950Vf9yCVHsJFFhcSpRLZpHnibdtb7yJ3Af/dx
y5s67hj38CPelWzqb+xLjVPvY2myi8qJCLo7WCNvXqlY8OemBtzCeUY73UiZim4+
clmdmCECvx/RIlXh6pCsK8y5rnUJuTGutuC8LhTAByWRmpTiE9ypKNY4ycoYJbFT
kZqz9c7fOqhtza0Iy6G3gjSTrZ04ErnvCK8Vw/jQXbTC9YT+h0k/NEY2TE28W2Bw
cqTUXAY0YmXJQrXoUf5ldHyQNCXQzxGjPBiIo+7cZqmgkGu42A+AHtWXOfD9zipW
Ulf3EQVzObW1/cyibMw1pSfcRAsnaKciIy+xTPR5vZQmITNKwb/pwl80dbWQmbjt
1n6tzkB/9WyQM20nCUlbsPngPXJ8051xrxMlGuqlCOmvoUy8OMkMtOaZeIlePffJ
zwLLo9uOAFgrQ7iaoMWmWciyv40amdPKTNfgF+PdvJhUTH7PbMvGFqsQJ/xbVfFf
Rt3FoBuuNK1B273kyltA
=8Xm+
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
