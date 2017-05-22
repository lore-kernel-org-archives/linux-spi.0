From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 5/6] spi: slave: Add SPI slave handler reporting uptime
 at previous message
Date: Mon, 22 May 2017 13:16:23 +0300
Message-ID: <CAHp75Ves5G3RfGDgmfArvE+0Uft_HDNWowcnAQKCT8uHV76EYA@mail.gmail.com>
References: <1495025272-23930-1-git-send-email-geert+renesas@glider.be>
 <1495025272-23930-6-git-send-email-geert+renesas@glider.be>
 <CAHp75VdphCGXYEMrF0eJ4WLe=wg_0o_xH833jJ1xjGynKV3jXA@mail.gmail.com> <CAMuHMdV6nNNA8_GsjYNTni0-V+2rujSdbyJ89pf136rD7toqhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>,
        Hiromitsu Yamasaki <hiromitsu.yamasaki.ym-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
        Jiada Wang <jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>,
        Matt Porter <mporter-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdV6nNNA8_GsjYNTni0-V+2rujSdbyJ89pf136rD7toqhQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Mon, May 22, 2017 at 1:13 PM, Geert Uytterhoeven
<geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org> wrote:
> On Thu, May 18, 2017 at 6:01 PM, Andy Shevchenko
> <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> On Wed, May 17, 2017 at 3:47 PM, Geert Uytterhoeven
>> <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org> wrote:

>>> +       rem_ns = do_div(ts, 1000000000) / 1000;
>>
>> You divide ts by 10^9, which makes it seconds if it was nanoseconds.
>> But reminder is still in nanoseconds and you divide it by 10^3.
>
>> If I didn't miss anything it should be called like
>> rem_ns -> reminder_ms
>
> Thanks, that must be a remainder from before I reworked the calculation.
> Will change it to rem_us (it's in microseconds, not milliseconds).

Yeah, correct, thanks.

-- 
With Best Regards,
Andy Shevchenko
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
