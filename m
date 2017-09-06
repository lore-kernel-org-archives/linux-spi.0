From: Dirk Behme <dirk.behme-V5te9oGctAVWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 3/8] spi: sh-msiof: Fix MSIOF address for DMAC
Date: Wed, 6 Sep 2017 12:09:18 +0200
Message-ID: <df19487c-14e3-75e5-521c-0140768b1f9d@de.bosch.com>
References: <20170906070507.26223-1-dirk.behme@de.bosch.com>
 <20170906070507.26223-4-dirk.behme@de.bosch.com>
 <CAMuHMdXu6t5StNB8jy2uGiJ1YLuQEHO7Kz4+PoihkaZnmLe8YA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>,
        Ryo Kataoka <ryo.kataoka.wt-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
        Hiromitsu Yamasaki <hiromitsu.yamasaki.ym-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdXu6t5StNB8jy2uGiJ1YLuQEHO7Kz4+PoihkaZnmLe8YA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 06.09.2017 11:22, Geert Uytterhoeven wrote:
> Hi Dirk,
> 
> On Wed, Sep 6, 2017 at 9:05 AM, Dirk Behme <dirk.behme-V5te9oGctAVWk0Htik3J/w@public.gmane.org> wrote:
>> From: Ryo Kataoka <ryo.kataoka.wt-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
>>
>> MSIOF Base Address H'E6xx can be accessed by CPU and DMAC.
>> MSIOF Base Address H'E7xx for DMAC was removed from H/W manual.
>>
>> Signed-off-by: Ryo Kataoka <ryo.kataoka.wt-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
>> Signed-off-by: Hiromitsu Yamasaki <hiromitsu.yamasaki.ym-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
>> Signed-off-by: Dirk Behme <dirk.behme-V5te9oGctAVWk0Htik3J/w@public.gmane.org>
> 
> NAKed-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
> 
> The MSIOF Base Address for DMAC was removed only from the R-Car Gen2/Gen3
> manuals. It still affects e.g. R-Mobile APE6.


Do we have a nice run time detection for that?


Best regards

Dirk
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
