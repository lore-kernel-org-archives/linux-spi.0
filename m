From: "Pietrek, Markus" <Markus.Pietrek-BU0Y/NROKIiELgA04lAiVw@public.gmane.org>
Subject: [PATCH] spi_board_info_cmdline.c: unknown
 command line options are ignored and all options have a name instead of
 being anonymous
Date: Tue, 2 Feb 2010 16:08:57 +0100
Message-ID: <95F51F4B902CAC40AF459205F6322F0171E8D499AC@BMK019S01.emtrion.local>
References: <95F51F4B902CAC40AF459205F6322F0171E8D49880@BMK019S01.emtrion.local>
	<20100130230629.GA2634@tarshish>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20100130230629.GA2634@tarshish>
Content-Language: de-DE
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Barauch,

as requested a more open approach for the command line options

Signed-off-by: Markus Pietrek <markus.pietrek-BU0Y/NROKIiELgA04lAiVw@public.gmane.org>
---
 drivers/spi/Kconfig                  |    2 +-
 drivers/spi/spi_board_info_cmdline.c |   92 +++++++++++++++------------------
 2 files changed, 43 insertions(+), 51 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 85e88fa..c8f3bbe 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -327,7 +327,7 @@ config SPI_BOARD_INFO_CMDLINE
           The syntax is:
          spi_board_info=<devcfg>[,<devcfg>...]
          with <devcfg> as
-         <devname>[:<max_speed_hz>[:<bus_num>[:<chip_select>[:<irq>[:<opt>[:<opt>...]]]]]]
+         <devname>[:max_speed_hz=<int>][:bus_num=<int>][:chip_select=<int>][:irq=<int>][:cs_gpio=<int>][:<opt>][:<opt>]...
           and <opt> as one of
           cpha,cpol,mode0,mode1,mode2,mode3,cs,lsb,3wire,loop,no_cs,ready

diff --git a/drivers/spi/spi_board_info_cmdline.c b/drivers/spi/spi_board_info_cmdline.c
index 765a941..1d86f87 100644
--- a/drivers/spi/spi_board_info_cmdline.c
+++ b/drivers/spi/spi_board_info_cmdline.c
@@ -65,57 +65,49 @@ static int __init spi_board_info_register_device(char *dev)
                if (next)
                        *next++ = '\0';

-               if (strlen(opt) > 0) {
-                       switch (num) {
-                           case 0:
-                               strncpy(info->modalias, opt, ARRAY_SIZE(info->modalias));
-                               info->modalias[ARRAY_SIZE(info->modalias)-1]=0;
-                               break;
-                           case 1:
-                               info->max_speed_hz = simple_strtoul(opt, NULL, 10);
-                               break;
-                           case 2:
-                               info->bus_num = simple_strtoul(opt, NULL, 10);
-                               break;
-                           case 3:
-                               info->chip_select = simple_strtoul(opt, NULL, 10);
-                               break;
-                           case 4:
+               if (!num) {
+                       /* name of device */
+                       strncpy(info->modalias, opt, ARRAY_SIZE(info->modalias));
+                       info->modalias[ARRAY_SIZE(info->modalias)-1]=0;
+               } else {
+                       if (!strcmp(opt, "cpha"))
+                               info->mode |= SPI_CPHA;
+                       else if (!strcmp(opt, "cpol"))
+                               info->mode |= SPI_CPOL;
+                       else if (!strcmp(opt, "mode0"))
+                               info->mode |= SPI_MODE_0;
+                       else if (!strcmp(opt, "mode1"))
+                               info->mode |= SPI_MODE_1;
+                       else if (!strcmp(opt, "mode2"))
+                               info->mode |= SPI_MODE_2;
+                       else if (!strcmp(opt, "mode3"))
+                               info->mode |= SPI_MODE_3;
+                       else if (!strcmp(opt, "cs_high"))
+                               info->mode |= SPI_CS_HIGH;
+                       else if (!strcmp(opt, "lsb"))
+                               info->mode |= SPI_LSB_FIRST;
+                       else if (!strcmp(opt, "3wire"))
+                               info->mode |= SPI_3WIRE;
+                       else if (!strcmp(opt, "loop"))
+                               info->mode |= SPI_LOOP;
+                       else if (!strcmp(opt, "no_cs"))
+                               info->mode |= SPI_NO_CS;
+                       else if (!strcmp(opt, "ready"))
+                               info->mode |= SPI_READY;
+                       else if (!strncmp(opt, "chip_select=", 12))
+                               info->chip_select = simple_strtoul(&opt[12], NULL, 10);
+                       else if (!strncmp(opt, "cs_gpio=", 8))
+                               /* defines the GPIO to be used as chipselect for spi_gpio.c */
+                               info->controller_data = (void*) simple_strtol(&opt[8], NULL, 10);
+                       else if (!strncmp(opt, "bus_num=", 8))
+                               info->bus_num = simple_strtoul(&opt[8], NULL, 10);
+                       else if (!strncmp(opt, "max_speed_hz=", 13))
+                               info->max_speed_hz = simple_strtoul(&opt[13], NULL, 10);
+                       else if (!strncmp(opt, "irq=", 4))
                                info->irq = simple_strtoul(opt, NULL, 10);
-                               break;
-                           default:
-                               if (!strcmp(opt, "cpha"))
-                                       info->mode |= SPI_CPHA;
-                               else if (!strcmp(opt, "cpol"))
-                                       info->mode |= SPI_CPOL;
-                               else if (!strcmp(opt, "mode0"))
-                                       info->mode |= SPI_MODE_0;
-                               else if (!strcmp(opt, "mode1"))
-                                       info->mode |= SPI_MODE_1;
-                               else if (!strcmp(opt, "mode2"))
-                                       info->mode |= SPI_MODE_2;
-                               else if (!strcmp(opt, "mode3"))
-                                       info->mode |= SPI_MODE_3;
-                               else if (!strcmp(opt, "cs"))
-                                       info->mode |= SPI_CS_HIGH;
-                               else if (!strcmp(opt, "lsb"))
-                                       info->mode |= SPI_LSB_FIRST;
-                               else if (!strcmp(opt, "3wire"))
-                                       info->mode |= SPI_3WIRE;
-                               else if (!strcmp(opt, "loop"))
-                                       info->mode |= SPI_LOOP;
-                               else if (!strcmp(opt, "no_cs"))
-                                       info->mode |= SPI_NO_CS;
-                               else if (!strcmp(opt, "ready"))
-                                       info->mode |= SPI_READY;
-                               else {
-                                       pr_err(DRIVER_NAME ": Don't know value %s\n", opt);
-                                       kfree(info);
-                                       return -1;
-                               }
-
-                               break;
-                       }
+                       else
+                               pr_err(DRIVER_NAME ": Unknown option %s, ignoring\n", opt);
+                       break;
                }

                /* next option */
--
1.5.4.3

_____________________________________

Amtsgericht Mannheim
HRB 110 300
Gesch?ftsf?hrer: Dieter Baur, Ramona Maurer
_____________________________________

Important Note:
- This e-mail may contain trade secrets or privileged, undisclosed or otherwise confidential information.
- If you have received this e-mail in error, you are hereby notified that any review, copying or distribution of it is strictly prohibited.
- Please inform us immediately and destroy the original transmittal.

Thank you for your cooperation.

------------------------------------------------------------------------------
The Planet: dedicated and managed hosting, cloud storage, colocation
Stay online with enterprise data centers and the best network in the business
Choose flexible plans and management services without long-term contracts
Personal 24x7 support from experience hosting pros just a phone call away.
http://p.sf.net/sfu/theplanet-com
