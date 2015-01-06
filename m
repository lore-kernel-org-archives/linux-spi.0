From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH] spi: orion: Add multiple chip select support for Armada
 370 and 375
Date: Tue, 6 Jan 2015 22:47:56 +0100
Message-ID: <20150106214756.GE25030@lunn.ch>
References: <1420579846-31962-1-git-send-email-ken.wilson@opengear.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: robh+dt@kernel.org, mark.rutland@arm.com,
	devicetree@vger.kernel.org, linux@arm.linux.org.uk,
	pawel.moll@arm.com, ijc+devicetree@hellion.org.uk,
	gerg@uclinux.org, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org, broonie@kernel.org,
	ezequiel.garcia@free-electrons.com, galak@codeaurora.org,
	linux-arm-kernel@lists.infradead.org
To: Ken Wilson <ken.wilson@opengear.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1420579846-31962-1-git-send-email-ken.wilson@opengear.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Ken

> -static const struct orion_spi_dev armada_spi_dev_data = {
> +static const struct orion_spi_dev armada_370_spi_dev_data = {
>  	.typ = ARMADA_SPI,
>  	.min_divisor = 1,
>  	.max_divisor = 1920,
>  	.prescale_mask = ARMADA_SPI_CLK_PRESCALE_MASK,
> +	.num_cs = 4,
> +};
> +
> +static const struct orion_spi_dev armada_375_spi_dev_data = {
> +	.typ = ORION_SPI,
> +	.min_divisor = 4,
> +	.max_divisor = 30,
> +	.prescale_mask = ORION_SPI_CLK_PRESCALE_MASK,
> +	.num_cs = 3,
>  };

Documentation/devicetree/bindings/spi/spi-bus.txt has the optional property:

- num-cs : total number of chipselects

Would it be better to use that?

      Andrew
