From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v17 1/2] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller
 driver
Date: Mon, 23 Dec 2019 23:07:12 +0300
Message-ID: <0e65db61-00e5-73cc-347a-023abfd138ba@cogentembedded.com>
References: <1565060061-11588-1-git-send-email-masonccyang@mxic.com.tw>
 <1565060061-11588-2-git-send-email-masonccyang@mxic.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        lee.jones@linaro.org, marek.vasut@gmail.com,
        miquel.raynal@bootlin.com
To: Mason Yang <masonccyang@mxic.com.tw>, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1565060061-11588-2-git-send-email-masonccyang@mxic.com.tw>
Content-Language: en-MW
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hello!

On 08/06/2019 05:54 AM, Mason Yang wrote:

> Add a driver for Renesas R-Car Gen3 RPC-IF SPI controller.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

   Mark Brown did have some comments to my variant of the RPC-IF SPI driver,
which didn't get addressed in your SPI driver... Relaying his comments to you,
I'd appreciate if you could reply to them...

[...]
> diff --git a/drivers/spi/spi-renesas-rpc.c b/drivers/spi/spi-renesas-rpc.c
> new file mode 100644
> index 0000000..52537b7
> --- /dev/null
> +++ b/drivers/spi/spi-renesas-rpc.c
> @@ -0,0 +1,756 @@
[...]
> +static void rpc_spi_transfer_setup(struct rpc_spi *rpc,
> +				   struct spi_message *msg)
> +{
> +	struct spi_transfer *t, xfer[4] = { };

Don't mix initialized and non-initialized declarations in a single line
(as per coding style).

> +	u32 i, xfercnt, xferpos = 0;
> +
> +	rpc->totalxferlen = 0;
> +	rpc->xfer_dir = SPI_MEM_NO_DATA;
> +
> +	list_for_each_entry(t, &msg->transfers, transfer_list) {
> +		if (t->tx_buf) {
> +			xfer[xferpos].tx_buf = t->tx_buf;
> +			xfer[xferpos].tx_nbits = t->tx_nbits;

xfer is hard coded to 4 elements but I'm not seeing any validation that
we don't have more transfers than that in the message, and there's lots
of assumptions later on about the number of transfers.

[...]
> +		if (list_is_last(&t->transfer_list, &msg->transfers)) {
> +			if (xferpos > 1) {
> +				if (t->rx_buf) {
> +					rpc->xfer_dir = SPI_MEM_DATA_IN;
> +					rpc->smcr = RPC_SMCR_SPIRE;
> +				} else if (t->tx_buf) {
> +					rpc->xfer_dir = SPI_MEM_DATA_OUT;
> +					rpc->smcr = RPC_SMCR_SPIWE;
> +				}
> +			}

Transfers can be bidirectional...  if the device can't support that it
should set SPI_CONTROLLER_HALF_DUPLEX.

[...]
> +static inline int rpc_spi_xfer_message(struct rpc_spi *rpc,
> +				       struct spi_transfer *data_xfer)

This has exactly one caller and contains a single statement - why have a
separate function?

> +{
> +	int ret;
> +
> +	ret = rpc_spi_set_freq(rpc, data_xfer->speed_hz);
> +	if (ret)
> +		return ret;
> +
> +	ret = rpc_spi_io_xfer(rpc,
> +			      rpc->xfer_dir == SPI_MEM_DATA_OUT ?
> +			      data_xfer->tx_buf : NULL,
> +			      rpc->xfer_dir == SPI_MEM_DATA_IN ?
> +			      data_xfer->rx_buf : NULL);

This is really hard to read.  Why are we abusing the ternery operator
here, especially when there's other places where we already set things
up based on the direction?

[...]
[...]
> +static int rpc_spi_remove(struct platform_device *pdev)
> +{
> +	struct spi_controller *ctlr = platform_get_drvdata(pdev);
> +
> +	pm_runtime_disable(&pdev->dev);
> +	spi_unregister_controller(ctlr);
> +
> +	return 0;
> +}
> +

Shouldn't we unregister the controller before we disable the RPM?  The
probe was the other way around and this means that we might still be
processing messages while the hardware is disabled which doesn't seem
good.

[...]

MBR, Sergei
