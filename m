From: Dirk Behme <dirk.behme-V5te9oGctAVWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 1/8] spi: sh-msiof: Add sleep before master transfer for
 test
Date: Thu, 7 Sep 2017 10:26:43 +0200
Message-ID: <1ae37860-9692-c749-f291-cee4a5d5d729@de.bosch.com>
References: <20170906070507.26223-1-dirk.behme@de.bosch.com>
 <20170906070507.26223-2-dirk.behme@de.bosch.com>
 <CAMuHMdV5vQsS5RgykMptRxDb1wgS9YryBQu7xgGHXactjGGWFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>,
        Hiromitsu Yamasaki <hiromitsu.yamasaki.ym-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdV5vQsS5RgykMptRxDb1wgS9YryBQu7xgGHXactjGGWFA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: de-DE
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 07.09.2017 10:11, Geert Uytterhoeven wrote:
> Hi Dirk,
> 
> On Wed, Sep 6, 2017 at 9:05 AM, Dirk Behme <dirk.behme-V5te9oGctAVWk0Htik3J/w@public.gmane.org> wrote:
>> From: Hiromitsu Yamasaki <hiromitsu.yamasaki.ym-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
>>
>> This patch is for debug of transfer between master and slave.
>> Since the slave needs to complete a preparation in data transfer
>> before the master working, the sleep wait is put before
>> the data transfer of the master.
>>
>> Signed-off-by: Hiromitsu Yamasaki <hiromitsu.yamasaki.ym-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
>> Signed-off-by: Dirk Behme <dirk.behme-V5te9oGctAVWk0Htik3J/w@public.gmane.org>
> 
> IMHO this is a pure debug patch, not intended for upstream.


Dropped for v2.


Thanks

Dirk

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
