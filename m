From: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 2/4] spi: imx: checkpatch cleanup
Date: Thu, 12 Feb 2015 04:42:18 -0800
Message-ID: <1423744938.15343.29.camel@perches.com>
References: <1423742848-15369-1-git-send-email-a.bouin@gmail.com>
	 <1423742848-15369-2-git-send-email-a.bouin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Aurelien BOUIN <a.bouin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1423742848-15369-2-git-send-email-a.bouin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thu, 2015-02-12 at 13:07 +0100, Aurelien BOUIN wrote:
> This patch solve various issue detected by checkpatch.pl

trivia:

> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
[]
> @@ -282,7 +282,8 @@ static unsigned int mx51_ecspi_clkdiv(unsigned int fin, unsigned int fspi,
>  		(post << MX51_ECSPI_CTRL_POSTDIV_OFFSET);
>  }
>  
> -static void __maybe_unused mx51_ecspi_intctrl(struct spi_imx_data *spi_imx, int enable)
> +static void __maybe_unused mx51_ecspi_intctrl(struct spi_imx_data *spi_imx,
> +		int enable)

Perhaps it'd be better to use this style:

__maybe_unused
static void foo(...)

ie:

__maybe_unused
static void mx51_ecspi_intctrl(struct spi_imx_data *spi_imx, int enable)

etc..

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
