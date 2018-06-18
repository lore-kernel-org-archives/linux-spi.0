From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH 03/11] spi: Add a driver for the Freescale/NXP QuadSPI
 controller
Date: Mon, 18 Jun 2018 21:27:40 +0200
Message-ID: <20180618212740.6b25c089@bbrezillon>
References: <1527686082-15142-1-git-send-email-frieder.schrempf@exceet.de>
        <1527686082-15142-4-git-send-email-frieder.schrempf@exceet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, richard@nod.at, miquel.raynal@bootlin.com,
        broonie@kernel.org, david.wolfe@nxp.com, fabio.estevam@nxp.com,
        prabhakar.kushwaha@nxp.com, yogeshnarayan.gaur@nxp.com,
        han.xu@nxp.com, linux-kernel@vger.kernel.org
To: Frieder Schrempf <frieder.schrempf@exceet.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1527686082-15142-4-git-send-email-frieder.schrempf@exceet.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Yogesh,

On Wed, 30 May 2018 15:14:32 +0200
Frieder Schrempf <frieder.schrempf@exceet.de> wrote:

> +static void fsl_qspi_select_mem(struct fsl_qspi *q, struct spi_device *spi)
> +{
> +	unsigned long rate = spi->max_speed_hz;
> +	int ret, i;
> +	u32 map_addr;
> +
> +	if (q->selected == spi->chip_select)
> +		return;
> +
> +	/*
> +	 * In HW there can be a maximum of four chips on two buses with
> +	 * two chip selects on each bus. We use four chip selects in SW
> +	 * to differentiate between the four chips.
> +	 * We use the SFA1AD, SFA2AD, SFB1AD, SFB2AD registers to select
> +	 * the chip we want to access.
> +	 */
> +	for (i = 0; i < 4; i++) {
> +		if (i < spi->chip_select)

Can you try with:

		if (i <= spi->chip_select)

and let me know if it fixes the problem you have when CS != 0?

> +			map_addr = q->memmap_phy;
> +		else
> +			map_addr = q->memmap_phy +
> +				   2 * q->devtype_data->ahb_buf_size;
> +
> +		qspi_writel(q, map_addr, q->iobase + QUADSPI_SFA1AD + (i * 4));
> +	}
> +
> +	if (needs_4x_clock(q))
> +		rate *= 4;
> +
> +	fsl_qspi_clk_disable_unprep(q);
> +
> +	ret = clk_set_rate(q->clk, rate);
> +	if (ret)
> +		return;
> +
> +	ret = fsl_qspi_clk_prep_enable(q);
> +	if (ret)
> +		return;
> +
> +	q->selected = spi->chip_select;
> +}
