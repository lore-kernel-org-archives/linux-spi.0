From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3] spi: orion.c: Add direct access mode
Date: Tue, 12 Apr 2016 20:27:36 +0100
Message-ID: <20160412192736.GC14664@sirena.org.uk>
References: <1460030811-13787-1-git-send-email-sr@denx.de>
 <20160411105740.GB3351@sirena.org.uk>
 <570CDF5F.9070106@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3siQDZowHQqNOShm"
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
To: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <570CDF5F.9070106-ynQEQJNshbs@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--3siQDZowHQqNOShm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 12, 2016 at 01:43:27PM +0200, Stefan Roese wrote:
> On 11.04.2016 12:57, Mark Brown wrote:
> > On Thu, Apr 07, 2016 at 02:06:51PM +0200, Stefan Roese wrote:

> >> +		if (count > da->size) {
> >> +			dev_err(&spi->dev,
> >> +				"max transfer size exceeded (%d > %d)\n",
> >> +				count, da->size);
> >> +			return 0;
> >> +		}

> > This seems obviously broken, we're neither returning an error nor
> > falling back to PIO here but instead silently ignoring the transfer.

> Its not silently ignored (dev_err above) but I agree, we should be
> able to fall back to PIO mode in this condition. I'll change this in
> v4.

Logging is not useful error handling, software doesn't see it and will
continue on potentially corrupting data.

> > Do bidirectional transfers work properly with this method (how much
> > incoming data can we queue up, is there memory backing the whole
> > region?), and are we guaranteed that the transfer finished by the time
> > we return?

> Frankly, I have no idea if bidirectional transfers work properly.
> I have no means to test it. As stated in the commit text, this=20
> direct mode is only tested for TX as this is the mode that I'm using
> for the FPGA bitstream programming. So its perhaps best to remove the
> RX path completely from the direct mode for now. It can be added
> once someone has a board / platform that can make use of this direct
> RX mode.

That seems a lot safer since if recieve doesn't work that's likely to
upset things like flashes.

> >> +               spi->direct_access[cs].vaddr =3D devm_ioremap_resource=
(&pdev->dev,
> >> +                                                                    r=
);
> >> +               if (IS_ERR(spi->direct_access[cs].vaddr)) {

> > I seem to be missing where we configure the hardware to connect the
> > windows to the chip selects.  We just seem to map the windows but never
> > otherwise interact with the hardware.

> The connection between the CS and the window is done in the DT. All
> is now implemented as Arnd has suggested:

Writing something in the DT won't magically configure anything in the
hardware which is (as I said) the bit I'm missing.

--3siQDZowHQqNOShm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXDUwnAAoJECTWi3JdVIfQMt0H/jGpyWlUfE2xP7X0pfns5WQP
RtAfbnMxzKqsxLfrhIpoYVU6aQnN3HzI02+Lrm/6uEfTqE1YCclN0WoFpXy0yTQ/
RJDVdGjfz3mt+VL5KCbXHWnUWWxx2M8YmPkijIB5OPIh+b0SnIznJjKXPJdX7t7q
iT1v/CyJd/vTVWDsGyrQyjTGJ5qo5OPKk7NuX4Luj+D/83OZq+aPN5pKQue55dKP
5YkPvNJuVipT/lS+Dx37B6EtvDz5I26WKmXAIxbJVKeSqU/Me6bpmaJ9bTTmXTZy
5TGeS7SV7GZWsMGTIUVqx5792pQUDFgjTmVOit0RZ4CwF6gfbV1RROPn5i+Km/Y=
=yNCt
-----END PGP SIGNATURE-----

--3siQDZowHQqNOShm--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
