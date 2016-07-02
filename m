From: Christian Gmeiner <christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: imx: wait_for_completion_timeout(..) for PIO transfers
Date: Sat, 2 Jul 2016 15:26:00 +0200
Message-ID: <CAH9NwWdJjX1aobXnybTH1CMZY4BzQ+=Ho+3BGnWzb+A0BwpNGQ@mail.gmail.com>
References: <20160621185100.GD28202@sirena.org.uk> <1467376378-21535-1-git-send-email-christian.gmeiner@gmail.com>
 <20160701150134.GR6247@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160701150134.GR6247-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark,

2016-07-01 17:01 GMT+02:00 Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>:
> On Fri, Jul 01, 2016 at 02:32:58PM +0200, Christian Gmeiner wrote:
>> In some rare cases I see the following 'task blocked' information. It
>> looks like the PIO transfer has some problems and never succeeds. Make
>> use of wait_for_completion_timeout(..) to detect this case and
>> return -ETIMEDOUT.
>>
>> v2: remove backtrace from commit message
>
> Please do not submit new versions of already applied patches, please
> submit incremental updates to the existing code.  Modifying existing
> commits creates problems for other users building on top of those
> commits so it's best practice to only change pubished git commits if
> absolutely essential.
>

I was not aware that the patch was applied already that is why I send out
a v2. I normally do not follow any subsystem or linux-next tree to see if a
patch of me got applied or not. Normally I get an Acked-by: or Signed-off-by:
reply to know about the state of the patch. In case of this patch I got a
separate main 'Applied "spi: imx: wait_for_completion_timeout(..) for
PIO transfers"
to the spi tree' which did not get any attention from me as it was
hidden due some
gmail filter-to-label rules. In the end I am happy that this patch got applied.
Thanks for that and sorry that I have stolen to much time.

> If you're including an inter-version changelog please keep it after the
> --- as covered in SubmittingPatches.

Will do the next time - sorry for that.

greets
--
Christian Gmeiner, MSc

https://soundcloud.com/christian-gmeiner
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
