From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] spi/tegra: add devicetree support
Date: Wed, 15 Jun 2011 13:08:48 -0600
Message-ID: <BANLkTikg=rzB3R3Gwed3+y1V8OXQhmm1Lg@mail.gmail.com>
References: <20110615190754.11693.26335.stgit@ponder>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stephen Warren <swarren@nvidia.com>
To: spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, Erik Gilling <konkers@android.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110615190754.11693.26335.stgit@ponder>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Jun 15, 2011 at 1:07 PM, Grant Likely <grant.likely@secretlab.c=
a> wrote:
> Allow the tegra spi driver to obtain populate the spi bus with device=
s
> from the device tree.
>
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

I'll commit this to spi/next in a few days if nobody objects.

g.

> ---
> =A0.../devicetree/bindings/spi/spi_nvidia.txt =A0 =A0 =A0 =A0 | =A0 =A0=
5 +++++
> =A0drivers/spi/spi-tegra.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0| =A0 12 ++++++++++++
> =A02 files changed, 17 insertions(+), 0 deletions(-)
> =A0create mode 100644 Documentation/devicetree/bindings/spi/spi_nvidi=
a.txt
>
> diff --git a/Documentation/devicetree/bindings/spi/spi_nvidia.txt b/D=
ocumentation/devicetree/bindings/spi/spi_nvidia.txt
> new file mode 100644
> index 0000000..bde450b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi_nvidia.txt
> @@ -0,0 +1,5 @@
> +NVIDIA Tegra 2 SPI device
> +
> +Required properties:
> +- compatible : should be "nvidia,tegra250-spi".
> +- gpios : should specify GPIOs used for chipselect.
> diff --git a/drivers/spi/spi-tegra.c b/drivers/spi/spi-tegra.c
> index 8e30727..a43ceeb 100644
> --- a/drivers/spi/spi-tegra.c
> +++ b/drivers/spi/spi-tegra.c
> @@ -546,6 +546,7 @@ static int __init spi_tegra_probe(struct platform=
_device *pdev)
> =A0 =A0 =A0 =A0tspi->rx_dma_req.req_sel =3D spi_tegra_req_sels[pdev->=
id];
> =A0 =A0 =A0 =A0tspi->rx_dma_req.dev =3D tspi;
>
> + =A0 =A0 =A0 master->dev.of_node =3D pdev->dev.of_node;
> =A0 =A0 =A0 =A0ret =3D spi_register_master(master);
>
> =A0 =A0 =A0 =A0if (ret < 0)
> @@ -595,10 +596,21 @@ static int __devexit spi_tegra_remove(struct pl=
atform_device *pdev)
>
> =A0MODULE_ALIAS("platform:spi_tegra");
>
> +#ifdef CONFIG_OF
> +static struct of_device_id spi_tegra_of_match_table[] __devinitdata =
=3D {
> + =A0 =A0 =A0 { .compatible =3D "nvidia,tegra250-spi", },
> + =A0 =A0 =A0 {}
> +};
> +MODULE_DEVICE_TABLE(of, spi_tegra_of_match_table);
> +#else /* CONFIG_OF */
> +#define spi_tegra_of_match_table NULL
> +#endif /* CONFIG_OF */
> +
> =A0static struct platform_driver spi_tegra_driver =3D {
> =A0 =A0 =A0 =A0.driver =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =3D =A0 =A0 =A0 =A0 "spi_tegra",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.owner =3D =A0 =A0 =A0 =A0THIS_MODULE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .of_match_table =3D spi_tegra_of_match_=
table,
> =A0 =A0 =A0 =A0},
> =A0 =A0 =A0 =A0.remove =3D =A0 =A0 =A0 __devexit_p(spi_tegra_remove),
> =A0};
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
