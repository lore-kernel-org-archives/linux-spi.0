From: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH v7 0/9] Fix broken DMAFLUSHP on Rockchips platform
Date: Mon, 08 Feb 2016 10:27:04 +0100
Message-ID: <3817335.PXCk0JfYDT@phil>
References: <1453460812-8498-1-git-send-email-wxt@rock-chips.com> <56AF01B6.6030204@gmail.com> <20160208031134.GI2531@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
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
To: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160208031134.GI2531@localhost>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Vinod,

Am Montag, 8. Februar 2016, 08:41:34 schrieb Vinod Koul:
> On Mon, Feb 01, 2016 at 02:56:54PM +0800, Caesar Wang wrote:
> > Hello Vinod,
> > 
> > Is there any chance apply the DMA patches?:-)
> 
> I was waiting for any ACKs on ARM patches before I merge this series.

I think the more regular way is for the driver maintainer to take the 
driver-specific stuff and the devicetree parts going through the specific arm-
tree. But if you really want to take the whole series, for patches 4,5,6

- ARM: dts: Add arm, pl330-broken-no-flushp quirk for rk3288 platform
- ARM: dts: Add arm, pl330-broken-no-flushp quirk for rk3xxx platform
- ARM: dts: add pl330-broken-no-flushp quirk for rk3036 SoCs

Acked-by: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>


Heiko
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
