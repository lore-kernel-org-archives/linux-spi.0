From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH] sh: MSIOF/mmc_spi platform data for the Ecovec24 board
Date: Tue, 15 Dec 2009 12:40:15 +0900
Message-ID: <20091215034015.GE7395@linux-sh.org>
References: <20091207140545.6294.90256.sendpatchset@rxone.opensource.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-sh@vger.kernel.org, spi-devel-general@lists.sourceforge.net,
	akpm@linux-foundation.org
To: Magnus Damm <magnus.damm@gmail.com>
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20091207140545.6294.90256.sendpatchset@rxone.opensource.se>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, Dec 07, 2009 at 11:05:45PM +0900, Magnus Damm wrote:
> This patch adds MSIOF and mmc_spi platform data for
> the CN11 port on the SuperH Ecovec24 board. No card
> detect interrupt is available so the MMC code is
> configured to poll. The WP signal is implemented
> together with CD and power control. The board only
> supports 3.3V power.
> 
> The platform data is wrapped in SDHI #ifdefs to
> allow both the SDHI and the MSIOF to coexist. Only
> one configuration is allowed at a time. The pin
> routing is selected by a dip switch but we can
> unfortunately not detect this setting at run time.

Now that the MSIOF driver is merged, I've applied this.
