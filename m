From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: fsl: Kill mpc8xxx_spi_cleanup and convert
 fsl_espi_setup to use devm_kzalloc
Date: Mon, 31 Mar 2014 19:21:42 +0100
Message-ID: <20140331182142.GC2269@sirena.org.uk>
References: <1396169003.21905.7.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aNVYTE9V2LY2iLDz"
Cc: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>, Andreas Larsson <andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1396169003.21905.7.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--aNVYTE9V2LY2iLDz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 30, 2014 at 04:43:23PM +0800, Axel Lin wrote:
> In current code, master->cleanup and master->setup are not set in the same
> function. This makes it hard to read and not good for code maintain.
> One example is in fsl-spi.c, master->cleanup is overrided in mpc8xxx_spi_probe()
> which leads to a memory leak.

Applied, thanks.

--aNVYTE9V2LY2iLDz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTObIyAAoJELSic+t+oim9r6IQAJbLHgJBolP8PejtYC2C16sQ
Zxr8eMHv/Y6rj5gw1liTgUObv2Lzr8HjaoXH9j8pKotvY2GnWcpZuUuhAm/gWAMp
eUEgURCz7AB7Fr7SHY38GqKoxibcJ7ILT2Y5yvJ86xBK4Prs82NI4f7COGmTgzHr
R9VUIFI1vlOVSiSHRNZrnXPuKRPI7HyNLfQj1etwGk5wiAsAPU+dqzNRYbo0IkWs
sb1JPX65x5oMVXIjskF1gK4/mvrzAqiQyU3GAPl+dKylA+oDzqQVoiywiS6tIqRa
3lmjGb8VGcY9r23QlP14ERa9owpc9WU8KTu7LI9uhPkaCgFZXZdVlPvrZ0VBgMVT
WXW2ZzPjtaMKQtJAaK2bZiNA437SYFwOA3Hqu7zUkO9/BXoV/ATXGZpr7zKP8CJH
3deabwZJLK/K94nEu2apDp8YuXy3wD56OPu83oX9xdwmIuAdMQHBnlUGNdkHMnLh
odg8phvA3ojGNWesgxkPtoyZNWosG8bzkbv8HH5Vy9dGDo6PEMDxFQmb5aywpJs6
jTwR4eAm0jIAbp43EEZemDFZ+35KfZMoSKWsI6mwWlR9ucV18aseAUKr5GY11+Tv
bscelxFMDGgvG/073qtgiwQZr6bIzlB1yUWHgte2FL579hmDMlqKNGbWiSyjlhr6
q8ElNbokhZuabJdYhskk
=VY+a
-----END PGP SIGNATURE-----

--aNVYTE9V2LY2iLDz--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
