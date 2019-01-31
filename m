From: Boris Brezillon <bbrezillon@kernel.org>
Subject: Re: [PATCH 9/9] spi: atmel-quadspi: add support for sam9x60 qspi
 controller
Date: Thu, 31 Jan 2019 12:55:19 +0100
Message-ID: <20190131125504.3eff449d@bbrezillon>
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

> +
> +static int atmel_sam9x60_qspi_set_cfg(struct atmel_qspi *aq,
> +				      const struct spi_mem_op *op,
> +				      struct atmel_qspi_cfg *cfg)
> +{
> +	int ret = atmel_qspi_set_mode(cfg, op);
> +
> +	if (ret)
> +		return ret;
> +
> +	cfg->icr = QSPI_ICR_INST(op->cmd.opcode);
> +
> +	if (!op->addr.nbytes) {
> +		cfg->ifr |= QSPI_IFR_TFRTYP_TRSFR_REG;
> +		if (op->data.dir == SPI_MEM_DATA_OUT)
> +			cfg->ifr |= QSPI_IFR_APBTFRTYP_WRITE;
> +		else
> +			cfg->ifr |= QSPI_IFR_APBTFRTYP_READ;
> +	} else {
> +		cfg->ifr |= QSPI_IFR_TFRTYP_TRSFR_MEM;

Why do you use a MEM transfer here? What's the difference with a
regular transfer?

> +	}
> +
> +	/* Set data enable */
> +	if (op->data.nbytes)
> +		cfg->ifr |= QSPI_IFR_DATAEN;
> +
> +	ret = atmel_qspi_set_address_mode(cfg, op);
> +	if (ret)
> +		return ret;
>  
>  	/* Clear pending interrupts */
>  	(void)atmel_qspi_readl(aq, QSPI_SR);
>  
>  	/* Set QSPI Instruction Frame registers */
> -	atmel_qspi_writel(aq, QSPI_IAR, iar);
> -	atmel_qspi_writel(aq, QSPI_ICR, icr);
> -	atmel_qspi_writel(aq, QSPI_IFR, ifr);
> +	atmel_qspi_writel(aq, QSPI_IAR, cfg->iar);
> +	if (op->data.dir == SPI_MEM_DATA_OUT)
> +		atmel_qspi_writel(aq, QSPI_ICR, cfg->icr);
> +	else
> +		atmel_qspi_writel(aq, QSPI_RICR, cfg->icr);
> +	atmel_qspi_writel(aq, QSPI_IFR, cfg->ifr);
> +
> +	return 0;
> +}
