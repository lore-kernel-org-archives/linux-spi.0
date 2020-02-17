From: "Ramuthevar, Vadivel MuruganX"
        <vadivel.muruganx.ramuthevar-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v9 0/2] spi: cadence-quadpsi: Add support for the Cadence
 QSPI controller
Date: Mon, 17 Feb 2020 18:09:08 +0800
Message-ID: <7d264baf-1ea8-8ada-d93f-df55600a59e9@linux.intel.com>
References: <20200214114618.29704-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <CAAh8qsxnRSwonuEPrriuS=gUMTjt8ddUVy5HxegmoCk-FoE4qg@mail.gmail.com>
 <20200214121145.GF4827@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Cc: linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org,
        cheol.yong.kim-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, qi-ming.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Simon Goldschmidt <simon.k.r.goldschmidt-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200214121145.GF4827-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark,

On 14/2/2020 8:11 PM, Mark Brown wrote:
> On Fri, Feb 14, 2020 at 01:02:22PM +0100, Simon Goldschmidt wrote:
>> On Fri, Feb 14, 2020 at 12:46 PM Ramuthevar,Vadivel MuruganX
>> <vadivel.muruganx.ramuthevar-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
>>> Add support for the Cadence QSPI controller. This controller is
>>> present in the Intel Lightning Mountain(LGM) SoCs, Altera and TI SoCs.
>>> This driver has been tested on the Intel LGM SoCs.
>> This is v9 and still, none of the altera maintainers are on CC?
>> How will it be ensured that this doesn't break altera if it is merged?
> Given that this is a new driver I'd be very surprised if it broke other
> users?  I can imagine it might not work for them and it would definitely
> be much better to get their review but it shouldn't be any worse than
> the current lack of support.
Thanks for the clarification, Please kindly see the below discussion b/w
Vignesh and Dinh in the earlier mail chain.

[Vignesh]  The legacy driver under drivers/mtd/spi-nor will be removed 
as we cannot
support both SPI NOR and SPI NAND with single driver if its under
spi-nor. New driver should be functionally equivalent to existing one.
So I suggest you test this driver on legcay SoCFPGA products.

[Dinh]   I don't have the original patch series, but will monitor going 
forward.
As long as the new driver does not break legacy SoCFPGA products that
use the cadence-quadspi driver then it should be ok.

Regards
vadivel
