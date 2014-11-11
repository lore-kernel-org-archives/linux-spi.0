From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: add support for DLN-2 USB-SPI adapter
Date: Tue, 11 Nov 2014 12:41:44 +0000
Message-ID: <20141111124144.GW3815@sirena.org.uk>
References: <1415364314-30320-1-git-send-email-laurentiu.palcu@intel.com>
 <1415364314-30320-2-git-send-email-laurentiu.palcu@intel.com>
 <20141108104606.GH2722@sirena.org.uk>
 <20141111123808.GM5826@lpalcu-linux>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jH8DeoQifCS4QviE"
Cc: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Johan Havold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurentiu Palcu <laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141111123808.GM5826@lpalcu-linux>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--jH8DeoQifCS4QviE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 11, 2014 at 02:38:08PM +0200, Laurentiu Palcu wrote:
> On Sat, Nov 08, 2014 at 10:46:06AM +0000, Mark Brown wrote:

> > You shouldn't need this _put(), it's defeating the purpose of having the
> > devm_ registration.

> Agreed! I used spi-rockchip.c as a template and I took it for granted.
> I'll remove this line in v2. And, if you think it's worth it, I can send
> a separate patch for spi-rockchip.c too.

Yes, please.

--jH8DeoQifCS4QviE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUYgQHAAoJECTWi3JdVIfQzzAH/2tu/vUCCmp2kgdUHXo0uo6c
1//BSVKMzNypRVrTI8htGAo6Y0VSmV8EaEawlc51qVOgxuA4b6K+YCcFW0Er/zp8
EhtX8g+81hbGVJE0WxZuHqMhM6s6A/RV7QIUXbUoNrV8cZbiey2ZQNyjy61JKTm2
tp3SFd2jZq/D4mgdbEJ8VZTASPpSAP8Lo8ITjB46p8ytS4k0i4e6rzsDeWb3/Xrc
9zEFAYk7KGtJ4IY8zn8YeDQ7MApbJu8rJVAA2U3dP0q7E8l96bNTd3S1GwwKnTVD
mS5KC2AseLeZGzESt9fS7wkFwA5i1Ed5r1wsRonB6o24WykSTO19btCEsuHre9Q=
=TPB6
-----END PGP SIGNATURE-----

--jH8DeoQifCS4QviE--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
