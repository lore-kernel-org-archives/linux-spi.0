From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 0/8] ARM: s3c64xx: Let amba-pl08x driver handle DMA
Date: Wed, 20 Nov 2013 12:31:52 +0000
Message-ID: <20131120123152.GZ2674@sirena.org.uk>
References: <1381950659-12703-1-git-send-email-tomasz.figa@gmail.com>
 <20131017102201.GK2443@sirena.org.uk>
 <52644563.1000203@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YNEMMPJXay2VNSoy"
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>,
	Padmavathi Venna <padma.v-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Sangbeom Kim <sbkim73-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>,
	Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>,
	Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <52644563.1000203-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--YNEMMPJXay2VNSoy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 21, 2013 at 06:04:35AM +0900, Kukjin Kim wrote:

> Applied this whole series.

This didn't seem to make it into -next or your tree, it'd be really
helpful to be able to merge into both ASoC and SPI so they can be used
for some framework work (I already have some patches for ASoC).  Would
it be possible to get the changes published on a separate branch or
signed tag so I can pull it into those subsystems for the next merge
window?

--YNEMMPJXay2VNSoy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSjKu0AAoJELSic+t+oim9uQwQAJaqm3gH0lG3H8u4ljnv3H9T
JntYWgAT8Vn5XqPKAbAJjLGhSNAFn423efSeIOv6XeOcDVbbXBZzxi731IbBXdOt
NdAA7nZmY09TdGdb/s3FYu8xi66yqvLTAT6jct3ov6Mm3s+xkKozerwUUmM21Uy0
Itydavphmn8XpdieQJVaYWSk0iKdb+HcPq865xsKgF9wU6F6sLtILkw9qf/Ly0IF
EFWnNa13e67sRwOnQOKT1mcWjaLJ5UWVmHtF1AvQ87QP9U0kkdHanyLYJTqC556I
+rN6euxf/MhthlRN/SooJNwf4mqEQafYqntc9zoY2hcUoM1ncrPf9GdoSZB/6jRQ
BGPQEIyCGHl6GArWLr51TBiD5KeEeu92kvvb6ybNkD/G9tpIZ+k/gvsP8Z+tYrJX
hVI4n9M7FNyGeIa4swhImt6AHANVHSB8lYxyWTyMs69KHoIdv4Q6yl5XT5A4buf2
bbuIF9zJ4949S6NmM2CtYxrYSPMBS3qYhO7Qc9hvvUVgQQAqPU4aMM/6Eg6nQzqm
tFrFYkBj40Gix7Do9wZlWFpeQTV7LdvrqXlcwUcK+QvOxwJTj577dPpQsGkBOFQq
OqAmmo35OqvYUV5tKnXYKzju4Wk5puj2wKqrSha1XmqF9OLZ1KbSxMuR/Ea5MqVn
fojeHEFQ7KWfASg2E9Cd
=dwHS
-----END PGP SIGNATURE-----

--YNEMMPJXay2VNSoy--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
