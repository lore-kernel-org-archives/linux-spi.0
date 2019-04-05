From: Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [LINUX PATCH v2 3/3] spi: spi-mem: Add support for Zynq QSPI
 controller
Date: Fri, 5 Apr 2019 10:13:39 +0530
Message-ID: <c8f73eab-99eb-ddbc-9776-ea6b3a3ecf0f@ti.com>
References: <1554105553-20207-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: richard@nod.at, linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
 marek.vasut@gmail.com, linux-mtd@lists.infradead.org, nagasuresh12@gmail.com,
 dwmw2@infradead.org, michal.simek@xilinx.com
To: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
 <broonie@kernel.org>, <bbrezillon@kernel.org>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <1554105553-20207-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org



On 01/04/19 1:29 PM, Naga Sureshkumar Relli wrote:
> +/**
> + * zynq_qspi_config_op - Configure QSPI controller for specified transfer
> + * @xqspi:	Pointer to the zynq_qspi structure
> + * @qspi:	Pointer to the spi_device structure
> + *
> + * Sets the operational mode of QSPI controller for the next QSPI transfer and
> + * sets the requested clock frequency.
> + *
> + * Return:	0 on success and -EINVAL on invalid input parameter
> + *
> + * Note: If the requested frequency is not an exact match with what can be
> + * obtained using the prescalar value, the driver sets the clock frequency which
> + * is lower than the requested frequency (maximum lower) for the transfer. If
> + * the requested frequency is higher or lower than that is supported by the QSPI
> + * controller the driver will set the highest or lowest frequency supported by
> + * controller.
> + */
> +static int zynq_qspi_config_op(struct zynq_qspi *xqspi, struct spi_device *spi)
> +{
> +	u32 config_reg, baud_rate_val = 0;
> +
> +	/*
> +	 * Set the clock frequency
> +	 * The baud rate divisor is not a direct mapping to the value written
> +	 * into the configuration register (config_reg[5:3])
> +	 * i.e. 000 - divide by 2
> +	 *      001 - divide by 4
> +	 *      ----------------
> +	 *      111 - divide by 256
> +	 */
> +	while ((baud_rate_val < ZYNQ_QSPI_BAUD_DIV_MAX)  &&
> +	       (clk_get_rate(xqspi->refclk) / (2 << baud_rate_val)) >
> +		spi->max_speed_hz)
> +		baud_rate_val++;
> +

Instead use DIV_ROUND_UP, something like below should work(untested):

	unsigned long refclk_rate = clk_get_rate(xqspi->refclk);
	u32 baud_rate_val = DIV_ROUND_UP(refclk_rate, spi->max_speed_hz) - 1;

	if (baud_rate_val > ZYNQ_QSPI_BAUD_DIV_MAX)
		baud_rate_val = ZYNQ_QSPI_BAUD_DIV_MAX;

> +	config_reg = zynq_qspi_read(xqspi, ZYNQ_QSPI_CONFIG_OFFSET);
> +
> +	/* Set the QSPI clock phase and clock polarity */
> +	config_reg &= (~ZYNQ_QSPI_CONFIG_CPHA_MASK) &
> +		      (~ZYNQ_QSPI_CONFIG_CPOL_MASK);
> +	if (spi->mode & SPI_CPHA)
> +		config_reg |= ZYNQ_QSPI_CONFIG_CPHA_MASK;
> +	if (spi->mode & SPI_CPOL)
> +		config_reg |= ZYNQ_QSPI_CONFIG_CPOL_MASK;
> +
> +	config_reg &= ~ZYNQ_QSPI_CONFIG_BDRATE_MASK;
> +	config_reg |= (baud_rate_val << ZYNQ_QSPI_BAUD_DIV_SHIFT);
> +	zynq_qspi_write(xqspi, ZYNQ_QSPI_CONFIG_OFFSET, config_reg);
> +
> +	return 0;
> +}
> +

-- 
Regards
Vignesh

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
