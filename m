From: v <vvoisin-elIyG9luQ85QFI55V6+gNQ@public.gmane.org>
Subject: card based on s3C2440: s3c2410-spi
 s3c2410-spi.0: Failed to register SPI master
Date: Wed, 09 Jun 2010 12:57:06 +0200
Message-ID: <4C0F7382.50209@induct.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hello,

I'm using a UTU2440 dev kit (http://youtiyou.com/SamsungS3C2440EK.aspx) 
based on a s3c2440.
I try to enable spidev device on the board.

I add the following lines for use spi on the platform is the kernel in 
the file:
arch/arm/mach-s3c2440/mach-utu2440.c:

/* SPI driver info */
static struct spi_board_info __initdata_refok utu2440_spi_board_info[] = {
//SPI Port 0
     {
       .modalias    = "spidev",
       .max_speed_hz    = 25000000, //25 MHz
       .bus_num    = 0,
       .chip_select    = 0,
       .mode     = SPI_MODE_3,
     },
}

static void utu2440_spi0_cs(struct s3c2410_spi_info *spi, int cs, int pol)
{
     s3c2410_gpio_setpin(S3C2410_GPG2, pol);
}

static struct s3c2410_spi_info utu2440_spi0_platdata = {
     //.pin_cs = S3C2410_GPG2,
     .board_size = ARRAY_SIZE(utu2440_spi_board_info),
     .board_info = utu2440_spi_board_info,
     .set_cs = utu2440_spi0_cs,
};

I activate the SPI_DEV in the kernel with the following lines in .config 
kernel configuration:

#
# SPI support
#
CONFIG_SPI=y
CONFIG_SPI_MASTER=y

#
# SPI Master Controller Drivers
#
CONFIG_SPI_BITBANG=y
CONFIG_SPI_S3C24XX=y
# CONFIG_SPI_S3C24XX_GPIO is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_AT25 is not set
CONFIG_SPI_SPIDEV=y

Unfortunately it didn't work, during the boot i have the following error:
s3c2410-spi s3c2410-spi.0: Failed to register SPI master
s3c2410-spi: probe of s3c2410-spi.0 failed with error -22

Is somebody can help me to complete the code ?

Best regards

Vincent

PS: sorry for my poor english








------------------------------------------------------------------------------
ThinkGeek and WIRED's GeekDad team up for the Ultimate 
GeekDad Father's Day Giveaway. ONE MASSIVE PRIZE to the 
lucky parental unit.  See the prize list and enter to win: 
http://p.sf.net/sfu/thinkgeek-promo
