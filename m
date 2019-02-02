From: Boris Brezillon <bbrezillon@kernel.org>
Subject: Re: [PATCH v3 11/13] spi: atmel-quadspi: add support for named
 peripheral clock
Date: Sat, 2 Feb 2019 08:16:25 +0100
Message-ID: <20190202081625.58a0be1d@bbrezillon>
References: <20190202040653.1217-1-tudor.ambarus@microchip.com>
        <20190202040653.1217-12-tudor.ambarus@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <Cyrille.Pitchen@microchip.com>,
        <bugalski.piotr@gmail.com>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
To: <Tudor.Ambarus@microchip.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190202040653.1217-12-tudor.ambarus@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Sat, 2 Feb 2019 04:07:41 +0000
<Tudor.Ambarus@microchip.com> wrote:

> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> Naming clocks is a good practice. Keep supporting unnamed
> peripheral clock, to be backward compatible with old DTs.
> While here, rename clk to pclk, to indicate that it is a
> peripheral clock.
> 
> Suggested-by: Boris Brezillon <bbrezillon@kernel.org>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>

> ---
> v3: new patch
> 
>  drivers/spi/atmel-quadspi.c | 33 ++++++++++++++++++---------------
>  1 file changed, 18 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
> index bfa5f5e92d96..c9548942535a 100644
> --- a/drivers/spi/atmel-quadspi.c
> +++ b/drivers/spi/atmel-quadspi.c
> @@ -136,7 +136,7 @@
>  struct atmel_qspi {
>  	void __iomem		*regs;
>  	void __iomem		*mem;
> -	struct clk		*clk;
> +	struct clk		*pclk;
>  	struct platform_device	*pdev;
>  	u32			pending;
>  	u32			smm;
> @@ -338,7 +338,7 @@ static int atmel_qspi_setup(struct spi_device *spi)
>  	if (!spi->max_speed_hz)
>  		return -EINVAL;
>  
> -	src_rate = clk_get_rate(aq->clk);
> +	src_rate = clk_get_rate(aq->pclk);
>  	if (!src_rate)
>  		return -EINVAL;
>  
> @@ -429,15 +429,18 @@ static int atmel_qspi_probe(struct platform_device *pdev)
>  	}
>  
>  	/* Get the peripheral clock */
> -	aq->clk = devm_clk_get(&pdev->dev, NULL);
> -	if (IS_ERR(aq->clk)) {
> +	aq->pclk = devm_clk_get(&pdev->dev, "pclk");
> +	if (IS_ERR(aq->pclk))
> +		aq->pclk = devm_clk_get(&pdev->dev, NULL);
> +
> +	if (IS_ERR(aq->pclk)) {
>  		dev_err(&pdev->dev, "missing peripheral clock\n");
> -		err = PTR_ERR(aq->clk);
> +		err = PTR_ERR(aq->pclk);
>  		goto exit;
>  	}
>  
>  	/* Enable the peripheral clock */
> -	err = clk_prepare_enable(aq->clk);
> +	err = clk_prepare_enable(aq->pclk);
>  	if (err) {
>  		dev_err(&pdev->dev, "failed to enable the peripheral clock\n");
>  		goto exit;
> @@ -448,25 +451,25 @@ static int atmel_qspi_probe(struct platform_device *pdev)
>  	if (irq < 0) {
>  		dev_err(&pdev->dev, "missing IRQ\n");
>  		err = irq;
> -		goto disable_clk;
> +		goto disable_pclk;
>  	}
>  	err = devm_request_irq(&pdev->dev, irq, atmel_qspi_interrupt,
>  			       0, dev_name(&pdev->dev), aq);
>  	if (err)
> -		goto disable_clk;
> +		goto disable_pclk;
>  
>  	err = atmel_qspi_init(aq);
>  	if (err)
> -		goto disable_clk;
> +		goto disable_pclk;
>  
>  	err = spi_register_controller(ctrl);
>  	if (err)
> -		goto disable_clk;
> +		goto disable_pclk;
>  
>  	return 0;
>  
> -disable_clk:
> -	clk_disable_unprepare(aq->clk);
> +disable_pclk:
> +	clk_disable_unprepare(aq->pclk);
>  exit:
>  	spi_controller_put(ctrl);
>  
> @@ -480,7 +483,7 @@ static int atmel_qspi_remove(struct platform_device *pdev)
>  
>  	spi_unregister_controller(ctrl);
>  	writel_relaxed(QSPI_CR_QSPIDIS, aq->regs + QSPI_CR);
> -	clk_disable_unprepare(aq->clk);
> +	clk_disable_unprepare(aq->pclk);
>  	return 0;
>  }
>  
> @@ -488,7 +491,7 @@ static int __maybe_unused atmel_qspi_suspend(struct device *dev)
>  {
>  	struct atmel_qspi *aq = dev_get_drvdata(dev);
>  
> -	clk_disable_unprepare(aq->clk);
> +	clk_disable_unprepare(aq->pclk);
>  
>  	return 0;
>  }
> @@ -497,7 +500,7 @@ static int __maybe_unused atmel_qspi_resume(struct device *dev)
>  {
>  	struct atmel_qspi *aq = dev_get_drvdata(dev);
>  
> -	clk_prepare_enable(aq->clk);
> +	clk_prepare_enable(aq->pclk);
>  
>  	return atmel_qspi_init(aq);
>  }
