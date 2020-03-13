From: Akash Asthana <akashast-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH V2 4/8] tty: serial: qcom_geni_serial: Add interconnect support
Date: Fri, 13 Mar 2020 18:42:10 +0530
Message-ID: <1584105134-13583-5-git-send-email-akashast@codeaurora.org>
References: <1584105134-13583-1-git-send-email-akashast@codeaurora.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, swboyd-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org,
        mgautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org,
        dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, evgreen-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org,
        Akash Asthana <akashast-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, agross-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        mark.rutland-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1584105134-13583-1-git-send-email-akashast-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Get the interconnect paths for Uart based Serial Engine device
and vote according to the baud rate requirement of the driver.

Signed-off-by: Akash Asthana <akashast-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
Changes in V2:
 - As per Bjorn's comment, removed se == NULL check from geni_serial_icc_get
 - As per Bjorn's comment, removed code to set se->icc_path* to NULL in failure
 - As per Bjorn's comment, introduced and using devm_of_icc_get API for getting
   path handle
 - As per Matthias comment, added error handling for icc_set_bw call

 drivers/tty/serial/qcom_geni_serial.c | 69 +++++++++++++++++++++++++++++++++--
 1 file changed, 65 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 272bae0..c8ad7e9 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -184,6 +184,19 @@ static struct qcom_geni_serial_port qcom_geni_console_port = {
 	},
 };
 
+static int geni_serial_icc_get(struct geni_se *se)
+{
+	se->icc_path_geni_to_core = devm_of_icc_get(se->dev, "qup-core");
+	if (IS_ERR(se->icc_path_geni_to_core))
+		return PTR_ERR(se->icc_path_geni_to_core);
+
+	se->icc_path_cpu_to_geni = devm_of_icc_get(se->dev, "qup-config");
+	if (IS_ERR(se->icc_path_cpu_to_geni))
+		return PTR_ERR(se->icc_path_cpu_to_geni);
+
+	return 0;
+}
+
 static int qcom_geni_serial_request_port(struct uart_port *uport)
 {
 	struct platform_device *pdev = to_platform_device(uport->dev);
@@ -962,6 +975,7 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
 	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
 	unsigned long clk_rate;
 	u32 ver, sampling_rate;
+	int ret;
 
 	qcom_geni_serial_stop_rx(uport);
 	/* baud rate */
@@ -983,6 +997,18 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
 	ser_clk_cfg = SER_CLK_EN;
 	ser_clk_cfg |= clk_div << CLK_DIV_SHFT;
 
+	/*
+	 * Put BW vote only on CPU path as driver supports FIFO mode only.
+	 * Assume peak_bw as twice of avg_bw.
+	 */
+	port->se.avg_bw_cpu = Bps_to_icc(baud);
+	port->se.peak_bw_cpu = Bps_to_icc(2 * baud);
+	ret = icc_set_bw(port->se.icc_path_cpu_to_geni, port->se.avg_bw_cpu,
+			port->se.peak_bw_cpu);
+	if (ret)
+		dev_err(uport->dev, "%s: ICC BW voting failed for cpu\n",
+			__func__);
+
 	/* parity */
 	tx_trans_cfg = readl(uport->membase + SE_UART_TX_TRANS_CFG);
 	tx_parity_cfg = readl(uport->membase + SE_UART_TX_PARITY_CFG);
@@ -1208,16 +1234,40 @@ static void qcom_geni_serial_pm(struct uart_port *uport,
 		unsigned int new_state, unsigned int old_state)
 {
 	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
-
+	int ret;
 	/* If we've never been called, treat it as off */
 	if (old_state == UART_PM_STATE_UNDEFINED)
 		old_state = UART_PM_STATE_OFF;
 
-	if (new_state == UART_PM_STATE_ON && old_state == UART_PM_STATE_OFF)
+	if (new_state == UART_PM_STATE_ON && old_state == UART_PM_STATE_OFF) {
+		/* Put BW vote for core clocks and CPU */
+		ret = icc_set_bw(port->se.icc_path_geni_to_core,
+			port->se.avg_bw_core, port->se.peak_bw_core);
+		if (ret)
+			dev_err(uport->dev, "%s: ICC BW voting failed for core\n",
+				__func__);
+
+		ret = icc_set_bw(port->se.icc_path_cpu_to_geni,
+			port->se.avg_bw_cpu, port->se.peak_bw_cpu);
+		if (ret)
+			dev_err(uport->dev, "%s: ICC BW voting failed for cpu\n",
+				__func__);
+
 		geni_se_resources_on(&port->se);
-	else if (new_state == UART_PM_STATE_OFF &&
-			old_state == UART_PM_STATE_ON)
+	} else if (new_state == UART_PM_STATE_OFF &&
+			old_state == UART_PM_STATE_ON) {
 		geni_se_resources_off(&port->se);
+		/* Remove BW vote from core clocks and CPU */
+		ret = icc_set_bw(port->se.icc_path_geni_to_core, 0, 0);
+		if (ret)
+			dev_err(uport->dev, "%s: ICC BW remove failed for core\n",
+				__func__);
+
+		ret = icc_set_bw(port->se.icc_path_cpu_to_geni, 0, 0);
+		if (ret)
+			dev_err(uport->dev, "%s: ICC BW remove failed for cpu\n",
+				__func__);
+	}
 }
 
 static const struct uart_ops qcom_geni_console_pops = {
@@ -1308,6 +1358,17 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 	port->rx_fifo_depth = DEF_FIFO_DEPTH_WORDS;
 	port->tx_fifo_width = DEF_FIFO_WIDTH_BITS;
 
+	ret = geni_serial_icc_get(&port->se);
+	if (ret)
+		return ret;
+	/* Set the bus quota to a reasonable value */
+	port->se.avg_bw_core = console ? Bps_to_icc(1000) :
+		Bps_to_icc(CORE_2X_50_MHZ);
+	port->se.peak_bw_core = console ? Bps_to_icc(1000) :
+		Bps_to_icc(CORE_2X_100_MHZ);
+	port->se.avg_bw_cpu = Bps_to_icc(1000);
+	port->se.peak_bw_cpu = Bps_to_icc(1000);
+
 	port->name = devm_kasprintf(uport->dev, GFP_KERNEL,
 			"qcom_geni_serial_%s%d",
 			uart_console(uport) ? "console" : "uart", uport->line);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project
