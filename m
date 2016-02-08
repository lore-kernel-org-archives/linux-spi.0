From: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v7 0/9] Fix broken DMAFLUSHP on Rockchips platform
Date: Mon, 8 Feb 2016 18:44:19 +0530
Message-ID: <20160208131419.GA19598@localhost>
References: <1453460812-8498-1-git-send-email-wxt@rock-chips.com>
 <56AF01B6.6030204@gmail.com>
 <20160208031134.GI2531@localhost>
 <3817335.PXCk0JfYDT@phil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Caesar Wang <caesar.upstream-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org,
	dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Sonny Rao <sonnyrao-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3817335.PXCk0JfYDT@phil>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Heiko,

On Mon, Feb 08, 2016 at 10:27:04AM +0100, Heiko Stuebner wrote:
> Hi Vinod,
> 
> Am Montag, 8. Februar 2016, 08:41:34 schrieb Vinod Koul:
> > On Mon, Feb 01, 2016 at 02:56:54PM +0800, Caesar Wang wrote:
> > > Hello Vinod,
> > > 
> > > Is there any chance apply the DMA patches?:-)
> > 
> > I was waiting for any ACKs on ARM patches before I merge this series.
> 
> I think the more regular way is for the driver maintainer to take the 
> driver-specific stuff and the devicetree parts going through the specific arm-
> tree. But if you really want to take the whole series, for patches 4,5,6

Yes but that causes cross tree dependencies, which looking at this won't be
a big problem, so I can safely merge dmaengine changes and rest can go thru
ARM tree.

Typically submitter should say which tree he/she prefers, which was not
provided..

So, are all okay to merge the entire series thru dmaengine tree or
independent. I don't mind either

> - ARM: dts: Add arm, pl330-broken-no-flushp quirk for rk3288 platform
> - ARM: dts: Add arm, pl330-broken-no-flushp quirk for rk3xxx platform
> - ARM: dts: add pl330-broken-no-flushp quirk for rk3036 SoCs
> 
> Acked-by: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>

Thanks
-- 
~Vinod
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
