From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v11 2/3] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller
 driver
Date: Mon, 22 Apr 2019 21:32:45 +0300
Message-ID: <d2a7a471-2847-b774-42b1-9feb8f4c69f3@cogentembedded.com>
References: <1555903925-15292-1-git-send-email-masonccyang@mxic.com.tw>
 <1555903925-15292-3-git-send-email-masonccyang@mxic.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw
To: Mason Yang <masonccyang@mxic.com.tw>, broonie@kernel.org,
        marek.vasut@gmail.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, bbrezillon@kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1555903925-15292-3-git-send-email-masonccyang@mxic.com.tw>
Content-Language: en-MW
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 04/22/2019 06:32 AM, Mason Yang wrote:

> Add a driver for Renesas R-Car Gen3 RPC-IF SPI controller.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
[...]

  Do dote that I'm opposed to the driver separation as it's presented in
this patches, and I have a large patch reworking both MFD and SPI drivers
in the works.

> diff --git a/drivers/spi/spi-renesas-rpc.c b/drivers/spi/spi-renesas-rpc.c
> new file mode 100644
> index 0000000..634222d
> --- /dev/null
> +++ b/drivers/spi/spi-renesas-rpc.c
> @@ -0,0 +1,571 @@
[...]
> +static int rpc_spi_probe(struct platform_device *pdev)
> +{
> +	struct spi_controller *ctlr;
> +	struct rpc_mfd *rpc_mfd = dev_get_drvdata(pdev->dev.parent);
> +	struct rpc_spi *rpc;
> +	int ret;
> +
> +	ctlr = spi_alloc_master(&pdev->dev, sizeof(*rpc));
> +	if (!ctlr)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, ctlr);
> +
> +	rpc = spi_controller_get_devdata(ctlr);
> +
> +	rpc->mfd = rpc_mfd;
> +	ctlr->dev.of_node = pdev->dev.parent->of_node;
> +
> +	pm_runtime_enable(&pdev->dev);
> +	ctlr->auto_runtime_pm = true;
> +
> +	ctlr->num_chipselect = 1;
> +	ctlr->mem_ops = &rpc_spi_mem_ops;
> +	ctlr->transfer_one_message = rpc_spi_transfer_one_message;
> +
> +	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
> +	ctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_TX_QUAD | SPI_RX_QUAD;
> +
> +	pm_runtime_get_sync(&pdev->dev);
> +	rpc_spi_hw_init(rpc);
> +	pm_runtime_put(&pdev->dev);
> +
> +	ret = spi_register_controller(ctlr);
> +	if (ret) {
> +		dev_err(&pdev->dev, "spi_register_controller failed\n");
> +		goto err_put_ctlr;
> +	}
> +
> +	return 0;

   Previous formatting was better, shouldn't have moved the empty line above
*return*...

> +err_put_ctlr:
> +	spi_controller_put(ctlr);
> +	pm_runtime_disable(&pdev->dev);
> +
> +	return ret;
> +}
[...]

MBR, Sergei
