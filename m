From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] spi: davinci: Added support for chip select using gpio
Date: Wed, 30 Jun 2010 17:03:22 -0600
Message-ID: <AANLkTilnVxNfsfJ4nCWITM_DhOb6BDGZQC8cMiM0RkiF@mail.gmail.com>
References: <1277707655-3468-1-git-send-email-lamiaposta71@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: davinci-linux-open-source@linux.davincidsp.com,
	Raffaele Recalcati <raffaele.recalcati@bticino.it>,
	Davide Bonfanti <davide.bonfanti@bticino.it>,
	Russell King <linux@arm.linux.org.uk>,
	Sandeep Paulraj <s-paulraj@ti.com>,
	Cyril Chemparathy <cyril@ti.com>,
	Miguel Aguilar <miguel.aguilar@ridgerun.com>,
	Thomas Koeller <thomas.koeller@baslerweb.com>,
	David Brownell <dbrownell@users.sourceforge.net>,
	Philby John <pjohn@in.mvista.com>,
	Sudhakar Rajashekhara <sudhakar.raj@ti.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net
To: Raffaele Recalcati <lamiaposta71@gmail.com>,
	Brian Niebuhr <bniebuhr3@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1277707655-3468-1-git-send-email-lamiaposta71@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, Jun 28, 2010 at 12:47 AM, Raffaele Recalcati
<lamiaposta71@gmail.com> wrote:
> From: Raffaele Recalcati <raffaele.recalcati@bticino.it>
>
> =A0 =A0It is not everytime possible, due to hardware constraints,
> =A0 =A0to use the hw chip select available on spi port.
> =A0 =A0So I add this possibility using a gpio as chip select.
> =A0 =A0If controller_data variable is not null it is
> =A0 =A0the gpio to be used as chip select.
> =A0 =A0The default case is compatible with evmdm365.
> =A0 =A0This patch has been developed against the
> =A0 =A0http://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-d=
avinci.git
> =A0 =A0git tree and has been tested on bmx board (similar to dm365 ev=
m but with
> =A0 =A0gpio as spi chip select).
>
> Signed-off-by: Raffaele Recalcati <raffaele.recalcati@bticino.it>
> Signed-off-by: Davide Bonfanti <davide.bonfanti@bticino.it>

The davinci SPI driver is getting completely replaced (as soon as I
receive the respun patches), and I assume this patch will no longer
apply after the fact, so I'm not going to pick this patch up.  You
should coordinate with Brian Niebuhr to get this feature into his new
driver.

Cheers,
g.

> ---
> =A0arch/arm/mach-davinci/dm365.c | =A0 10 ++++++----
> =A0drivers/spi/davinci_spi.c =A0 =A0 | =A0 27 ++++++++++++++++++-----=
----
> =A02 files changed, 24 insertions(+), 13 deletions(-)
>
> diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm=
365.c
> index a146849..42fd4a4 100644
> --- a/arch/arm/mach-davinci/dm365.c
> +++ b/arch/arm/mach-davinci/dm365.c
> @@ -677,10 +677,12 @@ void __init dm365_init_spi0(unsigned chipselect=
_mask,
> =A0 =A0 =A0 =A0davinci_cfg_reg(DM365_SPI0_SDO);
>
> =A0 =A0 =A0 =A0/* not all slaves will be wired up */
> - =A0 =A0 =A0 if (chipselect_mask & BIT(0))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_cfg_reg(DM365_SPI0_SDENA0);
> - =A0 =A0 =A0 if (chipselect_mask & BIT(1))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_cfg_reg(DM365_SPI0_SDENA1);
> + =A0 =A0 =A0 if =A0(!((unsigned long) info->controller_data)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (chipselect_mask & BIT(0))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_cfg_reg(DM365_S=
PI0_SDENA0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (chipselect_mask & BIT(1))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_cfg_reg(DM365_S=
PI0_SDENA1);
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0spi_register_board_info(info, len);
>
> diff --git a/drivers/spi/davinci_spi.c b/drivers/spi/davinci_spi.c
> index 95afb6b..621ae46 100644
> --- a/drivers/spi/davinci_spi.c
> +++ b/drivers/spi/davinci_spi.c
> @@ -29,6 +29,7 @@
> =A0#include <linux/spi/spi_bitbang.h>
> =A0#include <linux/slab.h>
>
> +#include <mach/gpio.h>
> =A0#include <mach/spi.h>
> =A0#include <mach/edma.h>
>
> @@ -270,18 +271,26 @@ static void davinci_spi_chipselect(struct spi_d=
evice *spi, int value)
> =A0 =A0 =A0 =A0pdata =3D davinci_spi->pdata;
>
> =A0 =A0 =A0 =A0/*
> - =A0 =A0 =A0 =A0* Board specific chip select logic decides the polar=
ity and cs
> - =A0 =A0 =A0 =A0* line for the controller
> - =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 * Board specific chip select logic decides the polarity=
 and cs
> + =A0 =A0 =A0 * line for the controller
> + =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0if (value =3D=3D BITBANG_CS_INACTIVE) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_io_bits(davinci_spi->base + SPIDEF,=
 CS_DEFAULT);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 data1_reg_val |=3D CS_DEFAULT << SPIDAT=
1_CSNR_SHIFT;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 iowrite32(data1_reg_val, davinci_spi->b=
ase + SPIDAT1);
> -
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if =A0((unsigned long) spi->controller_=
data) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_set_value(spi->con=
troller_data, \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !(spi->=
mode & SPI_CS_HIGH));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_io_bits(davinci_spi=
->base + SPIDEF, CS_DEFAULT);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data1_reg_val |=3D CS_D=
EFAULT << SPIDAT1_CSNR_SHIFT;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 iowrite32(data1_reg_val=
, davinci_spi->base + SPIDAT1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0while ((ioread32(davinci_spi->base + S=
PIBUF)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 & SPIBUF_RXEMPTY_MASK) =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 & SPIBU=
=46_RXEMPTY_MASK) =3D=3D 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cpu_relax();
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if =A0((unsigned long) spi->controller_=
data)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_set_value(spi->con=
troller_data, \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (spi->m=
ode & SPI_CS_HIGH));
> =A0 =A0 =A0 =A0}
> =A0}
>
> --
> 1.7.0.4
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
