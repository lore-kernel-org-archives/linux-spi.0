From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH v2 1/1] davinci: spi: replace
	existing driver
Date: Sat, 3 Jul 2010 23:47:22 -0600
Message-ID: <AANLkTikdEjvYRTXw9654APLZWqqXhC0cHqvRTCH0nv7A@mail.gmail.com>
References: <1278110334-13943-1-git-send-email-bniebuhr@efjohnson.com>
	<1278110334-13943-2-git-send-email-bniebuhr@efjohnson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Brian Niebuhr <bniebuhr3-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1278110334-13943-2-git-send-email-bniebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, Jul 2, 2010 at 4:38 PM, Brian Niebuhr <bniebuhr3-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> INTRODUCTION
>
> I have been working on a custom OMAP-L138 board that has multiple spi
> devices (seven) on one controller. =A0These devices have a wide range of
> transfer parameters (speed, phase, polarity, internal and gpio chip
> selects). =A0During my testing I found multiple errors in the davinci spi
> driver as a result of this complex setup. =A0The primary issues were:
>
> 1. There is a race condition due to the SPIBUF read busy-waits for slow
> =A0 =A0 =A0 =A0devices
> 2. I found some DMA transfer length errors under some conditions
> 3. The chip select code caused extra byte transfers (with no chip
> =A0 =A0 =A0 =A0select active) due to writes to SPIDAT1
> 4. Several issues prevented using multiple SPI devices, especially
> =A0 =A0 =A0 =A0the DMA code, as disucussed previously on the davinci list.
>
> The fixes to these problems were not simple. =A0I ended up making fairly
> large changes to the driver, and those changes are contained in these
> patches. =A0The full list of changes follows.
[...]
> Signed-off-by: Brian Niebuhr <bniebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>

Hi Brian,

Thanks for the quick respin.

Some more comments below...


> ---
> =A0arch/arm/mach-davinci/board-dm355-evm.c =A0 =A0 | =A0 10 +
> =A0arch/arm/mach-davinci/board-dm355-leopard.c | =A0 10 +
> =A0arch/arm/mach-davinci/board-dm365-evm.c =A0 =A0 | =A0 10 +
> =A0arch/arm/mach-davinci/dm355.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 12 +-
> =A0arch/arm/mach-davinci/dm365.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 12 +-
> =A0arch/arm/mach-davinci/include/mach/spi.h =A0 =A0| =A0 37 +-
> =A0drivers/spi/davinci_spi.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | 1328 +=
+++++++++++---------------
> =A07 files changed, 648 insertions(+), 771 deletions(-)
>
> diff --git a/arch/arm/mach-davinci/board-dm355-evm.c b/arch/arm/mach-davi=
nci/board-dm355-evm.c
> index a319101..d2e9f20 100644
> --- a/arch/arm/mach-davinci/board-dm355-evm.c
> +++ b/arch/arm/mach-davinci/board-dm355-evm.c
> @@ -32,6 +32,7 @@
> =A0#include <mach/nand.h>
> =A0#include <mach/mmc.h>
> =A0#include <mach/usb.h>
> +#include <mach/spi.h>
>
> =A0/* NOTE: =A0this is geared for the standard config, with a socketed
> =A0* 2 GByte Micron NAND (MT29F16G08FAA) using 128KB sectors. =A0If you
> @@ -300,10 +301,19 @@ static struct spi_eeprom at25640a =3D {
> =A0 =A0 =A0 =A0.flags =A0 =A0 =A0 =A0 =A0=3D EE_ADDR2,
> =A0};
>
> +static struct davinci_spi_config at25640a_spi_cfg =3D {
> + =A0 =A0 =A0 .parity_enable =A0=3D false,
> + =A0 =A0 =A0 .intr_level =A0 =A0 =3D 0,
> + =A0 =A0 =A0 .io_type =A0 =A0 =A0 =A0=3D SPI_IO_TYPE_DMA,
> + =A0 =A0 =A0 .wdelay =A0 =A0 =A0 =A0 =3D 0,
> + =A0 =A0 =A0 .timer_disable =A0=3D true,
> +};
> +
> =A0static struct spi_board_info dm355_evm_spi_info[] __initconst =3D {
> =A0 =A0 =A0 =A0{
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.modalias =A0 =A0 =A0 =3D "at25",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.platform_data =A0=3D &at25640a,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .controller_data =3D &at25640a_spi_cfg,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.max_speed_hz =A0 =3D 10 * 1000 * 1000, =
=A0 =A0 /* at 3v3 */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.bus_num =A0 =A0 =A0 =A0=3D 0,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.chip_select =A0 =A0=3D 0,
> diff --git a/arch/arm/mach-davinci/board-dm355-leopard.c b/arch/arm/mach-=
davinci/board-dm355-leopard.c
> index f1d8132..63078dc 100644
> --- a/arch/arm/mach-davinci/board-dm355-leopard.c
> +++ b/arch/arm/mach-davinci/board-dm355-leopard.c
> @@ -29,6 +29,7 @@
> =A0#include <mach/nand.h>
> =A0#include <mach/mmc.h>
> =A0#include <mach/usb.h>
> +#include <mach/spi.h>
>
> =A0/* NOTE: =A0this is geared for the standard config, with a socketed
> =A0* 2 GByte Micron NAND (MT29F16G08FAA) using 128KB sectors. =A0If you
> @@ -222,10 +223,19 @@ static struct spi_eeprom at25640a =3D {
> =A0 =A0 =A0 =A0.flags =A0 =A0 =A0 =A0 =A0=3D EE_ADDR2,
> =A0};
>
> +static struct davinci_spi_config at25640a_spi_cfg =3D {
> + =A0 =A0 =A0 =A0.parity_enable =A0=3D false,
> + =A0 =A0 =A0 =A0.intr_level =A0 =A0 =3D 0,
> + =A0 =A0 =A0 =A0.io_type =A0 =A0 =A0 =A0=3D SPI_IO_TYPE_DMA,
> + =A0 =A0 =A0 =A0.wdelay =A0 =A0 =A0 =A0 =3D 0,
> + =A0 =A0 =A0 =A0.timer_disable =A0=3D true,
> +};
> +
> =A0static struct spi_board_info dm355_leopard_spi_info[] __initconst =3D {
> =A0 =A0 =A0 =A0{
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.modalias =A0 =A0 =A0 =3D "at25",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.platform_data =A0=3D &at25640a,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .controller_data =3D &at25640a_spi_cfg,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.max_speed_hz =A0 =3D 10 * 1000 * 1000, =
=A0 =A0 /* at 3v3 */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.bus_num =A0 =A0 =A0 =A0=3D 0,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.chip_select =A0 =A0=3D 0,
> diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-davi=
nci/board-dm365-evm.c
> index 5bb86b2..5bc3622 100644
> --- a/arch/arm/mach-davinci/board-dm365-evm.c
> +++ b/arch/arm/mach-davinci/board-dm365-evm.c
> @@ -39,6 +39,7 @@
> =A0#include <mach/mmc.h>
> =A0#include <mach/nand.h>
> =A0#include <mach/keyscan.h>
> +#include <mach/spi.h>
>
> =A0#include <media/tvp514x.h>
>
> @@ -579,10 +580,19 @@ static struct spi_eeprom at25640 =3D {
> =A0 =A0 =A0 =A0.flags =A0 =A0 =A0 =A0 =A0=3D EE_ADDR2,
> =A0};
>
> +static struct davinci_spi_config at25640_spi_cfg =3D {
> + =A0 =A0 =A0 =A0.parity_enable =A0=3D false,
> + =A0 =A0 =A0 =A0.intr_level =A0 =A0 =3D 0,
> + =A0 =A0 =A0 =A0.io_type =A0 =A0 =A0 =A0=3D SPI_IO_TYPE_DMA,
> + =A0 =A0 =A0 =A0.wdelay =A0 =A0 =A0 =A0 =3D 0,
> + =A0 =A0 =A0 =A0.timer_disable =A0=3D true,
> +};
> +
> =A0static struct spi_board_info dm365_evm_spi_info[] __initconst =3D {
> =A0 =A0 =A0 =A0{
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.modalias =A0 =A0 =A0 =3D "at25",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.platform_data =A0=3D &at25640,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .controller_data =3D &at25640_spi_cfg,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.max_speed_hz =A0 =3D 10 * 1000 * 1000,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.bus_num =A0 =A0 =A0 =A0=3D 0,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.chip_select =A0 =A0=3D 0,
> diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
> index 3834781..378d41c 100644
> --- a/arch/arm/mach-davinci/dm355.c
> +++ b/arch/arm/mach-davinci/dm355.c
> @@ -397,27 +397,21 @@ static struct resource dm355_spi0_resources[] =3D {
> =A0 =A0 =A0 =A0},
> =A0 =A0 =A0 =A0{
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.start =3D 17,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =3D IORESOURCE_DMA,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =3D IORESOURCE_DMA | IORESOURCE_DMA_=
RX_CHAN,
> =A0 =A0 =A0 =A0},
> =A0 =A0 =A0 =A0{
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.start =3D 16,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =3D IORESOURCE_DMA,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =3D IORESOURCE_DMA | IORESOURCE_DMA_=
TX_CHAN,
> =A0 =A0 =A0 =A0},
> =A0 =A0 =A0 =A0{
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.start =3D EVENTQ_1,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =3D IORESOURCE_DMA,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =3D IORESOURCE_DMA | IORESOURCE_DMA_=
EVENT_Q,
> =A0 =A0 =A0 =A0},
> =A0};
>
> =A0static struct davinci_spi_platform_data dm355_spi0_pdata =3D {
> =A0 =A0 =A0 =A0.version =A0 =A0 =A0 =A0=3D SPI_VERSION_1,
> =A0 =A0 =A0 =A0.num_chipselect =3D 2,
> - =A0 =A0 =A0 .clk_internal =A0 =3D 1,
> - =A0 =A0 =A0 .cs_hold =A0 =A0 =A0 =A0=3D 1,
> - =A0 =A0 =A0 .intr_level =A0 =A0 =3D 0,
> - =A0 =A0 =A0 .poll_mode =A0 =A0 =A0=3D 1, =A0 =A0/* 0 -> interrupt mode =
1-> polling mode */
> - =A0 =A0 =A0 .c2tdelay =A0 =A0 =A0 =3D 0,
> - =A0 =A0 =A0 .t2cdelay =A0 =A0 =A0 =3D 0,
> =A0};
> =A0static struct platform_device dm355_spi0_device =3D {
> =A0 =A0 =A0 =A0.name =3D "spi_davinci",
> diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
> index 652f4b6..8e68f8c 100644
> --- a/arch/arm/mach-davinci/dm365.c
> +++ b/arch/arm/mach-davinci/dm365.c
> @@ -625,12 +625,6 @@ static u64 dm365_spi0_dma_mask =3D DMA_BIT_MASK(32);
> =A0static struct davinci_spi_platform_data dm365_spi0_pdata =3D {
> =A0 =A0 =A0 =A0.version =A0 =A0 =A0 =A0=3D SPI_VERSION_1,
> =A0 =A0 =A0 =A0.num_chipselect =3D 2,
> - =A0 =A0 =A0 .clk_internal =A0 =3D 1,
> - =A0 =A0 =A0 .cs_hold =A0 =A0 =A0 =A0=3D 1,
> - =A0 =A0 =A0 .intr_level =A0 =A0 =3D 0,
> - =A0 =A0 =A0 .poll_mode =A0 =A0 =A0=3D 1, =A0 =A0/* 0 -> interrupt mode =
1-> polling mode */
> - =A0 =A0 =A0 .c2tdelay =A0 =A0 =A0 =3D 0,
> - =A0 =A0 =A0 .t2cdelay =A0 =A0 =A0 =3D 0,
> =A0};
>
> =A0static struct resource dm365_spi0_resources[] =3D {
> @@ -645,15 +639,15 @@ static struct resource dm365_spi0_resources[] =3D {
> =A0 =A0 =A0 =A0},
> =A0 =A0 =A0 =A0{
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.start =3D 17,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =3D IORESOURCE_DMA,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =3D IORESOURCE_DMA | IORESOURCE_DMA_=
RX_CHAN,
> =A0 =A0 =A0 =A0},
> =A0 =A0 =A0 =A0{
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.start =3D 16,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =3D IORESOURCE_DMA,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =3D IORESOURCE_DMA | IORESOURCE_DMA_=
TX_CHAN,
> =A0 =A0 =A0 =A0},
> =A0 =A0 =A0 =A0{
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.start =3D EVENTQ_3,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =3D IORESOURCE_DMA,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =3D IORESOURCE_DMA | IORESOURCE_DMA_=
EVENT_Q,
> =A0 =A0 =A0 =A0},
> =A0};
>
> diff --git a/arch/arm/mach-davinci/include/mach/spi.h b/arch/arm/mach-dav=
inci/include/mach/spi.h
> index 910efbf..b69a2f5 100644
> --- a/arch/arm/mach-davinci/include/mach/spi.h
> +++ b/arch/arm/mach-davinci/include/mach/spi.h
> @@ -19,6 +19,13 @@
> =A0#ifndef __ARCH_ARM_DAVINCI_SPI_H
> =A0#define __ARCH_ARM_DAVINCI_SPI_H
>
> +#define SPI_INTERN_CS =A00xFF
> +
> +/* resource flags for IORESOURCE_DMA resources */
> +#define IORESOURCE_DMA_RX_CHAN =A0 =A0 =A0 =A0 0x01
> +#define IORESOURCE_DMA_TX_CHAN =A0 =A0 =A0 =A0 0x02
> +#define IORESOURCE_DMA_EVENT_Q =A0 =A0 =A0 =A0 0x04
> +

Not a good idea.  IORESOURCE_* definitions are defined in ioport.h and
the lower 8 bits are tagged for bus-specific use (not
device-specific).  Overloading them with arch-specific meanings is
just asking for breakage.

If index is unreliable, you can differentiate the resources by .name.

> =A0enum {
> =A0 =A0 =A0 =A0SPI_VERSION_1, /* For DM355/DM365/DM6467 */
> =A0 =A0 =A0 =A0SPI_VERSION_2, /* For DA8xx */
> @@ -26,19 +33,25 @@ enum {
>
> =A0struct davinci_spi_platform_data {
> =A0 =A0 =A0 =A0u8 =A0 =A0 =A0version;
> - =A0 =A0 =A0 u8 =A0 =A0 =A0num_chipselect;
> - =A0 =A0 =A0 u8 =A0 =A0 =A0wdelay;
> - =A0 =A0 =A0 u8 =A0 =A0 =A0odd_parity;
> - =A0 =A0 =A0 u8 =A0 =A0 =A0parity_enable;
> - =A0 =A0 =A0 u8 =A0 =A0 =A0wait_enable;
> - =A0 =A0 =A0 u8 =A0 =A0 =A0timer_disable;
> - =A0 =A0 =A0 u8 =A0 =A0 =A0clk_internal;
> - =A0 =A0 =A0 u8 =A0 =A0 =A0cs_hold;
> + =A0 =A0 =A0 u16 =A0 =A0 num_chipselect;
> + =A0 =A0 =A0 u8 =A0 =A0 =A0*chip_sel;
> +};
> +
> +struct davinci_spi_config {
> + =A0 =A0 =A0 bool =A0 =A0odd_parity;
> + =A0 =A0 =A0 bool =A0 =A0parity_enable;
> =A0 =A0 =A0 =A0u8 =A0 =A0 =A0intr_level;
> - =A0 =A0 =A0 u8 =A0 =A0 =A0poll_mode;
> - =A0 =A0 =A0 u8 =A0 =A0 =A0use_dma;
> - =A0 =A0 =A0 u8 =A0 =A0 =A0c2tdelay;
> - =A0 =A0 =A0 u8 =A0 =A0 =A0t2cdelay;
> + =A0 =A0 =A0 u8 =A0 =A0 =A0io_type;
> +#define SPI_IO_TYPE_INTR =A0 =A00
> +#define SPI_IO_TYPE_POLL =A0 =A01
> +#define SPI_IO_TYPE_DMA =A0 =A0 2
> + =A0 =A0 =A0 u8 =A0 =A0 =A0bytes_per_word;
> + =A0 =A0 =A0 u8 =A0 =A0 =A0wdelay;
> + =A0 =A0 =A0 bool =A0 =A0timer_disable;
> + =A0 =A0 =A0 u8 =A0 =A0 =A0c2t_delay;
> + =A0 =A0 =A0 u8 =A0 =A0 =A0t2c_delay;
> + =A0 =A0 =A0 u8 =A0 =A0 =A0t2e_delay;
> + =A0 =A0 =A0 u8 =A0 =A0 =A0c2e_delay;
> =A0};
>
> =A0#endif /* __ARCH_ARM_DAVINCI_SPI_H */
> diff --git a/drivers/spi/davinci_spi.c b/drivers/spi/davinci_spi.c
> index b85090c..10d5c34 100644
> --- a/drivers/spi/davinci_spi.c
> +++ b/drivers/spi/davinci_spi.c
> @@ -1,5 +1,6 @@
> =A0/*
> =A0* Copyright (C) 2009 Texas Instruments.
> + * Copyright (C) 2010 EF Johnson Technologies
> =A0*
> =A0* This program is free software; you can redistribute it and/or modify
> =A0* it under the terms of the GNU General Public License as published by
> @@ -27,197 +28,218 @@
> =A0#include <linux/dma-mapping.h>
> =A0#include <linux/spi/spi.h>
> =A0#include <linux/spi/spi_bitbang.h>
> -#include <linux/slab.h>
>
> =A0#include <mach/spi.h>
> =A0#include <mach/edma.h>
>
> -#define SPI_NO_RESOURCE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0((resource_size_t=
)-1)
> -
> -#define SPI_MAX_CHIPSELECT =A0 =A0 2
> -
> -#define CS_DEFAULT =A0 =A0 0xFF
> -
> -#define SPI_BUFSIZ =A0 =A0 (SMP_CACHE_BYTES + 1)
> -#define DAVINCI_DMA_DATA_TYPE_S8 =A0 =A0 =A0 0x01
> -#define DAVINCI_DMA_DATA_TYPE_S16 =A0 =A0 =A00x02
> -#define DAVINCI_DMA_DATA_TYPE_S32 =A0 =A0 =A00x04
> -
> -#define SPIFMT_PHASE_MASK =A0 =A0 =A0BIT(16)
> -#define SPIFMT_POLARITY_MASK =A0 BIT(17)
> -#define SPIFMT_DISTIMER_MASK =A0 BIT(18)
> -#define SPIFMT_SHIFTDIR_MASK =A0 BIT(20)
> -#define SPIFMT_WAITENA_MASK =A0 =A0BIT(21)
> -#define SPIFMT_PARITYENA_MASK =A0BIT(22)
> -#define SPIFMT_ODD_PARITY_MASK BIT(23)
> -#define SPIFMT_WDELAY_MASK =A0 =A0 0x3f000000u
> -#define SPIFMT_WDELAY_SHIFT =A0 =A024
> -#define SPIFMT_CHARLEN_MASK =A0 =A00x0000001Fu
> +#define CS_DEFAULT =A0 =A0 =A00xFF
> +#define SCS0_SELECT =A0 =A0 0x01
> +#define SCS1_SELECT =A0 =A0 0x02
> +#define SCS2_SELECT =A0 =A0 0x04
> +#define SCS3_SELECT =A0 =A0 0x08
> +#define SCS4_SELECT =A0 =A0 0x10
> +#define SCS5_SELECT =A0 =A0 0x20
> +#define SCS6_SELECT =A0 =A0 0x40
> +#define SCS7_SELECT =A0 =A0 0x80
> +
> +#define SPIFMT_PHASE_MASK =A0 =A0 =A0 BIT(16)
> +#define SPIFMT_POLARITY_MASK =A0 =A0BIT(17)
> +#define SPIFMT_DISTIMER_MASK =A0 =A0BIT(18)
> +#define SPIFMT_SHIFTDIR_MASK =A0 =A0BIT(20)
> +#define SPIFMT_WAITENA_MASK =A0 =A0 BIT(21)
> +#define SPIFMT_PARITYENA_MASK =A0 BIT(22)
> +#define SPIFMT_ODD_PARITY_MASK =A0BIT(23)
> +#define SPIFMT_WDELAY_MASK =A0 =A0 =A00x3f000000u
> +#define SPIFMT_WDELAY_SHIFT =A0 =A0 24
> +#define SPIFMT_CHARLEN_MASK =A0 =A0 0x0000001Fu
> +#define SPIFMT_PRESCALE_SHIFT =A0 8
>
> =A0/* SPIGCR1 */
> -#define SPIGCR1_SPIENA_MASK =A0 =A00x01000000u
> +#define SPIGCR1_SPIENA_MASK =A0 =A0 BIT(24)
> +#define SPIGCR1_POWERDOWN_MASK =A0BIT(8)
>
> =A0/* SPIPC0 */
> -#define SPIPC0_DIFUN_MASK =A0 =A0 =A0BIT(11) =A0 =A0 =A0 =A0 /* MISO */
> -#define SPIPC0_DOFUN_MASK =A0 =A0 =A0BIT(10) =A0 =A0 =A0 =A0 /* MOSI */
> -#define SPIPC0_CLKFUN_MASK =A0 =A0 BIT(9) =A0 =A0 =A0 =A0 =A0/* CLK */
> -#define SPIPC0_SPIENA_MASK =A0 =A0 BIT(8) =A0 =A0 =A0 =A0 =A0/* nREADY */
> -#define SPIPC0_EN1FUN_MASK =A0 =A0 BIT(1)
> -#define SPIPC0_EN0FUN_MASK =A0 =A0 BIT(0)
> -
> -#define SPIINT_MASKALL =A0 =A0 =A0 =A0 0x0101035F
> -#define SPI_INTLVL_1 =A0 =A0 =A0 =A0 =A0 0x000001FFu
> -#define SPI_INTLVL_0 =A0 =A0 =A0 =A0 =A0 0x00000000u
> +#define SPIPC0_DIFUN_MASK =A0 =A0 =A0 BIT(11) =A0 =A0 =A0 =A0 /* MISO */
> +#define SPIPC0_DOFUN_MASK =A0 =A0 =A0 BIT(10) =A0 =A0 =A0 =A0 /* MOSI */
> +#define SPIPC0_CLKFUN_MASK =A0 =A0 =A0BIT(9) =A0 =A0 =A0 =A0 =A0/* CLK */
> +#define SPIPC0_SPIENA_MASK =A0 =A0 =A0BIT(8) =A0 =A0 =A0 =A0 =A0/* nREAD=
Y */
> +#define SPIPC0_EN1FUN_MASK =A0 =A0 =A0BIT(1)
> +#define SPIPC0_EN0FUN_MASK =A0 =A0 =A0BIT(0)
> +
> +#define SPIINT_MASKALL =A0 =A0 =A0 =A0 =A00x0101035Fu
> +#define SPIINT_MASKINT =A0 =A0 =A0 =A0 =A00x0000035Fu
> +#define SPI_INTLVL_1 =A0 =A0 =A0 =A0 =A0 =A00x000001FFu
> +#define SPI_INTLVL_0 =A0 =A0 =A0 =A0 =A0 =A00x00000000u
>
> =A0/* SPIDAT1 */
> +#define SPIDAT1_CSHOLD_MASK =A0 =A0BIT(28)
> =A0#define SPIDAT1_CSHOLD_SHIFT =A0 28
> +#define SPIDAT1_WDEL_MASK =A0 =A0 =A0BIT(26)
> +#define SPIDAT1_CSNR_MASK =A0 =A0 =A00x00FF0000u
> =A0#define SPIDAT1_CSNR_SHIFT =A0 =A0 16
> +#define SPIDAT1_DFSEL_MASK =A0 =A0 (BIT(24 | BIT(25))
> =A0#define SPIGCR1_CLKMOD_MASK =A0 =A0BIT(1)
> -#define SPIGCR1_MASTER_MASK =A0 =A0 BIT(0)
> +#define SPIGCR1_MASTER_MASK =A0 =A0BIT(0)
> =A0#define SPIGCR1_LOOPBACK_MASK =A0BIT(16)
>
> =A0/* SPIBUF */
> -#define SPIBUF_TXFULL_MASK =A0 =A0 BIT(29)
> -#define SPIBUF_RXEMPTY_MASK =A0 =A0BIT(31)
> +#define SPIBUF_TXFULL_MASK =A0 =A0 =A0BIT(29)
> +#define SPIBUF_RXEMPTY_MASK =A0 =A0 BIT(31)
> +
> +/* SPIDELAY */
> +#define SPIDELAY_C2TDELAY_MASK =A00xFF000000u
> +#define SPIDELAY_C2TDELAY_SHIFT 24
> +#define SPIDELAY_T2CDELAY_MASK =A00x00FF0000u
> +#define SPIDELAY_T2CDELAY_SHIFT 16
> +#define SPIDELAY_T2EDELAY_MASK =A00x0000FF00u
> +#define SPIDELAY_T2EDELAY_SHIFT 8
> +#define SPIDELAY_C2EDELAY_MASK =A00x000000FFu
> +#define SPIDELAY_C2EDELAY_SHIFT 0
> +
> +/* SPIDEF */
> +#define SPIDEF_CSDEF_MASK =A0 =A0 =A0 0x000000FFu
>
> =A0/* Error Masks */
> -#define SPIFLG_DLEN_ERR_MASK =A0 =A0 =A0 =A0 =A0 BIT(0)
> -#define SPIFLG_TIMEOUT_MASK =A0 =A0 =A0 =A0 =A0 =A0BIT(1)
> -#define SPIFLG_PARERR_MASK =A0 =A0 =A0 =A0 =A0 =A0 BIT(2)
> -#define SPIFLG_DESYNC_MASK =A0 =A0 =A0 =A0 =A0 =A0 BIT(3)
> -#define SPIFLG_BITERR_MASK =A0 =A0 =A0 =A0 =A0 =A0 BIT(4)
> -#define SPIFLG_OVRRUN_MASK =A0 =A0 =A0 =A0 =A0 =A0 BIT(6)
> -#define SPIFLG_RX_INTR_MASK =A0 =A0 =A0 =A0 =A0 =A0BIT(8)
> -#define SPIFLG_TX_INTR_MASK =A0 =A0 =A0 =A0 =A0 =A0BIT(9)
> -#define SPIFLG_BUF_INIT_ACTIVE_MASK =A0 =A0BIT(24)
> -#define SPIFLG_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(SPIFLG_DLEN_=
ERR_MASK \
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | SPIFLG_TI=
MEOUT_MASK | SPIFLG_PARERR_MASK \
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | SPIFLG_DE=
SYNC_MASK | SPIFLG_BITERR_MASK \
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | SPIFLG_OV=
RRUN_MASK | SPIFLG_RX_INTR_MASK \
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | SPIFLG_TX=
_INTR_MASK \
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | SPIFLG_BU=
F_INIT_ACTIVE_MASK)
> -
> -#define SPIINT_DLEN_ERR_INTR =A0 BIT(0)
> -#define SPIINT_TIMEOUT_INTR =A0 =A0BIT(1)
> -#define SPIINT_PARERR_INTR =A0 =A0 BIT(2)
> -#define SPIINT_DESYNC_INTR =A0 =A0 BIT(3)
> -#define SPIINT_BITERR_INTR =A0 =A0 BIT(4)
> -#define SPIINT_OVRRUN_INTR =A0 =A0 BIT(6)
> -#define SPIINT_RX_INTR =A0 =A0 =A0 =A0 BIT(8)
> -#define SPIINT_TX_INTR =A0 =A0 =A0 =A0 BIT(9)
> -#define SPIINT_DMA_REQ_EN =A0 =A0 =A0BIT(16)
> -#define SPIINT_ENABLE_HIGHZ =A0 =A0BIT(24)
> -
> -#define SPI_T2CDELAY_SHIFT =A0 =A0 16
> -#define SPI_C2TDELAY_SHIFT =A0 =A0 24
> -
> +#define SPIFLG_DLEN_ERR_MASK =A0 =A0 =A0 =A0 =A0 =A0BIT(0)
> +#define SPIFLG_TIMEOUT_MASK =A0 =A0 =A0 =A0 =A0 =A0 BIT(1)
> +#define SPIFLG_PARERR_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0BIT(2)
> +#define SPIFLG_DESYNC_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0BIT(3)
> +#define SPIFLG_BITERR_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0BIT(4)
> +#define SPIFLG_OVRRUN_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0BIT(6)
> +#define SPIFLG_RX_INTR_MASK =A0 =A0 =A0 =A0 =A0 =A0 BIT(8)
> +#define SPIFLG_TX_INTR_MASK =A0 =A0 =A0 =A0 =A0 =A0 BIT(9)
> +#define SPIFLG_BUF_INIT_ACTIVE_MASK =A0 =A0 BIT(24)
> +#define SPIFLG_ERROR_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 (SPIFLG_DLEN_ERR_M=
ASK \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| SPIFLG=
_TIMEOUT_MASK | SPIFLG_PARERR_MASK \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| SPIFLG=
_DESYNC_MASK | SPIFLG_BITERR_MASK \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| SPIFLG=
_OVRRUN_MASK)
> +#define SPIFLG_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (SPIFLG_ERRO=
R_MASK \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| SPIFLG=
_RX_INTR_MASK | SPIFLG_TX_INTR_MASK \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| SPIFLG=
_BUF_INIT_ACTIVE_MASK)
> +
> +#define SPIINT_DLEN_ERR_INTR =A0 =A0BIT(0)
> +#define SPIINT_TIMEOUT_INTR =A0 =A0 BIT(1)
> +#define SPIINT_PARERR_INTR =A0 =A0 =A0BIT(2)
> +#define SPIINT_DESYNC_INTR =A0 =A0 =A0BIT(3)
> +#define SPIINT_BITERR_INTR =A0 =A0 =A0BIT(4)
> +#define SPIINT_OVRRUN_INTR =A0 =A0 =A0BIT(6)
> +#define SPIINT_RX_INTR =A0 =A0 =A0 =A0 =A0BIT(8)
> +#define SPIINT_TX_INTR =A0 =A0 =A0 =A0 =A0BIT(9)
> +#define SPIINT_DMA_REQ_EN =A0 =A0 =A0 BIT(16)
> +#define SPIINT_ENABLE_HIGHZ =A0 =A0 BIT(24)
> +
> +#define SPI_T2CDELAY_SHIFT =A0 =A0 =A016
> +#define SPI_C2TDELAY_SHIFT =A0 =A0 =A024
> =A0/* SPI Controller registers */
> -#define SPIGCR0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x00
> -#define SPIGCR1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x04
> -#define SPIINT =A0 =A0 =A0 =A0 0x08
> -#define SPILVL =A0 =A0 =A0 =A0 0x0c
> -#define SPIFLG =A0 =A0 =A0 =A0 0x10
> -#define SPIPC0 =A0 =A0 =A0 =A0 0x14
> -#define SPIPC1 =A0 =A0 =A0 =A0 0x18
> -#define SPIPC2 =A0 =A0 =A0 =A0 0x1c
> -#define SPIPC3 =A0 =A0 =A0 =A0 0x20
> -#define SPIPC4 =A0 =A0 =A0 =A0 0x24
> -#define SPIPC5 =A0 =A0 =A0 =A0 0x28
> -#define SPIPC6 =A0 =A0 =A0 =A0 0x2c
> -#define SPIPC7 =A0 =A0 =A0 =A0 0x30
> -#define SPIPC8 =A0 =A0 =A0 =A0 0x34
> -#define SPIDAT0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x38
> -#define SPIDAT1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x3c
> -#define SPIBUF =A0 =A0 =A0 =A0 0x40
> -#define SPIEMU =A0 =A0 =A0 =A0 0x44
> -#define SPIDELAY =A0 =A0 =A0 0x48
> -#define SPIDEF =A0 =A0 =A0 =A0 0x4c
> -#define SPIFMT0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x50
> -#define SPIFMT1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x54
> -#define SPIFMT2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x58
> -#define SPIFMT3 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x5c
> -#define TGINTVEC0 =A0 =A0 =A00x60
> -#define TGINTVEC1 =A0 =A0 =A00x64
> -
> -struct davinci_spi_slave {
> - =A0 =A0 =A0 u32 =A0 =A0 cmd_to_write;
> - =A0 =A0 =A0 u32 =A0 =A0 clk_ctrl_to_write;
> - =A0 =A0 =A0 u32 =A0 =A0 bytes_per_word;
> - =A0 =A0 =A0 u8 =A0 =A0 =A0active_cs;
> +#define SPIGCR0 =A0 =A0 =A0 =A0 0x00
> +#define SPIGCR1 =A0 =A0 =A0 =A0 0x04
> +#define SPIINT =A0 =A0 =A0 =A0 =A00x08
> +#define SPILVL =A0 =A0 =A0 =A0 =A00x0c
> +#define SPIFLG =A0 =A0 =A0 =A0 =A00x10
> +#define SPIPC0 =A0 =A0 =A0 =A0 =A00x14
> +#define SPIPC1 =A0 =A0 =A0 =A0 =A00x18
> +#define SPIPC2 =A0 =A0 =A0 =A0 =A00x1c
> +#define SPIPC3 =A0 =A0 =A0 =A0 =A00x20
> +#define SPIPC4 =A0 =A0 =A0 =A0 =A00x24
> +#define SPIPC5 =A0 =A0 =A0 =A0 =A00x28
> +#define SPIPC6 =A0 =A0 =A0 =A0 =A00x2c
> +#define SPIPC7 =A0 =A0 =A0 =A0 =A00x30
> +#define SPIPC8 =A0 =A0 =A0 =A0 =A00x34
> +#define SPIDAT0 =A0 =A0 =A0 =A0 0x38
> +#define SPIDAT1 =A0 =A0 =A0 =A0 0x3c
> +#define SPIBUF =A0 =A0 =A0 =A0 =A00x40
> +#define SPIEMU =A0 =A0 =A0 =A0 =A00x44
> +#define SPIDELAY =A0 =A0 =A0 =A00x48
> +#define SPIDEF =A0 =A0 =A0 =A0 =A00x4c
> +#define SPIFMT0 =A0 =A0 =A0 =A0 0x50
> +#define SPIFMT1 =A0 =A0 =A0 =A0 0x54
> +#define SPIFMT2 =A0 =A0 =A0 =A0 0x58
> +#define SPIFMT3 =A0 =A0 =A0 =A0 0x5c
> +#define TGINTVEC0 =A0 =A0 =A0 0x60
> +#define TGINTVEC1 =A0 =A0 =A0 0x64
> +
> +#define SPI_BUFSIZ =A0 =A0 =A0(SMP_CACHE_BYTES + 1)
> +
> +const char * const io_type_names[] =3D {
> + =A0 =A0 =A0 [SPI_IO_TYPE_INTR] =3D "Interrupt",
> + =A0 =A0 =A0 [SPI_IO_TYPE_POLL] =3D "Polled",
> + =A0 =A0 =A0 [SPI_IO_TYPE_DMA] =3D "DMA",
> =A0};
>
> =A0/* We have 2 DMA channels per CS, one for RX and one for TX */
> =A0struct davinci_spi_dma {
> - =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_tx_channel;
> - =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_rx_channel;
> - =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_tx_sync_dev;
> - =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_rx_sync_dev;
> - =A0 =A0 =A0 enum dma_event_q =A0 =A0 =A0 =A0eventq;
> -
> - =A0 =A0 =A0 struct completion =A0 =A0 =A0 dma_tx_completion;
> - =A0 =A0 =A0 struct completion =A0 =A0 =A0 dma_rx_completion;
> + =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_tx_chann=
el;
> + =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_rx_chann=
el;
> + =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_tx_sync_=
dev;
> + =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_rx_sync_=
dev;
> + =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dummy_param_=
slot;
> + =A0 =A0 =A0 =A0enum dma_event_q =A0 =A0 =A0 =A0eventq;
> =A0};
>
> =A0/* SPI Controller driver's private data. */
> =A0struct davinci_spi {
> - =A0 =A0 =A0 struct spi_bitbang =A0 =A0 =A0bitbang;
> - =A0 =A0 =A0 struct clk =A0 =A0 =A0 =A0 =A0 =A0 =A0*clk;
> -
> - =A0 =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0version;
> - =A0 =A0 =A0 resource_size_t =A0 =A0 =A0 =A0 pbase;
> - =A0 =A0 =A0 void __iomem =A0 =A0 =A0 =A0 =A0 =A0*base;
> - =A0 =A0 =A0 size_t =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0region_size;
> - =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq;
> - =A0 =A0 =A0 struct completion =A0 =A0 =A0 done;
> -
> - =A0 =A0 =A0 const void =A0 =A0 =A0 =A0 =A0 =A0 =A0*tx;
> - =A0 =A0 =A0 void =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*rx;
> - =A0 =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*tmp_buf;
> - =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 count;
> - =A0 =A0 =A0 struct davinci_spi_dma =A0*dma_channels;
> - =A0 =A0 =A0 struct =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0davinci_spi_platf=
orm_data *pdata;
> -
> - =A0 =A0 =A0 void =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(*get_rx)(u32 r=
x_data, struct davinci_spi *);
> - =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (*get_tx)(struc=
t davinci_spi *);
> -
> - =A0 =A0 =A0 struct davinci_spi_slave slave[SPI_MAX_CHIPSELECT];
> + =A0 =A0 =A0 =A0struct spi_bitbang =A0 =A0 =A0bitbang;
> + =A0 =A0 =A0 =A0struct clk =A0 =A0 =A0 =A0 =A0 =A0 =A0*clk;
> +
> + =A0 =A0 =A0 =A0u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0version;
> + =A0 =A0 =A0 =A0resource_size_t =A0 =A0 =A0 =A0 pbase;
> + =A0 =A0 =A0 =A0void __iomem =A0 =A0 =A0 =A0 =A0 =A0*base;
> + =A0 =A0 =A0 =A0size_t =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0region_size;
> + =A0 =A0 =A0 =A0u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq;
> + =A0 =A0 =A0 =A0struct completion =A0 =A0 =A0 done;
> +
> + =A0 =A0 =A0 =A0const void =A0 =A0 =A0 =A0 =A0 =A0 =A0*tx;
> + =A0 =A0 =A0 =A0void =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*rx;
> + =A0 =A0 =A0 =A0u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*tmp_buf;
> + =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rcount;
> + =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wcount;
> + =A0 =A0 =A0 =A0u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 errors;
> + =A0 =A0 =A0 =A0struct davinci_spi_dma =A0dma_channels;
> + =A0 =A0 =A0 =A0struct davinci_spi_platform_data *pdata;
> +
> + =A0 =A0 =A0 =A0void =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(*get_rx)(u3=
2 rx_data, struct davinci_spi *);
> + =A0 =A0 =A0 =A0u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (*get_tx)(st=
ruct davinci_spi *);
> =A0};
>
> -static unsigned use_dma;
> +#define =A0 =A0 =A0 =A0DAVINCI_SPI_NO_RESOURCE =A0 =A0 =A0 =A0 ((resourc=
e_size_t)-1)
>
> =A0static void davinci_spi_rx_buf_u8(u32 data, struct davinci_spi *davinc=
i_spi)
> =A0{
> - =A0 =A0 =A0 u8 *rx =3D davinci_spi->rx;
> -
> - =A0 =A0 =A0 *rx++ =3D (u8)data;
> - =A0 =A0 =A0 davinci_spi->rx =3D rx;
> + =A0 =A0 =A0 if (davinci_spi->rx) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u8 *rx =3D davinci_spi->rx;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *rx++ =3D (u8)data;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi->rx =3D rx;
> + =A0 =A0 =A0 }
> =A0}
>
> =A0static void davinci_spi_rx_buf_u16(u32 data, struct davinci_spi *davin=
ci_spi)
> =A0{
> - =A0 =A0 =A0 u16 *rx =3D davinci_spi->rx;
> -
> - =A0 =A0 =A0 *rx++ =3D (u16)data;
> - =A0 =A0 =A0 davinci_spi->rx =3D rx;
> + =A0 =A0 =A0 if (davinci_spi->rx) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u16 *rx =3D davinci_spi->rx;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *rx++ =3D (u16)data;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi->rx =3D rx;
> + =A0 =A0 =A0 }
> =A0}
>
> =A0static u32 davinci_spi_tx_buf_u8(struct davinci_spi *davinci_spi)
> =A0{
> - =A0 =A0 =A0 u32 data;
> - =A0 =A0 =A0 const u8 *tx =3D davinci_spi->tx;
> -
> - =A0 =A0 =A0 data =3D *tx++;
> - =A0 =A0 =A0 davinci_spi->tx =3D tx;
> + =A0 =A0 =A0 u32 data =3D 0;
> + =A0 =A0 =A0 if (davinci_spi->tx) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 const u8 *tx =3D davinci_spi->tx;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data =3D *tx++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi->tx =3D tx;
> + =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0return data;
> =A0}
>
> =A0static u32 davinci_spi_tx_buf_u16(struct davinci_spi *davinci_spi)
> =A0{
> - =A0 =A0 =A0 u32 data;
> - =A0 =A0 =A0 const u16 *tx =3D davinci_spi->tx;
> -
> - =A0 =A0 =A0 data =3D *tx++;
> - =A0 =A0 =A0 davinci_spi->tx =3D tx;
> + =A0 =A0 =A0 u32 data =3D 0;
> + =A0 =A0 =A0 if (davinci_spi->tx) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 const u16 *tx =3D davinci_spi->tx;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data =3D *tx++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi->tx =3D tx;
> + =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0return data;
> =A0}
>
> @@ -237,26 +259,6 @@ static inline void clear_io_bits(void __iomem *addr,=
 u32 bits)
> =A0 =A0 =A0 =A0iowrite32(v, addr);
> =A0}
>
> -static inline void set_fmt_bits(void __iomem *addr, u32 bits, int cs_num)
> -{
> - =A0 =A0 =A0 set_io_bits(addr + SPIFMT0 + (0x4 * cs_num), bits);
> -}
> -
> -static inline void clear_fmt_bits(void __iomem *addr, u32 bits, int cs_n=
um)
> -{
> - =A0 =A0 =A0 clear_io_bits(addr + SPIFMT0 + (0x4 * cs_num), bits);
> -}
> -
> -static void davinci_spi_set_dma_req(const struct spi_device *spi, int en=
able)
> -{
> - =A0 =A0 =A0 struct davinci_spi *davinci_spi =3D spi_master_get_devdata(=
spi->master);
> -
> - =A0 =A0 =A0 if (enable)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_io_bits(davinci_spi->base + SPIINT, SPI=
INT_DMA_REQ_EN);
> - =A0 =A0 =A0 else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 clear_io_bits(davinci_spi->base + SPIINT, S=
PIINT_DMA_REQ_EN);
> -}
> -
> =A0/*
> =A0* Interface to control the chip select signal
> =A0*/
> @@ -264,28 +266,57 @@ static void davinci_spi_chipselect(struct spi_devic=
e *spi, int value)
> =A0{
> =A0 =A0 =A0 =A0struct davinci_spi *davinci_spi;
> =A0 =A0 =A0 =A0struct davinci_spi_platform_data *pdata;
> - =A0 =A0 =A0 u32 data1_reg_val =3D 0;
> + =A0 =A0 =A0 u8 i, chip_sel =3D spi->chip_select;
> + =A0 =A0 =A0 u32 spidat1;
> + =A0 =A0 =A0 u16 spidat1_cfg;
>
> =A0 =A0 =A0 =A0davinci_spi =3D spi_master_get_devdata(spi->master);
> =A0 =A0 =A0 =A0pdata =3D davinci_spi->pdata;
>
> - =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0* Board specific chip select logic decides the polarity =
and cs
> - =A0 =A0 =A0 =A0* line for the controller
> - =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 if (value =3D=3D BITBANG_CS_INACTIVE) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_io_bits(davinci_spi->base + SPIDEF, CS_=
DEFAULT);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 data1_reg_val |=3D CS_DEFAULT << SPIDAT1_CS=
NR_SHIFT;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 iowrite32(data1_reg_val, davinci_spi->base =
+ SPIDAT1);
> + =A0 =A0 =A0 spidat1 =3D SPIDAT1_CSNR_MASK;
> + =A0 =A0 =A0 if (value =3D=3D BITBANG_CS_ACTIVE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spidat1 |=3D SPIDAT1_CSHOLD_MASK;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spidat1 |=3D SPIDAT1_WDEL_MASK;
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 while ((ioread32(davinci_spi->base + SPIBUF)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 & SPIBUF_RXEMPTY_MASK) =3D=3D 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpu_relax();
> + =A0 =A0 =A0 if (pdata->chip_sel =3D=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (value =3D=3D BITBANG_CS_ACTIVE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spidat1 &=3D ~((0x1 << chip=
_sel) << SPIDAT1_CSNR_SHIFT);
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < pdata->num_chipselect; i+=
+) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pdata->chip_sel[i] =3D=
=3D SPI_INTERN_CS) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((i =3D=
=3D chip_sel) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (va=
lue =3D=3D BITBANG_CS_ACTIVE)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 spidat1 &=3D ~((0x1 << chip_sel)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 << SPIDAT1_CSNR_SHIFT);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (value =
=3D=3D BITBANG_CS_INACTIVE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 gpio_set_value(pdata->chip_sel[i], 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (i =
=3D=3D chip_sel)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 gpio_set_value(pdata->chip_sel[i], 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0}
> +
> + =A0 =A0 =A0 spidat1_cfg =3D spidat1 >> SPIDAT1_CSNR_SHIFT;
> + =A0 =A0 =A0 iowrite16(spidat1_cfg, davinci_spi->base + SPIDAT1 + 2);
> +}
> +
> +/*
> + * davinci_spi_get_prescale - Calculates the correct prescale value
> + * @max_speed_hz: the maximum rate the SPI clock can run at
> + *
> + * This function calculates the prescale value that generates a clock ra=
te
> + * less than or equal to the specified maximum
> + */
> +static inline u32 davinci_spi_get_prescale(struct davinci_spi *davinci_s=
pi,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 u32 max_speed_hz)
> +{
> + =A0 =A0 =A0 return ((clk_get_rate(davinci_spi->clk) - 1) / max_speed_hz=
) & 0xff;
> =A0}
>
> -/**
> +/*
> =A0* davinci_spi_setup_transfer - This functions will determine transfer =
method
> =A0* @spi: spi device on which data transfer to be done
> =A0* @t: spi transfer in which transfer info is filled
> @@ -297,14 +328,15 @@ static void davinci_spi_chipselect(struct spi_devic=
e *spi, int value)
> =A0static int davinci_spi_setup_transfer(struct spi_device *spi,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct spi_transfer *t)
> =A0{
> -
> =A0 =A0 =A0 =A0struct davinci_spi *davinci_spi;
> =A0 =A0 =A0 =A0struct davinci_spi_platform_data *pdata;
> + =A0 =A0 =A0 struct davinci_spi_config *spi_cfg;
> =A0 =A0 =A0 =A0u8 bits_per_word =3D 0;
> - =A0 =A0 =A0 u32 hz =3D 0, prescale =3D 0, clkspeed;
> + =A0 =A0 =A0 u32 hz =3D 0, spifmt =3D 0, prescale, delay =3D 0;
>
> =A0 =A0 =A0 =A0davinci_spi =3D spi_master_get_devdata(spi->master);
> =A0 =A0 =A0 =A0pdata =3D davinci_spi->pdata;
> + =A0 =A0 =A0 spi_cfg =3D spi->controller_data;
>
> =A0 =A0 =A0 =A0if (t) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bits_per_word =3D t->bits_per_word;
> @@ -322,76 +354,112 @@ static int davinci_spi_setup_transfer(struct spi_d=
evice *spi,
> =A0 =A0 =A0 =A0if (bits_per_word <=3D 8 && bits_per_word >=3D 2) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0davinci_spi->get_rx =3D davinci_spi_rx_buf=
_u8;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0davinci_spi->get_tx =3D davinci_spi_tx_buf=
_u8;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi->slave[spi->chip_select].bytes_=
per_word =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi_cfg->bytes_per_word =3D 1;
> =A0 =A0 =A0 =A0} else if (bits_per_word <=3D 16 && bits_per_word >=3D 2) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0davinci_spi->get_rx =3D davinci_spi_rx_buf=
_u16;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0davinci_spi->get_tx =3D davinci_spi_tx_buf=
_u16;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi->slave[spi->chip_select].bytes_=
per_word =3D 2;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi_cfg->bytes_per_word =3D 2;
> =A0 =A0 =A0 =A0} else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
>
> =A0 =A0 =A0 =A0if (!hz)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hz =3D spi->max_speed_hz;
>
> - =A0 =A0 =A0 clear_fmt_bits(davinci_spi->base, SPIFMT_CHARLEN_MASK,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi->chip_select);
> - =A0 =A0 =A0 set_fmt_bits(davinci_spi->base, bits_per_word & 0x1f,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi->chip_select);
> + =A0 =A0 =A0 prescale =3D davinci_spi_get_prescale(davinci_spi, hz);
> + =A0 =A0 =A0 spifmt |=3D (prescale << SPIFMT_PRESCALE_SHIFT);
> +
> + =A0 =A0 =A0 spifmt |=3D (bits_per_word & 0x1f);
> +
> + =A0 =A0 =A0 if (spi->mode & SPI_LSB_FIRST)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spifmt |=3D SPIFMT_SHIFTDIR_MASK;
>
> - =A0 =A0 =A0 clkspeed =3D clk_get_rate(davinci_spi->clk);
> - =A0 =A0 =A0 if (hz > clkspeed / 2)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 prescale =3D 1 << 8;
> - =A0 =A0 =A0 if (hz < clkspeed / 256)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 prescale =3D 255 << 8;
> - =A0 =A0 =A0 if (!prescale)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 prescale =3D ((clkspeed / hz - 1) << 8) & 0=
x0000ff00;
> + =A0 =A0 =A0 if (spi->mode & SPI_CPOL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spifmt |=3D SPIFMT_POLARITY_MASK;
>
> - =A0 =A0 =A0 clear_fmt_bits(davinci_spi->base, 0x0000ff00, spi->chip_sel=
ect);
> - =A0 =A0 =A0 set_fmt_bits(davinci_spi->base, prescale, spi->chip_select);
> + =A0 =A0 =A0 if (!(spi->mode & SPI_CPHA))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spifmt |=3D SPIFMT_PHASE_MASK;
> +
> + =A0 =A0 =A0 if (davinci_spi->version =3D=3D SPI_VERSION_2) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spifmt |=3D ((spi_cfg->wdelay << SPIFMT_WDE=
LAY_SHIFT)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 & SPIFMT_WD=
ELAY_MASK);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (spi_cfg->odd_parity)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spifmt |=3D SPIFMT_ODD_PARI=
TY_MASK;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (spi_cfg->parity_enable)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spifmt |=3D SPIFMT_PARITYEN=
A_MASK;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (spi->mode & SPI_READY) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spifmt |=3D SPIFMT_WAITENA_=
MASK;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 delay |=3D (spi_cfg->t2e_de=
lay
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 << SPIDELAY_T2EDELAY_SHIFT)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 & SPIDELAY_T2EDELAY_MASK;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 delay |=3D (spi_cfg->c2e_de=
lay
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 << SPIDELAY_C2EDELAY_SHIFT)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 & SPIDELAY_C2EDELAY_MASK;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (spi_cfg->timer_disable) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spifmt |=3D SPIFMT_DISTIMER=
_MASK;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 delay |=3D (spi_cfg->c2t_de=
lay
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 << SPIDELAY_C2TDELAY_SHIFT)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 & SPIDELAY_C2TDELAY_MASK;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 delay |=3D (spi_cfg->t2c_de=
lay
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 << SPIDELAY_T2CDELAY_SHIFT)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 & SPIDELAY_T2CDELAY_MASK;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iowrite32(delay, davinci_spi->base + SPIDEL=
AY);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 iowrite32(spifmt, davinci_spi->base + SPIFMT0);
> +
> + =A0 =A0 =A0 if (spi_cfg->intr_level)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iowrite32(SPI_INTLVL_1, davinci_spi->base +=
 SPILVL);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iowrite32(SPI_INTLVL_0, davinci_spi->base +=
 SPILVL);
> +
> + =A0 =A0 =A0 if (spi->mode & SPI_LOOP)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_io_bits(davinci_spi->base + SPIGCR1,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SPIGCR1_LOO=
PBACK_MASK);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clear_io_bits(davinci_spi->base + SPIGCR1,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SPIGCR1_LOO=
PBACK_MASK);
>
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> =A0static void davinci_spi_dma_rx_callback(unsigned lch, u16 ch_status, v=
oid *data)
> =A0{
> - =A0 =A0 =A0 struct spi_device *spi =3D (struct spi_device *)data;
> - =A0 =A0 =A0 struct davinci_spi *davinci_spi;
> + =A0 =A0 =A0 struct davinci_spi *davinci_spi =3D (struct davinci_spi *)d=
ata;
> =A0 =A0 =A0 =A0struct davinci_spi_dma *davinci_spi_dma;
> =A0 =A0 =A0 =A0struct davinci_spi_platform_data *pdata;
>
> - =A0 =A0 =A0 davinci_spi =3D spi_master_get_devdata(spi->master);
> - =A0 =A0 =A0 davinci_spi_dma =3D &(davinci_spi->dma_channels[spi->chip_s=
elect]);
> + =A0 =A0 =A0 davinci_spi_dma =3D &(davinci_spi->dma_channels);
> =A0 =A0 =A0 =A0pdata =3D davinci_spi->pdata;
>
> + =A0 =A0 =A0 edma_stop(davinci_spi_dma->dma_rx_channel);
> +
> =A0 =A0 =A0 =A0if (ch_status =3D=3D DMA_COMPLETE)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 edma_stop(davinci_spi_dma->dma_rx_channel);
> - =A0 =A0 =A0 else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 edma_clean_channel(davinci_spi_dma->dma_rx_=
channel);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi->rcount =3D 0;
>
> - =A0 =A0 =A0 complete(&davinci_spi_dma->dma_rx_completion);
> - =A0 =A0 =A0 /* We must disable the DMA RX request */
> - =A0 =A0 =A0 davinci_spi_set_dma_req(spi, 0);
> + =A0 =A0 =A0 complete(&davinci_spi->done);
> =A0}
>
> =A0static void davinci_spi_dma_tx_callback(unsigned lch, u16 ch_status, v=
oid *data)
> =A0{
> - =A0 =A0 =A0 struct spi_device *spi =3D (struct spi_device *)data;
> - =A0 =A0 =A0 struct davinci_spi *davinci_spi;
> + =A0 =A0 =A0 struct davinci_spi *davinci_spi =3D (struct davinci_spi *)d=
ata;
> =A0 =A0 =A0 =A0struct davinci_spi_dma *davinci_spi_dma;
> =A0 =A0 =A0 =A0struct davinci_spi_platform_data *pdata;
>
> - =A0 =A0 =A0 davinci_spi =3D spi_master_get_devdata(spi->master);
> - =A0 =A0 =A0 davinci_spi_dma =3D &(davinci_spi->dma_channels[spi->chip_s=
elect]);
> + =A0 =A0 =A0 davinci_spi_dma =3D &(davinci_spi->dma_channels);
> =A0 =A0 =A0 =A0pdata =3D davinci_spi->pdata;
>
> - =A0 =A0 =A0 if (ch_status =3D=3D DMA_COMPLETE)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 edma_stop(davinci_spi_dma->dma_tx_channel);
> - =A0 =A0 =A0 else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 edma_clean_channel(davinci_spi_dma->dma_tx_=
channel);
> + =A0 =A0 =A0 edma_stop(davinci_spi_dma->dma_tx_channel);
>
> - =A0 =A0 =A0 complete(&davinci_spi_dma->dma_tx_completion);
> - =A0 =A0 =A0 /* We must disable the DMA TX request */
> - =A0 =A0 =A0 davinci_spi_set_dma_req(spi, 0);
> + =A0 =A0 =A0 if (ch_status =3D=3D DMA_COMPLETE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi->wcount =3D 0;
> =A0}
>
> =A0static int davinci_spi_request_dma(struct spi_device *spi)
> @@ -403,33 +471,54 @@ static int davinci_spi_request_dma(struct spi_devic=
e *spi)
> =A0 =A0 =A0 =A0int r;
>
> =A0 =A0 =A0 =A0davinci_spi =3D spi_master_get_devdata(spi->master);
> - =A0 =A0 =A0 davinci_spi_dma =3D &davinci_spi->dma_channels[spi->chip_se=
lect];
> + =A0 =A0 =A0 davinci_spi_dma =3D &davinci_spi->dma_channels;
> =A0 =A0 =A0 =A0pdata =3D davinci_spi->pdata;
> =A0 =A0 =A0 =A0sdev =3D davinci_spi->bitbang.master->dev.parent;
>
> =A0 =A0 =A0 =A0r =3D edma_alloc_channel(davinci_spi_dma->dma_rx_sync_dev,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi=
_dma_rx_callback, spi,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi=
_dma_rx_callback, davinci_spi,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0davinci_sp=
i_dma->eventq);
> =A0 =A0 =A0 =A0if (r < 0) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(sdev, "Unable to request DMA channe=
l for SPI RX\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EAGAIN;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(sdev, "Unable to request DMA channe=
l for MibSPI RX\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D =A0-EAGAIN;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto rx_dma_failed;
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0davinci_spi_dma->dma_rx_channel =3D r;
> +
> =A0 =A0 =A0 =A0r =3D edma_alloc_channel(davinci_spi_dma->dma_tx_sync_dev,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi=
_dma_tx_callback, spi,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi=
_dma_tx_callback, davinci_spi,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0davinci_sp=
i_dma->eventq);
> =A0 =A0 =A0 =A0if (r < 0) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 edma_free_channel(davinci_spi_dma->dma_rx_c=
hannel);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi_dma->dma_rx_channel =3D -1;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(sdev, "Unable to request DMA channe=
l for SPI TX\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EAGAIN;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(sdev, "Unable to request DMA channe=
l for MibSPI TX\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D -EAGAIN;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto tx_dma_failed;
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0davinci_spi_dma->dma_tx_channel =3D r;
>
> + =A0 =A0 =A0 r =3D edma_alloc_slot(EDMA_CTLR(davinci_spi_dma->dma_tx_syn=
c_dev),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 EDMA_SLOT_A=
NY);
> + =A0 =A0 =A0 if (r < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(sdev, "Unable to request SPI DMA pa=
ram slot\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D -EAGAIN;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto param_failed;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 davinci_spi_dma->dummy_param_slot =3D r;
> + =A0 =A0 =A0 edma_link(davinci_spi_dma->dummy_param_slot,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi_dma->dummy_param_slot);
> +
> =A0 =A0 =A0 =A0return 0;
> +
> +param_failed:
> + =A0 =A0 =A0 edma_free_channel(davinci_spi_dma->dma_tx_channel);
> + =A0 =A0 =A0 davinci_spi_dma->dma_tx_channel =3D -1;
> +tx_dma_failed:
> + =A0 =A0 =A0 edma_free_channel(davinci_spi_dma->dma_rx_channel);
> + =A0 =A0 =A0 davinci_spi_dma->dma_rx_channel =3D -1;
> +rx_dma_failed:
> + =A0 =A0 =A0 return r;
> =A0}
>
> -/**
> +/*
> =A0* davinci_spi_setup - This functions will set default transfer method
> =A0* @spi: spi device on which data transfer to be done
> =A0*
> @@ -438,129 +527,54 @@ static int davinci_spi_request_dma(struct spi_devi=
ce *spi)
>
> =A0static int davinci_spi_setup(struct spi_device *spi)
> =A0{
> - =A0 =A0 =A0 int retval;
> + =A0 =A0 =A0 int retval =3D 0;
> =A0 =A0 =A0 =A0struct davinci_spi *davinci_spi;
> - =A0 =A0 =A0 struct davinci_spi_dma *davinci_spi_dma;
> - =A0 =A0 =A0 struct device *sdev;
> + =A0 =A0 =A0 struct davinci_spi_dma *davinci_dma;
> + =A0 =A0 =A0 struct davinci_spi_platform_data *pdata;
> + =A0 =A0 =A0 struct davinci_spi_config *spi_cfg;
> + =A0 =A0 =A0 u32 prescale;
>
> =A0 =A0 =A0 =A0davinci_spi =3D spi_master_get_devdata(spi->master);
> - =A0 =A0 =A0 sdev =3D davinci_spi->bitbang.master->dev.parent;
> + =A0 =A0 =A0 pdata =3D davinci_spi->pdata;
> + =A0 =A0 =A0 spi_cfg =3D (struct davinci_spi_config *)spi->controller_da=
ta;
> + =A0 =A0 =A0 davinci_dma =3D &(davinci_spi->dma_channels);
>
> =A0 =A0 =A0 =A0/* if bits per word length is zero then set it default 8 */
> =A0 =A0 =A0 =A0if (!spi->bits_per_word)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spi->bits_per_word =3D 8;
>
> - =A0 =A0 =A0 davinci_spi->slave[spi->chip_select].cmd_to_write =3D 0;
> -
> - =A0 =A0 =A0 if (use_dma && davinci_spi->dma_channels) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi_dma =3D &davinci_spi->dma_chann=
els[spi->chip_select];
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((davinci_spi_dma->dma_rx_channel =3D=3D=
 -1)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 || (davinci=
_spi_dma->dma_tx_channel =3D=3D -1)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D davinci_spi_requ=
est_dma(spi);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (retval < 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return retv=
al;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> - =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (!(spi->mode & SPI_NO_CS)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((pdata->chip_sel =3D=3D NULL) ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (pdata->chip_sel[spi->chip_select] =
=3D=3D SPI_INTERN_CS))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_io_bits(davinci_spi->ba=
se + SPIPC0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 1 << spi->chip_select);
>
> - =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0* SPI in DaVinci and DA8xx operate between
> - =A0 =A0 =A0 =A0* 600 KHz and 50 MHz
> - =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 if (spi->max_speed_hz < 600000 || spi->max_speed_hz > 50000=
000) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(sdev, "Operating frequency is not i=
n acceptable "
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "range\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0* Set up SPIFMTn register, unique to this chipselect.
> - =A0 =A0 =A0 =A0*
> - =A0 =A0 =A0 =A0* NOTE: we could do all of these with one write. =A0Also=
, some
> - =A0 =A0 =A0 =A0* of the "version 2" features are found in chips that do=
n't
> - =A0 =A0 =A0 =A0* support all of them...
> - =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 if (spi->mode & SPI_LSB_FIRST)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_fmt_bits(davinci_spi->base, SPIFMT_SHIF=
TDIR_MASK,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi->chip_s=
elect);
> - =A0 =A0 =A0 else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 clear_fmt_bits(davinci_spi->base, SPIFMT_SH=
IFTDIR_MASK,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi->chip_s=
elect);
> + =A0 =A0 =A0 if (spi->mode & SPI_READY)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_io_bits(davinci_spi->base + SPIPC0, SPI=
PC0_SPIENA_MASK);
>
> - =A0 =A0 =A0 if (spi->mode & SPI_CPOL)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_fmt_bits(davinci_spi->base, SPIFMT_POLA=
RITY_MASK,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi->chip_s=
elect);
> - =A0 =A0 =A0 else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 clear_fmt_bits(davinci_spi->base, SPIFMT_PO=
LARITY_MASK,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi->chip_s=
elect);
> + =A0 =A0 =A0 if (spi_cfg->io_type =3D=3D SPI_IO_TYPE_DMA) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_dma =3D &(davinci_spi->dma_channels=
);
>
> - =A0 =A0 =A0 if (!(spi->mode & SPI_CPHA))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_fmt_bits(davinci_spi->base, SPIFMT_PHAS=
E_MASK,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi->chip_s=
elect);
> - =A0 =A0 =A0 else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 clear_fmt_bits(davinci_spi->base, SPIFMT_PH=
ASE_MASK,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi->chip_s=
elect);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((davinci_dma->dma_tx_sync_dev =3D=3D DA=
VINCI_SPI_NO_RESOURCE) ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (davinci_dma->dma_rx_sync_dev =3D=
=3D DAVINCI_SPI_NO_RESOURCE) ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (davinci_dma->eventq =3D=3D DAVINCI=
_SPI_NO_RESOURCE))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi_cfg->io_type =3D SPI_IO=
_TYPE_INTR;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if ((davinci_dma->dma_rx_channel =3D=
=3D -1) ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(davinci_dma->dma_tx_cha=
nnel =3D=3D -1))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D davinci_spi_requ=
est_dma(spi);
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0/*
> - =A0 =A0 =A0 =A0* Version 1 hardware supports two basic SPI modes:
> - =A0 =A0 =A0 =A0* =A0- Standard SPI mode uses 4 pins, with chipselect
> - =A0 =A0 =A0 =A0* =A0- 3 pin SPI is a 4 pin variant without CS (SPI_NO_C=
S)
> - =A0 =A0 =A0 =A0* =A0 =A0 =A0(distinct from SPI_3WIRE, with just one dat=
a wire;
> - =A0 =A0 =A0 =A0* =A0 =A0 =A0or similar variants without MOSI or without=
 MISO)
> - =A0 =A0 =A0 =A0*
> - =A0 =A0 =A0 =A0* Version 2 hardware supports an optional handshaking si=
gnal,
> - =A0 =A0 =A0 =A0* so it can support two more modes:
> - =A0 =A0 =A0 =A0* =A0- 5 pin SPI variant is standard SPI plus SPI_READY
> - =A0 =A0 =A0 =A0* =A0- 4 pin with enable is (SPI_READY | SPI_NO_CS)
> + =A0 =A0 =A0 =A0* Validate desired clock rate
> =A0 =A0 =A0 =A0 */
> + =A0 =A0 =A0 prescale =3D davinci_spi_get_prescale(davinci_spi, spi->max=
_speed_hz);
> + =A0 =A0 =A0 if ((prescale < 2) || (prescale > 255))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>
> - =A0 =A0 =A0 if (davinci_spi->version =3D=3D SPI_VERSION_2) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 clear_fmt_bits(davinci_spi->base, SPIFMT_WD=
ELAY_MASK,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi->chip_s=
elect);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_fmt_bits(davinci_spi->base,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (davinci_sp=
i->pdata->wdelay
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 << SPIFMT_WDELAY_SHIFT)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 & SPIFMT_WDELAY_MASK,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi->chip_s=
elect);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (davinci_spi->pdata->odd_parity)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_fmt_bits(davinci_spi->b=
ase,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 SPIFMT_ODD_PARITY_MASK,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 spi->chip_select);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clear_fmt_bits(davinci_spi-=
>base,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 SPIFMT_ODD_PARITY_MASK,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 spi->chip_select);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (davinci_spi->pdata->parity_enable)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_fmt_bits(davinci_spi->b=
ase,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 SPIFMT_PARITYENA_MASK,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 spi->chip_select);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clear_fmt_bits(davinci_spi-=
>base,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 SPIFMT_PARITYENA_MASK,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 spi->chip_select);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (davinci_spi->pdata->wait_enable)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_fmt_bits(davinci_spi->b=
ase,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 SPIFMT_WAITENA_MASK,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 spi->chip_select);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clear_fmt_bits(davinci_spi-=
>base,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 SPIFMT_WAITENA_MASK,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 spi->chip_select);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (davinci_spi->pdata->timer_disable)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_fmt_bits(davinci_spi->b=
ase,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 SPIFMT_DISTIMER_MASK,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 spi->chip_select);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clear_fmt_bits(davinci_spi-=
>base,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 SPIFMT_DISTIMER_MASK,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 spi->chip_select);
> - =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 retval =3D davinci_spi_setup_transfer(spi, NULL);
> + =A0 =A0 =A0 dev_info(&spi->dev, "DaVinci SPI driver in %s mode\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 io_type_names[spi_cfg->io_t=
ype]);
>
> =A0 =A0 =A0 =A0return retval;
> =A0}
> @@ -569,50 +583,19 @@ static void davinci_spi_cleanup(struct spi_device *=
spi)
> =A0{
> =A0 =A0 =A0 =A0struct davinci_spi *davinci_spi =3D spi_master_get_devdata=
(spi->master);
> =A0 =A0 =A0 =A0struct davinci_spi_dma *davinci_spi_dma;
> + =A0 =A0 =A0 struct davinci_spi_platform_data *pdata;
>
> - =A0 =A0 =A0 davinci_spi_dma =3D &davinci_spi->dma_channels[spi->chip_se=
lect];
> -
> - =A0 =A0 =A0 if (use_dma && davinci_spi->dma_channels) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi_dma =3D &davinci_spi->dma_chann=
els[spi->chip_select];
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((davinci_spi_dma->dma_rx_channel !=3D -=
1)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 && (davinci=
_spi_dma->dma_tx_channel !=3D -1)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 edma_free_channel(davinci_s=
pi_dma->dma_tx_channel);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 edma_free_channel(davinci_s=
pi_dma->dma_rx_channel);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> - =A0 =A0 =A0 }
> -}
> -
> -static int davinci_spi_bufs_prep(struct spi_device *spi,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct d=
avinci_spi *davinci_spi)
> -{
> - =A0 =A0 =A0 int op_mode =3D 0;
> -
> - =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0* REVISIT =A0unless devices disagree about SPI_LOOP or
> - =A0 =A0 =A0 =A0* SPI_READY (SPI_NO_CS only allows one device!), this
> - =A0 =A0 =A0 =A0* should not need to be done before each message...
> - =A0 =A0 =A0 =A0* optimize for both flags staying cleared.
> - =A0 =A0 =A0 =A0*/
> -
> - =A0 =A0 =A0 op_mode =3D SPIPC0_DIFUN_MASK
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 | SPIPC0_DOFUN_MASK
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 | SPIPC0_CLKFUN_MASK;
> - =A0 =A0 =A0 if (!(spi->mode & SPI_NO_CS))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 op_mode |=3D 1 << spi->chip_select;
> - =A0 =A0 =A0 if (spi->mode & SPI_READY)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 op_mode |=3D SPIPC0_SPIENA_MASK;
> + =A0 =A0 =A0 davinci_spi_dma =3D &davinci_spi->dma_channels;
> + =A0 =A0 =A0 pdata =3D davinci_spi->pdata;
>
> - =A0 =A0 =A0 iowrite32(op_mode, davinci_spi->base + SPIPC0);
> + =A0 =A0 =A0 if (davinci_spi_dma->dma_rx_channel !=3D -1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 edma_free_channel(davinci_spi_dma->dma_rx_c=
hannel);
>
> - =A0 =A0 =A0 if (spi->mode & SPI_LOOP)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_io_bits(davinci_spi->base + SPIGCR1,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SPIGCR1_LOO=
PBACK_MASK);
> - =A0 =A0 =A0 else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 clear_io_bits(davinci_spi->base + SPIGCR1,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SPIGCR1_LOO=
PBACK_MASK);
> + =A0 =A0 =A0 if (davinci_spi_dma->dma_tx_channel !=3D -1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 edma_free_channel(davinci_spi_dma->dma_tx_c=
hannel);
>
> - =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 if (davinci_spi_dma->dummy_param_slot !=3D -1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 edma_free_slot(davinci_spi_dma->dummy_param=
_slot);
> =A0}
>
> =A0static int davinci_spi_check_error(struct davinci_spi *davinci_spi,
> @@ -659,356 +642,248 @@ static int davinci_spi_check_error(struct davinci=
_spi *davinci_spi,
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> -/**
> - * davinci_spi_bufs - functions which will handle transfer data
> - * @spi: spi device on which data transfer to be done
> - * @t: spi transfer in which transfer info is filled
> +/*
> + * davinci_spi_process_events - check for and handle any SPI controller =
events
> + * @davinci_spi - the controller data
> =A0*
> - * This function will put data to be transferred into data register
> - * of SPI controller and then wait until the completion will be marked
> - * by the IRQ Handler.
> + * This function will check the SPIFLG register and handle any events th=
at are
> + * detected there
> =A0*/
> -static int davinci_spi_bufs_pio(struct spi_device *spi, struct spi_trans=
fer *t)
> +static int davinci_spi_process_events(struct davinci_spi *davinci_spi)
> =A0{
> - =A0 =A0 =A0 struct davinci_spi *davinci_spi;
> - =A0 =A0 =A0 int int_status, count, ret;
> - =A0 =A0 =A0 u8 conv, tmp;
> - =A0 =A0 =A0 u32 tx_data, data1_reg_val;
> - =A0 =A0 =A0 u32 buf_val, flg_val;
> - =A0 =A0 =A0 struct davinci_spi_platform_data *pdata;
> -
> - =A0 =A0 =A0 davinci_spi =3D spi_master_get_devdata(spi->master);
> - =A0 =A0 =A0 pdata =3D davinci_spi->pdata;
> -
> - =A0 =A0 =A0 davinci_spi->tx =3D t->tx_buf;
> - =A0 =A0 =A0 davinci_spi->rx =3D t->rx_buf;
> -
> - =A0 =A0 =A0 /* convert len to words based on bits_per_word */
> - =A0 =A0 =A0 conv =3D davinci_spi->slave[spi->chip_select].bytes_per_wor=
d;
> - =A0 =A0 =A0 davinci_spi->count =3D t->len / conv;
> -
> - =A0 =A0 =A0 INIT_COMPLETION(davinci_spi->done);
> -
> - =A0 =A0 =A0 ret =3D davinci_spi_bufs_prep(spi, davinci_spi);
> - =A0 =A0 =A0 if (ret)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> -
> - =A0 =A0 =A0 /* Enable SPI */
> - =A0 =A0 =A0 set_io_bits(davinci_spi->base + SPIGCR1, SPIGCR1_SPIENA_MAS=
K);
> -
> - =A0 =A0 =A0 iowrite32(0 | (pdata->c2tdelay << SPI_C2TDELAY_SHIFT) |
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (pdata->t2cdelay << SPI_T2C=
DELAY_SHIFT),
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi->base + SPIDELA=
Y);
> -
> - =A0 =A0 =A0 count =3D davinci_spi->count;
> - =A0 =A0 =A0 data1_reg_val =3D pdata->cs_hold << SPIDAT1_CSHOLD_SHIFT;
> - =A0 =A0 =A0 tmp =3D ~(0x1 << spi->chip_select);
> -
> - =A0 =A0 =A0 clear_io_bits(davinci_spi->base + SPIDEF, ~tmp);
> -
> - =A0 =A0 =A0 data1_reg_val |=3D tmp << SPIDAT1_CSNR_SHIFT;
> -
> - =A0 =A0 =A0 while ((ioread32(davinci_spi->base + SPIBUF)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 & SPIBUF_RX=
EMPTY_MASK) =3D=3D 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpu_relax();
> -
> - =A0 =A0 =A0 /* Determine the command to execute READ or WRITE */
> - =A0 =A0 =A0 if (t->tx_buf) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 clear_io_bits(davinci_spi->base + SPIINT, S=
PIINT_MASKALL);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (1) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_data =3D davinci_spi->ge=
t_tx(davinci_spi);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data1_reg_val &=3D ~(0xFFFF=
);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data1_reg_val |=3D (0xFFFF =
& tx_data);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf_val =3D ioread32(davinc=
i_spi->base + SPIBUF);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((buf_val & SPIBUF_TXFUL=
L_MASK) =3D=3D 0) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 iowrite32(d=
ata1_reg_val,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 davinci_spi->base + SPIDAT1);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 count--;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (ioread32(davinci_spi=
->base + SPIBUF)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 & SPIBUF_RXEMPTY_MASK)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpu_relax();
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* getting the returned byt=
e */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (t->rx_buf) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf_val =3D=
 ioread32(davinci_spi->base + SPIBUF);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi=
->get_rx(buf_val, davinci_spi);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (count <=3D 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> - =A0 =A0 =A0 } else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pdata->poll_mode) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (1) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* keeps th=
e serial clock going */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((ioread=
32(davinci_spi->base + SPIBUF)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 & SPIBUF_TXFULL_MASK) =3D=3D 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 iowrite32(data1_reg_val,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 davinci_spi->base + SPIDAT1);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (iore=
ad32(davinci_spi->base + SPIBUF) &
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 SPIBUF_RXEMPTY_MASK)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 cpu_relax();
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 flg_val =3D=
 ioread32(davinci_spi->base + SPIFLG);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf_val =3D=
 ioread32(davinci_spi->base + SPIBUF);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi=
->get_rx(buf_val, davinci_spi);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 count--;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (count <=
=3D 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 break;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else { =A0 =A0 =A0 =A0/* Receive in Inter=
rupt mode */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int i;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < davinci_s=
pi->count; i++) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_io_bits=
(davinci_spi->base + SPIINT,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 SPIINT_BITERR_INTR
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 | SPIINT_OVRRUN_INTR
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 | SPIINT_RX_INTR);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 iowrite32(d=
ata1_reg_val,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 davinci_spi->base + SPIDAT1);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (iore=
ad32(davinci_spi->base + SPIINT) &
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 SPIINT_RX_INTR)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 cpu_relax();
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 iowrite32((data1_reg_val & =
0x0ffcffff),
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 davinci_spi->base + SPIDAT1);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 u32 status, tx_data, rx_data, spidat1;
> + =A0 =A0 =A0 u8 tx_word =3D 0;
> +
> + =A0 =A0 =A0 status =3D ioread32(davinci_spi->base + SPIFLG);
> +
> + =A0 =A0 =A0 if ((davinci_spi->version =3D=3D SPI_VERSION_2) &&
> + =A0 =A0 =A0 =A0 =A0 (likely(status & SPIFLG_TX_INTR_MASK)) &&
> + =A0 =A0 =A0 =A0 =A0 (likely(davinci_spi->wcount > 0)))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_word =3D 1;
> +
> + =A0 =A0 =A0 if (likely(status & SPIFLG_RX_INTR_MASK)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rx_data =3D ioread32(davinci_spi->base + SP=
IBUF) & 0xFFFF;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi->get_rx(rx_data, davinci_spi);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi->rcount--;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((davinci_spi->version !=3D SPI_VERSION_=
2) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (likely(davinci_spi->wcount > 0)))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_word =3D 1;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0* Check for bit error, desync error,parity error,timeout=
 error and
> - =A0 =A0 =A0 =A0* receive overflow errors
> - =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 int_status =3D ioread32(davinci_spi->base + SPIFLG);
> -
> - =A0 =A0 =A0 ret =3D davinci_spi_check_error(davinci_spi, int_status);
> - =A0 =A0 =A0 if (ret !=3D 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 if (unlikely(status & SPIFLG_ERROR_MASK)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi->errors =3D (status & SPIFLG_ER=
ROR_MASK);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
> + =A0 =A0 =A0 }
>
> - =A0 =A0 =A0 /* SPI Framework maintains the count only in bytes so conve=
rt back */
> - =A0 =A0 =A0 davinci_spi->count *=3D conv;
> + =A0 =A0 =A0 if (likely(tx_word)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spidat1 =3D ioread32(davinci_spi->base + SP=
IDAT1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi->wcount--;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_data =3D davinci_spi->get_tx(davinci_spi=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spidat1 &=3D 0xFFFF0000;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spidat1 |=3D (tx_data & 0xFFFF);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iowrite32(spidat1, davinci_spi->base + SPID=
AT1);
> + =A0 =A0 =A0 }
>
> - =A0 =A0 =A0 return t->len;
> + =A0 =A0 =A0 return 0;
> =A0}
>
> -#define DAVINCI_DMA_DATA_TYPE_S8 =A0 =A0 =A0 0x01
> -#define DAVINCI_DMA_DATA_TYPE_S16 =A0 =A0 =A00x02
> -#define DAVINCI_DMA_DATA_TYPE_S32 =A0 =A0 =A00x04
> -
> -static int davinci_spi_bufs_dma(struct spi_device *spi, struct spi_trans=
fer *t)
> +/*
> + * davinci_spi_txrx_bufs - function which will handle transfer data
> + * @spi: spi device on which data transfer to be done
> + * @t: spi transfer in which transfer info is filled
> + *
> + * This function will put data to be transferred into data register
> + * of SPI controller and then wait until the completion will be marked
> + * by the IRQ Handler.
> + */
> +static int davinci_spi_txrx_bufs(struct spi_device *spi, struct spi_tran=
sfer *t)
> =A0{
> =A0 =A0 =A0 =A0struct davinci_spi *davinci_spi;
> - =A0 =A0 =A0 int int_status =3D 0;
> - =A0 =A0 =A0 int count, temp_count;
> - =A0 =A0 =A0 u8 conv =3D 1;
> - =A0 =A0 =A0 u8 tmp;
> - =A0 =A0 =A0 u32 data1_reg_val;
> - =A0 =A0 =A0 struct davinci_spi_dma *davinci_spi_dma;
> - =A0 =A0 =A0 int word_len, data_type, ret;
> - =A0 =A0 =A0 unsigned long tx_reg, rx_reg;
> + =A0 =A0 =A0 int data_type, ret =3D 0;
> + =A0 =A0 =A0 u32 tx_data, spidat1;
> + =A0 =A0 =A0 u16 tx_buf_count =3D 0, rx_buf_count =3D 0;
> + =A0 =A0 =A0 struct davinci_spi_config *spi_cfg;
> =A0 =A0 =A0 =A0struct davinci_spi_platform_data *pdata;
> + =A0 =A0 =A0 struct davinci_spi_dma *davinci_dma;
> =A0 =A0 =A0 =A0struct device *sdev;
> + =A0 =A0 =A0 dma_addr_t tx_reg, rx_reg;
> + =A0 =A0 =A0 void *tx_buf, *rx_buf;
> + =A0 =A0 =A0 struct edmacc_param rx_param, tx_param;
>
> =A0 =A0 =A0 =A0davinci_spi =3D spi_master_get_devdata(spi->master);
> =A0 =A0 =A0 =A0pdata =3D davinci_spi->pdata;
> - =A0 =A0 =A0 sdev =3D davinci_spi->bitbang.master->dev.parent;
> -
> - =A0 =A0 =A0 davinci_spi_dma =3D &davinci_spi->dma_channels[spi->chip_se=
lect];
> -
> - =A0 =A0 =A0 tx_reg =3D (unsigned long)davinci_spi->pbase + SPIDAT1;
> - =A0 =A0 =A0 rx_reg =3D (unsigned long)davinci_spi->pbase + SPIBUF;
> + =A0 =A0 =A0 spi_cfg =3D (struct davinci_spi_config *)spi->controller_da=
ta;
> + =A0 =A0 =A0 davinci_dma =3D &(davinci_spi->dma_channels);
>
> =A0 =A0 =A0 =A0davinci_spi->tx =3D t->tx_buf;
> =A0 =A0 =A0 =A0davinci_spi->rx =3D t->rx_buf;
> + =A0 =A0 =A0 davinci_spi->wcount =3D t->len / spi_cfg->bytes_per_word;
> + =A0 =A0 =A0 davinci_spi->rcount =3D davinci_spi->wcount;
> + =A0 =A0 =A0 davinci_spi->errors =3D 0;
>
> - =A0 =A0 =A0 /* convert len to words based on bits_per_word */
> - =A0 =A0 =A0 conv =3D davinci_spi->slave[spi->chip_select].bytes_per_wor=
d;
> - =A0 =A0 =A0 davinci_spi->count =3D t->len / conv;
> -
> - =A0 =A0 =A0 INIT_COMPLETION(davinci_spi->done);
> + =A0 =A0 =A0 spidat1 =3D ioread32(davinci_spi->base + SPIDAT1);
>
> - =A0 =A0 =A0 init_completion(&davinci_spi_dma->dma_rx_completion);
> - =A0 =A0 =A0 init_completion(&davinci_spi_dma->dma_tx_completion);
> -
> - =A0 =A0 =A0 word_len =3D conv * 8;
> -
> - =A0 =A0 =A0 if (word_len <=3D 8)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 data_type =3D DAVINCI_DMA_DATA_TYPE_S8;
> - =A0 =A0 =A0 else if (word_len <=3D 16)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 data_type =3D DAVINCI_DMA_DATA_TYPE_S16;
> - =A0 =A0 =A0 else if (word_len <=3D 32)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 data_type =3D DAVINCI_DMA_DATA_TYPE_S32;
> - =A0 =A0 =A0 else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> -
> - =A0 =A0 =A0 ret =3D davinci_spi_bufs_prep(spi, davinci_spi);
> - =A0 =A0 =A0 if (ret)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> -
> - =A0 =A0 =A0 /* Put delay val if required */
> - =A0 =A0 =A0 iowrite32(0 | (pdata->c2tdelay << SPI_C2TDELAY_SHIFT) |
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (pdata->t2cdelay << SPI_T2C=
DELAY_SHIFT),
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi->base + SPIDELA=
Y);
> -
> - =A0 =A0 =A0 count =3D davinci_spi->count; =A0 =A0 /* the number of elem=
ents */
> - =A0 =A0 =A0 data1_reg_val =3D pdata->cs_hold << SPIDAT1_CSHOLD_SHIFT;
> -
> - =A0 =A0 =A0 /* CS default =3D 0xFF */
> - =A0 =A0 =A0 tmp =3D ~(0x1 << spi->chip_select);
> -
> - =A0 =A0 =A0 clear_io_bits(davinci_spi->base + SPIDEF, ~tmp);
> -
> - =A0 =A0 =A0 data1_reg_val |=3D tmp << SPIDAT1_CSNR_SHIFT;
> -
> - =A0 =A0 =A0 /* disable all interrupts for dma transfers */
> - =A0 =A0 =A0 clear_io_bits(davinci_spi->base + SPIINT, SPIINT_MASKALL);
> - =A0 =A0 =A0 /* Disable SPI to write configuration bits in SPIDAT */
> - =A0 =A0 =A0 clear_io_bits(davinci_spi->base + SPIGCR1, SPIGCR1_SPIENA_M=
ASK);
> - =A0 =A0 =A0 iowrite32(data1_reg_val, davinci_spi->base + SPIDAT1);
> - =A0 =A0 =A0 /* Enable SPI */
> + =A0 =A0 =A0 clear_io_bits(davinci_spi->base + SPIGCR1, SPIGCR1_POWERDOW=
N_MASK);
> =A0 =A0 =A0 =A0set_io_bits(davinci_spi->base + SPIGCR1, SPIGCR1_SPIENA_MA=
SK);
>
> - =A0 =A0 =A0 while ((ioread32(davinci_spi->base + SPIBUF)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 & SPIBUF_RX=
EMPTY_MASK) =3D=3D 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpu_relax();
> -
> + =A0 =A0 =A0 INIT_COMPLETION(davinci_spi->done);
>
> - =A0 =A0 =A0 if (t->tx_buf) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 t->tx_dma =3D dma_map_single(&spi->dev, (vo=
id *)t->tx_buf, count,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DMA_TO_DEVI=
CE);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (dma_mapping_error(&spi->dev, t->tx_dma)=
) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(sdev, "Unable to DM=
A map a %d bytes"
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 " TX buffer=
\n", count);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> + =A0 =A0 =A0 if ((spi_cfg->io_type =3D=3D SPI_IO_TYPE_INTR) ||
> + =A0 =A0 =A0 =A0 =A0 (spi_cfg->io_type =3D=3D SPI_IO_TYPE_POLL)) {
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (spi_cfg->io_type =3D=3D SPI_IO_TYPE_INT=
R)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_io_bits(davinci_spi->ba=
se + SPIINT, SPIINT_MASKINT);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* start the transfer */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi->wcount--;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_data =3D davinci_spi->get_tx(davinci_spi=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spidat1 &=3D 0xFFFF0000;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spidat1 |=3D (tx_data & 0xFFFF);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iowrite32(spidat1, davinci_spi->base + SPID=
AT1);
> +
> + =A0 =A0 =A0 } else if (spi_cfg->io_type =3D=3D SPI_IO_TYPE_DMA) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data_type =3D spi_cfg->bytes_per_word;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_reg =3D (dma_addr_t)davinci_spi->pbase +=
 SPIDAT1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rx_reg =3D (dma_addr_t)davinci_spi->pbase +=
 SPIBUF;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (t->tx_buf) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_buf =3D ((void *)t->tx_b=
uf);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_buf_count =3D davinci_sp=
i->wcount;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_buf =3D (void *)davinci_=
spi->tmp_buf;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_buf_count =3D SPI_BUFSIZ;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_count =3D count;
> - =A0 =A0 =A0 } else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* We need TX clocking for RX transaction */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 t->tx_dma =3D dma_map_single(&spi->dev,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (void *)dav=
inci_spi->tmp_buf, count + 1,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DMA_TO_DEVI=
CE);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (dma_mapping_error(&spi->dev, t->tx_dma)=
) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(sdev, "Unable to DM=
A map a %d bytes"
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 " TX tmp bu=
ffer\n", count);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (t->rx_buf) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rx_buf =3D (void *)t->rx_bu=
f;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rx_buf_count =3D davinci_sp=
i->rcount;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rx_buf =3D (void *)davinci_=
spi->tmp_buf;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rx_buf_count =3D SPI_BUFSIZ;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_count =3D count + 1;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 t->tx_dma =3D dma_map_single(&spi->dev, tx_=
buf,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 tx_buf_count, DMA_TO_DEVICE);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 t->rx_dma =3D dma_map_single(&spi->dev, rx_=
buf,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 rx_buf_count, DMA_FROM_DEVICE);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_param.opt =3D TCINTEN | EDMA_TCC(davinci=
_dma->dma_tx_channel);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_param.src =3D t->tx_buf ? t->tx_dma : tx=
_reg;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_param.a_b_cnt =3D davinci_spi->wcount <<=
 16 | data_type;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_param.dst =3D tx_reg;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_param.src_dst_bidx =3D t->tx_buf ? data_=
type : 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_param.link_bcntrld =3D 0xffff;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_param.src_dst_cidx =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_param.ccnt =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 edma_write_slot(davinci_dma->dma_tx_channel=
, &tx_param);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 edma_link(davinci_dma->dma_tx_channel,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_dma->dummy_para=
m_slot);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rx_param.opt =3D TCINTEN | EDMA_TCC(davinci=
_dma->dma_rx_channel);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rx_param.src =3D rx_reg;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rx_param.a_b_cnt =3D davinci_spi->rcount <<=
 16 | data_type;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rx_param.dst =3D t->rx_dma;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rx_param.src_dst_bidx =3D (t->rx_buf ? data=
_type : 0) << 16;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rx_param.link_bcntrld =3D 0xffff;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rx_param.src_dst_cidx =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rx_param.ccnt =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 edma_write_slot(davinci_dma->dma_rx_channel=
, &rx_param);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iowrite16(spidat1 >> SPIDAT1_CSNR_SHIFT,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi=
->base + SPIDAT1 + 2);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 edma_start(davinci_dma->dma_rx_channel);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 edma_start(davinci_dma->dma_tx_channel);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_io_bits(davinci_spi->base + SPIINT, SPI=
INT_DMA_REQ_EN);
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 edma_set_transfer_params(davinci_spi_dma->dma_tx_channel,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 data_type, temp_count, 1, 0, ASYNC);
> - =A0 =A0 =A0 edma_set_dest(davinci_spi_dma->dma_tx_channel, tx_reg, INCR=
, W8BIT);
> - =A0 =A0 =A0 edma_set_src(davinci_spi_dma->dma_tx_channel, t->tx_dma, IN=
CR, W8BIT);
> - =A0 =A0 =A0 edma_set_src_index(davinci_spi_dma->dma_tx_channel, data_ty=
pe, 0);
> - =A0 =A0 =A0 edma_set_dest_index(davinci_spi_dma->dma_tx_channel, 0, 0);
> -
> - =A0 =A0 =A0 if (t->rx_buf) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* initiate transaction */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 iowrite32(data1_reg_val, davinci_spi->base =
+ SPIDAT1);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 t->rx_dma =3D dma_map_single(&spi->dev, (vo=
id *)t->rx_buf, count,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DMA_FROM_DE=
VICE);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (dma_mapping_error(&spi->dev, t->rx_dma)=
) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(sdev, "Couldn't DMA=
 map a %d bytes RX buffer\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 count);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (t->tx_buf !=3D NULL)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_unmap_s=
ingle(NULL, t->tx_dma,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0count, DMA_TO_DEVICE);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> + =A0 =A0 =A0 /* Wait for the transfer to complete */
> + =A0 =A0 =A0 if (spi_cfg->io_type !=3D SPI_IO_TYPE_POLL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 wait_for_completion_interruptible(&(davinci=
_spi->done));
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while ((davinci_spi->rcount > 0) && (ret =
=3D=3D 0)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D davinci_spi_process=
_events(davinci_spi);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpu_relax();
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 edma_set_transfer_params(davinci_spi_dma->d=
ma_rx_channel,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data_type, =
count, 1, 0, ASYNC);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 edma_set_src(davinci_spi_dma->dma_rx_channe=
l,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rx_reg, INC=
R, W8BIT);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 edma_set_dest(davinci_spi_dma->dma_rx_chann=
el,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 t->rx_dma, =
INCR, W8BIT);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 edma_set_src_index(davinci_spi_dma->dma_rx_=
channel, 0, 0);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 edma_set_dest_index(davinci_spi_dma->dma_rx=
_channel,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data_type, =
0);
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 if ((t->tx_buf) || (t->rx_buf))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 edma_start(davinci_spi_dma->dma_tx_channel);
> -
> - =A0 =A0 =A0 if (t->rx_buf)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 edma_start(davinci_spi_dma->dma_rx_channel);
> -
> - =A0 =A0 =A0 if ((t->rx_buf) || (t->tx_buf))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi_set_dma_req(spi, 1);
> -
> - =A0 =A0 =A0 if (t->tx_buf)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 wait_for_completion_interruptible(
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &davinci_sp=
i_dma->dma_tx_completion);
> -
> - =A0 =A0 =A0 if (t->rx_buf)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 wait_for_completion_interruptible(
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &davinci_sp=
i_dma->dma_rx_completion);
> -
> - =A0 =A0 =A0 dma_unmap_single(NULL, t->tx_dma, temp_count, DMA_TO_DEVICE=
);
> -
> - =A0 =A0 =A0 if (t->rx_buf)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_unmap_single(NULL, t->rx_dma, count, DM=
A_FROM_DEVICE);
> -
> - =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0* Check for bit error, desync error,parity error,timeout=
 error and
> - =A0 =A0 =A0 =A0* receive overflow errors
> - =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 int_status =3D ioread32(davinci_spi->base + SPIFLG);
> + =A0 =A0 =A0 clear_io_bits(davinci_spi->base + SPIINT, SPIINT_MASKALL);
> + =A0 =A0 =A0 if (spi_cfg->io_type =3D=3D SPI_IO_TYPE_DMA) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_unmap_single(NULL, t->tx_dma, tx_buf_co=
unt,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 DMA_TO_DEVICE);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_unmap_single(NULL, t->rx_dma, rx_buf_co=
unt,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 DMA_FROM_DEVICE);
> + =A0 =A0 =A0 }
>
> - =A0 =A0 =A0 ret =3D davinci_spi_check_error(davinci_spi, int_status);
> - =A0 =A0 =A0 if (ret !=3D 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 clear_io_bits(davinci_spi->base + SPIGCR1, SPIGCR1_SPIENA_M=
ASK);
> + =A0 =A0 =A0 set_io_bits(davinci_spi->base + SPIGCR1, SPIGCR1_POWERDOWN_=
MASK);
>
> - =A0 =A0 =A0 /* SPI Framework maintains the count only in bytes so conve=
rt back */
> - =A0 =A0 =A0 davinci_spi->count *=3D conv;
> + =A0 =A0 =A0 if (davinci_spi->errors) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D davinci_spi_check_error(davinci_spi=
, davinci_spi->errors);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret !=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if ((davinci_spi->rcount !=3D 0) || (davinci_spi->wcount !=
=3D 0)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdev =3D davinci_spi->bitbang.master->dev.p=
arent;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info(sdev, "SPI data transfer error\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EIO;
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0return t->len;
> =A0}
>
> -/**
> - * davinci_spi_irq - IRQ handler for DaVinci SPI
> +/*
> + * davinci_spi_irq - probe function for SPI Master Controller
> =A0* @irq: IRQ number for this SPI Master
> =A0* @context_data: structure for SPI Master controller davinci_spi
> + *
> + * ISR will determine that interrupt arrives either for READ or WRITE co=
mmand.
> + * According to command it will do the appropriate action. It will check
> + * transfer length and if it is not zero then dispatch transfer command =
again.
> + * If transfer length is zero then it will indicate the COMPLETION so th=
at
> + * davinci_spi_bufs function can go ahead.
> =A0*/
> =A0static irqreturn_t davinci_spi_irq(s32 irq, void *context_data)
> =A0{
> =A0 =A0 =A0 =A0struct davinci_spi *davinci_spi =3D context_data;
> - =A0 =A0 =A0 u32 int_status, rx_data =3D 0;
> - =A0 =A0 =A0 irqreturn_t ret =3D IRQ_NONE;
> -
> - =A0 =A0 =A0 int_status =3D ioread32(davinci_spi->base + SPIFLG);
> + =A0 =A0 =A0 int status;
>
> - =A0 =A0 =A0 while ((int_status & SPIFLG_RX_INTR_MASK)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (likely(int_status & SPIFLG_RX_INTR_MASK=
)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D IRQ_HANDLED;
> + =A0 =A0 =A0 status =3D davinci_spi_process_events(davinci_spi);
> + =A0 =A0 =A0 if (unlikely(status !=3D 0))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clear_io_bits(davinci_spi->base + SPIINT, S=
PIINT_MASKINT);
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rx_data =3D ioread32(davinc=
i_spi->base + SPIBUF);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi->get_rx(rx_data=
, davinci_spi);
> + =A0 =A0 =A0 if ((davinci_spi->rcount =3D=3D 0) || (status !=3D 0))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 complete(&(davinci_spi->done));
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Disable Receive Interrup=
t */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 iowrite32(~(SPIINT_RX_INTR =
| SPIINT_TX_INTR),
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 davinci_spi->base + SPIINT);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (void)davinci_spi_check_err=
or(davinci_spi, int_status);
> + =A0 =A0 =A0 return IRQ_HANDLED;
> +}
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 int_status =3D ioread32(davinci_spi->base +=
 SPIFLG);
> +resource_size_t davinci_spi_get_dma_by_flag(struct platform_device *dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long flag)
> +{
> + =A0 =A0 =A0 struct resource *r;
> + =A0 =A0 =A0 int i;
> +
> + =A0 =A0 =A0 for (i =3D 0; i < dev->num_resources; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D platform_get_resource(dev, IORESOURCE=
_DMA, i);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (r =3D=3D NULL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((r->flags & flag) =3D=3D flag)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return r->start;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 return DAVINCI_SPI_NO_RESOURCE;
> =A0}
>
> -/**
> +/*
> =A0* davinci_spi_probe - probe function for SPI Master Controller
> =A0* @pdev: platform_device structure which contains plateform specific d=
ata
> + *
> + * According to Linux Device Model this function will be invoked by Linux
> + * with platform_device struct which contains the device specific info.
> + * This function will map the SPI controller's memory, register IRQ,
> + * Reset SPI controller and setting its registers to default value.
> + * It will invoke spi_bitbang_start to create work queue so that client =
driver
> + * can register transfer method to work queue.
> =A0*/
> =A0static int davinci_spi_probe(struct platform_device *pdev)
> =A0{
> @@ -1016,10 +891,11 @@ static int davinci_spi_probe(struct platform_devic=
e *pdev)
> =A0 =A0 =A0 =A0struct davinci_spi *davinci_spi;
> =A0 =A0 =A0 =A0struct davinci_spi_platform_data *pdata;
> =A0 =A0 =A0 =A0struct resource *r, *mem;
> - =A0 =A0 =A0 resource_size_t dma_rx_chan =3D SPI_NO_RESOURCE;
> - =A0 =A0 =A0 resource_size_t dma_tx_chan =3D SPI_NO_RESOURCE;
> - =A0 =A0 =A0 resource_size_t dma_eventq =3D SPI_NO_RESOURCE;
> + =A0 =A0 =A0 resource_size_t dma_rx_chan =3D DAVINCI_SPI_NO_RESOURCE;
> + =A0 =A0 =A0 resource_size_t dma_tx_chan =3D DAVINCI_SPI_NO_RESOURCE;
> + =A0 =A0 =A0 resource_size_t dma_eventq =3D DAVINCI_SPI_NO_RESOURCE;
> =A0 =A0 =A0 =A0int i =3D 0, ret =3D 0;
> + =A0 =A0 =A0 u32 spipc0;
>
> =A0 =A0 =A0 =A0pdata =3D pdev->dev.platform_data;
> =A0 =A0 =A0 =A0if (pdata =3D=3D NULL) {
> @@ -1073,14 +949,16 @@ static int davinci_spi_probe(struct platform_devic=
e *pdev)
>
> =A0 =A0 =A0 =A0ret =3D request_irq(davinci_spi->irq, davinci_spi_irq, IRQ=
F_DISABLED,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_name(&pdev->dev), =
davinci_spi);
> - =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 if (ret !=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EAGAIN;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto unmap_io;
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0/* Allocate tmp_buf for tx_buf */
> =A0 =A0 =A0 =A0davinci_spi->tmp_buf =3D kzalloc(SPI_BUFSIZ, GFP_KERNEL);
> =A0 =A0 =A0 =A0if (davinci_spi->tmp_buf =3D=3D NULL) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D -ENOMEM;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto irq_free;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err1;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0davinci_spi->bitbang.master =3D spi_master_get(master);
> @@ -1104,55 +982,23 @@ static int davinci_spi_probe(struct platform_devic=
e *pdev)
>
> =A0 =A0 =A0 =A0davinci_spi->bitbang.chipselect =3D davinci_spi_chipselect;
> =A0 =A0 =A0 =A0davinci_spi->bitbang.setup_transfer =3D davinci_spi_setup_=
transfer;
> + =A0 =A0 =A0 davinci_spi->bitbang.txrx_bufs =3D davinci_spi_txrx_bufs;
>
> =A0 =A0 =A0 =A0davinci_spi->version =3D pdata->version;
> - =A0 =A0 =A0 use_dma =3D pdata->use_dma;
>
> =A0 =A0 =A0 =A0davinci_spi->bitbang.flags =3D SPI_NO_CS | SPI_LSB_FIRST |=
 SPI_LOOP;
> =A0 =A0 =A0 =A0if (davinci_spi->version =3D=3D SPI_VERSION_2)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0davinci_spi->bitbang.flags |=3D SPI_READY;
>
> - =A0 =A0 =A0 if (use_dma) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D platform_get_resource=
(pdev, IORESOURCE_DMA, 0);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (r)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_rx_chan=
 =3D r->start;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D platform_get_resource=
(pdev, IORESOURCE_DMA, 1);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (r)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_tx_chan=
 =3D r->start;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D platform_get_resource=
(pdev, IORESOURCE_DMA, 2);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (r)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_eventq =
=3D r->start;
> - =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 if (!use_dma ||
> - =A0 =A0 =A0 =A0 =A0 dma_rx_chan =3D=3D SPI_NO_RESOURCE ||
> - =A0 =A0 =A0 =A0 =A0 dma_tx_chan =3D=3D SPI_NO_RESOURCE ||
> - =A0 =A0 =A0 =A0 =A0 dma_eventq =A0=3D=3D SPI_NO_RESOURCE) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi->bitbang.txrx_bufs =3D davinci_=
spi_bufs_pio;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 use_dma =3D 0;
> - =A0 =A0 =A0 } else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi->bitbang.txrx_bufs =3D davinci_=
spi_bufs_dma;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi->dma_channels =3D kzalloc(maste=
r->num_chipselect
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * sizeof(st=
ruct davinci_spi_dma), GFP_KERNEL);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (davinci_spi->dma_channels =3D=3D NULL) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto free_clk;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < master->num_chipselect; i=
++) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi->dma_channels[i=
].dma_rx_channel =3D -1;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi->dma_channels[i=
].dma_rx_sync_dev =3D
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_rx_chan;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi->dma_channels[i=
].dma_tx_channel =3D -1;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi->dma_channels[i=
].dma_tx_sync_dev =3D
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_tx_chan;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi->dma_channels[i=
].eventq =3D dma_eventq;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info(&pdev->dev, "DaVinci SPI driver in=
 EDMA mode\n"
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Using RX c=
hannel =3D %d , TX channel =3D %d and "
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "event queu=
e =3D %d", dma_rx_chan, dma_tx_chan,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_eventq);
> - =A0 =A0 =A0 }
> + =A0 =A0 =A0 dma_rx_chan =3D davinci_spi_get_dma_by_flag(pdev, IORESOURC=
E_DMA_RX_CHAN);
> + =A0 =A0 =A0 dma_tx_chan =3D davinci_spi_get_dma_by_flag(pdev, IORESOURC=
E_DMA_TX_CHAN);
> + =A0 =A0 =A0 dma_eventq =A0=3D davinci_spi_get_dma_by_flag(pdev, IORESOU=
RCE_DMA_EVENT_Q);
> + =A0 =A0 =A0 davinci_spi->dma_channels.dma_rx_channel =3D -1;
> + =A0 =A0 =A0 davinci_spi->dma_channels.dma_rx_sync_dev =3D dma_rx_chan;
> + =A0 =A0 =A0 davinci_spi->dma_channels.dma_tx_channel =3D -1;
> + =A0 =A0 =A0 davinci_spi->dma_channels.dma_tx_sync_dev =3D dma_tx_chan;
> + =A0 =A0 =A0 davinci_spi->dma_channels.dummy_param_slot =3D -1;
> + =A0 =A0 =A0 davinci_spi->dma_channels.eventq =3D dma_eventq;
>
> =A0 =A0 =A0 =A0davinci_spi->get_rx =3D davinci_spi_rx_buf_u8;
> =A0 =A0 =A0 =A0davinci_spi->get_tx =3D davinci_spi_tx_buf_u8;
> @@ -1164,32 +1010,29 @@ static int davinci_spi_probe(struct platform_devi=
ce *pdev)
> =A0 =A0 =A0 =A0udelay(100);
> =A0 =A0 =A0 =A0iowrite32(1, davinci_spi->base + SPIGCR0);
>
> - =A0 =A0 =A0 /* Clock internal */
> - =A0 =A0 =A0 if (davinci_spi->pdata->clk_internal)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_io_bits(davinci_spi->base + SPIGCR1,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SPIGCR1_CLK=
MOD_MASK);
> - =A0 =A0 =A0 else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 clear_io_bits(davinci_spi->base + SPIGCR1,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SPIGCR1_CLK=
MOD_MASK);
> + =A0 =A0 =A0 /* Set up SPIPC0. =A0CS and ENA init is done in davinci_spi=
_setup */
> + =A0 =A0 =A0 spipc0 =3D SPIPC0_DIFUN_MASK | SPIPC0_DOFUN_MASK | SPIPC0_C=
LKFUN_MASK;
> + =A0 =A0 =A0 iowrite32(spipc0, davinci_spi->base + SPIPC0);
>
> - =A0 =A0 =A0 /* master mode default */
> - =A0 =A0 =A0 set_io_bits(davinci_spi->base + SPIGCR1, SPIGCR1_MASTER_MAS=
K);
> + =A0 =A0 =A0 /* initialize chip selects */
> + =A0 =A0 =A0 if (pdata->chip_sel !=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < pdata->num_chipselect; i+=
+) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pdata->chip_sel[i] !=3D=
 SPI_INTERN_CS)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_direct=
ion_output(pdata->chip_sel[i], 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 iowrite32(SPIDEF_CSDEF_MASK, davinci_spi->base + SPIDEF);
>
> - =A0 =A0 =A0 if (davinci_spi->pdata->intr_level)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 iowrite32(SPI_INTLVL_1, davinci_spi->base +=
 SPILVL);
> - =A0 =A0 =A0 else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 iowrite32(SPI_INTLVL_0, davinci_spi->base +=
 SPILVL);
> + =A0 =A0 =A0 set_io_bits(davinci_spi->base + SPIGCR1, SPIGCR1_CLKMOD_MAS=
K);
> + =A0 =A0 =A0 set_io_bits(davinci_spi->base + SPIGCR1, SPIGCR1_MASTER_MAS=
K);
> + =A0 =A0 =A0 set_io_bits(davinci_spi->base + SPIGCR1, SPIGCR1_POWERDOWN_=
MASK);
>
> =A0 =A0 =A0 =A0ret =3D spi_bitbang_start(&davinci_spi->bitbang);
> - =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 if (ret !=3D 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto free_clk;
>
> =A0 =A0 =A0 =A0dev_info(&pdev->dev, "Controller at 0x%p \n", davinci_spi-=
>base);
>
> - =A0 =A0 =A0 if (!pdata->poll_mode)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info(&pdev->dev, "Operating in interrup=
t mode"
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 " using IRQ %d\n", davinci_=
spi->irq);
> -
> =A0 =A0 =A0 =A0return ret;
>
> =A0free_clk:
> @@ -1199,7 +1042,7 @@ put_master:
> =A0 =A0 =A0 =A0spi_master_put(master);
> =A0free_tmp_buf:
> =A0 =A0 =A0 =A0kfree(davinci_spi->tmp_buf);
> -irq_free:
> +err1:
> =A0 =A0 =A0 =A0free_irq(davinci_spi->irq, davinci_spi);
> =A0unmap_io:
> =A0 =A0 =A0 =A0iounmap(davinci_spi->base);
> @@ -1211,7 +1054,7 @@ err:
> =A0 =A0 =A0 =A0return ret;
> =A0}
>
> -/**
> +/*
> =A0* davinci_spi_remove - remove function for SPI Master Controller
> =A0* @pdev: platform_device structure which contains plateform specific d=
ata
> =A0*
> @@ -1220,7 +1063,7 @@ err:
> =A0* It will also call spi_bitbang_stop to destroy the work queue which w=
as
> =A0* created by spi_bitbang_start.
> =A0*/
> -static int __exit davinci_spi_remove(struct platform_device *pdev)
> +static int __devexit davinci_spi_remove(struct platform_device *pdev)
> =A0{
> =A0 =A0 =A0 =A0struct davinci_spi *davinci_spi;
> =A0 =A0 =A0 =A0struct spi_master *master;
> @@ -1242,8 +1085,11 @@ static int __exit davinci_spi_remove(struct platfo=
rm_device *pdev)
> =A0}
>
> =A0static struct platform_driver davinci_spi_driver =3D {
> - =A0 =A0 =A0 .driver.name =3D "spi_davinci",
> - =A0 =A0 =A0 .remove =3D __exit_p(davinci_spi_remove),
> + =A0 =A0 =A0 .driver =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "spi_davinci",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =3D THIS_MODULE,
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 .remove =3D __devexit_p(davinci_spi_remove),
> =A0};
>
> =A0static int __init davinci_spi_init(void)
> --
> 1.6.3.3
>
>



-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

---------------------------------------------------------------------------=
---
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
