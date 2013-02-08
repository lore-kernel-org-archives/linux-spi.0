From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/5] spi: pl022: use generic DMA slave configuration if
 possible
Date: Fri, 8 Feb 2013 23:10:02 +0100
Message-ID: <CACRpkdYOB=XX+Ogs8SVrrwVdMw+xZ9u3BBwwhsKYJKu4tTdDOg@mail.gmail.com>
References: <1359395857-1235-1-git-send-email-arnd@arndb.de>
 <3752726.iyKukyN6sF@wuerfel>
 <20130208162248.GY17833@n2100.arm.linux.org.uk>
 <11938235.WbhQmuClDR@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Vinod Koul <vinod.koul-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
 Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
 Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org,
 Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
 spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
 Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
 linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <11938235.WbhQmuClDR@wuerfel>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Id: linux-spi.vger.kernel.org

On Fri, Feb 8, 2013 at 5:28 PM, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> wrote:
> On Friday 08 February 2013 16:22:48 Russell King - ARM Linux wrote:
>> If it's DMA _to_ a device, then we will only ever clean the lines prior to
>> a transfer, never invalidate them.  So that's not really a concern.  (There
>> better not be any dirty cache lines associated with the empty zero page
>> either.)
>
> Right, makes sense. I thought I had read about a CPU that
> could not flush a cache line without also invalidating
> it, but that must have been something other than ARM,
> or maybe I'm misremembering it.

I don't think it matters one bit. The page can contain a bitmap
of Donald Duck or zero FWIW. It's just that the DMA
controller just neeeds to read *something* that does not cause
a bus stall.

It's due to the syncronous nature of the SPI protocol, to get
something out you need to put something in. So when reading,
this is a way to feed in some junk.

So this goes on my TODO...

Yours,
Linus Walleij
