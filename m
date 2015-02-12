From: Aurelien BOUIN <a.bouin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/4] serial: imx: checkpatch cleanup
Date: Thu, 12 Feb 2015 13:07:25 +0100
Message-ID: <1423742848-15369-1-git-send-email-a.bouin@gmail.com>
Cc: festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Aurelien BOUIN <a.bouin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This patch solve various issue detected by checkpatch.pl

Signed-off-by: Aurelien BOUIN <a.bouin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index a086eef..63eb457 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -275,9 +275,12 @@ static struct platform_device_id imx_uart_devtype[] = {
 MODULE_DEVICE_TABLE(platform, imx_uart_devtype);
 
 static struct of_device_id imx_uart_dt_ids[] = {
-	{ .compatible = "fsl,imx6q-uart", .data = &imx_uart_devdata[IMX6Q_UART], },
-	{ .compatible = "fsl,imx1-uart", .data = &imx_uart_devdata[IMX1_UART], },
-	{ .compatible = "fsl,imx21-uart", .data = &imx_uart_devdata[IMX21_UART], },
+	{ .compatible = "fsl,imx6q-uart",
+			.data = &imx_uart_devdata[IMX6Q_UART], },
+	{ .compatible = "fsl,imx1-uart",
+			.data = &imx_uart_devdata[IMX1_UART], },
+	{ .compatible = "fsl,imx21-uart",
+			.data = &imx_uart_devdata[IMX21_UART], },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, imx_uart_dt_ids);
@@ -430,6 +433,7 @@ static void imx_stop_tx(struct uart_port *port)
 	if (USE_IRDA(sport)) {
 		/* half duplex - wait for end of transmission */
 		int n = 256;
+
 		while ((--n > 0) &&
 		      !(readl(sport->port.membase + USR2) & USR2_TXDC)) {
 			udelay(5);
@@ -621,7 +625,6 @@ static void imx_dma_tx(struct imx_port *sport)
 	sport->dma_is_txing = 1;
 	dmaengine_submit(desc);
 	dma_async_issue_pending(chan);
-	return;
 }
 
 /*
@@ -870,7 +873,8 @@ static unsigned int imx_tx_empty(struct uart_port *port)
 	struct imx_port *sport = (struct imx_port *)port;
 	unsigned int ret;
 
-	ret = (readl(sport->port.membase + USR2) & USR2_TXDC) ?  TIOCSER_TEMT : 0;
+	ret = (readl(sport->port.membase + USR2) & USR2_TXDC) ?
+			TIOCSER_TEMT : 0;
 
 	/* If the TX DMA is working, return 0. */
 	if (sport->dma_is_enabled && sport->dma_is_txing)
@@ -1256,6 +1260,7 @@ static int imx_startup(struct uart_port *port)
 
 	if (USE_IRDA(sport)) {
 		struct imxuart_platform_data *pdata;
+
 		pdata = dev_get_platdata(sport->port.dev);
 		sport->irda_inv_rx = pdata->irda_inv_rx;
 		sport->irda_inv_tx = pdata->irda_inv_tx;
@@ -1299,6 +1304,7 @@ static void imx_shutdown(struct uart_port *port)
 
 	if (USE_IRDA(sport)) {
 		struct imxuart_platform_data *pdata;
+
 		pdata = dev_get_platdata(sport->port.dev);
 		if (pdata->irda_enable)
 			pdata->irda_enable(0);
@@ -1754,7 +1760,8 @@ imx_console_get_options(struct imx_port *sport, int *baud,
 		ubir = readl(sport->port.membase + UBIR) & 0xffff;
 		ubmr = readl(sport->port.membase + UBMR) & 0xffff;
 
-		ucfr_rfdiv = (readl(sport->port.membase + UFCR) & UFCR_RFDIV) >> 7;
+		ucfr_rfdiv = (readl(sport->port.membase + UFCR) & UFCR_RFDIV)
+				>> 7;
 		if (ucfr_rfdiv == 6)
 			ucfr_rfdiv = 7;
 		else
@@ -1763,12 +1770,13 @@ imx_console_get_options(struct imx_port *sport, int *baud,
 		uartclk = clk_get_rate(sport->clk_per);
 		uartclk /= ucfr_rfdiv;
 
-		{	/*
-			 * The next code provides exact computation of
-			 *   baud_raw = round(((uartclk/16) * (ubir + 1)) / (ubmr + 1))
-			 * without need of float support or long long division,
-			 * which would be required to prevent 32bit arithmetic overflow
-			 */
+		{
+		/*
+		 * The next code provides exact computation of
+		 *   baud_raw = round(((uartclk/16) * (ubir + 1)) / (ubmr + 1))
+		 * without need of float support or long long division,
+		 * which would be required to prevent 32bit arithmetic overflow
+		 */
 			unsigned int mul = ubir + 1;
 			unsigned int div = 16 * (ubmr + 1);
 			unsigned int rem = uartclk % div;
@@ -1844,7 +1852,7 @@ static struct console imx_console = {
 	.data		= &imx_reg,
 };
 
-#define IMX_CONSOLE	&imx_console
+#define IMX_CONSOLE	(&imx_console)
 #else
 #define IMX_CONSOLE	NULL
 #endif
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
