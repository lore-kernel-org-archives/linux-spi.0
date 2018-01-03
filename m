From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH 2/8] spi: sh-msiof: Fix DMA transfer size check
Date: Wed, 3 Jan 2018 18:25:17 +0100
Message-ID: <CAMuHMdVvk2_0T7HdJbmd_QZ+7OtXAQYo3GZ6Xt2QPmd0N=1_qg@mail.gmail.com>
References: <20170906070507.26223-1-dirk.behme@de.bosch.com>
 <20170906070507.26223-3-dirk.behme@de.bosch.com> <CAMuHMdWzWK5UTtmfoGmpHEwac8i3r1c6XqzT6cmwMXko2X7mvw@mail.gmail.com>
 <931484ec-8830-0e63-98cb-9dd58ce35230@de.bosch.com> <CAMuHMdVY5fLf+qH0rKSe5BrXSd7xDpA3x=GAnwD43cu9LT8wig@mail.gmail.com>
 <09ce4c7a-347c-7df8-d8ed-4eb61a00bd20@de.bosch.com> <CAMuHMdVo_62kYYmgLZNHksRi+Z96K+tu9KTsgyKfmk6U_gP79w@mail.gmail.com>
 <a3fbaa5c-caa1-c28f-3248-6c5557a96d8c@de.bosch.com> <CAMuHMdXQKj3F02zur3BZ95Et+btQD=rOfpMUC8cFWBnwF4Qxdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>,
        Hiromitsu Yamasaki <hiromitsu.yamasaki.ym-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
To: Dirk Behme <dirk.behme-V5te9oGctAVWk0Htik3J/w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdXQKj3F02zur3BZ95Et+btQD=rOfpMUC8cFWBnwF4Qxdw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Dirk,

On Thu, Sep 7, 2017 at 11:12 AM, Geert Uytterhoeven
<geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org> wrote:
> On Thu, Sep 7, 2017 at 11:05 AM, Dirk Behme <dirk.behme-V5te9oGctAVWk0Htik3J/w@public.gmane.org> wrote:
>> On 07.09.2017 10:59, Geert Uytterhoeven wrote:
>>> On Thu, Sep 7, 2017 at 10:42 AM, Dirk Behme <dirk.behme-V5te9oGctAVWk0Htik3J/w@public.gmane.org>
>>> wrote:
>>>> On 07.09.2017 10:39, Geert Uytterhoeven wrote:
>>>>> On Thu, Sep 7, 2017 at 10:33 AM, Dirk Behme <dirk.behme-V5te9oGctAVWk0Htik3J/w@public.gmane.org>
>>>>> wrote:
>>>>>> On 07.09.2017 10:31, Geert Uytterhoeven wrote:
>>>>>>> On Wed, Sep 6, 2017 at 9:05 AM, Dirk Behme <dirk.behme-V5te9oGctAVWk0Htik3J/w@public.gmane.org>
>>>>>>> wrote:
>>>>>>>> From: Hiromitsu Yamasaki <hiromitsu.yamasaki.ym-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
>>>>>>>> DMA supports 32-bit words only,
>>>>>>>> even if BITLEN1 of SITMDR2 register is 16bit.
>>>>>>>>
>>>>>>>> Signed-off-by: Hiromitsu Yamasaki <hiromitsu.yamasaki.ym-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
>>>>>>>> Signed-off-by: Dirk Behme <dirk.behme-V5te9oGctAVWk0Htik3J/w@public.gmane.org>
>>>>>>>> ---
>>>>>>>>     drivers/spi/spi-sh-msiof.c | 2 +-
>>>>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
>>>>>>>> index 2b4d3a520176..f9300fdf41e5 100644
>>>>>>>> --- a/drivers/spi/spi-sh-msiof.c
>>>>>>>> +++ b/drivers/spi/spi-sh-msiof.c
>>>>>>>> @@ -904,7 +904,7 @@ static int sh_msiof_transfer_one(struct
>>>>>>>> spi_master
>>>>>>>> *master,
>>>>>>>>                                    break;
>>>>>>>>                            copy32 = copy_bswap32;
>>>>>>>>                    } else if (bits <= 16) {
>>>>>>>> -                       if (l & 1)
>>>>>>>> +                       if (l & 3)
>>>>>>>>                                    break;
>>>>>>>>                            copy32 = copy_wswap32;
>>>>>>>>                    } else {
>>>>>>>
>>>>>>> Looks OK, as l is in bytes, not 16-bit words.
>>>>>>>
>>>>>>> Reviewed-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
>>>>>>
>>>>>> What do you think about CCing this to -stable?
>>>>>
>>>>> Sounds OK. Have you tested this?
>>>>
>>>> I tested all 8 patches together if they fix the issues I observed with
>>>> plain
>>>> mainline.
>>>
>>> Could you please elaborate about the issues you observed with plain
>>> mainline?
>>> It may help to identify which patches are responsible for fixing them.
>>
>> I've been told that an easy test case is to just cat random data (any mid
>> sized file) into SPI. E.g.:
>>
>> # cat /proc/cpuinfo > /dev/spidev32764.2
>> [  504.544948] spi_sh_msiof e6e90000.spi: failed to shut down hardware
>> [  504.551265] spidev spi32764.2: SPI transfer failed: -110
>> [  504.556625] spi_master spi32764: failed to transfer one message from
>> queue
>> [  504.564857] spi_sh_msiof e6e90000.spi: failed to shut down hardware
>> [  504.571177] spidev spi32764.2: SPI transfer failed: -110
>> [  504.576528] spi_master spi32764: failed to transfer one message from
>> queue
>> cat: write error: Connection timed out
>>
>> done on plain 4.13-rc6.
>
> Thank you, that's very valuable information!
> We'll give it a try...

After some investigation, this is caused by DMA completion triggering
too early for TX-only transfers.  This should indeed be fixed by "[PATCH 5/8]
spi: sh-msiof: Wait for Tx FIFO empty after DMA" you extracted from the BSP.

As that patch needs changes to apply (a) on current spi/for-next and (b)
without other patches from your series, I reworked it into "[PATCH] spi:
sh-msiof: Fix timeout failures for TX-only DMA transfers".

As for the other patches from your series:
  - Upstream already has commit 36735783fdb599c9 ("spi: sh-msiof: Fix DMA
    transfer size check"),
  - spi/for-next has commit b8761434bdec32fa ("spi: sh-msiof: Implement
    cs-gpios configuration").
The remaining were either rejected, retracted, or it is unclear which problem
(if any) they are really fixing.

Do you agree?
Thanks!

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
