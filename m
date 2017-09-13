From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 2/2] spi: Add ADI driver for Spreadtrum platform
Date: Wed, 13 Sep 2017 14:45:48 -0500
Message-ID: <20170913194548.qsyfyyboitz3mpcr@rob-hp-laptop>
References: <d1c5720eccf12ee5ea6bffcbe4c1555680638fcc.1504859001.git.baolin.wang@spreadtrum.com>
 <4573c724b795c569e1ccea2a1a4f6c0bdd602744.1504859001.git.baolin.wang@spreadtrum.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: broonie@kernel.org, mark.rutland@arm.com,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, baolin.wang@linaro.org
To: Baolin Wang <baolin.wang@spreadtrum.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4573c724b795c569e1ccea2a1a4f6c0bdd602744.1504859001.git.baolin.wang@spreadtrum.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, Sep 08, 2017 at 04:33:42PM +0800, Baolin Wang wrote:
> This patch adds ADI driver based on SPI framework for
> Spreadtrum SC9860 platform.
> 
> Signed-off-by: Baolin Wang <baolin.wang@spreadtrum.com>
> ---

[...]

> +++ b/drivers/spi/spi-sprd-adi.c
> @@ -0,0 +1,419 @@
> +/*
> + * Copyright (C) 2017 Spreadtrum Communications Inc.
> + *
> + * SPDX-License-Identifier: (GPL-2.0+ OR MIT)

Kernel code should generally not be MIT license.

[...]

> +static int sprd_adi_drain_fifo(struct sprd_adi *sadi)
> +{
> +	u32 timeout = ADI_FIFO_DRAIN_TIMEOUT;
> +	u32 sts;
> +
> +	do {
> +		sts = readl_relaxed(sadi->base + REG_ADI_ARM_FIFO_STS);
> +		if (sts & BIT_FIFO_EMPTY)
> +			break;
> +
> +		cpu_relax();
> +	} while (--timeout);

You can use readl_poll_timeout.

> +
> +	if (timeout == 0) {
> +		dev_err(sadi->dev, "drain write fifo timeout\n");
> +		return -EBUSY;
> +	}
> +
> +	return 0;
> +}
> +
> +static int sprd_adi_fifo_is_full(struct sprd_adi *sadi)
> +{
> +	return readl_relaxed(sadi->base + REG_ADI_ARM_FIFO_STS) & BIT_FIFO_FULL;
> +}
> +
> +static int sprd_adi_read(struct sprd_adi *sadi, u32 reg_paddr, u32 *read_val)
> +{
> +	int read_timeout = ADI_READ_TIMEOUT;
> +	u32 val, rd_addr;
> +
> +	/*
> +	 * Set the physical register address need to read into RD_CMD register,
> +	 * then ADI controller will start to transfer automatically.
> +	 */
> +	writel_relaxed(reg_paddr, sadi->base + REG_ADI_RD_CMD);
> +
> +	/*
> +	 * Wait read operation complete, the BIT_RD_CMD_BUSY will be set
> +	 * simultaneously when writing read command to register, and the
> +	 * BIT_RD_CMD_BUSY will be cleared after the read operation is
> +	 * completed.
> +	 */
> +	do {
> +		val = readl_relaxed(sadi->base + REG_ADI_RD_DATA);
> +		if (!(val & BIT_RD_CMD_BUSY))
> +			break;
> +
> +		cpu_relax();
> +	} while (--read_timeout);

readl_poll_timeout

> +
> +	if (read_timeout == 0) {
> +		dev_err(sadi->dev, "ADI read timeout\n");
> +		return -EBUSY;
> +	}
