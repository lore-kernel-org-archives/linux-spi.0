From: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/3] spi/bcm63xx-hsspi: allow providing clock rate through
 a second clock
Date: Mon, 27 Feb 2017 14:48:04 -0800
Message-ID: <6a6463e4-b3e0-3e93-494d-81a4aa305ab9@gmail.com>
References: <20170222131940.31085-1-jonas.gorski@gmail.com>
 <20170222182602.p4wlcjfkxx6ulj4x@sirena.org.uk>
 <CAOiHx=m_bnm+PXYVxtbxzKFqLtjKhi20TONX4UTUWrmMNpWcUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
To: Jonas Gorski <jonas.gorski-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAOiHx=m_bnm+PXYVxtbxzKFqLtjKhi20TONX4UTUWrmMNpWcUg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 02/22/2017 12:00 PM, Jonas Gorski wrote:
> On 22 February 2017 at 19:26, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>> On Wed, Feb 22, 2017 at 02:19:38PM +0100, Jonas Gorski wrote:
>>> Instead of requiring the hsspi clock to have a rate, allow using a second
>>> clock for providing the Hz rate, which is probably more correct anyway.
>>
>> I'm sorry but I just can't follow the logic here at all - why would we
>> use "a second clock" to get the rate of a clock and why would that be
>> more correct?  There's a few steps in the reasoning missing here I
>> think!
> 
> The PLL rate is hardcoded in the original broadcom code (with
> #if-deffery for different SoCs); when I added support for the HSSPI
> controller in upstream linux, I thought "hey, let's put it as the rate
> of the (gateable) HSSPI clock, then I don't need to pass it as
> platform data". Part of the issue is also that bcm63xx has its own clk
> code, so couldn't use clk lookups even if I wanted.
> 
> The register for the gated clock control is calld blkEnables (so might
> be just power gating?), and the #define for the rate is called
> HS_SPI_PLL_FREQ, which at least gives me the impression these could be
> two different things/clocks. Whether it's a separate PLL from the
> gated clock or not someone with actual hardware knowledge would have
> to tell.

I looked at the HSSPI datasheet again and there are indeed two separate
input clock signals to the HSSPI block, one which is a PLL clock and
that is used to control the external SPI output/input clock. The other
clock is the UBUS register interface clock and also clock gates the
block when unused.

So with that:

Acked-by: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

> 
> To (eventually) get rid of bcm63xx's own clk code and replace it with
> a proper clock driver with lookups and stuff, it would make it much
> easier to just move the PLL_FREQ into a separate fixed-rate clock, as
> it is the only clock in the bcm63xx code that has a rate attached and
> is gated. So I wouldn't need to create composite clocks to and could
> just directly make it a simple gated-clock driver.
> 
> Hope that explanation helps.
> 
> 
> Regards
> Jonas
> 


-- 
Florian
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
