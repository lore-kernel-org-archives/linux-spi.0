From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] SPI: moved the PL022 test chip out
	to the SPI subsystem v2
Date: Sun, 1 Aug 2010 01:29:30 -0600
Message-ID: <AANLkTimD=MTn-=EB1Kt87tz9bSVUq+mbZwoOxDbG5sbr@mail.gmail.com>
References: <1280045963-10564-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1280045963-10564-1-git-send-email-linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Sun, Jul 25, 2010 at 2:19 AM, Linus Walleij
<linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org> wrote:
> This moves the SPI test chip from the U300 architecture to the
> SPI subsystem. This is where the code belongs: we want the
> loopback test chip to be available to all users of PL022.
>
> Signed-off-by: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>

Hi Linus, thanks for the quick respin.

Better, but not quite right yet in my opinion.  With the code now
embedded into the driver (which I agree with), there is no need to
create a dummy spi_device any more.  What is this code intended to
test?  The hardware, or the spi subsystem.  If it is to test the
hardware (which I suspect), then just driver the hardware directly
(using the driver's own access functions of course).  You don't need
to register a dummy spi_device for that because it is all driver
internal.

If it goal is to exercise the spi subsystem, then do it from userspace
with the loopback flag set, and add loopback flag support to the
driver.  You don't need to test all the modes of the hardware in this
situation.

g.

> ---
> Changes v1->v2:
> - Moved into the PL022 driver instead of keeping this as a module
> =A0so as not to set bad examples for SPI chips
> - Moved test triggers and report to debugfs and create a unique
> =A0file there
> - One, bisectable patch only
> - Folded in a bad malloc() check fix mailed during review
> ---
> =A0arch/arm/mach-u300/Kconfig =A0| =A0 12 --
> =A0arch/arm/mach-u300/Makefile | =A0 =A01 -
> =A0arch/arm/mach-u300/spi.c =A0 =A0| =A0 61 -------
> =A0drivers/spi/Kconfig =A0 =A0 =A0 =A0 | =A0 14 ++
> =A0drivers/spi/amba-pl022.c =A0 =A0| =A0369 +++++++++++++++++++++++++++++=
+++++++++++++-
> =A05 files changed, 382 insertions(+), 75 deletions(-)
>
> diff --git a/arch/arm/mach-u300/Kconfig b/arch/arm/mach-u300/Kconfig
> index 801b21e..337b9aa 100644
> --- a/arch/arm/mach-u300/Kconfig
> +++ b/arch/arm/mach-u300/Kconfig
> @@ -81,18 +81,6 @@ config MACH_U300_SEMI_IS_SHARED
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Memory Interface) from both from access an=
d application
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0side.
>
> -config MACH_U300_SPIDUMMY
> - =A0 =A0 =A0 bool "SSP/SPI dummy chip"
> - =A0 =A0 =A0 select SPI
> - =A0 =A0 =A0 select SPI_MASTER
> - =A0 =A0 =A0 select SPI_PL022
> - =A0 =A0 =A0 help
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 This creates a small kernel module that cre=
ates a dummy
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 SPI device to be used for loopback tests. R=
egularly used
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 to test reference designs. If you're not te=
sting SPI,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 you don't need it. Selecting this will acti=
vate the
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 SPI framework and ARM PL022 support.
> -
> =A0comment "All the settings below must match the bootloader's settings"
>
> =A0config MACH_U300_ACCESS_MEM_SIZE
> diff --git a/arch/arm/mach-u300/Makefile b/arch/arm/mach-u300/Makefile
> index fab46fe..1f0f4b8 100644
> --- a/arch/arm/mach-u300/Makefile
> +++ b/arch/arm/mach-u300/Makefile
> @@ -10,6 +10,5 @@ obj- =A0 =A0 =A0 =A0 =A0:=3D
> =A0obj-$(CONFIG_ARCH_U300) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D u300.o
> =A0obj-$(CONFIG_MMC) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D mmc.o
> =A0obj-$(CONFIG_SPI_PL022) =A0 =A0 =A0 =A0 =A0 +=3D spi.o
> -obj-$(CONFIG_MACH_U300_SPIDUMMY) =A0+=3D dummyspichip.o
> =A0obj-$(CONFIG_I2C_STU300) =A0 =A0 =A0 =A0 =A0+=3D i2c.o
> =A0obj-$(CONFIG_REGULATOR_AB3100) =A0 =A0+=3D regulator.o
> diff --git a/arch/arm/mach-u300/spi.c b/arch/arm/mach-u300/spi.c
> index f0e887b..0790cce 100644
> --- a/arch/arm/mach-u300/spi.c
> +++ b/arch/arm/mach-u300/spi.c
> @@ -16,68 +16,8 @@
> =A0/*
> =A0* The following is for the actual devices on the SSP/SPI bus
> =A0*/
> -#ifdef CONFIG_MACH_U300_SPIDUMMY
> -static void select_dummy_chip(u32 chipselect)
> -{
> - =A0 =A0 =A0 pr_debug("CORE: %s called with CS=3D0x%x (%s)\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0chipselect,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0chipselect ? "unselect chip" : "select c=
hip");
> - =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0* Here you would write the chip select value to the GPIO=
 pins if
> - =A0 =A0 =A0 =A0* this was a real chip (but this is a loopback dummy).
> - =A0 =A0 =A0 =A0*/
> -}
> -
> -struct pl022_config_chip dummy_chip_info =3D {
> - =A0 =A0 =A0 /* Nominally this is LOOPBACK_DISABLED, but this is our dum=
my chip! */
> - =A0 =A0 =A0 .lbm =3D LOOPBACK_ENABLED,
> - =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0* available POLLING_TRANSFER and INTERRUPT_TRANSFER,
> - =A0 =A0 =A0 =A0* DMA_TRANSFER does not work
> - =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 .com_mode =3D INTERRUPT_TRANSFER,
> - =A0 =A0 =A0 .iface =3D SSP_INTERFACE_MOTOROLA_SPI,
> - =A0 =A0 =A0 /* We can only act as master but SSP_SLAVE is possible in t=
heory */
> - =A0 =A0 =A0 .hierarchy =3D SSP_MASTER,
> - =A0 =A0 =A0 /* 0 =3D drive TX even as slave, 1 =3D do not drive TX as s=
lave */
> - =A0 =A0 =A0 .slave_tx_disable =3D 0,
> - =A0 =A0 =A0 /* LSB first */
> - =A0 =A0 =A0 .endian_tx =3D SSP_TX_LSB,
> - =A0 =A0 =A0 .endian_rx =3D SSP_RX_LSB,
> - =A0 =A0 =A0 .data_size =3D SSP_DATA_BITS_8, /* used to be 12 in some de=
fault */
> - =A0 =A0 =A0 .rx_lev_trig =3D SSP_RX_1_OR_MORE_ELEM,
> - =A0 =A0 =A0 .tx_lev_trig =3D SSP_TX_1_OR_MORE_EMPTY_LOC,
> - =A0 =A0 =A0 .clk_phase =3D SSP_CLK_SECOND_EDGE,
> - =A0 =A0 =A0 .clk_pol =3D SSP_CLK_POL_IDLE_LOW,
> - =A0 =A0 =A0 .ctrl_len =3D SSP_BITS_12,
> - =A0 =A0 =A0 .wait_state =3D SSP_MWIRE_WAIT_ZERO,
> - =A0 =A0 =A0 .duplex =3D SSP_MICROWIRE_CHANNEL_FULL_DUPLEX,
> - =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0* This is where you insert a call to a function to enabl=
e CS
> - =A0 =A0 =A0 =A0* (usually GPIO) for a certain chip.
> - =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 .cs_control =3D select_dummy_chip,
> -};
> -#endif
>
> =A0static struct spi_board_info u300_spi_devices[] =3D {
> -#ifdef CONFIG_MACH_U300_SPIDUMMY
> - =A0 =A0 =A0 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* A dummy chip used for loopback tests */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .modalias =A0 =A0 =A0 =3D "spi-dummy",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Really dummy, pass in additional chip co=
nfig here */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .platform_data =A0=3D NULL,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* This defines how the controller shall ha=
ndle the device */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .controller_data =3D &dummy_chip_info,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* .irq - no external IRQ routed from this =
device */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .max_speed_hz =A0 =3D 1000000,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .bus_num =A0 =A0 =A0 =A0=3D 0, /* Only one =
bus on this chip */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .chip_select =A0 =A0=3D 0,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Means SPI_CS_HIGH, change if e.g low CS =
*/
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .mode =A0 =A0 =A0 =A0 =A0 =3D 0,
> - =A0 =A0 =A0 },
> -#endif
> =A0};
>
> =A0static struct pl022_ssp_controller ssp_platform_data =3D {
> @@ -94,7 +34,6 @@ static struct pl022_ssp_controller ssp_platform_data =
=3D {
> =A0 =A0 =A0 =A0.num_chipselect =3D 3,
> =A0};
>
> -
> =A0void __init u300_spi_init(struct amba_device *adev)
> =A0{
> =A0 =A0 =A0 =A0struct pmx *pmx;
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 91c2f4f..8f01be6 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -227,6 +227,20 @@ config SPI_PL022
> =A0 =A0 =A0 =A0 =A0controller. If you have an embedded system with an AMB=
A(R)
> =A0 =A0 =A0 =A0 =A0bus and a PL022 controller, say Y or M here.
>
> +config SPI_PL022_LOOPTEST
> + =A0 =A0 =A0 bool "PL022 loopback test"
> + =A0 =A0 =A0 depends on SPI_PL022
> + =A0 =A0 =A0 select DEBUG_FS
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 The PL022 supports a loopback mode where the output is
> + =A0 =A0 =A0 =A0 looped back to the input for testing.
> +
> + =A0 =A0 =A0 =A0 This creates a small kernel module that creates a dummy
> + =A0 =A0 =A0 =A0 SPI device on each PL022 SPI bus to be used for loopback
> + =A0 =A0 =A0 =A0 tests. You find the device in the /sys filesystem, e.g.
> + =A0 =A0 =A0 =A0 /sys/bus/spi/devices/spi0.0/looptest and the test is ru=
n by
> + =A0 =A0 =A0 =A0 issuing cat <looptest>.
> +
> =A0config SPI_PPC4xx
> =A0 =A0 =A0 =A0tristate "PPC4xx SPI Controller"
> =A0 =A0 =A0 =A0depends on PPC32 && 4xx && SPI_MASTER
> diff --git a/drivers/spi/amba-pl022.c b/drivers/spi/amba-pl022.c
> index f0a1418..68e3943 100644
> --- a/drivers/spi/amba-pl022.c
> +++ b/drivers/spi/amba-pl022.c
> @@ -3,7 +3,7 @@
> =A0*
> =A0* A driver for the ARM PL022 PrimeCell SSP/SPI bus master.
> =A0*
> - * Copyright (C) 2008-2009 ST-Ericsson AB
> + * Copyright (C) 2008-2010 ST-Ericsson AB
> =A0* Copyright (C) 2006 STMicroelectronics Pvt. Ltd.
> =A0*
> =A0* Author: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
> @@ -45,6 +45,8 @@
> =A0#include <linux/amba/pl022.h>
> =A0#include <linux/io.h>
> =A0#include <linux/slab.h>
> +#include <linux/debugfs.h>
> +#include <linux/seq_file.h>
>
> =A0/*
> =A0* This macro is used to define some register default values.
> @@ -337,6 +339,8 @@ struct vendor_data {
> =A0* @virtbase: The virtual memory where the SSP is mapped
> =A0* @master: SPI framework hookup
> =A0* @master_info: controller-specific data from machine setup
> + * @loopdev: loopback device used for testing
> + * @loopdev_file: dentry holding the debugfs file used for testing
> =A0* @regs: SSP controller register's virtual address
> =A0* @pump_messages: Work struct for scheduling work to the workqueue
> =A0* @lock: spinlock to syncronise access to driver data
> @@ -362,6 +366,7 @@ struct pl022 {
> =A0 =A0 =A0 =A0struct clk =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*clk;
> =A0 =A0 =A0 =A0struct spi_master =A0 =A0 =A0 =A0 =A0 =A0 =A0 *master;
> =A0 =A0 =A0 =A0struct pl022_ssp_controller =A0 =A0 *master_info;
> + =A0 =A0 =A0 struct spi_device =A0 =A0 =A0 =A0 =A0 =A0 =A0 *loopdev;
> =A0 =A0 =A0 =A0/* Driver message queue */
> =A0 =A0 =A0 =A0struct workqueue_struct =A0 =A0 =A0 =A0 *workqueue;
> =A0 =A0 =A0 =A0struct work_struct =A0 =A0 =A0 =A0 =A0 =A0 =A0pump_message=
s;
> @@ -1722,6 +1727,355 @@ static void pl022_cleanup(struct spi_device *spi)
> =A0 =A0 =A0 =A0kfree(chip);
> =A0}
>
> +/*
> + * The following code self-registers the PL022 loopback
> + * chip on each PL022 SPI bus if desired.
> + */
> +#ifdef CONFIG_SPI_PL022_LOOPTEST
> +
> +struct pl022_loopback {
> + =A0 =A0 =A0 struct device *dev;
> + =A0 =A0 =A0 struct mutex lock;
> + =A0 =A0 =A0 struct dentry *file;
> +};
> +
> +#define DMA_TEST_SIZE 2048
> +
> +static void pl022_select_loopback_chip(u32 chipselect)
> +{
> + =A0 =A0 =A0 pr_debug("PL022 loopback chip: %s called with CS=3D0x%x (%s=
)\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0chipselect,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0chipselect ? "unselect chip" : "select c=
hip");
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Here you would write the chip select value to the GPIO=
 pins if
> + =A0 =A0 =A0 =A0* this was a real chip (but this is a loopback dummy).
> + =A0 =A0 =A0 =A0*/
> +}
> +
> +struct pl022_config_chip pl022_loopback_chip_info =3D {
> + =A0 =A0 =A0 /* Nominally this is LOOPBACK_DISABLED, but this is our dum=
my chip! */
> + =A0 =A0 =A0 .lbm =3D LOOPBACK_ENABLED,
> + =A0 =A0 =A0 .com_mode =3D INTERRUPT_TRANSFER,
> + =A0 =A0 =A0 .iface =3D SSP_INTERFACE_MOTOROLA_SPI,
> + =A0 =A0 =A0 .hierarchy =3D SSP_MASTER,
> + =A0 =A0 =A0 .slave_tx_disable =3D 0,
> + =A0 =A0 =A0 /* LSB first */
> + =A0 =A0 =A0 .endian_tx =3D SSP_TX_LSB,
> + =A0 =A0 =A0 .endian_rx =3D SSP_RX_LSB,
> + =A0 =A0 =A0 .data_size =3D SSP_DATA_BITS_8,
> + =A0 =A0 =A0 .rx_lev_trig =3D SSP_RX_1_OR_MORE_ELEM,
> + =A0 =A0 =A0 .tx_lev_trig =3D SSP_TX_1_OR_MORE_EMPTY_LOC,
> + =A0 =A0 =A0 .clk_phase =3D SSP_CLK_SECOND_EDGE,
> + =A0 =A0 =A0 .clk_pol =3D SSP_CLK_POL_IDLE_LOW,
> + =A0 =A0 =A0 .ctrl_len =3D SSP_BITS_12,
> + =A0 =A0 =A0 .wait_state =3D SSP_MWIRE_WAIT_ZERO,
> + =A0 =A0 =A0 .duplex =3D SSP_MICROWIRE_CHANNEL_FULL_DUPLEX,
> + =A0 =A0 =A0 .cs_control =3D pl022_select_loopback_chip,
> +};
> +
> +static struct spi_board_info pl022_loopback_device =3D {
> + =A0 =A0 =A0 /* A dummy chip used for loopback tests */
> + =A0 =A0 =A0 .modalias =A0 =A0 =A0 =3D "pl022-loop",
> + =A0 =A0 =A0 /* Really dummy, pass in additional chip config here */
> + =A0 =A0 =A0 .platform_data =A0=3D NULL,
> + =A0 =A0 =A0 /* This defines how the controller shall handle the device =
*/
> + =A0 =A0 =A0 .controller_data =3D &pl022_loopback_chip_info,
> + =A0 =A0 =A0 /* .irq - no external IRQ routed from this device */
> + =A0 =A0 =A0 .max_speed_hz =A0 =3D 1000000,
> + =A0 =A0 =A0 .bus_num =A0 =A0 =A0 =A0=3D 0, /* Only one bus on this chip=
 */
> + =A0 =A0 =A0 .chip_select =A0 =A0=3D 0,
> + =A0 =A0 =A0 /* Means SPI_CS_HIGH, change if e.g low CS */
> + =A0 =A0 =A0 .mode =A0 =A0 =A0 =A0 =A0 =3D 0,
> +};
> +
> +/*
> + * This is where the tests begin. When we issue:
> + * cat /sys/bus/spi/devices/spi0.0/looptest
> + * this will be triggered.
> + */
> +static int pl022_looptest(struct seq_file *s, void *data)
> +{
> + =A0 =A0 =A0 struct spi_device *spi =3D s->private;
> + =A0 =A0 =A0 struct pl022_loopback *p_loop =3D dev_get_drvdata(&spi->dev=
);
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* WARNING! Do not dereference the chip-specific data in =
any normal
> + =A0 =A0 =A0 =A0* driver for a chip. It is usually STATIC and shall not =
be read
> + =A0 =A0 =A0 =A0* or written to. Your chip driver should NOT depend on f=
ields in this
> + =A0 =A0 =A0 =A0* struct, this is just used here to alter the behaviour =
of the chip
> + =A0 =A0 =A0 =A0* in order to perform tests.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 struct pl022_config_chip *chip_info =3D spi->controller_dat=
a;
> + =A0 =A0 =A0 int status;
> + =A0 =A0 =A0 u8 txbuf[14] =3D {0xDE, 0xAD, 0xBE, 0xEF, 0x2B, 0xAD,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0xCA, 0xFE, 0xBA, 0xBE, 0xB=
1, 0x05,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0xF0, 0x0D};
> + =A0 =A0 =A0 u8 rxbuf[14];
> + =A0 =A0 =A0 u8 *bigtxbuf_virtual =3D NULL;
> + =A0 =A0 =A0 u8 *bigrxbuf_virtual =3D NULL;
> +
> + =A0 =A0 =A0 if (mutex_lock_interruptible(&p_loop->lock))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ERESTARTSYS;
> +
> + =A0 =A0 =A0 bigtxbuf_virtual =3D kmalloc(DMA_TEST_SIZE, GFP_KERNEL);
> + =A0 =A0 =A0 if (bigtxbuf_virtual =3D=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 bigrxbuf_virtual =3D kmalloc(DMA_TEST_SIZE, GFP_KERNEL);
> + =A0 =A0 =A0 if (bigrxbuf_virtual =3D=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Fill TXBUF with some happy pattern */
> + =A0 =A0 =A0 memset(bigtxbuf_virtual, 0xAA, DMA_TEST_SIZE);
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Force chip to 8 bit mode
> + =A0 =A0 =A0 =A0* WARNING: NEVER DO THIS IN REAL DRIVER CODE, THIS SHOUL=
D BE STATIC!
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 chip_info->data_size =3D SSP_DATA_BITS_8;
> + =A0 =A0 =A0 /* You should NOT DO THIS EITHER */
> + =A0 =A0 =A0 spi->master->setup(spi);
> +
> + =A0 =A0 =A0 /* Now run the tests for 8bit mode */
> + =A0 =A0 =A0 seq_printf(s, "Simple test 1: write 0xAA byte, read back ga=
rbage byte "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "in 8bit mode\n");
> + =A0 =A0 =A0 status =3D spi_w8r8(spi, 0xAA);
> + =A0 =A0 =A0 if (status < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 seq_printf(s, "Siple test 1: FAILURE: spi_w=
rite_then_read "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"failed with status =
%d\n", status);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 seq_printf(s, "Simple test 1: SUCCESS!\n");
> +
> + =A0 =A0 =A0 seq_printf(s, "Simple test 2: write 8 bytes, read back 8 by=
tes garbage "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "in 8bit mode (full FIFO)\n");
> + =A0 =A0 =A0 status =3D spi_write_then_read(spi, &txbuf[0], 8, &rxbuf[0]=
, 8);
> + =A0 =A0 =A0 if (status < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 seq_printf(s, "Simple test 2: FAILURE: spi_=
write_then_read() "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"failed with status =
%d\n", status);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 seq_printf(s, "Simple test 2: SUCCESS!\n");
> +
> + =A0 =A0 =A0 seq_printf(s, "Simple test 3: write 14 bytes, read back 14 =
bytes "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"garbage in 8bit mode (see if we ove=
rflow FIFO)\n");
> + =A0 =A0 =A0 status =3D spi_write_then_read(spi, &txbuf[0], 14, &rxbuf[0=
], 14);
> + =A0 =A0 =A0 if (status < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 seq_printf(s, "Simple test 3: FAILURE: fail=
ed with status %d "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"(probably FIFO over=
run)\n", status);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 seq_printf(s, "Simple test 3: SUCCESS!\n");
> +
> + =A0 =A0 =A0 seq_printf(s, "Simple test 4: write 8 bytes with spi_write(=
), read 8 "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "bytes garbage with spi_read() in 8bit mode=
\n");
> + =A0 =A0 =A0 status =3D spi_write(spi, &txbuf[0], 8);
> + =A0 =A0 =A0 if (status < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 seq_printf(s, "Simple test 4 step 1: FAILUR=
E: spi_write() "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"failed with status =
%d\n", status);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 seq_printf(s, "Simple test 4 step 1: SUCCES=
S!\n");
> + =A0 =A0 =A0 status =3D spi_read(spi, &rxbuf[0], 8);
> + =A0 =A0 =A0 if (status < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 seq_printf(s, "Simple test 4 step 2: FAILUR=
E: spi_read() "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"failed with status =
%d\n", status);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 seq_printf(s, "Simple test 4 step 2: SUCCES=
S!\n");
> +
> + =A0 =A0 =A0 seq_printf(s, "Simple test 5: write 14 bytes with spi_write=
(), read "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "14 bytes garbage with spi_read() in 8bit m=
ode\n");
> + =A0 =A0 =A0 status =3D spi_write(spi, &txbuf[0], 14);
> + =A0 =A0 =A0 if (status < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 seq_printf(s, "Simple test 5 step 1: FAILUR=
E: spi_write() "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"failed with status =
%d (probably FIFO overrun)\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0status);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 seq_printf(s, "Simple test 5 step 1: SUCCES=
S!\n");
> + =A0 =A0 =A0 status =3D spi_read(spi, &rxbuf[0], 14);
> + =A0 =A0 =A0 if (status < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 seq_printf(s, "Simple test 5 step 2: FAILUR=
E: spi_read() "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"failed with status =
%d (probably FIFO overrun)\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0status);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 seq_printf(s, "Simple test 5: SUCCESS!\n");
> +
> + =A0 =A0 =A0 seq_printf(s, "Simple test 6: write %d bytes with spi_write=
(), "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "read %d bytes garbage with spi_read() in 8=
bit mode\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 DMA_TEST_SIZE, DMA_TEST_SIZE);
> + =A0 =A0 =A0 status =3D spi_write(spi, &bigtxbuf_virtual[0], DMA_TEST_SI=
ZE);
> + =A0 =A0 =A0 if (status < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 seq_printf(s, "Simple test 6 step 1: FAILUR=
E: spi_write() "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"failed with status =
%d (probably FIFO overrun)\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0status);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 seq_printf(s, "Simple test 6 step 1: SUCCES=
S!\n");
> + =A0 =A0 =A0 status =3D spi_read(spi, &bigrxbuf_virtual[0], DMA_TEST_SIZ=
E);
> + =A0 =A0 =A0 if (status < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 seq_printf(s, "Simple test 6 step 2: FAILUR=
E: spi_read() "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"failed with status =
%d (probably FIFO overrun)\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0status);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 seq_printf(s, "Simple test 6: SUCCESS!\n");
> +
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Force chip to 16 bit mode
> + =A0 =A0 =A0 =A0* WARNING: NEVER DO THIS IN REAL DRIVER CODE, THIS SHOUL=
D BE STATIC!
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 chip_info->data_size =3D SSP_DATA_BITS_16;
> + =A0 =A0 =A0 /* You should NOT DO THIS EITHER */
> + =A0 =A0 =A0 spi->master->setup(spi);
> +
> + =A0 =A0 =A0 seq_printf(s, "Simple test 7: write 0xAA byte, read back ga=
rbage byte "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "in 16bit bus mode\n");
> + =A0 =A0 =A0 status =3D spi_w8r8(spi, 0xAA);
> + =A0 =A0 =A0 if (status =3D=3D -EIO)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 seq_printf(s, "Simple test 7: SUCCESS! (exp=
ected failure with "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "status EIO)\n");
> + =A0 =A0 =A0 else if (status < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 seq_printf(s, "Siple test 7: FAILURE: spi_w=
rite_then_read "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"failed with status =
%d\n", status);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 seq_printf(s, "Simple test 7: FAILURE: spi_=
write_then_read "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"succeeded but it wa=
s expected to fail!\n");
> +
> + =A0 =A0 =A0 seq_printf(s, "Simple test 8: write 8 bytes, read back 8 by=
tes garbage "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "in 16bit mode (full FIFO)\n");
> + =A0 =A0 =A0 status =3D spi_write_then_read(spi, &txbuf[0], 8, &rxbuf[0]=
, 8);
> + =A0 =A0 =A0 if (status < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 seq_printf(s, "Simple test 8: FAILURE: spi_=
write_then_read() "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"failed with status =
%d\n", status);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 seq_printf(s, "Simple test 8: SUCCESS!\n");
> +
> + =A0 =A0 =A0 seq_printf(s, "Simple test 9: write 14 bytes, read back 14 =
bytes "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "garbage in 16bit mode (see if we overflow =
FIFO)\n");
> + =A0 =A0 =A0 status =3D spi_write_then_read(spi, &txbuf[0], 14, &rxbuf[0=
], 14);
> + =A0 =A0 =A0 if (status < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 seq_printf(s, "Simple test 9: FAILURE: fail=
ed with status %d "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"(probably FIFO over=
run)\n", status);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 seq_printf(s, "Simple test 9: SUCCESS!\n");
> +
> + =A0 =A0 =A0 seq_printf(s, "Simple test 10: write %d bytes with spi_writ=
e(), "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0"read %d bytes garbage with spi_read() in 16=
bit mode\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0DMA_TEST_SIZE, DMA_TEST_SIZE);
> + =A0 =A0 =A0 status =3D spi_write(spi, &bigtxbuf_virtual[0], DMA_TEST_SI=
ZE);
> + =A0 =A0 =A0 if (status < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 seq_printf(s, "Simple test 10 step 1: FAILU=
RE: spi_write() "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"failed with status =
%d (probably FIFO overrun)\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0status);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 seq_printf(s, "Simple test 10 step 1: SUCCE=
SS!\n");
> +
> + =A0 =A0 =A0 status =3D spi_read(spi, &bigrxbuf_virtual[0], DMA_TEST_SIZ=
E);
> + =A0 =A0 =A0 if (status < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 seq_printf(s, "Simple test 10 step 2: FAILU=
RE: spi_read() "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"failed with status =
%d (probably FIFO overrun)\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0status);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 seq_printf(s, "Simple test 10: SUCCESS!\n");
> +
> + =A0 =A0 =A0 seq_printf(s, "loop test complete\n");
> + out:
> + =A0 =A0 =A0 kfree(bigrxbuf_virtual);
> + =A0 =A0 =A0 kfree(bigtxbuf_virtual);
> + =A0 =A0 =A0 mutex_unlock(&p_loop->lock);
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int pl022_looptest_open(struct inode *inode, struct file *file)
> +{
> + =A0 =A0 =A0 return single_open(file, pl022_looptest, inode->i_private);
> +}
> +
> +static const struct file_operations pl022_looptest_operations =3D {
> + =A0 =A0 =A0 .open =A0 =A0 =A0 =A0 =A0 =3D pl022_looptest_open,
> + =A0 =A0 =A0 .read =A0 =A0 =A0 =A0 =A0 =3D seq_read,
> + =A0 =A0 =A0 .llseek =A0 =A0 =A0 =A0 =3D seq_lseek,
> + =A0 =A0 =A0 .release =A0 =A0 =A0 =A0=3D single_release,
> + =A0 =A0 =A0 .owner =A0 =A0 =A0 =A0 =A0=3D THIS_MODULE,
> +};
> +
> +/*
> + * This is called from the PL022 driver to register a loopback
> + * on itself if this module is compiled in.
> + */
> +static struct spi_device * __init
> +pl022_loopback_probe(struct spi_master *master)
> +{
> + =A0 =A0 =A0 struct pl022_loopback *p_loop;
> + =A0 =A0 =A0 struct spi_device *spidev;
> + =A0 =A0 =A0 char *filename;
> + =A0 =A0 =A0 int status;
> +
> + =A0 =A0 =A0 spidev =3D spi_new_device(master, &pl022_loopback_device);
> + =A0 =A0 =A0 if (!spidev) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&master->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "could not register loopbac=
k test chip\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ERR_PTR(-ENOMEM);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 dev_info(&spidev->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"registered loopback test chip\n");
> +
> + =A0 =A0 =A0 p_loop =3D kzalloc(sizeof *p_loop, GFP_KERNEL);
> + =A0 =A0 =A0 if (!p_loop) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out_dev_create_looptest_failed;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 dev_set_drvdata(&spidev->dev, p_loop);
> + =A0 =A0 =A0 mutex_init(&p_loop->lock);
> +
> + =A0 =A0 =A0 /* debugfs hook */
> + =A0 =A0 =A0 filename =3D kasprintf(GFP_KERNEL, "%s-looptest", dev_name(=
&spidev->dev));
> + =A0 =A0 =A0 if (!filename) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out_dev_create_looptest_failed;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 p_loop->file =3D debugfs_create_file(filename, S_IFREG | S_=
IRUGO,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0NULL, spidev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0&pl022_looptest_operations);
> + =A0 =A0 =A0 kfree(filename);
> +
> + =A0 =A0 =A0 if (!p_loop->file) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&spidev->dev, "couldn't create debu=
gfs file\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D -EIO;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out_dev_create_looptest_failed;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return spidev;
> +
> +out_dev_create_looptest_failed:
> + =A0 =A0 =A0 dev_set_drvdata(&spidev->dev, NULL);
> + =A0 =A0 =A0 spi_unregister_device(spidev);
> + =A0 =A0 =A0 kfree(p_loop);
> + =A0 =A0 =A0 return ERR_PTR(status);
> +}
> +
> +static void __exit pl022_loopback_remove(struct spi_device *spi)
> +{
> + =A0 =A0 =A0 struct pl022_loopback *p_loop =3D dev_get_drvdata(&spi->dev=
);
> +
> + =A0 =A0 =A0 dev_info(&spi->dev, "removing loopback SPI device\n");
> + =A0 =A0 =A0 debugfs_remove(p_loop->file);
> + =A0 =A0 =A0 dev_set_drvdata(&spi->dev, NULL);
> + =A0 =A0 =A0 spi_unregister_device(spi);
> + =A0 =A0 =A0 kfree(p_loop);
> +}
> +#else
> +inline struct spi_device *pl022_loopback_probe(struct spi_master *master)
> +{
> + =A0 =A0 =A0 return NULL;
> +}
> +
> +inline void pl022_loopback_remove(struct spi_device *spi)
> +{
> +}
> +#endif
>
> =A0static int __init
> =A0pl022_probe(struct amba_device *adev, struct amba_id *id)
> @@ -1818,8 +2172,18 @@ pl022_probe(struct amba_device *adev, struct amba_=
id *id)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_spi_register;
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0dev_dbg(dev, "probe succeded\n");
> +
> + =A0 =A0 =A0 /* Register a loopback test if desired - PL023 does not hav=
e loopback */
> + =A0 =A0 =A0 if (!pl022->vendor->pl023) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pl022->loopdev =3D pl022_loopback_probe(mas=
ter);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (IS_ERR(pl022->loopdev))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_loopback;
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0return 0;
>
> + err_loopback:
> + =A0 =A0 =A0 spi_unregister_master(master);
> =A0err_spi_register:
> =A0err_start_queue:
> =A0err_init_queue:
> @@ -1846,6 +2210,9 @@ pl022_remove(struct amba_device *adev)
> =A0 =A0 =A0 =A0if (!pl022)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
>
> + =A0 =A0 =A0 /* Remove any loopback */
> + =A0 =A0 =A0 pl022_loopback_remove(pl022->loopdev);
> +
> =A0 =A0 =A0 =A0/* Remove the queue */
> =A0 =A0 =A0 =A0status =3D destroy_queue(pl022);
> =A0 =A0 =A0 =A0if (status !=3D 0) {
> --
> 1.7.1.1
>
>



-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

---------------------------------------------------------------------------=
---
The Palm PDK Hot Apps Program offers developers who use the
Plug-In Development Kit to bring their C/C++ apps to Palm for a share
of $1 Million in cash or HP Products. Visit us here for more details:
http://p.sf.net/sfu/dev2dev-palm
