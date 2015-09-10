From: Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Subject: Re: [PATCH 5/6] spi/bcm63xx: move register definitions into the driver
Date: Thu, 10 Sep 2015 12:10:36 -0700
Message-ID: <55F1D5AC.5020407@openwrt.org>
References: <1441894304-22316-1-git-send-email-jogo@openwrt.org> <1441894304-22316-6-git-send-email-jogo@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1441894304-22316-6-git-send-email-jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 10/09/15 07:11, Jonas Gorski wrote:
> Move all register definitions and structs into the driver. This allows
> us dropping the platform_data struct and drop any arch specific
> includes.
> 
> Since we now have full control over the message width, we can drop the
> size check, which was broken anyway, since it never set ret to any error
> code.
> 
> Also since we now have no arch depedendent resources, we can now allow
> compiling it for any arch, hidding behind COMPILE_TEST.
> 
> Signed-off-by: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
> ---

[snip]

> +	switch (resource_size(r)) {
> +	case SPI_6348_RSET_SIZE:
> +		bs->reg_offsets = bcm6348_spi_reg_offsets;
> +		bs->msg_type_shift = SPI_6348_MSG_TYPE_SHIFT;
> +		bs->msg_ctl_width = SPI_6348_MSG_CTL_WIDTH;
> +		bs->fifo_size = SPI_6348_MSG_DATA_SIZE;
> +		break;
> +	case SPI_6358_RSET_SIZE:
> +		bs->reg_offsets = bcm6358_spi_reg_offsets;
> +		bs->msg_type_shift = SPI_6358_MSG_TYPE_SHIFT;
> +		bs->msg_ctl_width = SPI_6358_MSG_CTL_WIDTH;
> +		bs->fifo_size = SPI_6358_MSG_DATA_SIZE;
>  		break;

This is a little fragile, I would rather create more specialized
platform_id names, like "bcm6348-spi" and "bcm6358-spi", very much like
what the FEC driver does, such that:

- you could directly pass this information as part of an additional
structure which specializes the instance of the driver
- the conversion to Device Tree in your other patches would make this
more natural or nearly identical

What do you think?
--
Florian
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
