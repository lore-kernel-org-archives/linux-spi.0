From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/5] Rewrite GPIO SPI to use descriptors
Date: Sun, 7 Jan 2018 00:18:35 +0100
Message-ID: <CACRpkdZcxFpBMC2RpuXOzZy2DJW_ain4h51jbij5g-2RibTjww@mail.gmail.com>
References: <20180101133749.29567-1-linus.walleij@linaro.org>
 <1514918569.26695.151.camel@impinj.com> <CACRpkdYRJ=jR4B2Ko2P1axwGMKob2vHkY2h8cMc9t9Qi7n52sQ@mail.gmail.com>
 <20180103162449.GG28713@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Trent Piepho <tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180103162449.GG28713-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Jan 3, 2018 at 5:24 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Wed, Jan 03, 2018 at 12:17:07AM +0100, Linus Walleij wrote:
>
>> I'd be surprised if either performance or object code size is affected
>> in a bad way though. I don't have any high-speed SPI devices I can test
>> really, and loopback would require some special hardware set-up I
>> don't have.
>
> You could just do something like spin on register reads on some device
> or something?  Something like dumping a regmap via debugfs would do the
> trick probably.

OK I tried this on my new Ilitek ILI9322 panel driver:

A script like this dumping the regmap 10000 times (it
has no caching obviously) on an otherwise idle system
in two iterations before and after the patches:

#!/bin/sh
for run in `seq 10000`
do
    cat /debug/regmap/spi0.0/registers > /dev/null
done

Before the patch:
time test.sh
real    3m 41.03s
user    0m 29.41s
sys     3m 7.22s

time test.sh
real    3m 44.24s
user    0m 32.31s
sys     3m 7.60s

After the patch:

time test.sh
real    3m 41.32s
user    0m 28.92s
sys     3m 8.08s

time test.sh
real    3m 39.92s
user    0m 30.20s
sys     3m 5.56s

So any performance differences seems to be in the error margin.

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
