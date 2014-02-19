From: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
Subject: Re: [RFT][PATCH v3] spi: clps711x: Refactor to use core message
 parsing
Date: Wed, 19 Feb 2014 23:22:39 +0400
Message-ID: <20140219232239.73c05e8e1b5edceefffffe42@mail.ru>
References: <1392714954.25855.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1392714954.25855.1.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, 18 Feb 2014 17:15:54 +0800
Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org> wrote:

> Convert to use default implementation of transfer_one_message() which provides
> standard handling of delays and chip select management.
> 
> Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
> ---
...

I tested this patch slightly modified, since I use DT only system now,
nevertheless, changes work for me, so that

Tested-by: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>

-- 
Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
