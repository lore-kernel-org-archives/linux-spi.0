From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 0/3] OMAP4 Ethernet Controller Support
Date: Tue, 11 May 2010 12:51:48 -0700
Message-ID: <20100511195148.GE13931@atomide.com>
References: <27F9C60D11D683428E133F85D2BB4A53043DFD52D4@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
	"spi-devel-general@lists.sourceforge.net"
	<spi-devel-general@lists.sourceforge.net>
To: "Arce, Abraham" <x0066660@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <27F9C60D11D683428E133F85D2BB4A53043DFD52D4@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

* Arce, Abraham <x0066660@ti.com> [100510 18:36]:
> 
> Enable network chip Micrel KS8851 for OMAP4430 SDP
> 
> - Based on mainline version 2.6.34 rc7
> - Tested in OMAP4430 SDP
> 
> Throughput measurements using nuttcp application:
>   11.9375 MB /  10.06 sec =    9.9519 Mbps 92 %TX 0 %RX 0 retrans 7.87 msRTT
> 
> --
> 
> All patches have been tagged as version 3
> 
> [PATCH v3 1/3] OMAP4: SPI: Fix Driver Kconfig 
> [PATCH v3 2/3] OMAP4: Ethernet: KS8851 Board Support
> [PATCH v3 3/3] OMAP4: Networking: Defconfig Support
> 
> --
> 
>  arch/arm/configs/omap_4430sdp_defconfig |   57 +++++++++++++++++++++-
>  arch/arm/mach-omap2/board-4430sdp.c     |   82 ++++++++++++++++++++++++++++++++
>  drivers/spi/Kconfig                     |    6 +-
>  3 files changed, 140 insertions(+), 5 deletions(-)

I've applied all three into omap for-next branch.

Regards,

Tony
