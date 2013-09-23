From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [RESEND] spi/tegra114: Correct support for cs_change
Date: Mon, 23 Sep 2013 12:51:52 -0600
Message-ID: <52408DC8.3020407@wwwdotorg.org>
References: <1379528245-6283-1-git-send-email-rklein@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
To: Rhyland Klein <rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1379528245-6283-1-git-send-email-rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 09/18/2013 12:17 PM, Rhyland Klein wrote:
> The tegra114 driver wasn't currently handling the cs_change functionality.
> It is meant to invert normal behavior, and we were only using it to possibly
> delay at the end of a transfer.

I don't really follow this patch description well. It may help if you
fully spelled out the definition of normal behaviour, what the driver
was doing, and what it should be doing (which is presumable what it does
do after this patch).

> This patch modifies the logic so that the cs state will be toggled after
> every individual transfer or NOT toggled at the end of the last transfer
> if cs_change is set in that transfer struct.
> 
> Also, this builds in logic so that if a different device tries to start
> a transfer while CS is active from a different device, it will abort the
> previous transfer and start a new one for the new device.

What user-visible impact does this patch have. Does it solve a bug, or
improve performance, or ...? In other words, how would I test this
patch, other that testing for regressions in SPI functionality that I
know already works.

BTW, I don't think you're using get_maintainer.pl, since Mark Brown is
the SPI maintainer now, not Grant Likely.

> diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
> index 145dd43..a9973de 100644
> --- a/drivers/spi/spi-tegra114.c
> +++ b/drivers/spi/spi-tegra114.c
> @@ -182,6 +182,7 @@ struct tegra_spi_data {
>  	u32					cur_speed;
>  
>  	struct spi_device			*cur_spi;
> +	struct spi_device			*cs_control;
>  	unsigned				cur_pos;
>  	unsigned				cur_len;
>  	unsigned				words_per_32bit;
> @@ -717,7 +718,12 @@ static int tegra_spi_start_transfer_one(struct spi_device *spi,
>  		else if (req_mode == SPI_MODE_3)
>  			command1 |= SPI_CONTROL_MODE_3;
>  
> -		tegra_spi_writel(tspi, command1, SPI_COMMAND1);
> +		if (tspi->cs_control) {
> +			if (tspi->cs_control != spi)
> +				tegra_spi_writel(tspi, command1, SPI_COMMAND1);

Do you really need a separate write call there? The value of command1
isn't fully set up there (the CS bits are all set up immediately after),
so won't that glitch the CS lines in some cases?

> +			tspi->cs_control = NULL;
> +		} else
> +			tegra_spi_writel(tspi, command1, SPI_COMMAND1);
>  
>  		command1 |= SPI_CS_SW_HW;
>  		if (spi->mode & SPI_CS_HIGH)
> @@ -732,6 +738,9 @@ static int tegra_spi_start_transfer_one(struct spi_device *spi,
>  		command1 |= SPI_BIT_LENGTH(bits_per_word - 1);
>  	}
>  
> +	if (t->len == 0 && !t->tx_buf && !t->rx_buf)
> +		return 0;

What if !t->len, but t->tx_buf || t->rx_buf ?

This code is also duplicated in tegra_spi_transfer_one_message() after
this patch. Instead, perhaps the first N lines of
tegra_spi_start_transfer_one() should be split out into e.g.
tegra_spi_setup_transfer_one(), such that
tegra_spi_transfer_one_message() can always call it, plus have
tegra_spi_transfer_one_message() only call
tegra_spi_start_transfer_one() if (t->len != 0).
