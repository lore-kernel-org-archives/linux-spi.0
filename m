From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [linux-sunxi] [PATCH 2/3] spidev: Add DT binding example.
Date: Mon, 27 Apr 2015 11:46:02 +0100
Message-ID: <20150427104602.GO22845@sirena.org.uk>
References: <20150426110144.GK22845@sirena.org.uk>
 <553CCABA.3090504@redhat.com>
 <12F80B18-7418-430E-94F7-5A20C133BA9A@martin.sperl.org>
 <CAOMqctR8MZ_r6HHEBWhgxpUsTaV=M7DfmnJ_VxTqjWu4KMBSwA@mail.gmail.com>
 <20150426125113.GF5627@lukather>
 <CAOMqctRbYoNG2c-5atBP3QvMKbEhOrAgxzK1QskA5k2TgHraFQ@mail.gmail.com>
 <20150426143359.GI5627@lukather>
 <CAOMqctR5NiuZ2T3wYOpqu6Ez1yk7U9VoxDZHBT6uEqftRN_Z-g@mail.gmail.com>
 <20150426155404.GL5627@lukather>
 <CAOMqctT1sC5PWLLXr0By_-5GaJK0nKoGOxHiwpaFZtBFmWkDbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9ioi+DVKW/PB6LhC"
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>,
	Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>,
	linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
	Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-doc <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAOMqctT1sC5PWLLXr0By_-5GaJK0nKoGOxHiwpaFZtBFmWkDbQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--9ioi+DVKW/PB6LhC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Apr 26, 2015 at 08:53:16PM +0200, Michal Suchanek wrote:

> Do you have to describe a modem or terminal emulator in DT to connect
> it to your serial port? You just describe the port. So here you have a
> SPI port and it should be described in the DT as faithfully as the
> serial port.

Serial ports have runtime mechanisms defined for connecting devices to
them (opening the device or attaching a line discipline).

> Or do you suggest that I patch the compatible into spidev, write a
> driver for it, and then back out the compatible from spidev and check
> in the compatible again with the driver?

Until someone provides a way of binding spidev to otherwise unbound
devices that's exactly what is being suggested; if your main purpose in
this is to write a kernel driver for the device then that would be a
local modification to add the compatible (or you could just ignore the
warning) until you get something in kernel space, no need to upstream.

--9ioi+DVKW/PB6LhC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVPhNqAAoJECTWi3JdVIfQyrsH/RfUEHVGEPvD0zvuewuMJDln
c/LxghVP9XmFWo5k1D+0cyUSHHtOK072cUVmj9DfuLWwcYAPgLiJWJolE+IxjJ1o
tblmD3AgiodnJyt6MmeAgduz6vmcTv3OaF7d3kkEa2bQ0IzTeP3X9SmJ7yVWQB0H
IJw58n+C+NAoW3XA/1z2Yq55NZp8n1pK37bs3krLXhzo8zMIknjr9EmCuoIzFsSJ
R2+5DGodjmG8xUdREtAIjQfwttSNTnLMjU9yKdqgS8goIllQFVbmHiXwVpxIXoh+
sATRmCTRfPN6wgElUS6c9Rzm3Dfw0vPRy/uky/H5Pos+Zxg0kE9pdjnMxOU8soI=
=sP5D
-----END PGP SIGNATURE-----

--9ioi+DVKW/PB6LhC--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
