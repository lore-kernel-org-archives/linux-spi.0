From: "Ivan T. Ivanov" <iivanov@mm-sol.com>
Subject: Re: [PATCH v3] spi: qup: Add DMA capabilities
Date: Wed, 04 Mar 2015 10:38:10 +0200
Message-ID: <1425458290.5705.2.camel@mm-sol.com>
References: <1425056312-13746-1-git-send-email-stanimir.varbanov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Kumar Gala <galak@codeaurora.org>,
	Andy Gross <agross@codeaurora.org>,
	Sagar Dharia <sdharia@codeaurora.org>,
	Daniel Sneddon <dsneddon@codeaurora.org>
To: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425056312-13746-1-git-send-email-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


Hi Stan,

It looks good now, except it doesn't apply and two small issues below:

On Fri, 2015-02-27 at 18:58 +0200, Stanimir Varbanov wrote:
> From: Andy Gross <agross@codeaurora.org>
> 
> This patch adds DMA capabilities to the spi-qup driver.  If DMA channels are
> present, the QUP will use DMA instead of block mode for transfers to/from SPI
> peripherals for transactions larger than the length of a block.
> 
> Signed-off-by: Andy Gross <agross@codeaurora.org>
> Signed-off-by: Stanimir Varbanov varbanov@linaro.org>
> ---
> 
> v2 -> v3
>  - now using one dma done callback on rx channel if bidirectional transfer
>    and on tx channel if only transmit transfer
>  - rearranged the spi_qup_transfer_one() in order to reuse wait for
>    completion and completion init code
>  - move dma init function early in .probe to avoid controller reset if
>    probe deffer
>  - add function to get controller mode

<snip>

> 
> +
> +static int spi_qup_init_dma(struct spi_master *master, resource_size_t base)
> +{
> 

<snip>

> +
> +       /* set DMA parameters */
> +       rx_conf->direction = DMA_DEV_TO_MEM;
> +       rx_conf->device_fc = 1;

Strictly speeching this is a bool not int.

> +       rx_conf->src_addr = base + QUP_INPUT_FIFO;
> +       rx_conf->src_maxburst = spi->in_blk_sz;
> +
> +       tx_conf->direction = DMA_MEM_TO_DEV;
> +       tx_conf->device_fc = 1;

Same here.


> @@ -553,6 +813,8 @@ static int spi_qup_probe(struct platform_device *pdev)
>         master->transfer_one = spi_qup_transfer_one;
>         master->dev.of_node = pdev->dev.of_node;
>         master->auto_runtime_pm = true;
> +       master->dma_alignment = dma_get_cache_alignment();
> +       master->max_dma_len = SPI_MAX_DMA_XFER;
> 
>         platform_set_drvdata(pdev, master);
> 
> @@ -564,6 +826,12 @@ static int spi_qup_probe(struct platform_device *pdev)
>         controller->cclk = cclk;
>         controller->irq = irq;
> 
> +       ret = spi_qup_init_dma(master, res->start);
> +       if (ret == -EPROBE_DEFER)
> +               goto error;
> +       else if (!ret)
> +               master->can_dma = spi_qup_can_dma;
> +
>         /* set v1 flag if device is version 1 */
>         if (of_device_is_compatible(dev->of_node, "qcom,spi-qup-v1.1.1"))
>                 controller->qup_v1 = 1;

It is not visible from this patch, but in case of error reseting
SPI controller (QUP_STATE_RESET), exit error path should be 
'error_dma' and not 'error' label.

> @@ -624,7 +892,7 @@ static int spi_qup_probe(struct platform_device *pdev)
>         ret = devm_request_irq(dev, irq, spi_qup_qup_irq,
>                                                                                 
> IRQF_TRIGGER_HIGH, pdev->name, controller);
>         if (ret)
> -               goto error;
> +               goto error_dma;
> 
>         pm_runtime_set_autosuspend_delay(dev, MSEC_PER_SEC);
>         pm_runtime_use_autosuspend(dev);
> @@ -639,6 +907,8 @@ static int spi_qup_probe(struct platform_device *pdev)
> 
>  disable_pm:
>         pm_runtime_disable(&pdev->dev);
> +error_dma:
> +       spi_qup_release_dma(master);
>  error:
>         clk_disable_unprepare(cclk);
>         clk_disable_unprepare(iclk);
> @@ -730,6 +1000,8 @@ static int spi_qup_remove(struct platform_device *pdev)
>         if (ret)
>                 return ret;
> 
> +       spi_qup_release_dma(master);
> +
>         clk_disable_unprepare(controller->cclk);
>         clk_disable_unprepare(controller->iclk);
> 

Regards,
Ivan
