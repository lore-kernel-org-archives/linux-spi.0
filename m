From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] spi: sh-msiof: Fix limit maximum word transfer size of
 FIFO size
Date: Mon, 16 Mar 2015 08:50:31 +0100
Message-ID: <CAMuHMdWVRCpF72tS7pQc-cwSMTU-mbqJWtjPtjDSe8YNo-dpqw@mail.gmail.com>
References: <1426127476-18456-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
	<CAMuHMdXmr7QH8jSkyH2q6xCise7ew5YzyAFc6Zb0psHZt3mGrg@mail.gmail.com>
	<CABMQnVK=-okU4L8vCnY15Vpwy9uCoOLzmnOPkpxj4=U6JXzSOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie@kernel.org>,
	Linux-sh list <linux-sh@vger.kernel.org>,
	linux-spi <linux-spi@vger.kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <CABMQnVK=-okU4L8vCnY15Vpwy9uCoOLzmnOPkpxj4=U6JXzSOg@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Iwamatsu-san,

On Mon, Mar 16, 2015 at 2:18 AM, Nobuhiro Iwamatsu
<nobuhiro.iwamatsu.yj@renesas.com> wrote:
> 2015-03-12 21:35 GMT+09:00 Geert Uytterhoeven <geert@linux-m68k.org>:
>> On Thu, Mar 12, 2015 at 3:31 AM, Nobuhiro Iwamatsu
>> <nobuhiro.iwamatsu.yj@renesas.com> wrote:

>>> -       /* limit maximum word transfer to rx/tx fifo size */
>>> -       if (tx_buf)
>>> -               words = min_t(int, words, p->tx_fifo_size);
>>> -       if (rx_buf)
>>> -               words = min_t(int, words, p->rx_fifo_size);

>> Sorry, I fail to see what exactly this is fixing.
>>
>> If SPI_MASTER_MUST_TX is set, all hardware SPI transfers are either
>>   a) transmit-only.
>>   b) bidirectional (transmit buffer may be a dummy, provided by the SPI core).
>>
>> For case a, only the TX FIFO size matters.
>>   - The original code ignored the RX FIFO size (rx_buf == NULL),
>>   - After your change, it always uses the minimum of the TX and RX FIFO sizes
>>     (granted, the RX FIFO size is larger, so this doesn't make a difference on
>>     current hardware).
>
> Yes.
>
>>
>> For case b, both FIFO sizes matter, and the original code handled that fine
>> (tx_buf != NULL, rx_buf != NULL).
>>
>> What am I missing?
>> Are you using a backport with broken SPI_MASTER_MUST_TX handling in the SPI
>> core?
>
> When tx_buf != NULL and rx_buf != NULL, current code uses FIFO size of
> rx_buffer.
> Since TX FIFO size is smaller than RX FIFO  size, corrent code set the
> wrong value to SITMDR2 register.

if tx_buf != NULL and rx_buf != NULL, current code does:

    words = min_t(int, words, p->tx_fifo_size);
    words = min_t(int, words, p->rx_fifo_size);

Hence words will be the minimum of the original value of words, tx_fifo_size,
and rx_fifo_size. What's wrong about that?

> Therefore, this patch selects a smaller FIFO size, adds the function to set.
>
> Does this has become a description?
>
>>
>> I've just verified that with today's tree (renesas-drivers-2015-03-12-v4.0-rc3),
>> SPI_MASTER_MUST_TX works fine, and a dummy tx_buf is passed when needed.
>
> I think correctly work on hardware. However, driver has been set to
> the correct register value?

I printed the value of words, which is passed to sh_msiof_spi_set_mode_regs().

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
