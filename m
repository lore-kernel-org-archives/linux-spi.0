From: Ivan Kuten <ivan.kuten-NihHnkIkDZhBDgjK7y7TUQ@public.gmane.org>
Subject: problem with converting from at91_spi to
	atmel_spi (AT91RM9200)
Date: Wed, 23 May 2007 14:34:56 +0300
Message-ID: <20070523143456.15fc49ab@newbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, andrew-eS41wJS13H5l57MIdRCFDg@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org


Hello,

I'm trying to convert from legacy at91_spi to newer atmel_spi driver in my board.
Linux kernel 2.6.22rc2 + corresponding patch from maxim.org.za/at91_26.html

board specific spi info :

static struct spi_board_info chub_spi_devices[] = {
        {       /* DataFlash chip */
                .modalias       = "mtd_dataflash",
                .chip_select    = 0,
                .max_speed_hz   = 15 * 1000 * 1000,
        },
};

snip from .config:

CONFIG_MTD_DATAFLASH=y

# 
# SPI support
# 
CONFIG_SPI=y
CONFIG_SPI_DEBUG=y
CONFIG_SPI_MASTER=y

#
# SPI Master Controller Drivers
# 
CONFIG_SPI_ATMEL=y
# CONFIG_SPI_BITBANG is not set
CONFIG_SPI_AT91_MANUAL_CS=y
#
# SPI Protocol Masters
#
# CONFIG_SPI_AT25 is not set
# CONFIG_SPI_SPIDEV is not set

While boot, the board stumbles on SPI initialization:

Uncompressing Linux....................................................................... done, booting the kernel.
Linux version 2.6.22-rc1 (vano@newbox) (gcc version 3.4.2) #12 Wed May 23 14:05:30 EEST 2007
CPU: ARM920T [41129200] revision 0 (ARMv4T), cr=c0007177
Machine: Promwad Chub
---snip----
eth0: Link now 100-FullDuplex
eth0: AT91 ethernet at 0xfefbc000 int=24 100-FullDuplex (00:12:34:56:78:9a)
eth0: National Semiconductor DP83848 PHY
NAND device: Manufacturer ID: 0xec, Chip ID: 0x76 (Samsung NAND 64MiB 3,3V 8-bit)
Scanning device for bad blocks
Creating 1 MTD partitions on "NAND 64MiB 3,3V 8-bit":
0x00000000-0x04000000 : "NAND Partition 1"
atmel_spi atmel_spi.0: Atmel SPI Controller at 0xfffe0000 (irq 13)

Not booting further. Timer led is still blinking. Is atmel_spi usable?
I have working setup on 2.6.20 + corresponding patch from maxim.org.za/at91_26.html +  legacy "at91_dataflash" + legacy "at91_spi"

Best regards, Ivan



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
