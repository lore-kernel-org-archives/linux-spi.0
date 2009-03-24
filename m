From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 3/6] xtensa: add spi mmc host to s6105 platform
Date: Tue, 24 Mar 2009 13:09:27 -0700
Message-ID: <200903241309.27310.david-b@pacbell.net>
References: <1237822462-32109-1-git-send-email-dg@emlix.com> <1237822462-32109-3-git-send-email-dg@emlix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Chris Zankel <chris@zankel.net>,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
To: Daniel =?iso-8859-1?q?Gl=F6ckner?= <dg@emlix.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760001AbZCXUJn@vger.kernel.org>
In-Reply-To: <1237822462-32109-3-git-send-email-dg@emlix.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Monday 23 March 2009, Daniel Gl=F6ckner wrote:
> Signed-off-by: Daniel Gl=F6ckner <dg@emlix.com>

Looks OK to me.  FWIW I don't expect to ack arch patches
that just use public interfaces...


> ---
>  arch/xtensa/platforms/s6105/device.c |   55 ++++++++++++++++++++++++=
++++++++++
>  1 files changed, 55 insertions(+), 0 deletions(-)
>=20
> diff --git a/arch/xtensa/platforms/s6105/device.c b/arch/xtensa/platf=
orms/s6105/device.c
> index a7ea916..789448e 100644
> --- a/arch/xtensa/platforms/s6105/device.c
> +++ b/arch/xtensa/platforms/s6105/device.c
> @@ -11,9 +11,11 @@
>  #include <linux/init.h>
>  #include <linux/irq.h>
>  #include <linux/phy.h>
> +#include <linux/mmc/host.h>
>  #include <linux/platform_device.h>
>  #include <linux/serial.h>
>  #include <linux/serial_8250.h>
> +#include <linux/spi/mmc_spi.h>
>  #include <linux/spi/spi.h>
>  #include <linux/spi/spi_s6000.h>
> =20
> @@ -209,7 +211,60 @@ static __devinitdata struct s6_spi_platform_data=
 s6_spi_pdata =3D {
>  #define S6_SPI_CS_EXPANSION	3
>  #define S6_SPI_CS_MMC_SLOT	4
> =20
> +static int __devinit s6_init_mmc_host(struct device *spi,
> +				      irqreturn_t (*handler)(int, void *),
> +				      void *mmc)
> +{
> +	int ret;
> +	ret =3D gpio_request(GPIO_SD_WP, "mmc_wp");
> +	if (ret < 0)
> +		return ret;
> +	ret =3D gpio_request(GPIO_SD_IRQ, "mmc_irq");
> +	if (ret < 0)
> +		return ret;
> +	ret =3D gpio_direction_input(GPIO_SD_WP);
> +	if (ret < 0)
> +		return ret;
> +	ret =3D gpio_direction_input(GPIO_SD_IRQ);
> +	if (ret < 0)
> +		return ret;
> +	ret =3D gpio_to_irq(GPIO_SD_IRQ);
> +	if (ret < 0)
> +		return ret;
> +	ret =3D request_irq(ret, handler,
> +			  IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
> +			  "mmc_slot", mmc);
> +	return ret;
> +}
> +
> +static void __devexit s6_exit_mmc_host(struct device *spi, void *mmc=
)
> +{
> +	free_irq(gpio_to_irq(GPIO_SD_IRQ), mmc);
> +	gpio_free(GPIO_SD_IRQ);
> +	gpio_free(GPIO_SD_WP);
> +}
> +
> +static int s6_mmc_get_ro(struct device *spi)
> +{
> +	return gpio_get_value(GPIO_SD_WP);
> +}
> +
> +static struct mmc_spi_platform_data s6_spi_mmc_pdata =3D {
> +	.caps =3D 0,
> +	.ocr_mask =3D MMC_VDD_32_33,
> +	.init =3D s6_init_mmc_host,
> +	.exit =3D __devexit_p(s6_exit_mmc_host),
> +	.get_ro =3D s6_mmc_get_ro,
> +};
> +
>  static struct spi_board_info __initdata s6_spi_devices[] =3D {
> +	{
> +		.modalias =3D "mmc_spi",
> +		.platform_data =3D &s6_spi_mmc_pdata,
> +		.bus_num =3D S6_SPI_BUS_NUM,
> +		.chip_select =3D S6_SPI_CS_MMC_SLOT,
> +		.max_speed_hz =3D 50000000,
> +	},
>  };
> =20
>  static struct platform_device platform_devices[] =3D {
> --=20
> 1.6.2.107.ge47ee
>=20
>=20
