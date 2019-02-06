From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6 01/13] spi: atmel-quadspi: cache MR value to avoid a
 write access
Date: Wed, 6 Feb 2019 16:08:16 +0000
Message-ID: <20190206160816.GD17630@sirena.org.uk>
References: <20190205173254.16388-1-tudor.ambarus@microchip.com>
 <20190205173254.16388-2-tudor.ambarus@microchip.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8955665559743187489=="
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alexandre.belloni@bootlin.com, bbrezillon@kernel.org,
 linux-kernel@vger.kernel.org, Cyrille.Pitchen@microchip.com,
 linux-spi@vger.kernel.org, Ludovic.Desroches@microchip.com, robh+dt@kernel.org,
 linux-mtd@lists.infradead.org, bugalski.piotr@gmail.com,
 linux-arm-kernel@lists.infradead.org
To: Tudor.Ambarus@microchip.com
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190205173254.16388-2-tudor.ambarus@microchip.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org


--===============8955665559743187489==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="osDK9TLjxFScVI/L"
Content-Disposition: inline


--osDK9TLjxFScVI/L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 05, 2019 at 05:33:06PM +0000, Tudor.Ambarus@microchip.com wrote:
> From: Tudor Ambarus <tudor.ambarus@microchip.com>
>=20
> Set the controller by default in Serial Memory Mode (SMM) at probe.
> Cache Mode Register (MR) value to avoid write access when setting
> the controller in serial memory mode at exec_op().
>=20
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
> v6: no change
> v5: collect R-b

You say you've collected a reviewed-by for this but there's no
reviewed-by on the patch?

--osDK9TLjxFScVI/L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxbBm8ACgkQJNaLcl1U
h9DUSwf/SwsNZqQQTTU5XFciBiMdWRRBaxg3WW4hWjTWIrLVYjcB21QsuvC9Sxds
4yfqRnDD0VNgpxnNN2UhQ+RuDXjwpvZasc3goyrR432ilG/+GdRRNWLMGkxxRC8u
kcEG3E6TSA2WdXRahvhepBK53R7lnnYD8GdZIrOMNKu0c3mJdX3Ksy3aYZ9XD0Rf
k+uTgCHDekLYThyaxeWc52Npo12yh8oOJt4VzA4+olU5ZQ/mqptZM5hDNc0b5VrJ
YXeLvvSkog3krfdK5mpDrcFp0/zg2vAqat8d5TxqR3dR8z3LRyxykfTOH5ZAjdP/
kYJ5nrbTOz0QV1Ato4twWY63x3rKkg==
=Ij/B
-----END PGP SIGNATURE-----

--osDK9TLjxFScVI/L--


--===============8955665559743187489==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8955665559743187489==--
