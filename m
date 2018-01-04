From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Applied "spi: sh-msiof: Fix timeout failures for TX-only DMA
 transfers" to the spi tree
Date: Thu, 4 Jan 2018 09:26:31 +0100
Message-ID: <CAMuHMdVnYeQhdnJvaXWzjeH4LF_RJ_VdXMuJCjRqcPFABtveuw@mail.gmail.com>
References: <E1eWn56-0005rw-N5@debutante> <ff4bca03-24aa-e77b-23ad-63ea01b98a2b@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
To: Dirk Behme <dirk.behme@de.bosch.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <ff4bca03-24aa-e77b-23ad-63ea01b98a2b@de.bosch.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Dirk,

On Thu, Jan 4, 2018 at 8:05 AM, Dirk Behme <dirk.behme@de.bosch.com> wrote:
> On 03.01.2018 18:44, Mark Brown wrote:
>> The patch
>>
>>     spi: sh-msiof: Fix timeout failures for TX-only DMA transfers
>>
>> has been applied to the spi tree at
>>
>>     https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git
>
> Would it make sense to forward this to -stable, too?

Yes, _after_ it has landed in Linus' tree.
I didn't add a Fixes tag, as the fix needs changes to apply to any pre-4.13
kernel.

Most probably it will be picked up by stable automatically, as it has the
magic word "Fix" in the one-line summary.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
