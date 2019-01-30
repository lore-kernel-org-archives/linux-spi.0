From: Boris Brezillon <bbrezillon@kernel.org>
Subject: Re: [PATCH 9/9] spi: atmel-quadspi: add support for sam9x60 qspi
 controller
Date: Wed, 30 Jan 2019 18:43:13 +0100
Message-ID: <20190130184313.281f5374@bbrezillon>
References: <20190130150818.24902-1-tudor.ambarus@microchip.com>
        <20190130150818.24902-10-tudor.ambarus@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: <broonie@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
To: <Tudor.Ambarus@microchip.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190130150818.24902-10-tudor.ambarus@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, 30 Jan 2019 15:08:47 +0000
<Tudor.Ambarus@microchip.com> wrote:

> +static int atmel_sam9x60_qspi_clk_prepare_enable(struct atmel_qspi *aq)
> +{
> +	struct device *dev = &aq->pdev->dev;
> +	int ret;
> +
> +	if (!aq->clk) {
> +		/* Get the peripheral clock */
> +		aq->clk = devm_clk_get(dev, "pclk");
> +		if (IS_ERR(aq->clk)) {
> +			dev_err(dev, "missing peripheral clock\n");
> +			return PTR_ERR(aq->clk);
> +		}
> +	}
> +
> +	if (!aq->qspick) {
> +		/* Get the QSPI system clock */
> +		aq->qspick = devm_clk_get(dev, "qspick");
> +		if (IS_ERR(aq->qspick)) {
> +			dev_err(dev, "missing system clock\n");
> +			return PTR_ERR(aq->qspick);
> +		}
> +	}

Move the devm_clk_get() calls to the probe path instead of doing it at
prepare time, and you can make it generic for both compats with
something like:

	aq->clk = devm_clk_get(dev, "pclk");
	if (IS_ERR(aq->clk))
		aq->clk = devm_clk_get(dev, NULL);

	if (IS_ERR(aq->clk))
		return PTR_ERR(aq->clk);

	if (aq->caps->qspick_required) {
		aq->qspick = devm_clk_get(dev, "qspick");
		if (IS_ERR(aq->qspick)) {
			return PTR_ERR(aq->qspick);
	}

> +
> +	/* Enable the peripheral clock */
> +	ret = clk_prepare_enable(aq->clk);
> +	if (ret) {
> +		dev_err(dev, "failed to enable the peripheral clock\n");
> +		return ret;
> +	}
> +
> +	/* Enable the QSPI system clock */
> +	ret = clk_prepare_enable(aq->qspick);
> +	if (ret) {
> +		dev_err(dev, "failed to enable the QSPI system clock\n");
> +		clk_disable_unprepare(aq->clk);
> +	}

Again, you can make the enable function generic since
clk_prepare_enable(NULL) is a NO-OP that returns 0 and aq->qspick will
be NULL when it's not required.

> +
> +	return ret;
> +}
> +
> +static void atmel_sam9x60_qspi_clk_disable_unprepare(struct atmel_qspi *aq)
> +{
> +	clk_disable_unprepare(aq->qspick);
> +	clk_disable_unprepare(aq->clk);

Ditto.

> +}
