From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/6] spi: bcm2835: remove dependency on handle_err which
 is
Date: Sun, 29 Mar 2015 09:48:18 -0700
Message-ID: <20150329164818.GO1743@sirena.org.uk>
References: <72441EEF-C509-433B-9DBA-53A936ED5BDB@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XLsjFikA86nwwlhe"
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <72441EEF-C509-433B-9DBA-53A936ED5BDB-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--XLsjFikA86nwwlhe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 29, 2015 at 04:03:22PM +0200, Martin Sperl wrote:
>  in spi-for-next
>=20
> Remove the implementation of handle_err, the function of which was introd=
uced to
> spi-for-next with patch b716c4ff=20

Why?

When referencing patches please include the patch title as well as the
hash, this makes the mail/commit log more directly readable by humans.

--XLsjFikA86nwwlhe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVGCzRAAoJECTWi3JdVIfQ5owH/2GHq1755w97V5Q+LPGJw7Yx
5dghE58VrYR4W5wJe39t+QLO1h+otKMiXPVDlnaHsKsFlCIIIa5RtXpTW65uqMeC
HFA0Zh2ia7VNH7Ai1axZLy1klLvuO005yWneBjFzBA1fyzdrh82LVajVMoBV//YE
qPpsB0qfXW/vED8BTLTvi500vJCZvI3W8UHrm3UEy9s/YOBOnC7Mcpp/T7hgkUch
EoyTSQZuQ6SiObbCLQRJl7XxanjWDx1LgnynWc5njvLl2ndAzY9tv+xYgmkqQGWl
OU1akU2q78GDeNP2SygjQO9J3mf4AjDrwTGX6nzCdV6b98RYMFw623FyPSj0+Yg=
=DR0d
-----END PGP SIGNATURE-----

--XLsjFikA86nwwlhe--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
