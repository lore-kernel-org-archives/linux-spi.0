From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH] spi: Force the registration of the spidev devices
Date: Wed, 13 May 2015 19:50:34 +0200
Message-ID: <20150513175034.GC4004@lukather>
References: <1431462804-30467-1-git-send-email-maxime.ripard@free-electrons.com>
 <20150513112604.GI3066@sirena.org.uk>
 <20150513153740.GC11677@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5QAgd0e35j3NYeGe"
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>,
	Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150513153740.GC11677-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--5QAgd0e35j3NYeGe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Wed, May 13, 2015 at 08:37:40AM -0700, Greg Kroah-Hartman wrote:
> On Wed, May 13, 2015 at 12:26:04PM +0100, Mark Brown wrote:
> > On Tue, May 12, 2015 at 10:33:24PM +0200, Maxime Ripard wrote:
> >=20
> > > While this is nicer than the DT solution because of its accurate hard=
ware
> > > representation, it's still not perfect because you might not have acc=
ess to the
> > > DT, or you might be driving a completely generic device (such as a
> > > microcontroller) that might be used for something else in a different
> > > context/board.
> >=20
> > Greg, you're copied on this because this seems to be a generic problem
> > that should perhaps be solved at a driver model level - having a way to
> > bind userspace access to devices that we don't otherwise have a driver
> > for.  The subsystem could specify the UIO driver to use when no other
> > driver is available.
>=20
> That doesn't really work.  I've been talking to the ACPI people about
> this, and the problem is "don't otherwise have a driver for" is an
> impossible thing to prove, as you never know when a driver is going to
> be loaded from userspace.
>=20
> You can easily bind drivers to devices today from userspace, why not
> just use the built-in functionality you have today if you "know" that
> there is no driver for this hardware.

What we're really after here is that we want to have an spidev
instance when we don't even have a device.

And since SPI isn't really doing any kind of hotplug, the only
situation that might be problematic is if we have the DT overlays
registering new devices.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--5QAgd0e35j3NYeGe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVU47qAAoJEBx+YmzsjxAgykoP/jYonFs6kWgHcsaDK2E68fnC
0afbUWEWocyt455nRvPnuZT3b+tyDPIlmVzryxI5AB1apyDA7EqELWCn/SYu+zsK
xMQPZyyxk1gLkVI+7huxiGDBvqezdJWjyzLUJA7eVJpe4qL4ByxaOYSIXKZokDfP
udJxR5nIZtH2AhvXnq2rxFLQruVXmzUh8qmG7uGGgBdmjwAy926YLbPuKXUaM7s4
NLjT4dVTVEfpW2a8J0Uz0x1QZeNpBTrY0FpCS1xpdFIvtp5HmzvSf+dCD2ns1Lre
0VVe6D0SNxixyf/+8Z3fDkfneAUxLxSHuFXWiVXM4gazrVAjOd6ThjEwTY+1gKS2
nWOBMjNVj3htihI7yYMA1UW/KOVVPlWM8Qr81U+3EZDGJ2hx1LXuZpI3gkhK5D1J
e6i6avSNDo1nSQ4+DGhSEqYIPkPIRKs7Lcqi5Yktm9a7qEyY60SHLqmNXHG7L2C9
aJxiWbDv4hBvV+r6h4HRptyceM4s+fpBNiWoHfqPwaWd5DbstfOaciOi/lCv+58r
aI6b4TBul5va8inU7qUAq4eoLEA+VggpqQfnQIKwdZoEW8N8KFzMucJ72t8y1fEh
uy52V2mKbc9O1IXdg3d8CNg8HutzE02Yytj1Dpq/1DtqdN40Z25R9nCb6284+JVF
fDHFvUhfm9BqmuMcd04F
=W2mn
-----END PGP SIGNATURE-----

--5QAgd0e35j3NYeGe--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
