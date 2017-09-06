From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 3/8] spi: sh-msiof: Fix MSIOF address for DMAC
Date: Wed, 6 Sep 2017 13:01:51 +0200
Message-ID: <CAMuHMdWYwe-cxVVk6Vema9J0EFEeioMB0V9rNwg+O9f7Y35C0Q@mail.gmail.com>
References: <20170906070507.26223-1-dirk.behme@de.bosch.com>
 <20170906070507.26223-4-dirk.behme@de.bosch.com> <CAMuHMdXu6t5StNB8jy2uGiJ1YLuQEHO7Kz4+PoihkaZnmLe8YA@mail.gmail.com>
 <df19487c-14e3-75e5-521c-0140768b1f9d@de.bosch.com> <CAMuHMdXimyHd3Egy0tja2Zst-8Ok_BwdTv7fg1_eYSb1j5XBjA@mail.gmail.com>
 <b408d4a1-2ccf-a1dc-d4f0-d5908d8cf731@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Ryo Kataoka <ryo.kataoka.wt@renesas.com>,
        Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>
To: Dirk Behme <dirk.behme@de.bosch.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <b408d4a1-2ccf-a1dc-d4f0-d5908d8cf731@de.bosch.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Dirk,

On Wed, Sep 6, 2017 at 12:59 PM, Dirk Behme <dirk.behme@de.bosch.com> wrote:
> On 06.09.2017 12:42, Geert Uytterhoeven wrote:
>> On Wed, Sep 6, 2017 at 12:09 PM, Dirk Behme <dirk.behme@de.bosch.com>
>> wrote:
>>> On 06.09.2017 11:22, Geert Uytterhoeven wrote:
>>>> On Wed, Sep 6, 2017 at 9:05 AM, Dirk Behme <dirk.behme@de.bosch.com>
>>>> wrote:
>>>>> From: Ryo Kataoka <ryo.kataoka.wt@renesas.com>
>>>>>
>>>>> MSIOF Base Address H'E6xx can be accessed by CPU and DMAC.
>>>>> MSIOF Base Address H'E7xx for DMAC was removed from H/W manual.
>>>>>
>>>>> Signed-off-by: Ryo Kataoka <ryo.kataoka.wt@renesas.com>
>>>>> Signed-off-by: Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>
>>>>> Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
>>>>
>>>> NAKed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>>>
>>>> The MSIOF Base Address for DMAC was removed only from the R-Car
>>>> Gen2/Gen3
>>>> manuals. It still affects e.g. R-Mobile APE6.
>>>
>>> Do we have a nice run time detection for that?
>>
>> The current driver code just looks at the DTS, cfr. the comment:
>>
>>      /* The DMA engine uses the second register set, if present */
>
> Ok, yes, thanks.
>
> So this patch is completely superfluous, even in the BSP, correct?

Correct. But it keeps on popping up, I think this is the third time someone
tried to submit it upstream :-(

> Will drop it for the next round, hoping that it doesn't result in too much
> rebase hassle ;)

OK, thx!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
