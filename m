From: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v7 0/9] Fix broken DMAFLUSHP on Rockchips platform
Date: Mon, 08 Feb 2016 23:21:57 +0100
Message-ID: <2223201.4nEkyUQu1O@phil>
References: <1453460812-8498-1-git-send-email-wxt@rock-chips.com> <3817335.PXCk0JfYDT@phil> <20160208131419.GA19598@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Caesar Wang <caesar.upstream@gmail.com>,
	Caesar Wang <wxt@rock-chips.com>,
	Mark Rutland <mark.rutland@arm.com>,
	devicetree@vger.kernel.org, Russell King <linux@arm.linux.org.uk>,
	Pawel Moll <pawel.moll@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com,
	dianders@chromium.org, Rob Herring <robh+dt@kernel.org>,
	linux-spi@vger.kernel.org, linux-rockchip@lists.infradead.org,
	Mark Brown <broonie@kernel.org>,
	Kumar Gala <galak@codeaurora.org>, dmaengine@vger.kernel.org,
	Dan Williams <dan.j.williams@intel.com>,
	Sonny Rao <sonnyrao@chromium.org>,
	linux-arm-kernel@lists.infradead.org
To: Vinod Koul <vinod.koul@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160208131419.GA19598@localhost>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Vinod,

Am Montag, 8. Februar 2016, 18:44:19 schrieb Vinod Koul:
> On Mon, Feb 08, 2016 at 10:27:04AM +0100, Heiko Stuebner wrote:
> > Am Montag, 8. Februar 2016, 08:41:34 schrieb Vinod Koul:
> > > On Mon, Feb 01, 2016 at 02:56:54PM +0800, Caesar Wang wrote:
> > > > Hello Vinod,
> > > > 
> > > > Is there any chance apply the DMA patches?:-)
> > > 
> > > I was waiting for any ACKs on ARM patches before I merge this series.
> > 
> > I think the more regular way is for the driver maintainer to take the
> > driver-specific stuff and the devicetree parts going through the
> > specific arm- tree. But if you really want to take the whole series,
> > for patches 4,5,6
> Yes but that causes cross tree dependencies, which looking at this won't
> be a big problem, so I can safely merge dmaengine changes and rest can go
> thru ARM tree.
> 
> Typically submitter should say which tree he/she prefers, which was not
> provided..
> 
> So, are all okay to merge the entire series thru dmaengine tree or
> independent. I don't mind either

In general I don't mind either solution, but would prefer me taking the 3 
"ARM: dts: foo" patches, while the rest would go through your tree.

Main reason is to prevent any possible conflicts with other Rockchip 
devicetree additions also going into 4.6 .


Thanks
Heiko

> > - ARM: dts: Add arm, pl330-broken-no-flushp quirk for rk3288 platform
> > - ARM: dts: Add arm, pl330-broken-no-flushp quirk for rk3xxx platform
> > - ARM: dts: add pl330-broken-no-flushp quirk for rk3036 SoCs
> > 
> > Acked-by: Heiko Stuebner <heiko@sntech.de>
> 
> Thanks
