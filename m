From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: bcm2835: Allow platform to set realtime priority
Date: Thu, 23 Mar 2017 14:48:01 +0100
Message-ID: <CACRpkdY2QKLNbW_+i=qBCYr8iOHckYmukePOHUHtVpdW5xpjWw@mail.gmail.com>
References: <c1ca8a5522272d06f5c3fb67d8442f148b2d6cfb.1490264661.git.lukas@wunner.de>
 <1503363fcfb92adfa765d1c1c3e69fc673e72dde.1490264661.git.lukas@wunner.de>
 <20170323110718.sncw32gspvls75u7@sirena.org.uk> <20170323120257.GC20546@h08.hostsharing.net>
 <20170323122118.i2gc77debz4eu5hq@sirena.org.uk> <20170323134336.GA10576@h08.hostsharing.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Mathias Duckeck <m.duckeck-XB/JSsFECOqzQB+pC5nmwQ@public.gmane.org>,
        linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
        Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
To: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170323134336.GA10576-KMaqurgeqYRAE5l8fViCMtHuzzzSOjJt@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thu, Mar 23, 2017 at 2:43 PM, Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org> wrote:
> On Thu, Mar 23, 2017 at 12:21:18PM +0000, Mark Brown wrote:
>> > Also, if you question setting the RT priority in the devicetree, why
>> > was that functionality allowed for pl022 in the first place?
>>
>> This was being done via platform data not via device tree, unlike
>> platform data device tree should provide a long term stable OS neutral
>> ABI.
>
> No, specifying it via the device tree was subsequently added with
> commit 39a6ac11df65 ("spi/pl022: Devicetree support w/o platform data"),
> sorry for not mentioning this in the commit message.

This was in 2012 when we were walking around like zombies in
devicetreeland and walking into the wall and breaking things to the
left and right, just trying to comply with the recent decision to move
all of ARM development over to using device tree.

If the property would be allowed today it would at *least* be prefixed
with "linux,*" so "linux,realtime-priority".

Even though linux-specific DT properties are generally frowned upon
they do have their place sometimes.

If this DT property was suggested today it would get a very different
treatment than in 2012. We are older and wiser now. Mistakes were
made, also by me.

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
