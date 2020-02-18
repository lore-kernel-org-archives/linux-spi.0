From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH 2/6] tty: serial: qcom_geni_serial: Add interconnect
 support
Date: Tue, 18 Feb 2020 14:34:50 -0800
Message-ID: <20200218223450.GE15781@google.com>
References: <1581946205-27189-1-git-send-email-akashast@codeaurora.org>
 <1581946205-27189-3-git-send-email-akashast@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gregkh@linuxfoundation.org, agross@kernel.org,
        bjorn.andersson@linaro.org, wsa@the-dreams.de, broonie@kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org,
        linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, swboyd@chromium.org,
        mgautam@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, dianders@chromium.org
To: Akash Asthana <akashast@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1581946205-27189-3-git-send-email-akashast@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, Feb 17, 2020 at 07:00:01PM +0530, Akash Asthana wrote:
> Get the interconnect paths for Uart based Serial Engine device
> and vote according to the baud rate requirement of the driver.
> 
> Signed-off-by: Akash Asthana <akashast@codeaurora.org>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 84 ++++++++++++++++++++++++++++++-----
>  1 file changed, 74 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index 191abb1..a8fb2b7 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -174,6 +174,35 @@ static struct qcom_geni_serial_port qcom_geni_console_port = {
>  	},
>  };
>  
> +static int geni_serial_icc_get(struct geni_se *se)
> +{
> +	if (!se)
> +		return -EINVAL;
> +
> +	se->icc_path[GENI_TO_CORE] = of_icc_get(se->dev, "qup-core");
> +	if (IS_ERR(se->icc_path[GENI_TO_CORE]))
> +		return PTR_ERR(se->icc_path[GENI_TO_CORE]);
> +
> +	se->icc_path[CPU_TO_GENI] = of_icc_get(se->dev, "qup-config");
> +	if (IS_ERR(se->icc_path[CPU_TO_GENI])) {
> +		icc_put(se->icc_path[GENI_TO_CORE]);
> +		se->icc_path[GENI_TO_CORE] = NULL;
> +		return PTR_ERR(se->icc_path[CPU_TO_GENI]);
> +	}
> +
> +	return 0;
> +}
> +
> +void geni_serial_icc_put(struct geni_se *se)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(se->icc_path); i++) {
> +		icc_put(se->icc_path[i]);
> +		se->icc_path[i] = NULL;
> +	}
> +}
> +
>  static int qcom_geni_serial_request_port(struct uart_port *uport)
>  {
>  	struct platform_device *pdev = to_platform_device(uport->dev);
> @@ -949,6 +978,12 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
>  	ser_clk_cfg = SER_CLK_EN;
>  	ser_clk_cfg |= clk_div << CLK_DIV_SHFT;
>  
> +	/* Put BW vote only on CPU path as driver supports FIFO mode only */
> +	port->se.avg_bw_cpu = Bps_to_icc(baud);
> +	port->se.peak_bw_cpu = Bps_to_icc(2 * baud);
> +	icc_set_bw(port->se.icc_path[CPU_TO_GENI], port->se.avg_bw_cpu,
> +			port->se.peak_bw_cpu);
> +
>  	/* parity */
>  	tx_trans_cfg = readl(uport->membase + SE_UART_TX_TRANS_CFG);
>  	tx_parity_cfg = readl(uport->membase + SE_UART_TX_PARITY_CFG);
> @@ -1179,11 +1214,20 @@ static void qcom_geni_serial_pm(struct uart_port *uport,
>  	if (old_state == UART_PM_STATE_UNDEFINED)
>  		old_state = UART_PM_STATE_OFF;
>  
> -	if (new_state == UART_PM_STATE_ON && old_state == UART_PM_STATE_OFF)
> +	if (new_state == UART_PM_STATE_ON && old_state == UART_PM_STATE_OFF) {
> +		/* Put BW vote for core clocks and CPU */
> +		icc_set_bw(port->se.icc_path[GENI_TO_CORE],
> +			port->se.avg_bw_core, port->se.peak_bw_core);
> +		icc_set_bw(port->se.icc_path[CPU_TO_GENI], port->se.avg_bw_cpu,
> +			port->se.peak_bw_cpu);
>  		geni_se_resources_on(&port->se);
> -	else if (new_state == UART_PM_STATE_OFF &&
> -			old_state == UART_PM_STATE_ON)
> +	} else if (new_state == UART_PM_STATE_OFF &&
> +			old_state == UART_PM_STATE_ON) {
>  		geni_se_resources_off(&port->se);
> +		/* Remove BW vote from core clocks and CPU */
> +		icc_set_bw(port->se.icc_path[GENI_TO_CORE], 0, 0);
> +		icc_set_bw(port->se.icc_path[CPU_TO_GENI], 0, 0);
> +	}
>  }
>  
>  static const struct uart_ops qcom_geni_console_pops = {
> @@ -1274,15 +1318,30 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
>  	port->rx_fifo_depth = DEF_FIFO_DEPTH_WORDS;
>  	port->tx_fifo_width = DEF_FIFO_WIDTH_BITS;
>  
> +	ret = geni_serial_icc_get(&port->se);
> +	if (ret)
> +		return ret;
> +	/* Set the bus quota to a reasonable value */
> +	port->se.avg_bw_core = console ? Bps_to_icc(1000) :
> +		Bps_to_icc(CORE_2X_50_MHZ);
> +	port->se.peak_bw_core = console ? Bps_to_icc(1000) :
> +		Bps_to_icc(CORE_2X_100_MHZ);
> +	port->se.avg_bw_cpu = Bps_to_icc(1000);
> +	port->se.avg_bw_cpu = Bps_to_icc(1000);

I guess you mean 'peak_bw_cpu'?
