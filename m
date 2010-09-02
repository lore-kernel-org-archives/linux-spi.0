From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 5/6] mx51_3ds: add eCSPI2 support on the imx51_3ds board
Date: Thu, 2 Sep 2010 17:05:16 +0200
Message-ID: <20100902150516.GO14214@pengutronix.de>
References: <1283413924-14210-1-git-send-email-jason77.wang@gmail.com>
	<1283413924-14210-2-git-send-email-jason77.wang@gmail.com>
	<1283413924-14210-3-git-send-email-jason77.wang@gmail.com>
	<1283413924-14210-4-git-send-email-jason77.wang@gmail.com>
	<1283413924-14210-5-git-send-email-jason77.wang@gmail.com>
	<1283413924-14210-6-git-send-email-jason77.wang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: grant.likely@secretlab.ca, spi-devel-general@lists.sourceforge.net,
	s.hauer@pengutronix.de, amit.kucheria@canonical.com,
	linux-arm-kernel@lists.infradead.org
To: Jason Wang <jason77.wang@gmail.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1283413924-14210-6-git-send-email-jason77.wang@gmail.com>
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

Hi Jason,

On Thu, Sep 02, 2010 at 03:52:03PM +0800, Jason Wang wrote:
> Add platform data for eCSPI2 and register it through spi_imx dynamical
> register interface.
> =

> Signed-off-by: Jason Wang <jason77.wang@gmail.com>
> ---
>  arch/arm/mach-mx5/board-mx51_3ds.c |   20 ++++++++++++++++++++
>  1 files changed, 20 insertions(+), 0 deletions(-)
> =

> diff --git a/arch/arm/mach-mx5/board-mx51_3ds.c b/arch/arm/mach-mx5/board=
-mx51_3ds.c
> index f95c2fd..0cf4e14 100644
> --- a/arch/arm/mach-mx5/board-mx51_3ds.c
> +++ b/arch/arm/mach-mx5/board-mx51_3ds.c
> @@ -24,9 +24,11 @@
>  #include <mach/imx-uart.h>
>  #include <mach/3ds_debugboard.h>
>  =

> +#include "devices-imx51.h"
>  #include "devices.h"
>  =

>  #define EXPIO_PARENT_INT	(MXC_INTERNAL_IRQS + GPIO_PORTA + 6)
> +#define MX51_3DS_ECSPI2_CS	(GPIO_PORTC + 28)
>  =

>  static struct pad_desc mx51_3ds_pads[] =3D {
>  	/* UART1 */
> @@ -61,6 +63,12 @@ static struct pad_desc mx51_3ds_pads[] =3D {
>  	MX51_PAD_KEY_COL3__KEY_COL3,
>  	MX51_PAD_KEY_COL4__KEY_COL4,
>  	MX51_PAD_KEY_COL5__KEY_COL5,
> +
> +	/* eCSPI2 */
> +	MX51_PAD_NANDF_RB2__ECSPI2_SCLK,
> +	MX51_PAD_NANDF_RB3__ECSPI2_MISO,
> +	MX51_PAD_NANDF_D15__ECSPI2_MOSI,
> +	MX51_PAD_NANDF_D12__GPIO_3_28,
>  };
>  =

>  /* Serial ports */
> @@ -127,6 +135,16 @@ static inline void mxc_init_keypad(void)
>  }
>  #endif
>  =

> +static int mx51_3ds_spi2_cs[] =3D {
> +	MXC_SPI_CS(0),
> +	MX51_3DS_ECSPI2_CS,
> +};
> +
> +static struct spi_imx_master mx51_3ds_spi2_pdata =3D {
> +	.chipselect	=3D mx51_3ds_spi2_cs,
> +	.num_chipselect	=3D ARRAY_SIZE(mx51_3ds_spi2_cs),
> +};
maybe better call it mx51_3ds_ecspi2_pdata?  This should be const
__initconst.

>  /*
>   * Board specific initialization.
>   */
> @@ -136,6 +154,8 @@ static void __init mxc_board_init(void)
>  					ARRAY_SIZE(mx51_3ds_pads));
>  	mxc_init_imx_uart();
>  =

> +	imx51_add_spi_imx1(&mx51_3ds_spi2_pdata);
> +
>  	if (mxc_expio_init(MX51_CS5_BASE_ADDR, EXPIO_PARENT_INT))
>  		printk(KERN_WARNING "Init of the debugboard failed, all "
>  				    "devices on the board are unusable.\n");
> -- =

> 1.5.6.5
> =

> =


-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
