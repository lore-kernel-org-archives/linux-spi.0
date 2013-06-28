From: Ryan Mallon <rmallon@gmail.com>
Subject: Re: [PATCH 3/8] spi: spi-ep93xx: always handle transfer specific
 settings
Date: Sat, 29 Jun 2013 09:17:46 +1000
Message-ID: <51CE199A.4040606@gmail.com>
References: <201306281143.35130.hartleys@visionengravers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	spi-devel-general@lists.sourceforge.net, mika.westerberg@iki.fi,
	broonie@kernel.org, grant.likely@linaro.org
To: H Hartley Sweeten <hartleys@visionengravers.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201306281143.35130.hartleys@visionengravers.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 29/06/13 04:43, H Hartley Sweeten wrote:

> __spi_async(), which starts every SPI message transfer, initializes
> the bits_per_word and max speed for every transfer in the message.
> Since the conditional test in ep93xx_spi_process_transfer() will
> always succeed just remove it and always call ep93xx_spi_chip_setup()
> to configure the hardware for each transfer in the message.
> 
> Remove the redundant ep93xx_spi_chp_setup() in ep93xx_spi_process_transfer()
> which just initializes the hardware to the "default" based on the SPI
> device.
> 
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Ryan Mallon <rmallon@gmail.com>
> Cc: Mika Westerberg <mika.westerberg@iki.fi>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Grant Likely <grant.likely@linaro.org>
> ---


> +	err = ep93xx_spi_calc_divisors(espi, chip, t->speed_hz);
> +	if (err) {
> +		dev_err(&espi->pdev->dev, "failed to adjust speed\n");


Printing out the speed it was trying to set might be useful here?

~Ryan
