From: "Ivan T. Ivanov" <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2] spi: core: Validate lenght of the transfers in
 message
Date: Mon, 17 Feb 2014 17:20:00 +0200
Message-ID: <1392650400.17130.12.camel@iivanov-dev>
References: <1392444566-23605-1-git-send-email-iivanov@mm-sol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Gerhard Sittig <gsi-ynQEQJNshbs@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1392444566-23605-1-git-send-email-iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


Hi, Please ignore this patch.

On Sat, 2014-02-15 at 08:09 +0200, Ivan T. Ivanov wrote:

> 
> +		/*
> +		 * SPI transfer length should be multiple of SPI word size
> +		 * where SPI word size should be power-of-two multiple
> +		 */
> +		if (xfer->bits_per_word <= 8)
> +			w_size = 1;
> +		else if (xfer->bits_per_word <= 16)
> +			w_size = 2;
> +		else
> +			w_size = 4;
> +
> +		n_words = xfer->len / w_size;
> +		/* No partial transfers accepted */
> +		if (!n_words || xfer->len % xfer->bits_per_word)

This should be
if (!n_words || xfer->len % w_size)


Regards,
Ivan

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
