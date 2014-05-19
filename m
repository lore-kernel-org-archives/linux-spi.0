From: "Ivan T. Ivanov" <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/4] spi: qup: Correct selection of FIFO/Block mode
Date: Mon, 19 May 2014 10:31:44 +0300
Message-ID: <1400484704.1464.4.camel@iivanov-dev>
References: <1400016884-9568-1-git-send-email-agross@codeaurora.org>
	 <1400016884-9568-3-git-send-email-agross@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Bjorn Andersson <bjorn.andersson-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org>
To: Andy Gross <agross-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1400016884-9568-3-git-send-email-agross-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, 2014-05-13 at 16:34 -0500, Andy Gross wrote:
> This patch fixes the calculation for determining whether to use FIFO or BLOCK
> mode.

<snip>

> @@ -368,7 +368,7 @@ static int spi_qup_io_config(struct spi_device *spi, struct spi_transfer *xfer)
>  	n_words = xfer->len / w_size;
>  	controller->w_size = w_size;
>  
> -	if (n_words <= controller->in_fifo_sz) {
> +	if (n_words <= (controller->in_fifo_sz / sizeof(u32))) {

Wouldn't be better to divide by w_size? Probably will not make
too much difference, but..

>  		mode = QUP_IO_M_MODE_FIFO;

Regards,
Ivan

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
