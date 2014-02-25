From: Atsushi Nemoto <anemo-7JcRY8pycbNHfZP73Gtkiw@public.gmane.org>
Subject: Re: [PATCH v3] spi: core: Validate length of the transfers in
 message
Date: Tue, 25 Feb 2014 22:55:28 +0900 (JST)
Message-ID: <20140225.225528.453119424.anemo@mba.ocn.ne.jp>
References: <1392890528-7417-1-git-send-email-iivanov@mm-sol.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gsi-ynQEQJNshbs@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1392890528-7417-1-git-send-email-iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thu, 20 Feb 2014 12:02:08 +0200, "Ivan T. Ivanov" <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org> wrote:
> SPI transfer length should be multiple of SPI word size,
> where SPI word size should be power-of-two multiple
...
> +		n_words = xfer->len / w_size;
> +		/* No partial transfers accepted */
> +		if (!n_words || xfer->len % w_size)
> +			return -EINVAL;

Is xfer->len == 0 invalid?
Long time ago I have fixed atmel spi driver to support zero length
transfer (commit 06719814 atmel_spi: support zero length transfer).

According to Documentation/spi/spi-summary, zeto length transfer seems
valid.

      + optionally defining short delays after transfers ... using
        the spi_transfer.delay_usecs setting (this delay can be the
        only protocol effect, if the buffer length is zero);

---
Atsushi Nemoto
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
