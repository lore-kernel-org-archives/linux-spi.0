From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v3 02/13] spi: sunxi: fix transfer timeout
Date: Mon, 13 Jun 2016 21:55:29 +0200
Message-ID: <20160613195529.GB2600@lukather>
References: <cover.1465490774.git.hramrach@gmail.com>
 <064955d033503f129c3e138b0563817d1fffab27.1465490774.git.hramrach@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4bRzO86E/ozDv8r1"
Cc: linux-sunxi@googlegroups.com, stable@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Russell King <linux@armlinux.org.uk>,
	Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Olof Johansson <olof@lixom.net>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Javier Martinez Canillas <javier@osg.samsung.com>,
	Simon Horman <horms+renesas@verge.net.au>,
	Sjoerd Simons <sjoerd.simons@collabora.co.uk>,
	Thierry Reding <treding@nvidia.com>,
	Alison Wang <b18965@freescale.com>,
	Timo Sigurdsson <public_timo.s@silentcreek.de>,
	Jonathan Liu <net147@gmail.com>,
	Gerhard Bertelsmann <info@gerhard-bertelsmann.de>,
	Priit Laes <plaes@plaes.org>, devicetree@vger.kernel.org,
	linux-arm-kernel@list
To: Michal Suchanek <hramrach@gmail.com>
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <064955d033503f129c3e138b0563817d1fffab27.1465490774.git.hramrach@gmail.com>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--4bRzO86E/ozDv8r1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 13, 2016 at 05:46:49PM -0000, Michal Suchanek wrote:
> The trasfer timeout is fixed at 1000 ms. Reading a 4Mbyte flash over
> 1MHz SPI bus takes way longer than that. Calculate the timeout from the
> actual time the transfer is supposed to take and multiply by 2 for good
> measure.
>=20
> Signed-off-by: Michal Suchanek <hramrach@gmail.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--4bRzO86E/ozDv8r1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXXw+xAAoJEBx+YmzsjxAgtQUQAIVacQYe8Hn5EXkzexpyOXie
xLkDqPMtcYuOAQ7A40ZV4rEzCSErkFTZay3Zrt/TwslRGzbl7D+3YG1rZLQ+lzXX
ypVFM9kSXoGiPEoxfB709uMC5wG+BHN3NOn+GPqWoRsdvZcTDQoeF1wxBCYF8su1
tYtQHPiVTpDNti3TIC3Qs4FdvMNU0sqP8GyO39HHNhgKWJ7s2JB23OqMCK3vjEZM
UDxBV1I5rXrX4bxx1J28vzMggwFsiCi5e/Lymr3/g/CveeQYnc8JLJfPXtIX+RCl
Fh3a+YvKdoJvb32oH5tPx+xoRbHhCL5uPBQAWrCATmO+elQO1ezXZQT1EF39dXz+
vZoXKLFtH9yQHF0q4F+Oahw+1aF/f7dTApNT+/NVNANqUPy1zNrirBkDYyCbBKip
HSaMq70KTH8pU4GwLD/0WZli6hc5zYeSvM4cxIh3KPJ9eSP40TUQcfBoogW5TJMj
1TpVfDtd+tXKyxt5ovLU3MxnRUDKAvETQZRPwQI6YgcOeVAVYGr9JeCTrj3QH0US
2OsAWjQFtVCxg0Fjc10UTYltatmI3yxvHptZ9S+75J/DT//yx9JNZlUKAWO9dpL/
bwmd+vFv8eSdmChApm5VgrDpCfLTA4lEqK+8TgcXikvNa8ibjiK2Rvink555bq6N
uPiZe22XgrphxbL176ot
=7o8b
-----END PGP SIGNATURE-----

--4bRzO86E/ozDv8r1--
