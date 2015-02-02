From: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] spi: tegra114: cleanup wait_for_completion return handling
Date: Mon, 2 Feb 2015 14:34:21 +0530
Message-ID: <54CF3D95.3060607@nvidia.com>
References: <1422798911-1626-1-git-send-email-hofrat@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1422798911-1626-1-git-send-email-hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Sunday 01 February 2015 07:25 PM, Nicholas Mc Guire wrote:
> return type of wait_for_completion_timeout is unsigned long not int, this
> patch adds an appropriate variable and fixes up the assignment.
> As the string in dev_err already explicitly states "timeout" there
> is little point in printing the 0 here which also just says "timeout".
>
Looks good to me. Thanks for fixing this.
I think it is good if we fix the typo here also.

Acked-by: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

> +		if (WARN_ON(dma_timeout == 0)) {
> +			dev_err(tspi->dev, "spi trasfer timeout\n");
trasfer->transfer

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
