From: Ryan Mallon <ryan@bluewatersys.com>
Subject: Re: [PATCH 1/5] dmaengine: add ep93xx DMA support
Date: Thu, 26 May 2011 17:26:01 +1200
Message-ID: <4DDDE469.2020502@bluewatersys.com>
References: <cover.1306082097.git.mika.westerberg@iki.fi> <e6777eb9f7228ee1dadec1f0c9f16c3afc44c307.1306082097.git.mika.westerberg@iki.fi> <BANLkTi=3z3kO5VEe2up8Mfm+bNXkY3baUw@mail.gmail.com> <20110525195413.GC2996@acer> <BANLkTin8Trn-44Op+GbxrgocFrnPuXUZ2w@mail.gmail.com> <20110526043344.GA2749@acer>
Reply-To: rmallon@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Linus Walleij <linus.walleij@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	Vinod Koul <vinod.koul@intel.com>,
	linux-kernel@vger.kernel.org, hsweeten@visionengravers.com,
	Dan Williams <dan.j.williams@intel.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	spi mailing list <spi-devel-general@lists.sourceforge.net>
To: Mika Westerberg <mika.westerberg@iki.fi>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110526043344.GA2749@acer>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 26/05/11 16:33, Mika Westerberg wrote:
> On Wed, May 25, 2011 at 10:47:14PM +0200, Linus Walleij wrote:
>>
>>> IMHO it is better to have ep93xx implementation on its own driver since it is
>>> not a real AMBA PL022 peripheral but some weird hack made by Cirrus (although
>>> my opinions are bit biased).
>>
>> I disagree because it's IMO at first sight no more deviant than our "PL023"
>> variants that still use the same pl022 driver.
> 
> Ok.
> 
> Do you think that we can go forward with this patch series if I drop the last
> patch (spi/ep93xx: add DMA support)? This way we will have dmaengine
> implementation in place, whatever SPI driver we choose to use with ep93xx.
> 
> We can then try to use amba-pl022 driver with ep93xx and see if it works or
> not, and how much work is needed. I would like some comments from Hartley and
> Ryan also.

I think if we can modify the amba-pl022 driver, without it turning into
a mess, then we should do that. The ep93xx doesn't really see much
attention, so sharing the code base wherever possible should hopefully
get better review and testing.

The rest of the patch series is fine by me. You can have my

Acked-by: Ryan Mallon <rmallon@gmail.com>

for the ep93xx core and old dma implementation removal parts.

~Ryan
