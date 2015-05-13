From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH] spi: Force the registration of the spidev devices
Date: Wed, 13 May 2015 21:26:40 +0200
Message-ID: <20150513192640.GF4004@lukather>
References: <1431462804-30467-1-git-send-email-maxime.ripard@free-electrons.com>
 <20150513112604.GI3066@sirena.org.uk>
 <20150513153740.GC11677@kroah.com>
 <20150513175034.GC4004@lukather>
 <20150513181736.GC16811@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rWhLK7VZz0iBluhq"
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>,
	Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150513181736.GC16811-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--rWhLK7VZz0iBluhq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2015 at 11:17:36AM -0700, Greg Kroah-Hartman wrote:
> On Wed, May 13, 2015 at 07:50:34PM +0200, Maxime Ripard wrote:
> > Hi Greg,
> >=20
> > On Wed, May 13, 2015 at 08:37:40AM -0700, Greg Kroah-Hartman wrote:
> > > On Wed, May 13, 2015 at 12:26:04PM +0100, Mark Brown wrote:
> > > > On Tue, May 12, 2015 at 10:33:24PM +0200, Maxime Ripard wrote:
> > > >=20
> > > > > While this is nicer than the DT solution because of its accurate =
hardware
> > > > > representation, it's still not perfect because you might not have=
 access to the
> > > > > DT, or you might be driving a completely generic device (such as a
> > > > > microcontroller) that might be used for something else in a diffe=
rent
> > > > > context/board.
> > > >=20
> > > > Greg, you're copied on this because this seems to be a generic prob=
lem
> > > > that should perhaps be solved at a driver model level - having a wa=
y to
> > > > bind userspace access to devices that we don't otherwise have a dri=
ver
> > > > for.  The subsystem could specify the UIO driver to use when no oth=
er
> > > > driver is available.
> > >=20
> > > That doesn't really work.  I've been talking to the ACPI people about
> > > this, and the problem is "don't otherwise have a driver for" is an
> > > impossible thing to prove, as you never know when a driver is going to
> > > be loaded from userspace.
> > >=20
> > > You can easily bind drivers to devices today from userspace, why not
> > > just use the built-in functionality you have today if you "know" that
> > > there is no driver for this hardware.
> >=20
> > What we're really after here is that we want to have an spidev
> > instance when we don't even have a device.
>=20
> That's crazy, just create a device, things do not work without one.

Our use case is this one: we want to export spidev files so that "dev
boards" with a header that allows to plug virtually anything on it
(Raspberry Pi, Cubieboards, Xplained, and all the likes) without
having to change the kernel and / or device tree.

That would mean that if we plug something to that port, no device will
be created because the DT itself won't have that device declared in
the first place.

This patch is actually doing this: creating a new device for all the
chipselects that are not in use that will be bound to the spidev
driver.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--rWhLK7VZz0iBluhq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVU6VwAAoJEBx+YmzsjxAgmmoP/iaEv0wDwdQYlibCwRkqDT83
+igaPKE2Ao3FFPvoi9XpHgwbVaxFLwbcmrMpdnvzq+/XuZUK/0JLVMfHvF/+CkmB
DdbM/v54bH4VMj4na79swIgvK9r2xf3uhSJUXtiYU664Lmrj/4QkUQ66BAiZDaho
ooFMsRb+kflYWgYb0sYEEWg4ynb38Fs9Nba6DKit0UkhbCTMjmx81tnwAWQH1pf+
XFd7T24p998WWCpsJmRBiEDd0leS2Psa60I2LFkh2Fwfh/gqz3s1kCCCvPeCXZvk
74uSlK98xMF+9VE3ntZnlX5Ory4d6tBwMhHbEX652A66m7pwu/6APH0u90Ke9qwO
Z88Gx9HOQqZQzNnzzMJdqcr2JPcizyKo1MR6BtRPJl/GC6lAdQwtLhXh8wP093Um
COw+zvF6TVN5fGP+XgMYUO5yBWQf/dxFGNZiDClP/UceaBi4+do+MvHGc5F1ckVa
ctoc21PwwO9eePd4WSXbeWDocEqogF/T/bzC8UAGV6PQNfS5SNc5Lhq3pltvS0/a
hZWbj7OD8Quwh/UESTHolIJZjHzIMTvXkTTZi/CcOCzkKFhNDTXXr7E3o9SX+RJj
UxD0zvQdSpzqkwKb5yMVWjf3X11c0nFK+n7OcZc0wnrwpGyLJvj9GqJFYvoHLqz+
ixNy4FCl9w8Zytl3D1lD
=ulER
-----END PGP SIGNATURE-----

--rWhLK7VZz0iBluhq--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
