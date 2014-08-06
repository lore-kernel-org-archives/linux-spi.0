From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 03/12] spi: rspi: Use devm_kasprintf()
Date: Wed, 6 Aug 2014 21:26:32 +0100
Message-ID: <20140806202632.GR17528@sirena.org.uk>
References: <1407329949-5695-1-git-send-email-geert+renesas@glider.be>
 <1407329949-5695-4-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rGFapJQksCwzvIuF"
Cc: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>,
	Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1407329949-5695-4-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--rGFapJQksCwzvIuF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 06, 2014 at 02:59:00PM +0200, Geert Uytterhoeven wrote:
> Use the devm_kasprintf() helper function instead of open coding
> error-prone buffer handling and string formatting.

Applied, thanks.

--rGFapJQksCwzvIuF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT4o91AAoJELSic+t+oim957gP/370VcQiNyBaXn7MiFb3fxCU
LyjgnZoqsA6mtsT8ocUg752LbafjcFtF06dqawGvyZ5Lm1HkoGCM+jrUAqkBGtg+
yE0uRChxTXyZOfOFh2ceZBlMbeSmvxuLF+nk+QKTt/RNQRv4cCj4s7dqWtR41+PN
dyBDSq4QsJHK7ssLecAF6JYoISbVpbFxEkJc+hfwzABHBcr9q1fJ8I/4D/oJr7L0
Jz/QFcwBfbfKYFhGYRDwEljbstL3RnE1p+GzhF3cDc/lqxMWjpGmDWBokHePeK7S
QxbK0uJ7ivToiTaIzj24zqE2eXczpIewefMSEG32PZYf8ndEn0wO6rcagsGUjT9s
Jmo0iVz8Vp7h9+54uvBTkbGT/5p0nDilZRAvo0W/G5OlcdMdgApy0gJCgnaA7JMt
AQSYlxY+mgVwm7IC26cCWPzlKy0Ot7P3UDAhUShsiipP7MEemGjAGoHdKywXvhzS
HIcy0eohogwTf4tE50z5JOFF7DHGfuUP8RRYroqb/DSvW6+nQkmOdJIhX6MewsDR
i+sNDKs48RBA+Z283DEaE5z+EARBR7oQqDMHH9A1DJdGfRcuNZgC3/2f/iPUUW0p
QbArir9ED0PATx1rR69k0VTPOslqzLrh9mMNuL82sTPo2OA7f6+1JyNPOx10JtuW
TKaqijRrkMLYsAwZO6RP
=0NBV
-----END PGP SIGNATURE-----

--rGFapJQksCwzvIuF--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
