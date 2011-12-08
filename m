From: Wolfram Sang <wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Current state of for-linus
Date: Thu, 08 Dec 2011 11:47:03 +0100
Message-ID: <4EE095A7.5000504@the-dreams.de>
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

Hi,

this is a resend of a mail I already sent yesterday. Since sf.net seems to
be blocking my emails (it should rather block the spam, grngl), this is
sent from another address which is not set up for patches, so you will
have all the annoyances that go with it :( However, I want this mail to be
in the wild and the patch is for information purposes mainly, so I guess
this will do. The final pull-request will be sent from my well-known
email-address and go to lkml as well.

So, this is the current status of the for-linus branch which I intend to
send out. Please notify me of missing patches or other things I might have
done wrong. If I don't hear any complaints, I'll ask Linus to pull it in
about 24 hours.

Thanks,

   Wolfram

The following changes since commit 5611cc4572e889b62a7b4c72a413536bf6a9c416:

  Linux 3.2-rc4 (2011-12-01 14:56:01 -0800)

are available in the git repository at:
  git://git.pengutronix.de/git/wsa/linux-2.6.git spi/for-linus

Axel Lin (1):
      spi/nuc900: Include linux/module.h

Gabor Juhos (1):
      spi/ath79: fix compile error due to missing include

Jiri Slaby (1):
      spi/fsl-espi: disable CONFIG_SPI_FSL_ESPI=m build

Manuel Lauss (1):
      spi/gpio: fix section mismatch warning

 drivers/spi/Kconfig      |    4 ++--
 drivers/spi/spi-ath79.c  |    1 +
 drivers/spi/spi-gpio.c   |    4 ++--
 drivers/spi/spi-nuc900.c |    1 +
 4 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index a1fd73d..8ba4510 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -199,7 +199,7 @@ config SPI_FSL_LIB
        depends on FSL_SOC

 config SPI_FSL_SPI
-       tristate "Freescale SPI controller"
+       bool "Freescale SPI controller"
        depends on FSL_SOC
        select SPI_FSL_LIB
        help
@@ -208,7 +208,7 @@ config SPI_FSL_SPI
          MPC8569 uses the controller in QE mode, MPC8610 in cpu mode.

 config SPI_FSL_ESPI
-       tristate "Freescale eSPI controller"
+       bool "Freescale eSPI controller"
        depends on FSL_SOC
        select SPI_FSL_LIB
        help
diff --git a/drivers/spi/spi-ath79.c b/drivers/spi/spi-ath79.c
index 024b48a..acc88b4 100644
--- a/drivers/spi/spi-ath79.c
+++ b/drivers/spi/spi-ath79.c
@@ -13,6 +13,7 @@
  */

 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/spinlock.h>
diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index e093d3e..0094c64 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -256,7 +256,7 @@ static void spi_gpio_cleanup(struct spi_device *spi)
        spi_bitbang_cleanup(spi);
 }

-static int __init spi_gpio_alloc(unsigned pin, const char *label, bool is_in)
+static int __devinit spi_gpio_alloc(unsigned pin, const char *label, bool
is_in)
 {
        int value;

@@ -270,7 +270,7 @@ static int __init spi_gpio_alloc(unsigned pin, const
char *label, bool is_in)
        return value;

 }

-static int __init
+static int __devinit
 spi_gpio_request(struct spi_gpio_platform_data *pdata, const char *label,
        u16 *res_flags)
 {
diff --git a/drivers/spi/spi-nuc900.c b/drivers/spi/spi-nuc900.c
index 21c70b2..182e9c8 100644
--- a/drivers/spi/spi-nuc900.c
+++ b/drivers/spi/spi-nuc900.c
@@ -8,6 +8,7 @@
  *
  */

+#include <linux/module.h>
 #include <linux/init.h>
 #include <linux/spinlock.h>
 #include <linux/workqueue.h>

--
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

------------------------------------------------------------------------------
Cloud Services Checklist: Pricing and Packaging Optimization
This white paper is intended to serve as a reference, checklist and point of 
discussion for anyone considering optimizing the pricing and packaging model 
of a cloud services business. Read Now!
http://www.accelacomm.com/jaw/sfnl/114/51491232/
