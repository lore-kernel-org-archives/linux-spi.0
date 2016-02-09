From: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v7 0/9] Fix broken DMAFLUSHP on Rockchips platform
Date: Tue, 9 Feb 2016 08:51:05 +0530
Message-ID: <20160209032105.GD19598@localhost>
References: <1453460812-8498-1-git-send-email-wxt@rock-chips.com>
 <3817335.PXCk0JfYDT@phil> <20160208131419.GA19598@localhost>
 <2223201.4nEkyUQu1O@phil>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Caesar Wang <caesar.upstream-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
 Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
 Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
 shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
 linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org,
 linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
 Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
 dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
 linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sonny Rao <sonnyrao-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
 linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
To: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, g@localhost
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <2223201.4nEkyUQu1O@phil>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, Feb 08, 2016 at 11:21:57PM +0100, Heiko Stuebner wrote:
> Hi Vinod,
> 
> Am Montag, 8. Februar 2016, 18:44:19 schrieb Vinod Koul:
> > On Mon, Feb 08, 2016 at 10:27:04AM +0100, Heiko Stuebner wrote:
> > > Am Montag, 8. Februar 2016, 08:41:34 schrieb Vinod Koul:
> > > > On Mon, Feb 01, 2016 at 02:56:54PM +0800, Caesar Wang wrote:
> > > > > Hello Vinod,
> > > > > 
> > > > > Is there any chance apply the DMA patches?:-)
> > > > 
> > > > I was waiting for any ACKs on ARM patches before I merge this series.
> > > 
> > > I think the more regular way is for the driver maintainer to take the
> > > driver-specific stuff and the devicetree parts going through the
> > > specific arm- tree. But if you really want to take the whole series,
> > > for patches 4,5,6
> > Yes but that causes cross tree dependencies, which looking at this won't
> > be a big problem, so I can safely merge dmaengine changes and rest can go
> > thru ARM tree.
> > 
> > Typically submitter should say which tree he/she prefers, which was not
> > provided..
> > 
> > So, are all okay to merge the entire series thru dmaengine tree or
> > independent. I don't mind either
> 
> In general I don't mind either solution, but would prefer me taking the 3 
> "ARM: dts: foo" patches, while the rest would go through your tree.
> 
> Main reason is to prevent any possible conflicts with other Rockchip 
> devicetree additions also going into 4.6 .

Sounds good, will queue them up

-- 
~Vinod
