From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] spi: octeon: Add thunderx driver
Date: Wed, 27 Jul 2016 19:08:24 +0100
Message-ID: <20160727180824.GS11806@sirena.org.uk>
References: <57963ED3.4090402@caviumnetworks.com>
 <20160725175622.7167-1-jglauber@cavium.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eBTWNsZZiigckDWV"
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>,
	"Steven J . Hill" <steven.hill-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
To: Jan Glauber <jglauber-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160725175622.7167-1-jglauber-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--eBTWNsZZiigckDWV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 25, 2016 at 07:56:22PM +0200, Jan Glauber wrote:
> Add ThunderX SPI driver using the shared part from the Octeon
> driver. The main difference of the ThunderX driver is that it
> is a PCI device so probing is different. The system clock settings
> can be specified in device tree.

Don't send individual patches in reply to the middle of threads, it
makes it really confusing what's going on.  I now have multiple patches
=66rom you for this driver completely unthreaded in my inbox with no
indication of ordering or anything.  Please resend anything that's
pending as a proper patch series.

--eBTWNsZZiigckDWV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXmPiYAAoJECTWi3JdVIfQvgcH/iWt19Dv1BtUK/8exJfFP8fI
2SfjMLp7E6Tv44isDKP9lmrI4V4RMDTl7JXlUnM+zHAyDXOn11Kig9lSh+P05lYZ
eaVq9kg3PRRiEVDQg+OZsamCSjqUzvpQdiuGDg5tEJbwwnFGfvlxNJ5myL+EjBT+
E/0YEmmQdYdVk2pWOj9TbM3GDi/1QYiqX/8E+6VMid0ElsVYnOyFahOQe+yE/g53
v0dGSQYnLy9LKEhMdK2ZQa7lHSUZ1YdoYFlQmlhjpyvY+rRfRb49C9Ha+ggglc+9
Z8rkdkjoGAS+ROJKcLyCk0nAyxY6tiQ1JvMPTqoMa84LWnSjaevaiaxW2dcK68g=
=ugC+
-----END PGP SIGNATURE-----

--eBTWNsZZiigckDWV--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
