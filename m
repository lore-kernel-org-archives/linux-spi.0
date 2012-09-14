From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/5] spi: tegra: remove support of legacy DMA driver
 based access
Date: Fri, 14 Sep 2012 16:57:08 +0100
Message-ID: <20120914155707.GC4684@opensource.wolfsonmicro.com>
References: <1345126397-28864-1-git-send-email-ldewangan@nvidia.com>
 <1345126397-28864-5-git-send-email-ldewangan@nvidia.com>
 <504936AF.8010701@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Laxman Dewangan <ldewangan@nvidia.com>, grant.likely@secretlab.ca,
	olof@lixom.net, lrg@ti.com, vinod.koul@linux.intel.com,
	linux@arm.linux.org.uk, linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net,
	alsa-devel@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <504936AF.8010701@wwwdotorg.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, Sep 06, 2012 at 05:50:07PM -0600, Stephen Warren wrote:
> On 08/16/2012 08:13 AM, Laxman Dewangan wrote:

> > Remove the support code which uses the legacy APB DMA driver
> > for accessing the SPI FIFO.
> > The driver will use the dmaengine based APB DMA driver for
> > accessing reqding/writing to SPI FIFO.

> I'd like to take this patch through the Tegra tree, since it relies on
> the previous Tegra patches to convert to dmaengine. Could I please get
> an ack if that's OK? Thanks.

I don't seem to have the patch for review, not sure why.
