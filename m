From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 3/4] spi: Add MFD for Macronix MX25F0A SPI controller
 driver
Date: Wed, 10 Apr 2019 10:37:16 +0100
Message-ID: <20190410093716.GC6106@sirena.org.uk>
References: <1554777000-10542-1-git-send-email-masonccyang@mxic.com.tw>
 <1554777000-10542-4-git-send-email-masonccyang@mxic.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7943740534075861812=="
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, juliensu@mxic.com.tw,
 christophe.kerello@st.com, richard@nod.at, bbrezillon@kernel.org,
 marcel.ziswiler@toradex.com, dwmw2@infradead.org, miquel.raynal@bootlin.com,
 linux-kernel@vger.kernel.org, stefan@agner.ch, linux-spi@vger.kernel.org,
 marek.vasut@gmail.com, paul.burton@mips.com, robh+dt@kernel.org,
 geert@linux-m68k.org, linux-mtd@lists.infradead.org,
 computersforpeace@gmal.com, liang.yang@amlogic.com, lee.jones@linaro.org,
 zhengxunli@mxic.com.tw
To: Mason Yang <masonccyang@mxic.com.tw>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <1554777000-10542-4-git-send-email-masonccyang@mxic.com.tw>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org


--===============7943740534075861812==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="z4+8/lEcDcG5Ke9S"
Content-Disposition: inline


--z4+8/lEcDcG5Ke9S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 09, 2019 at 10:29:59AM +0800, Mason Yang wrote:
> Add a MFD driver for Macronix MX25F0A SPI controller.
>=20
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> ---
>  drivers/spi/spi-mxic.c | 275 +++++++++----------------------------------=
------

This isn't adding a new MFD driver, this is a substantial refactoring of
the SPI driver which doesn't touch SPI at all.

--z4+8/lEcDcG5Ke9S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlytuUsACgkQJNaLcl1U
h9AeQgf8Cq4PSo+iWmspUorVUXm+K5G5aUI3052g+2/+hl0mEaCt7grEKFmiY6ef
xWMpNCd1tocLecIJxAyiipHfJQDpA4hrpRhZaXkbJAG6LXwXfjK2l8YCnzHpSd43
zGBQvVlwNIpqjYv8/YmFXe92QFk6XNPhhofK83HennndKm5ZwjF+vJTa8ZDdPhR5
oikRqtPYEs9ONDwKPL0WRzWBq05uRoe7MjE6tfAqwahQC7paVJCgv40S51m7FUZQ
dv5NyqAfA+piR5zFrrk5QR3GEX3+Hh2pudJjRCSjY8QQkyULl4hT2ehjanj4uWj9
bH4xjLtxOcgcsSxo4wM6vyVNDEffnQ==
=oPnu
-----END PGP SIGNATURE-----

--z4+8/lEcDcG5Ke9S--


--===============7943740534075861812==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

--===============7943740534075861812==--
