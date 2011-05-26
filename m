From: Mika Westerberg <mika.westerberg@iki.fi>
Subject: Re: [PATCH 1/5] dmaengine: add ep93xx DMA support
Date: Thu, 26 May 2011 21:38:01 +0300
Message-ID: <20110526183800.GE2957@acer>
References: <cover.1306082097.git.mika.westerberg@iki.fi>
 <e6777eb9f7228ee1dadec1f0c9f16c3afc44c307.1306082097.git.mika.westerberg@iki.fi>
 <BANLkTi=3z3kO5VEe2up8Mfm+bNXkY3baUw@mail.gmail.com>
 <20110525195413.GC2996@acer>
 <BANLkTin8Trn-44Op+GbxrgocFrnPuXUZ2w@mail.gmail.com>
 <20110526043344.GA2749@acer>
 <BANLkTikzrXRmdnv_v_nmJw7Nvsr6TY-5RQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-arm-kernel@lists.infradead.org,
	Vinod Koul <vinod.koul@intel.com>,
	linux-kernel@vger.kernel.org, hsweeten@visionengravers.com,
	ryan@bluewatersys.com, Dan Williams <dan.j.williams@intel.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	spi mailing list <spi-devel-general@lists.sourceforge.net>
To: Linus Walleij <linus.walleij@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <BANLkTikzrXRmdnv_v_nmJw7Nvsr6TY-5RQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, May 26, 2011 at 09:15:25AM +0200, Linus Walleij wrote:
> On Thu, May 26, 2011 at 6:33 AM, Mika Westerberg <mika.westerberg@iki.fi> wrote:
> 
> > Do you think that we can go forward with this patch series if I drop the last
> > patch (spi/ep93xx: add DMA support)? This way we will have dmaengine
> > implementation in place, whatever SPI driver we choose to use with ep93xx.
> 
> Yes and you don't have to drop any DMA support for the existing driver
> for me alone, now that it's in the tree it should be maintained. I only
> wanted to raise the issue of code duplication, not block any patches.

Ok, so I'll keep the last patch for now.

BTW: if we get amba-pl022 driver to work with ep93xx, do you have any ideas
how to proceed from there? I mean, should we convert existing users to use
that driver instead and finally remove the ep93xx_spi driver?
