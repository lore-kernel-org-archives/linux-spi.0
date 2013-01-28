From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: [PATCH 3/5] serial: pl011: use generic DMA slave configuration if
	possible
Date: Mon, 28 Jan 2013 17:57:35 +0000
Message-ID: <1359395857-1235-4-git-send-email-arnd@arndb.de>
References: <1359395857-1235-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Vinod Koul <vinod.koul-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>,
	Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org,
	Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: linux-arm-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1359395857-1235-1-git-send-email-arnd-r2nGTMty4D4@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

With the new OF DMA binding, it is possible to completely avoid the
need for platform_data for configuring a DMA channel. In cases where the
platform has already been converted, calling dma_request_slave_channel
should get all the necessary information from the device tree.

Like the patch that converts the dw_dma controller, this is completely
untested and is looking for someone to try it out.

Signed-off-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Vinod Koul <vinod.koul-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Cc: linux-arm-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
---
 drivers/tty/serial/amba-pl011.c | 62 ++++++++++++++++++++++++-----------------
 1 file changed, 37 insertions(+), 25 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 3ea5408..c25b00e 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -245,7 +245,7 @@ static void pl011_sgbuf_free(struct dma_chan *chan, struct pl011_sgbuf *sg,
 	}
 }
 
-static void pl011_dma_probe_initcall(struct uart_amba_port *uap)
+static void pl011_dma_probe_initcall(struct device *dev, struct uart_amba_port *uap)
 {
 	/* DMA is the sole user of the platform data right now */
 	struct amba_pl011_data *plat = uap->port.dev->platform_data;
@@ -259,20 +259,25 @@ static void pl011_dma_probe_initcall(struct uart_amba_port *uap)
 	struct dma_chan *chan;
 	dma_cap_mask_t mask;
 
-	/* We need platform data */
-	if (!plat || !plat->dma_filter) {
-		dev_info(uap->port.dev, "no DMA platform data\n");
-		return;
-	}
+	chan = dma_request_slave_channel(dev, "tx");
 
-	/* Try to acquire a generic DMA engine slave TX channel */
-	dma_cap_zero(mask);
-	dma_cap_set(DMA_SLAVE, mask);
-
-	chan = dma_request_channel(mask, plat->dma_filter, plat->dma_tx_param);
 	if (!chan) {
-		dev_err(uap->port.dev, "no TX DMA channel!\n");
-		return;
+		/* We need platform data */
+		if (!plat || !plat->dma_filter) {
+			dev_info(uap->port.dev, "no DMA platform data\n");
+			return;
+		}
+
+		/* Try to acquire a generic DMA engine slave TX channel */
+		dma_cap_zero(mask);
+		dma_cap_set(DMA_SLAVE, mask);
+
+		chan = dma_request_channel(mask, plat->dma_filter,
+						plat->dma_tx_param);
+		if (!chan) {
+			dev_err(uap->port.dev, "no TX DMA channel!\n");
+			return;
+		}
 	}
 
 	dmaengine_slave_config(chan, &tx_conf);
@@ -282,7 +287,18 @@ static void pl011_dma_probe_initcall(struct uart_amba_port *uap)
 		 dma_chan_name(uap->dmatx.chan));
 
 	/* Optionally make use of an RX channel as well */
-	if (plat->dma_rx_param) {
+	chan = dma_request_slave_channel(dev, "rx");
+	
+	if (!chan && plat->dma_rx_param) {
+		chan = dma_request_channel(mask, plat->dma_filter, plat->dma_rx_param);
+
+		if (!chan) {
+			dev_err(uap->port.dev, "no RX DMA channel!\n");
+			return;
+		}
+	}
+
+	if (chan) {
 		struct dma_slave_config rx_conf = {
 			.src_addr = uap->port.mapbase + UART01x_DR,
 			.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE,
@@ -291,12 +307,6 @@ static void pl011_dma_probe_initcall(struct uart_amba_port *uap)
 			.device_fc = false,
 		};
 
-		chan = dma_request_channel(mask, plat->dma_filter, plat->dma_rx_param);
-		if (!chan) {
-			dev_err(uap->port.dev, "no RX DMA channel!\n");
-			return;
-		}
-
 		dmaengine_slave_config(chan, &rx_conf);
 		uap->dmarx.chan = chan;
 
@@ -315,6 +325,7 @@ static void pl011_dma_probe_initcall(struct uart_amba_port *uap)
 struct dma_uap {
 	struct list_head node;
 	struct uart_amba_port *uap;
+	struct device *dev;
 };
 
 static LIST_HEAD(pl011_dma_uarts);
@@ -325,7 +336,7 @@ static int __init pl011_dma_initcall(void)
 
 	list_for_each_safe(node, tmp, &pl011_dma_uarts) {
 		struct dma_uap *dmau = list_entry(node, struct dma_uap, node);
-		pl011_dma_probe_initcall(dmau->uap);
+		pl011_dma_probe_initcall(dmau->dev, dmau->uap);
 		list_del(node);
 		kfree(dmau);
 	}
@@ -334,18 +345,19 @@ static int __init pl011_dma_initcall(void)
 
 device_initcall(pl011_dma_initcall);
 
-static void pl011_dma_probe(struct uart_amba_port *uap)
+static void pl011_dma_probe(struct device *dev, struct uart_amba_port *uap)
 {
 	struct dma_uap *dmau = kzalloc(sizeof(struct dma_uap), GFP_KERNEL);
 	if (dmau) {
 		dmau->uap = uap;
+		dmau->dev = dev;
 		list_add_tail(&dmau->node, &pl011_dma_uarts);
 	}
 }
 #else
-static void pl011_dma_probe(struct uart_amba_port *uap)
+static void pl011_dma_probe(struct device *dev, struct uart_amba_port *uap)
 {
-	pl011_dma_probe_initcall(uap);
+	pl011_dma_probe_initcall(dev, uap);
 }
 #endif
 
@@ -2020,7 +2032,7 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
 	uap->port.ops = &amba_pl011_pops;
 	uap->port.flags = UPF_BOOT_AUTOCONF;
 	uap->port.line = i;
-	pl011_dma_probe(uap);
+	pl011_dma_probe(&dev->dev, uap);
 
 	/* Ensure interrupts from this UART are masked and cleared */
 	writew(0, uap->port.membase + UART011_IMSC);
-- 
1.8.0


------------------------------------------------------------------------------
Master Visual Studio, SharePoint, SQL, ASP.NET, C# 2012, HTML5, CSS,
MVC, Windows 8 Apps, JavaScript and much more. Keep your skills current
with LearnDevNow - 3,200 step-by-step video tutorials by Microsoft
MVPs and experts. ON SALE this month only -- learn more at:
http://p.sf.net/sfu/learnnow-d2d
