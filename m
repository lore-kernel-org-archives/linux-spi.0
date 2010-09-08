From: Kevin Wells <wellsk40-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] amba_pl022: Setup SPI configuration based on spi->mode
Date: Wed, 8 Sep 2010 15:03:59 -0700
Message-ID: <AANLkTik4Jm6u+jowgG7Py3u8N=B48opWYAikGztpXhs_@mail.gmail.com>
References: <1283446992-23764-1-git-send-email-wellsk40@gmail.com>
	<AANLkTi=2XQ==iCYtAQ_74wPZ6JRB3x9SjS=sjVoC5YiM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Lukasz.Baj-++hxYGjEMp0AvxtiuMwx3w@public.gmane.org
To: Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <AANLkTi=2XQ==iCYtAQ_74wPZ6JRB3x9SjS=sjVoC5YiM-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

>
>> This patch changes the way SPI transfers are setup. The previous
>> method uses the pl022_config_chip data for configuration of
>> loopback mode, edge count, clock polarity, number of data bits,
>> and bit transfer order. This change configures these parameters
>> based on spi->mode passed via master->setup and will allow the
>> drivers use SPI to configure the interface.
>
> I get regressions on my in-kernel drivers of the SPI when I apply
> this patch.
>
> I guess I also have to update all in-kernel clients to supply the
> correct bits?
>
> Can you help me out on what needs to be done... the major
> in-kernel user is drivers/mfd/ab8500-spi.c so far.
>

Hi Linus,

Yes - the clients and the client setup info need some changes.
I'm currently testing these patches and will post them soon.

The basic patches are below. These aren't really official yet
and should only be considered RFC.

diff --git a/arch/arm/mach-lpc32xx/phy3250.c b/arch/arm/mach-lpc32xx/phy3250.c
index bc9a42d..0d57602 100644
--- a/arch/arm/mach-lpc32xx/phy3250.c
+++ b/arch/arm/mach-lpc32xx/phy3250.c
@@ -240,6 +240,7 @@ static int __init phy3250_spi_board_register(void)
 			.bus_num = 0,
 			.chip_select = 0,
 			.platform_data = &eeprom,
+			.mode = SPI_MODE_0,
 			.controller_data = &spi0_chip_info,
 		},
 	};
diff --git a/arch/arm/mach-u300/dummyspichip.c
b/arch/arm/mach-u300/dummyspichip.c
index 5f55012..9fcb318 100644
--- a/arch/arm/mach-u300/dummyspichip.c
+++ b/arch/arm/mach-u300/dummyspichip.c
@@ -72,7 +72,7 @@ static ssize_t dummy_looptest(struct device *dev,
 	 * Force chip to 8 bit mode
 	 * WARNING: NEVER DO THIS IN REAL DRIVER CODE, THIS SHOULD BE STATIC!
 	 */
-	chip_info->data_size = SSP_DATA_BITS_8;
+	spi->bits_per_word = 8;
 	/* You should NOT DO THIS EITHER */
 	spi->master->setup(spi);

@@ -159,7 +159,7 @@ static ssize_t dummy_looptest(struct device *dev,
 	 * Force chip to 16 bit mode
 	 * WARNING: NEVER DO THIS IN REAL DRIVER CODE, THIS SHOULD BE STATIC!
 	 */
-	chip_info->data_size = SSP_DATA_BITS_16;
+	spi->bits_per_word = 16;
 	/* You should NOT DO THIS EITHER */
 	spi->master->setup(spi);

diff --git a/arch/arm/mach-u300/spi.c b/arch/arm/mach-u300/spi.c
index f0e887b..2d4ed5b 100644
--- a/arch/arm/mach-u300/spi.c
+++ b/arch/arm/mach-u300/spi.c
@@ -75,7 +75,7 @@ static struct spi_board_info u300_spi_devices[] = {
 		.bus_num        = 0, /* Only one bus on this chip */
 		.chip_select    = 0,
 		/* Means SPI_CS_HIGH, change if e.g low CS */
-		.mode           = 0,
+		.mode           = SPI_MODE_1 | SPI_LSB_FIRST | SPI_LOOP,
 	},
 #endif
 };
diff --git a/arch/arm/mach-ux500/board-mop500.c
b/arch/arm/mach-ux500/board-mop500.c
index 0e8fd13..69dff11 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -83,7 +83,7 @@ static struct spi_board_info u8500_spi_devices[] = {
 		.max_speed_hz = 12000000,
 		.bus_num = 0,
 		.chip_select = 0,
-		.mode = SPI_MODE_0,
+		.mode = SPI_MODE_3,
 		.irq = IRQ_DB8500_AB8500,
 	},
 };
diff --git a/drivers/mfd/ab8500-spi.c b/drivers/mfd/ab8500-spi.c
index e1c8b62..003e339 100644
--- a/drivers/mfd/ab8500-spi.c
+++ b/drivers/mfd/ab8500-spi.c
@@ -92,6 +92,7 @@ static int __devinit ab8500_spi_probe(struct spi_device *spi)

 	ab8500->read = ab8500_spi_read;
 	ab8500->write = ab8500_spi_write;
+	spi->bits_per_word = 24;

 	spi_set_drvdata(spi, ab8500);

Kevin

> Yours,
> Linus Walleij
>

------------------------------------------------------------------------------
This SF.net Dev2Dev email is sponsored by:

Show off your parallel programming skills.
Enter the Intel(R) Threading Challenge 2010.
http://p.sf.net/sfu/intel-thread-sfd
