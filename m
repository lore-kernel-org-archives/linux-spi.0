From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: spidev: Add ACPI probing support
Date: Mon, 4 Jul 2016 15:20:48 +0200
Message-ID: <20160704132048.GC6247@sirena.org.uk>
References: <1467628683-5783-1-git-send-email-mika.westerberg@linux.intel.com>
 <20160704125600.GB6247@sirena.org.uk>
 <20160704130806.GB23527@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aRuUY7KzmetiZjaI"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160704130806.GB23527-3PARRvDOhMZrdx17CPfAsdBPR1lH4CV8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--aRuUY7KzmetiZjaI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 04, 2016 at 04:08:06PM +0300, Mika Westerberg wrote:
> On Mon, Jul 04, 2016 at 02:56:00PM +0200, Mark Brown wrote:

> > This is fine for now since all the ACPI devices are dummy ones but as
> > soon as someone comes up with an actual ACPI ID for something that
> > should be managed via spidev it'll need changing...

> Sure. That's why the comment above also mentions SPT000* there.

I'm trying to suggest that it'd be nice to write the code to check the
IDs and only warns when appropriate.  :)

--aRuUY7KzmetiZjaI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXemKvAAoJECTWi3JdVIfQc4EH/3cSvDohdIsZVwZA8ZVaYG8x
xg0KFkkQ78QDWeA09UVd7pYU7rmcA6tTqIIjSOKa2+y206bjFl7yvvssXtfV7oGT
dlf2KBRWox3REJP13vMFzgKhwRaqzItArPXizwAobKkW4uy6YVX+L4Id2PNEyy4g
WdQRY4XoK7xuy+FDexGDU5CrEwuc0ZEY/RPP/1oX0nxbIDppL1FPiq54eq/GenoB
u68cvvTf6AiEjH9Ur6H12fT2xhhezWBz0BlJR4flpNoMwvFsqVOBUf4mAhQ/Pf5S
4s1PS1aw/dr6Y+O27MY3+wdSCYHRlS51jxYbiOCyj/2S17lkYtiatougQ9aTfTo=
=7Cxb
-----END PGP SIGNATURE-----

--aRuUY7KzmetiZjaI--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
