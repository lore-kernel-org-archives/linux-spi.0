From: =?iso-8859-1?Q?Jan_Kundr=E1t?= <jan.kundrat@cesnet.cz>
Subject: Re: [PATCH v4] spi: orion: cosmetics - alias long =?iso-8859-1?Q?direct=5Faccess_variables?=
Date: Sat, 25 Aug 2018 00:50:33 +0200
Message-ID: <6db77ac3-dd15-4b29-8097-06fe66c17645@cesnet.cz>
References: <20180815190449.23738-1-zertsekel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Cc: Mark Brown <broonie@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Stefan Roese <sr@denx.de>, Ken Wilson <ken.wilson@opengear.com>
To: Kosta Zertsekel <zertsekel@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180815190449.23738-1-zertsekel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On st=C5=99eda 15. srpna 2018 21:04:49 CEST, Kosta Zertsekel wrote:
> This change increases the source code readability.
> Instead of using `spi->child[cs].direct_access.XXX` use `dir_acc->XXX`.
> Instead of using `orion_spi->child[cs].direct_access.vaddr` use `vaddr`.
>
> Signed-off-by: Kosta Zertsekel <zertsekel@gmail.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Reviewed-by: Stefan Roese <sr@denx.de>
> ---
>  drivers/spi/spi-orion.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
> index d01a6adc726e..184ba91abeee 100644
> --- a/drivers/spi/spi-orion.c
> +++ b/drivers/spi/spi-orion.c
> @@ -430,6 +430,7 @@ orion_spi_write_read(struct spi_device=20
> *spi, struct spi_transfer *xfer)
>  =09int word_len;
>  =09struct orion_spi *orion_spi;
>  =09int cs =3D spi->chip_select;
> +=09void __iomem *vaddr;
> =20
>  =09word_len =3D spi->bits_per_word;
>  =09count =3D xfer->len;
> @@ -440,8 +441,9 @@ orion_spi_write_read(struct spi_device=20
> *spi, struct spi_transfer *xfer)
>  =09 * Use SPI direct write mode if base address is available. Otherwise
>  =09 * fall back to PIO mode for this transfer.
>  =09 */
> -=09if ((orion_spi->child[cs].direct_access.vaddr) && (xfer->tx_buf) &&
> -=09    (word_len =3D=3D 8)) {
> +=09vaddr =3D orion_spi->child[cs].direct_access.vaddr;
> +
> +=09if (vaddr && xfer->tx_buf && word_len =3D=3D 8) {
>  =09=09unsigned int cnt =3D count / 4;
>  =09=09unsigned int rem =3D count % 4;
> =20
> @@ -449,13 +451,11 @@ orion_spi_write_read(struct spi_device=20
> *spi, struct spi_transfer *xfer)
>  =09=09 * Send the TX-data to the SPI device via the direct
>  =09=09 * mapped address window
>  =09=09 */
> -=09=09iowrite32_rep(orion_spi->child[cs].direct_access.vaddr,
> -=09=09=09      xfer->tx_buf, cnt);
> +=09=09iowrite32_rep(vaddr, xfer->tx_buf, cnt);
>  =09=09if (rem) {
>  =09=09=09u32 *buf =3D (u32 *)xfer->tx_buf;
> =20
> -=09=09=09iowrite8_rep(orion_spi->child[cs].direct_access.vaddr,
> -=09=09=09=09     &buf[cnt], rem);
> +=09=09=09iowrite8_rep(vaddr, &buf[cnt], rem);
>  =09=09}
> =20
>  =09=09return count;
> @@ -683,6 +683,7 @@ static int orion_spi_probe(struct platform_device *pdev=
)
> =20
>  =09/* Scan all SPI devices of this controller for direct mapped devices */=

>  =09for_each_available_child_of_node(pdev->dev.of_node, np) {
> +=09=09struct orion_direct_acc *dir_acc;
>  =09=09u32 cs;
> =20
>  =09=09/* Get chip-select number from the "reg" property */
> @@ -711,14 +712,13 @@ static int orion_spi_probe(struct=20
> platform_device *pdev)
>  =09=09 * This needs to get extended for the direct SPI-NOR / SPI-NAND
>  =09=09 * support, once this gets implemented.
>  =09=09 */
> -=09=09spi->child[cs].direct_access.vaddr =3D devm_ioremap(&pdev->dev,
> -=09=09=09=09=09=09=09    r->start,
> -=09=09=09=09=09=09=09    PAGE_SIZE);
> -=09=09if (!spi->child[cs].direct_access.vaddr) {
> +=09=09dir_acc =3D &spi->child[cs].direct_access;
> +=09=09dir_acc->vaddr =3D devm_ioremap(&pdev->dev, r->start, PAGE_SIZE);
> +=09=09if (!dir_acc->vaddr) {
>  =09=09=09status =3D -ENOMEM;
>  =09=09=09goto out_rel_axi_clk;
>  =09=09}
> -=09=09spi->child[cs].direct_access.size =3D PAGE_SIZE;
> +=09=09dir_acc->size =3D PAGE_SIZE;
> =20
>  =09=09dev_info(&pdev->dev, "CS%d configured for direct access\n", cs);
>  =09}

Reviewed-by: Jan Kundr=C3=A1t <jan.kundrat@cesnet.cz>
