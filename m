From: Jiada Wang <jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] spi: imx: Revert "spi: imx: dynamic burst length adjust
 for PIO mode"
Date: Thu, 18 May 2017 08:37:54 -0700
Message-ID: <591DBFD2.4090601@mentor.com>
References: <1495113735-11891-1-git-send-email-fabio.estevam@nxp.com> <1495115958.26925.23.camel@nxp.com> <CAOMZO5Adj+sgxgoO9gN232EEH=NtjTHpKfB+EaUAbRXyaPD_Gg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Leonard Crestez <leonard.crestez-3arQi8VN3Tc@public.gmane.org>,
        Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAOMZO5Adj+sgxgoO9gN232EEH=NtjTHpKfB+EaUAbRXyaPD_Gg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hello Fabio

On 05/18/2017 07:22 AM, Fabio Estevam wrote:
> Hi Leonard,
>
> On Thu, May 18, 2017 at 10:59 AM, Leonard Crestez
> <leonard.crestez-3arQi8VN3Tc@public.gmane.org>  wrote:
>
>> A fix was already posted: https://lkml.org/lkml/2017/5/18/264. Can you
>> check it in your scenario? I don't know if a revert or a fix is more
>> appropriate.
> I have tested this patch and it does not solve the SPI NOR detection issue.
>
> That's why I sent a revert.
>
> Thanks
Which kernel and HW version are you using for test?

with the test on my imx6q sabresd board,
no matter using upstream kernel or our internal kernel,
the issue exists with or without the patch.

Thanks,
Jiada
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
