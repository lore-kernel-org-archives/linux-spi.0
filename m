From: Josh Boyer <jwboyer-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v3] spi: Add PPC4xx SPI driver
Date: Wed, 29 Oct 2008 10:53:05 -0400
Message-ID: <20081029145305.GA3676@yoda.jdub.homelinux.org>
References: <1225000124-29366-1-git-send-email-sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
To: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1225000124-29366-1-git-send-email-sr-ynQEQJNshbs@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Sun, Oct 26, 2008 at 06:48:44AM +0100, Stefan Roese wrote:
>This adds a SPI driver for the SPI controller found in the IBM/AMCC
>4xx PowerPC's.
>
>Signed-off-by: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>
>Signed-off-by: Wolfgang Ocker <weo-pMF0Ia4UJXeoYr4blSSd5g@public.gmane.org>
>---
>Changes in v3:
>- When the device is removed the GPIOs are released. The memory
>  for the GPIO array is freed.
>
>Changes in v2:
>- Now the gpios property is correctly decoded and the
>  resulting gpio numbers are used as the devices chip
>  selects.
>
>  So we can describe the SPI node like this:
>
>        SPI0: spi@ef600900 {
>                #address-cells = <1>;
>                #size-cells = <0>;
>                ...
>
>                /* two GPIOs, representing two chip selects: 0 and 1 */
>                gpios = <&GPIO0 5 0 &GPIO1 16 0>;
>
>                mmc-slot@0 {
>                        reg = <0>;
>                        ...
>                };
>
>                touchscreen@1 {
>                        reg = <1>;
>                        ...
>                };
>        }
>
>Special thanks to Wolfgang Ocker and Anton Vorontsov for their input.

Looks pretty good.  Just a few minor comments/questions below.

Also, do you have a patch for a DTS file that gives an example of how to
instantiate the SPI stuff in the device tree?

>diff --git a/drivers/spi/spi_ppc4xx.c b/drivers/spi/spi_ppc4xx.c
>new file mode 100644
>index 0000000..6f94acc
>--- /dev/null
>+++ b/drivers/spi/spi_ppc4xx.c
>+#include <linux/module.h>
>+#include <linux/init.h>
>+#include <linux/sched.h>
>+#include <linux/errno.h>
>+#include <linux/wait.h>
>+#include <linux/of_platform.h>
>+#include <linux/of_spi.h>
>+#include <linux/of_gpio.h>
>+#include <linux/interrupt.h>
>+#include <linux/delay.h>
>+
>+#include <linux/gpio.h>
>+#include <linux/spi/spi.h>
>+#include <linux/spi/spi_bitbang.h>
>+
>+#include <asm/io.h>
>+#include <asm/dcr-native.h>

Should maybe just be <asm/dcr.h>

>+#include <asm/dcr-regs.h>
>+

<snip>

>+/* SPI Controller driver's private data. */
>+struct ppc4xx_spi {
>+	/* bitbang has to be first */
>+	struct spi_bitbang bitbang;
>+	struct completion done;
>+
>+	u64 mapbase;
>+	u64 mapsize;
>+	int irqnum;
>+	/* need this to set the SPI clock */
>+	unsigned int opb_freq;
>+
>+	/* for transfers */
>+	int len;
>+	int count;
>+	/* data buffers */
>+	const unsigned char *tx;
>+	unsigned char *rx;
>+
>+	int *gpios;
>+	unsigned int num_gpios;
>+
>+	volatile struct spi_ppc4xx_regs __iomem *regs; /* pointer to the registers */

volatile?

>+	struct spi_master *master;
>+	struct device *dev;
>+};

<snip>

>+static int spi_ppc4xx_txrx(struct spi_device *spi, struct spi_transfer *t)
>+{
>+	struct ppc4xx_spi *hw;
>+	u8 data;
>+
>+	dev_dbg(&spi->dev, "txrx: tx %p, rx %p, len %d\n",
>+		t->tx_buf, t->rx_buf, t->len);
>+
>+	hw = spi_master_get_devdata(spi->master);
>+
>+	hw->tx = t->tx_buf;
>+	hw->rx = t->rx_buf;
>+	hw->len = t->len;
>+	hw->count = 0;
>+
>+	/* send the first byte */
>+	data = hw->tx ? hw->tx[0] : 0;
>+	out_8(&hw->regs->txd, data);
>+	out_8(&hw->regs->cr, SPI_PPC4XX_CR_STR);

Maybe iowrite8?  Same comment elsewhere.

>+	wait_for_completion(&hw->done);
>+
>+	return hw->count;
>+}
>+

<snip>

>+static struct of_device_id spi_ppc4xx_of_match[] = {
>+	{ .compatible = "ibm,spi", },
>+	{},
>+};

I'm wondering if that is too generic of a match.  In theory,
IBM could have another SPI controller that isn't for 4xx.
Maybe "ibm,spi-4xx" ?

josh

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
