From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: Force the registration of the spidev devices
Date: Thu, 14 May 2015 15:34:39 +0100
Message-ID: <20150514143439.GP2761@sirena.org.uk>
References: <1431462804-30467-1-git-send-email-maxime.ripard@free-electrons.com>
 <20150513112604.GI3066@sirena.org.uk>
 <20150513153740.GC11677@kroah.com>
 <20150513175034.GC4004@lukather>
 <20150513181736.GC16811@kroah.com>
 <20150513192640.GF4004@lukather>
 <20150513223331.GA26748@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gS/sOEqITpbrYRmu"
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>,
	Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150513223331.GA26748-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--gS/sOEqITpbrYRmu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 13, 2015 at 03:33:31PM -0700, Greg Kroah-Hartman wrote:
> On Wed, May 13, 2015 at 09:26:40PM +0200, Maxime Ripard wrote:

> > Our use case is this one: we want to export spidev files so that "dev
> > boards" with a header that allows to plug virtually anything on it
> > (Raspberry Pi, Cubieboards, Xplained, and all the likes) without
> > having to change the kernel and / or device tree.

> You want to do that on a bus that is not self-describing or dynamic?
> I too want a pony.  Please go kick the hardware engineer who designed
> such a mess, we solved this problem 20+ years ago with "real" busses.

The hardware engineers for some of these things did build enumeration in
but none of them with any sort of community have been able to make it
stick - the community just ends up ignoring the ID allocation.

> > This patch is actually doing this: creating a new device for all the
> > chipselects that are not in use that will be bound to the spidev
> > driver.

> I have yet to see a patch...

That was the first message in the thread.

--gS/sOEqITpbrYRmu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVVLJ6AAoJECTWi3JdVIfQr4EH/jXdIy5AH4gZdEtVXX7QTgUM
DdQR2ces5OVnRpGNstaUDSoJ39TX4nqUJRShMHoIlLzH3qDfnr1Y/9Xf46N/vbXK
tJGb+PuAYSGrH3Trk5ne/BsJ9AFe4pZZbyZAqoW6rgMaO32wLzuf2in1xvfYyVgP
cijnZX7pi46oL3TPemgjcuQMaF7vh9BwGz2ZgCXYaAA+W5ZitcNhg74NuL2SZ4Lp
dX0IfV3pRPsdgxOB0I0vZGpmtxaki9urzvaXC01WHAd4Zcp2TFUR2FqQYDNglI1I
LowsITXKznOibGHpBYoR1MJUc+LxaUtL06yT2iB3ILNtrmfNfBacaW39so1Rx4Y=
=NHPE
-----END PGP SIGNATURE-----

--gS/sOEqITpbrYRmu--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
