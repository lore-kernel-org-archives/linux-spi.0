From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: Re: [PATCH] spi: tegra: add spi driver for SLINK controller
Date: Mon, 22 Oct 2012 20:04:56 +0200
Message-ID: <20121022180456.GA16735@avionic-0098.mockup.avionic-design.de>
References: <1350557233-31234-1-git-send-email-ldewangan@nvidia.com>
 <20121022122825.GD4477@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Cc: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org,
	rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20121022122825.GD4477-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 22, 2012 at 01:28:26PM +0100, Mark Brown wrote:
> On Thu, Oct 18, 2012 at 04:17:13PM +0530, Laxman Dewangan wrote:
[...]
> > +static struct tegra_spi_platform_data *tegra_slink_parese_dt(
> > +		struct platform_device *pdev)
> > +{
>=20
> There doens't seem to be any binding documentation; binding
> documentation is mandatory.

Also this should probably be renamed to tegra_slink_parse_dt().

Thierry

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQhYrIAAoJEN0jrNd/PrOha2wQAKki4XBdCQf79grlXRu/crBA
FmtQrnLcI6Gt+EOmT19Q39XCXb48OH05jBYuDWZZV0l/NJIdg5XSkZhxfobxdQXA
wg5bHBFeiRHtUBqiC/b+Or+Jo4PVGtFETyvKVNNPBaLTj7NpyLP8ezFaJVfYDktq
suDLxlBcNzQjn6D07kyQijXiSlmMQU7Ci7yk3/Tm3BwYzReUzfg43lR9RBI+ptP2
DKnT4VdSzPxXGuarjV2CY43dABs13Gm5sNA1taNqleXsLmZbGTedqeKdo0E4sqF8
qOCzkrocX//xeIISdqmZfG8eI3LvizjAi9BIhADN883y+lJv5KX6GRxUXI6jJWeC
fMaJ1pEHhGg1R6IJJECKy2anz2D2H2NKJD7rKVLX7DAi2R8zcPq9Kr08N4tX9lJi
T4pgjgWxBhUobr2dUjX2bp8xtIqjMh7W1UFZzlahK+J1zRav2A3uEXQL1mUrkm5f
3UCmnLOadtD03tssFT2LBOc88LDe71e70Dl7DvNYLWuhCZuQRCR22YHy7EPsv+pa
l9rBHt03KfJZ9eOTV+Ig3fDFkhqJMpdU35fIZrYyLzvQJEglGs11MMJtWkodGw2Q
nYBA1k91Iw+gr5k58ePJu4aDVb5XpTc2BMDJV4OQHLtqVUwzkiGj1V87othrfT5j
jwldxaskbirg7onkRwjt
=Yv1o
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
