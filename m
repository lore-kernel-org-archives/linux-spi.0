From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: Force the registration of the spidev devices
Date: Wed, 13 May 2015 19:12:16 +0100
Message-ID: <20150513181216.GH2761@sirena.org.uk>
References: <1431462804-30467-1-git-send-email-maxime.ripard@free-electrons.com>
 <20150513112604.GI3066@sirena.org.uk>
 <20150513153740.GC11677@kroah.com>
 <20150513175034.GC4004@lukather>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="G1IH56i3DES2a+WZ"
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
	linux-spi@vger.kernel.org, Martin Sperl <kernel@martin.sperl.org>,
	Michal Suchanek <hramrach@gmail.com>
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150513175034.GC4004@lukather>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--G1IH56i3DES2a+WZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 13, 2015 at 07:50:34PM +0200, Maxime Ripard wrote:
> On Wed, May 13, 2015 at 08:37:40AM -0700, Greg Kroah-Hartman wrote:

> > That doesn't really work.  I've been talking to the ACPI people about
> > this, and the problem is "don't otherwise have a driver for" is an
> > impossible thing to prove, as you never know when a driver is going to
> > be loaded from userspace.

> > You can easily bind drivers to devices today from userspace, why not
> > just use the built-in functionality you have today if you "know" that
> > there is no driver for this hardware.

> What we're really after here is that we want to have an spidev
> instance when we don't even have a device.

We do?

> And since SPI isn't really doing any kind of hotplug, the only
> situation that might be problematic is if we have the DT overlays
> registering new devices.

Well, we still have the driver loaded from userspace in the future
situation as well - the hardware might be static but the software isn't.

--G1IH56i3DES2a+WZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVU5P/AAoJECTWi3JdVIfQI0gH+gIhZ5tFQblEGnwukkU3Z2pQ
ZSWi3Aq7r6jwT/Lk4lDvQoGKOodLlRmaWYOg4S94OvXQB/8CeA8lX0k7ORQUV9pC
K/bKYV8lEVRWqC3D8g3FdG+GkSyYteKC2ljSG4Mi/Osm2A5RAdCIbeL26tSf4bDa
KtUBdDJk38kskp8QYm6urmpGWIY9FYgF3Y/yyMjffKA97TSL6tBzpYu7LyA6fvVO
sXXkmj4YzO5oVKzUK4GsVQm7sww3sW3MBtple9A8mRnZfKanPzFNvILdE1Y9Ij59
8TeQzglXSKE5dnr/qMRSjvrEtNHAsjUGTH0wm8VxN3J80p6Y+J6MqO9Z1YR9gs8=
=7bR0
-----END PGP SIGNATURE-----

--G1IH56i3DES2a+WZ--
