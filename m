From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/7] spi: core: Validate Tx/Rx buffers for non-zero length transfer
Date: Wed, 19 Mar 2014 23:43:55 +0800
Message-ID: <CAFRkauCUUOQ0xxa-k5_TMKUA7jnnz1FPjXnGT4T10v7upyOy8Q@mail.gmail.com>
References: <1395201227.16346.1.camel@phoenix>
	<CAMuHMdWCdp_SW5CNt50cSfG700JRU3tr=Pbyhv8nv-1Ve=XUNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	Fabrice Crohas <fcrohas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Illia Smyrnov <illia.smyrnov-hExfYMNmJl/Cnp4W7fqMDg@public.gmane.org>,
	Atsushi Nemoto <anemo-7JcRY8pycbNHfZP73Gtkiw@public.gmane.org>,
	Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdWCdp_SW5CNt50cSfG700JRU3tr=Pbyhv8nv-1Ve=XUNw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

2014-03-19 16:06 GMT+08:00 Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>:
> On Wed, Mar 19, 2014 at 4:53 AM, Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org> wrote:
>> Reject transfer if both tx_buf and rx_buf are NULL for non-zero length transfer.
>> Add the checking in spi core so we can remove the same checking in various
>> drivers.
>
> Just wondering: are there any SPI slave drivers that implement dummy cycles
> this way?

I think I found one such case:
drivers/net/wireless/libertas/if_spi.c
the dummy_trans has non-zero length, and both tx_buf and rx_buf are NULL.

But that means it doesn't work with master drivers with this checking, e.g.
all drivers using bitbang library has this checking.

Regards,
Axel
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
