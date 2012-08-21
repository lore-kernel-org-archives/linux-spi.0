From: Matt Porter <mporter@ti.com>
Subject: Re: [PATCH 1/3] dmaengine: add TI EDMA DMA engine driver
Date: Tue, 21 Aug 2012 14:20:04 -0400
Message-ID: <20120821182004.GA32420@beef>
References: <1345153471-22757-1-git-send-email-mporter@ti.com>
 <1345153471-22757-2-git-send-email-mporter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
	Linux MMC List <linux-mmc@vger.kernel.org>,
	Linux SPI Devel List
	<spi-devel-general@lists.sourceforge.net>,
	Linux DaVinci Kernel List
	<davinci-linux-open-source@linux.davincidsp.com>,
	Sekhar Nori <nsekhar@ti.com>
To: vinod.koul@intel.com, dan.j.williams@intel.com, cjb@laptop.org,
	grant.likely@secretlab.ca
Return-path: <linux-mmc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1345153471-22757-2-git-send-email-mporter@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, Aug 16, 2012 at 05:44:29PM -0400, Matt Porter wrote:
> Add a DMA engine driver for the TI EDMA controller. This driver
> is implemented as a wrapper around the existing DaVinci private
> DMA implementation. This approach allows for incremental conversion
> of each peripheral driver to the DMA engine API. The EDMA driver
> supports slave transfers but does not yet support cyclic transfers.

I got my hands on a AM18x WL12xx module so I could test MMC1 and this
exposed some bugs in the driver's handling of the second EDMA controller
case. DA850/OMAP-L138/AM1x have this second EDMA controller. I've
addressed this in v2 which will be posted shortly.

I'm expecting to receive a DM646x EVM RSN so I can cover testing that
part as well.

-Matt
