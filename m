From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH] spi: add spi_tegra driver
Date: Fri, 30 Jul 2010 09:54:43 +0200
Message-ID: <20100730075443.GA17814@avionic-design.de>
References: <1280450224-25118-1-git-send-email-ccross@google.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0390089218=="
Cc: linux-tegra@vger.kernel.org, spi-devel-general@lists.sourceforge.net,
	Erik Gilling <konkers@android.com>, linux-arm-kernel@lists.infradead.org
To: Colin Cross <ccross@google.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1280450224-25118-1-git-send-email-ccross@google.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org


--===============0390089218==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Colin Cross wrote:
> From: Erik Gilling <konkers@android.com>
>=20
> CC: spi-devel-general@lists.sourceforge.net
> Signed-off-by: Erik Gilling <konkers@android.com>
> ---
> This patch depends on the Tegra APB DMA driver:
> [PATCH] [ARM] tegra: Add APB DMA support
> ---
>  drivers/spi/Kconfig     |    6 +
>  drivers/spi/Makefile    |    1 +
>  drivers/spi/spi_tegra.c |  651 +++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 658 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/spi/spi_tegra.c
>=20
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 91c2f4f..c07e0de 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -298,6 +298,12 @@ config SPI_STMP3XXX
>  	help
>  	  SPI driver for Freescale STMP37xx/378x SoC SSP interface
> =20
> +config SPI_TEGRA
> +	tristate "Nvidia Tegra SPI controller"
> +	depends on ARCH_TEGRA
> +	help
> +	  SPI driver for NVidia Tegra SoCs
> +
[...]

Since you say this driver depends on the APB DMA driver, should this not be
expressed as a Kconfig dependency? Something like:

	select TEGRA_SYSTEM_DMA

Thierry

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkxShUMACgkQZ+BJyKLjJp+xeQCfVFL/6xTCMGH2PH2RskDgKDXw
jsMAoJsyxkZzeUJx9h/7Ot+AdUYl58dX
=fq/x
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--


--===============0390089218==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0390089218==--
