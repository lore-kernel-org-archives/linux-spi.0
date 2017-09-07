From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH 2/8] spi: sh-msiof: Fix DMA transfer size check
Date: Thu, 7 Sep 2017 10:39:18 +0200
Message-ID: <CAMuHMdVY5fLf+qH0rKSe5BrXSd7xDpA3x=GAnwD43cu9LT8wig@mail.gmail.com>
References: <20170906070507.26223-1-dirk.behme@de.bosch.com>
 <20170906070507.26223-3-dirk.behme@de.bosch.com> <CAMuHMdWzWK5UTtmfoGmpHEwac8i3r1c6XqzT6cmwMXko2X7mvw@mail.gmail.com>
 <931484ec-8830-0e63-98cb-9dd58ce35230@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>,
        Hiromitsu Yamasaki <hiromitsu.yamasaki.ym-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
To: Dirk Behme <dirk.behme-V5te9oGctAVWk0Htik3J/w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <931484ec-8830-0e63-98cb-9dd58ce35230-V5te9oGctAVWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Dirk,

On Thu, Sep 7, 2017 at 10:33 AM, Dirk Behme <dirk.behme-V5te9oGctAVWk0Htik3J/w@public.gmane.org> wrote:
> On 07.09.2017 10:31, Geert Uytterhoeven wrote:
>> On Wed, Sep 6, 2017 at 9:05 AM, Dirk Behme <dirk.behme-V5te9oGctAVWk0Htik3J/w@public.gmane.org>
>> wrote:
>>> From: Hiromitsu Yamasaki <hiromitsu.yamasaki.ym-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
>>>
>>> DMA supports 32-bit words only,
>>> even if BITLEN1 of SITMDR2 register is 16bit.
>>>
>>> Signed-off-by: Hiromitsu Yamasaki <hiromitsu.yamasaki.ym-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
>>> Signed-off-by: Dirk Behme <dirk.behme-V5te9oGctAVWk0Htik3J/w@public.gmane.org>
>>> ---
>>>   drivers/spi/spi-sh-msiof.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
>>> index 2b4d3a520176..f9300fdf41e5 100644
>>> --- a/drivers/spi/spi-sh-msiof.c
>>> +++ b/drivers/spi/spi-sh-msiof.c
>>> @@ -904,7 +904,7 @@ static int sh_msiof_transfer_one(struct spi_master
>>> *master,
>>>                                  break;
>>>                          copy32 = copy_bswap32;
>>>                  } else if (bits <= 16) {
>>> -                       if (l & 1)
>>> +                       if (l & 3)
>>>                                  break;
>>>                          copy32 = copy_wswap32;
>>>                  } else {
>>
>>
>> Looks OK, as l is in bytes, not 16-bit words.
>>
>> Reviewed-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
>
> What do you think about CCing this to -stable?

Sounds OK. Have you tested this?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
