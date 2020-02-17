From: Vignesh Raghavendra <vigneshr-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v9 0/2] spi: cadence-quadpsi: Add support for the Cadence
 QSPI controller
Date: Mon, 17 Feb 2020 17:48:02 +0530
Message-ID: <f5f868e5-a977-7487-9395-a76dd5e7c963@ti.com>
References: <20200214114618.29704-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <CAAh8qsxnRSwonuEPrriuS=gUMTjt8ddUVy5HxegmoCk-FoE4qg@mail.gmail.com>
 <20200214121145.GF4827@sirena.org.uk>
 <4712cdc4-34cd-990b-3d53-3d394ae1250b@linux.intel.com>
 <20200217115213.GA9304@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Cc: Simon Goldschmidt <simon.k.r.goldschmidt-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>,
        <cheol.yong.kim-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, <qi-ming.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
        <dinguyen-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <tien.fong.chee-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "Ramuthevar, Vadivel MuruganX"
        <vadivel.muruganx.ramuthevar-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200217115213.GA9304-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Vadivel,

On 17/02/20 5:22 pm, Mark Brown wrote:
> On Mon, Feb 17, 2020 at 05:28:38PM +0800, Ramuthevar, Vadivel MuruganX wrote:
>> On 14/2/2020 8:11 PM, Mark Brown wrote:
> 
>>> Given that this is a new driver I'd be very surprised if it broke other
>>> users?  I can imagine it might not work for them and it would definitely
>>> be much better to get their review but it shouldn't be any worse than
>>> the current lack of support.
> 
>> *[Vignesh]*  The legacy driver under drivers/mtd/spi-nor will be removed as
>> we cannot
>> support both SPI NOR and SPI NAND with single driver if its under
>> spi-nor. New driver should be functionally equivalent to existing one.
>> So I suggest you test this driver on legcay SoCFPGA products.
> 
> You're not actually removing the driver here, you're adding another
> driver for the same thing.
> 

I agree with Mark here.

I realized that you are using same CONFIG option as the old one to build
this driver. This causes new driver to fail to probe as old driver would
bind to the node instead (both drivers will be built into the kernel and
both drivers have same compatible).

So, you should remove the old driver. Could you also include patches
removing old driver? New driver and bindings are anyways backward
compatible with existing one

-- 
Regards
Vignesh
