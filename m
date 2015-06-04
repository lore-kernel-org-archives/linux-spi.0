From: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 10/11] spi: add more debug prints in s3c64xx
Date: Thu, 4 Jun 2015 11:33:37 +0200
Message-ID: <CAOMqctQxn6UY2DJ9Syp6Ay9SYKLgdU+8EjiTK_48-R3dZ8PcvA@mail.gmail.com>
References: <cover.1433364398.git.hramrach@gmail.com> <305830ebf9c0ae98c4f6e0ebbdec7414d6762b36.1433364398.git.hramrach@gmail.com>
 <20150604091634.GY14071@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
	Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Han Xu <han.xu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>,
	Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>,
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Alison Chaiken <alison_chaiken-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>,
	Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Ben Hutchings <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>,
	Knut Wohlrab <knut.wohlrab-V5te9oGctAVWk0Htik3J/w@public.gmane.org>,
	=?UTF-8?B?QmVhbiBIdW8g6ZyN5paM5paMIChiZWFuaHVvKQ==?=
	<beanhuo-AL4WhLSQfzjQT0dZR+AlfA@public.gmane.org>, "grmoore-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org"
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150604091634.GY14071-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hello,

On 4 June 2015 at 11:16, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Wed, Jun 03, 2015 at 09:26:42PM -0000, Michal Suchanek wrote:
>> The SPI NOR transfers mysteriously fail so add more debug prints about
>> SPI transactions.
>
> Please try to only send patches to relevant people - the list of
> recipients for this is so large that it only barely fits on a single
> screen in my mail client.
>
> Also for this patch (which just adds some trace) there isn't any clear
> reason for it to be sent as part of the series at all, it doesn't help
> deliver the functionality and doesn't depend on the rest of the series.

I used this patch to add missing information to dmesg output so I
could diagnose the SPI failures so I think it is relevant.

The failure is reported by the s3c64xx but the root cause is pl330 not
finishing a DMA transfer.

It is non-obvious that this is the issue. The information that a call
to pl330 failed is only available in the s3c64xx driver and not SPI
core so I think there is no reasonable way to debug this issue other
than adding prints in s3c64xx. This issue is not completely resolved
or even well tested (I have only single board to test with) so these
prints remain relevant in my view.

>
>> --- a/drivers/spi/spi-s3c64xx.c
>> +++ b/drivers/spi/spi-s3c64xx.c
>> @@ -18,6 +18,7 @@
>>  #include <linux/interrupt.h>
>>  #include <linux/delay.h>
>>  #include <linux/clk.h>
>> +#include <linux/clk-provider.h>
>
> Whatever you're doing here this indicates that there's a very big
> abstraction problem going on.

I wanted to print a clock name in case the information was relevant
for the issue at hand.

To print a clock name you AFAICT need this header. I think this is an
abstraction problem in the clock framework. Fixing the abstraction
problem with clock framework would only grow the list of recipients
which is already so long you complain about it.

It turns out that in this case the clock was not at fault so I did not
need the clock name in the end.

>
>> +     pr_debug("%s %s %s waiting for %ims transferring %zubytes@%iHz",
>> +              __func__, sdd->pdev ? dev_name(&sdd->pdev->dev) : NULL,
>> +              dev_name(&sdd->master->dev),
>> +              ms, xfer->len, sdd->cur_speed);
>
> I'd say dev_dbg() but more generally this is just tracing things that
> seem to be already covered by the trace points already present in the
> core, the same goes for most of the rest of it.  If there's things
> missing from the existing trace it seems better to add to it.

There is master and slave device involved but it's certainly possible
to use dev_dbg on one of them and pass the other as string.

Thanks

Michal
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
