From: Jean-Michel Hautbois <jean-michel.hautbois-JiVWUdsMzBtWk0Htik3J/w@public.gmane.org>
Subject: Re: spi-imx: wait_for_completion should timeout even in non-DMA
 transfer cases
Date: Mon, 21 Sep 2015 11:08:55 +0200
Message-ID: <CAH-u=816w-uGmWt-sf2AqahRL2j7RBCah8JAKOCXFFnvVdMzhw@mail.gmail.com>
References: <CAH-u=81E2RnMvm2UZxUasCSf6hMQtiMO9Y1VcNiy0pFR6Uy6vg@mail.gmail.com>
 <20150919175614.GM30445@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150919175614.GM30445-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

2015-09-19 19:56 GMT+02:00 Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>:
> On Fri, Sep 18, 2015 at 02:38:27PM +0200, Jean-Michel Hautbois wrote:
>> Hi,
>>
>> I am wondering why in spi-imx the spi_imx_pio_transfer() function is
>> calling wait_for_completion() and not wait_for_completion_timeout() =
as
>> in the spi_imx_dma_transfer() one.
>> I can't see a good reason for this, maybe should it be calculated
>> based on the spi clock and transfer->len, or at least be the same as
>> IMX_DMA_TIMEOUT which is 3 seconds ?
>> If you want it, I have a patch, just tell me if you are interested a=
nd
>> if you prefer a calculated timeout or even something else ?
>
> A calculated timeout is probably best.

Well, it depends...
If you have a 20MHz clock, then you can transfer a byte in 4=C2=B5s.
As most of the time pio_transfer is used for 8 to 32 bytes max, it
would be irrelevant to use such a small timeout.
I can obviously do it, but not sure if using a small (say, 100ms)
timeout would not be better.

JM
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
