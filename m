From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/2] SPI: make the moved loopback test work
Date: Sun, 18 Jul 2010 23:51:20 -0600
Message-ID: <AANLkTikfwTxZ4iMaveddXLd1Z2phF0hVi_yG7A2wUNCo@mail.gmail.com>
References: <1278809005-29948-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general@lists.sourceforge.net,
	linux-arm-kernel@lists.infradead.org
To: Linus Walleij <linus.walleij@stericsson.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1278809005-29948-1-git-send-email-linus.walleij@stericsson.com>
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

On Sat, Jul 10, 2010 at 6:43 PM, Linus Walleij
<linus.walleij@stericsson.com> wrote:
> This completes the move of the SPI test chip out of the U300
> architecture by modifying the loopback test to register itself on
> every PL022 master if it is compiled in. Also updates some minor
> things like naming to make the code stricter.
>
> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>

Having a test driver in common code that purposefully does bad things
is a sure fire way to get people to copy those bad practices when they
write their own drivers (despite all the comments in the code that say
don't do this).  I'm talking about things like the dereferencing of
controller data, and calling the setup() hook in something that looks
like a normal spi_device driver.  As-is, I'm not excited about merging
this patch (and it isn't bisectable either).

If you want this loopback functionality, It should be integrated into
the pl022 driver itself.  It should not pretend to be an spi_device.

> ---
> =A0arch/arm/mach-u300/Kconfig =A0 =A0 =A0 =A0| =A0 12 ----
> =A0arch/arm/mach-u300/Makefile =A0 =A0 =A0 | =A0 =A01 -
> =A0arch/arm/mach-u300/spi.c =A0 =A0 =A0 =A0 =A0| =A0 61 -----------------=
--
> =A0drivers/spi/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 13 ++++
> =A0drivers/spi/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A01 +
> =A0drivers/spi/amba-pl022-looptest.c | =A0120 +++++++++++++++++++++++++++=
++-------
> =A0drivers/spi/amba-pl022-looptest.h | =A0 11 ++++
> =A0drivers/spi/amba-pl022.c =A0 =A0 =A0 =A0 =A0| =A0 =A06 ++
> =A08 files changed, 127 insertions(+), 98 deletions(-)
> =A0create mode 100644 drivers/spi/amba-pl022-looptest.h
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
> index 91c2f4f..9e584dc 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -227,6 +227,19 @@ config SPI_PL022
> =A0 =A0 =A0 =A0 =A0controller. If you have an embedded system with an AMB=
A(R)
> =A0 =A0 =A0 =A0 =A0bus and a PL022 controller, say Y or M here.
>
> +config SPI_PL022_LOOPTEST
> + =A0 =A0 =A0 bool "PL022 loopback chip"
> + =A0 =A0 =A0 depends on SPI_PL022
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

Questionable usage of sysfs.  sysfs files should contain single values
only, or a list of things-of-the-same-type, and by convention sysfs
files are supposed to be available immediately when the struct device
is registered.  It looks like debugfs should really be used instead.

> +
> =A0config SPI_PPC4xx
> =A0 =A0 =A0 =A0tristate "PPC4xx SPI Controller"
> =A0 =A0 =A0 =A0depends on PPC32 && 4xx && SPI_MASTER
> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> index e9cbd18..9ac8e95 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -31,6 +31,7 @@ obj-$(CONFIG_SPI_OMAP24XX) =A0 =A0 =A0 =A0 =A0 =A0+=3D =
omap2_mcspi.o
> =A0obj-$(CONFIG_SPI_OMAP_100K) =A0 =A0 =A0 =A0 =A0 =A0+=3D omap_spi_100k.o
> =A0obj-$(CONFIG_SPI_ORION) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0+=3D orion_spi.o
> =A0obj-$(CONFIG_SPI_PL022) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0+=3D amba-pl022.o
> +obj-$(CONFIG_SPI_PL022_LOOPTEST) =A0 =A0 =A0 +=3D amba-pl022-looptest.o
> =A0obj-$(CONFIG_SPI_MPC512x_PSC) =A0 =A0 =A0 =A0 =A0+=3D mpc512x_psc_spi.o
> =A0obj-$(CONFIG_SPI_MPC52xx_PSC) =A0 =A0 =A0 =A0 =A0+=3D mpc52xx_psc_spi.o
> =A0obj-$(CONFIG_SPI_MPC52xx) =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D mpc52xx_spi.o
> diff --git a/drivers/spi/amba-pl022-looptest.c b/drivers/spi/amba-pl022-l=
ooptest.c
> index 5f55012..561886a 100644
> --- a/drivers/spi/amba-pl022-looptest.c
> +++ b/drivers/spi/amba-pl022-looptest.c
> @@ -1,7 +1,5 @@
> =A0/*
> - * arch/arm/mach-u300/dummyspichip.c
> - *
> - * Copyright (C) 2007-2009 ST-Ericsson AB
> + * Copyright (C) 2007-2010 ST-Ericsson SA
> =A0* License terms: GNU General Public License (GPL) version 2
> =A0* This is a dummy loopback SPI "chip" used for testing SPI.
> =A0* Author: Linus Walleij <linus.walleij@stericsson.com>
> @@ -25,19 +23,93 @@
> =A0*/
> =A0#include <linux/amba/pl022.h>
>
> -struct dummy {
> +struct pl022_loopback {
> =A0 =A0 =A0 =A0struct device *dev;
> =A0 =A0 =A0 =A0struct mutex lock;
> =A0};
>
> =A0#define DMA_TEST_SIZE 2048
>
> -/* When we cat /sys/bus/spi/devices/spi0.0/looptest this will be trigger=
ed */
> -static ssize_t dummy_looptest(struct device *dev,
> +/*
> + * The following code self-registers the PL022 loopback
> + * chip on each PL022 SPI bus.
> + */
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
> + * This is called from the PL022 driver to register a loopback
> + * on itself if this module is compiled in.
> + */
> +void pl022_loopback_register(struct spi_master *master)
> +{
> + =A0 =A0 =A0 struct spi_device *spidev;
> +
> + =A0 =A0 =A0 spidev =3D spi_new_device(master, &pl022_loopback_device);
> + =A0 =A0 =A0 if (!spidev)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&master->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "could not register loopbac=
k test chip\n");
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&master->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "registered loopback test c=
hip\n");
> +}
> +
> +/*
> + * This is where the tests begin. When we issue:
> + * cat /sys/bus/spi/devices/spi0.0/looptest
> + * this will be triggered.
> + */
> +static ssize_t pl022_looptest(struct device *dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct device_attribute *attr, char *buf)
> =A0{
> =A0 =A0 =A0 =A0struct spi_device *spi =3D to_spi_device(dev);
> - =A0 =A0 =A0 struct dummy *p_dummy =3D dev_get_drvdata(&spi->dev);
> + =A0 =A0 =A0 struct pl022_loopback *p_loop =3D dev_get_drvdata(&spi->dev=
);
>
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * WARNING! Do not dereference the chip-specific data in a=
ny normal
> @@ -55,7 +127,7 @@ static ssize_t dummy_looptest(struct device *dev,
> =A0 =A0 =A0 =A0u8 *bigtxbuf_virtual;
> =A0 =A0 =A0 =A0u8 *bigrxbuf_virtual;
>
> - =A0 =A0 =A0 if (mutex_lock_interruptible(&p_dummy->lock))
> + =A0 =A0 =A0 if (mutex_lock_interruptible(&p_loop->lock))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ERESTARTSYS;
>
> =A0 =A0 =A0 =A0bigtxbuf_virtual =3D kmalloc(DMA_TEST_SIZE, GFP_KERNEL);
> @@ -217,25 +289,25 @@ static ssize_t dummy_looptest(struct device *dev,
> =A0 =A0 =A0 =A0kfree(bigrxbuf_virtual);
> =A0 =A0 =A0 =A0kfree(bigtxbuf_virtual);
> =A0out:
> - =A0 =A0 =A0 mutex_unlock(&p_dummy->lock);
> + =A0 =A0 =A0 mutex_unlock(&p_loop->lock);
> =A0 =A0 =A0 =A0return status;
> =A0}
>
> -static DEVICE_ATTR(looptest, S_IRUGO, dummy_looptest, NULL);
> +static DEVICE_ATTR(looptest, S_IRUGO, pl022_looptest, NULL);
>
> -static int __devinit pl022_dummy_probe(struct spi_device *spi)
> +static int __devinit pl022_loopback_probe(struct spi_device *spi)
> =A0{
> - =A0 =A0 =A0 struct dummy *p_dummy;
> + =A0 =A0 =A0 struct pl022_loopback *p_loop;
> =A0 =A0 =A0 =A0int status;
>
> =A0 =A0 =A0 =A0dev_info(&spi->dev, "probing dummy SPI device\n");
>
> - =A0 =A0 =A0 p_dummy =3D kzalloc(sizeof *p_dummy, GFP_KERNEL);
> - =A0 =A0 =A0 if (!p_dummy)
> + =A0 =A0 =A0 p_loop =3D kzalloc(sizeof *p_loop, GFP_KERNEL);
> + =A0 =A0 =A0 if (!p_loop)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENOMEM;
>
> - =A0 =A0 =A0 dev_set_drvdata(&spi->dev, p_dummy);
> - =A0 =A0 =A0 mutex_init(&p_dummy->lock);
> + =A0 =A0 =A0 dev_set_drvdata(&spi->dev, p_loop);
> + =A0 =A0 =A0 mutex_init(&p_loop->lock);
>
> =A0 =A0 =A0 =A0/* sysfs hook */
> =A0 =A0 =A0 =A0status =3D device_create_file(&spi->dev, &dev_attr_looptes=
t);
> @@ -248,29 +320,29 @@ static int __devinit pl022_dummy_probe(struct spi_d=
evice *spi)
>
> =A0out_dev_create_looptest_failed:
> =A0 =A0 =A0 =A0dev_set_drvdata(&spi->dev, NULL);
> - =A0 =A0 =A0 kfree(p_dummy);
> + =A0 =A0 =A0 kfree(p_loop);
> =A0 =A0 =A0 =A0return status;
> =A0}
>
> -static int __devexit pl022_dummy_remove(struct spi_device *spi)
> +static int __devexit pl022_loopback_remove(struct spi_device *spi)
> =A0{
> - =A0 =A0 =A0 struct dummy *p_dummy =3D dev_get_drvdata(&spi->dev);
> + =A0 =A0 =A0 struct pl022_loopback *p_loop =3D dev_get_drvdata(&spi->dev=
);
>
> =A0 =A0 =A0 =A0dev_info(&spi->dev, "removing dummy SPI device\n");
> =A0 =A0 =A0 =A0device_remove_file(&spi->dev, &dev_attr_looptest);
> =A0 =A0 =A0 =A0dev_set_drvdata(&spi->dev, NULL);
> - =A0 =A0 =A0 kfree(p_dummy);
> + =A0 =A0 =A0 kfree(p_loop);
>
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> =A0static struct spi_driver pl022_dummy_driver =3D {
> =A0 =A0 =A0 =A0.driver =3D {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "spi-dummy",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "pl022-loop",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.owner =A0=3D THIS_MODULE,
> =A0 =A0 =A0 =A0},
> - =A0 =A0 =A0 .probe =A0=3D pl022_dummy_probe,
> - =A0 =A0 =A0 .remove =3D __devexit_p(pl022_dummy_remove),
> + =A0 =A0 =A0 .probe =A0=3D pl022_loopback_probe,
> + =A0 =A0 =A0 .remove =3D __devexit_p(pl022_loopback_remove),
> =A0};
>
> =A0static int __init pl022_init_dummy(void)
> @@ -287,5 +359,5 @@ module_init(pl022_init_dummy);
> =A0module_exit(pl022_exit_dummy);
>
> =A0MODULE_AUTHOR("Linus Walleij <linus.walleij@stericsson.com>");
> -MODULE_DESCRIPTION("PL022 SSP/SPI DUMMY Linux driver");
> +MODULE_DESCRIPTION("PL022 loopback test driver");
> =A0MODULE_LICENSE("GPL");
> diff --git a/drivers/spi/amba-pl022-looptest.h b/drivers/spi/amba-pl022-l=
ooptest.h
> new file mode 100644
> index 0000000..1bedcc6
> --- /dev/null
> +++ b/drivers/spi/amba-pl022-looptest.h
> @@ -0,0 +1,11 @@
> +/*
> + * Defines a single function for the master to create a loopback
> + * on itself.
> + */
> +#ifdef CONFIG_SPI_PL022_LOOPTEST
> +void pl022_loopback_register(struct spi_master *master);
> +#else
> +static void inline pl022_loopback_register(struct spi_master *master)
> +{
> +}
> +#endif
> diff --git a/drivers/spi/amba-pl022.c b/drivers/spi/amba-pl022.c
> index f0a1418..6e4a657 100644
> --- a/drivers/spi/amba-pl022.c
> +++ b/drivers/spi/amba-pl022.c
> @@ -46,6 +46,8 @@
> =A0#include <linux/io.h>
> =A0#include <linux/slab.h>
>
> +#include "amba-pl022-looptest.h"
> +
> =A0/*
> =A0* This macro is used to define some register default values.
> =A0* reg is masked with mask, the OR:ed with an (again masked)
> @@ -1818,6 +1820,10 @@ pl022_probe(struct amba_device *adev, struct amba_=
id *id)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_spi_register;
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0dev_dbg(dev, "probe succeded\n");
> +
> + =A0 =A0 =A0 /* Register a loopback test if desired */
> + =A0 =A0 =A0 pl022_loopback_register(master);
> +
> =A0 =A0 =A0 =A0return 0;
>
> =A0err_spi_register:
> --
> 1.7.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>



-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
