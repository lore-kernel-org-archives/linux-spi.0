From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: spidev: Warn loudly if instantiated from DT as
 "spidev"
Date: Thu, 23 Apr 2015 20:32:34 +0100
Message-ID: <20150423193234.GD22845@sirena.org.uk>
References: <1427499742-26916-1-git-send-email-broonie@kernel.org>
 <7C2BEBF5-5169-4804-A7B8-DBCE2E9E8C70@martin.sperl.org>
 <CAMuHMdUv0z=VOec+JbbRBeM9fg2TvQgRX4GefVbOZDoQoOECQQ@mail.gmail.com>
 <CAMuHMdW5hgB7vFmMc6TRqJ2wwWZ0=S+OKdQQoucXakoSnVixtw@mail.gmail.com>
 <20150423103652.GT22845@sirena.org.uk>
 <5538F1D6.7020503@martin.sperl.org>
 <20150423133622.GV22845@sirena.org.uk>
 <5538F95A.20203@martin.sperl.org>
 <20150423181317.GZ22845@sirena.org.uk>
 <81BCB930-E90B-4978-9593-7997B64F65CE@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="I5PYSK0R2Sa5XBHe"
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <81BCB930-E90B-4978-9593-7997B64F65CE-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--I5PYSK0R2Sa5XBHe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 23, 2015 at 09:16:54PM +0200, Martin Sperl wrote:
> > On 23.04.2015, at 20:13, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> > As *repeatedly* mentioned before please stop taking things off-list.  I
> > really shouldn't need to remind you of this quite so often, I'm very
> > tempted to start ignoring such messages.

> This was NOT my intention and I am really sorry for that.

Please also use the normal list, you're using the sourceforge list which
hasn't been in use for quite some time now.

> >> I agree, that we need a long-term solution, but the way it is right now
> >> in for-next/for-linux people think something is broken and will call it
> >> a regression or maybe an API change (because of a change in behaviour =
on
> >> the device-tree).

> > The entire point of this change is to make it look like things are
> > broken because they are, in fact, broken.  We continue to support these
> > systems, we just complain loudly about them.

> Essentially you say: let us produce an error-message for some
> situation where there is NO way around making it work without
> an error message.

Sure there is, add a device ID to spidev and use that in the DT as Geert
said.

> Also note that the "beagle-bone people=E2=80=9D still provide device-tree=
s that
> explicitly set up compatiblity=3D=E2=80=9Cspidev=E2=80=9D - I just did a =
quick check:
> /boot/dtbs/3.19.3-bone4/omap3-ha-lcd.dtb contains spidev.

I suspect that's just some random DT they inherited from mainline rather
than something production, and honestly the fact that people keep on
doing this is exactly the reason we now complain loudly.  It's tedious
having to go through the "no, your DT should describe the hardware"
routine again and again.

--I5PYSK0R2Sa5XBHe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVOUjRAAoJECTWi3JdVIfQ3G8H+gLEbGKwNh33VmZH+vfX79oR
eihsOoiNSbkJ19Dl/SmVCSeogNJuWZ7TM8VOvhtG6Q39Eoc7YAc55m1gSsG/tkHA
Q5OObovAn2WoX1YOL3qRoPmPp3kktatxBl1KJEFmyZnS9QzuUShx06t3ixURgVi0
jBDTS+TWjbr6DdPNasfOd0ZYbKvcNdFsUq58qnGH3M2pdKENEsh9+NDr4WFG0C36
d8f6Z1/3bJ5DDlLoOv0Hum+bYv2DOASuD16A8A2YMaHRuB4deZSS98LLskEROTZ9
H8j0IjR2blo3xOAplmZet3BTUKsiDhpMXBuCdOWHyAYuAsJYNLj4SzGhbtIPqng=
=CAwZ
-----END PGP SIGNATURE-----

--I5PYSK0R2Sa5XBHe--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
