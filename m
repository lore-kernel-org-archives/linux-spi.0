From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 0/5] spi: omap2-mcspi: driver updates
Date: Tue, 27 Mar 2012 15:58:38 -0600
Message-ID: <20120327215838.AB7C33E13A0@localhost>
References: <1332769480-28069-1-git-send-email-shubhrajyoti@ti.com>
Cc: Shubhrajyoti@ponder.secretlab.ca, linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org, D <shubhrajyoti@ti.com>
To: Shubhrajyoti D <shubhrajyoti@ti.com>,
	spi-devel-general@lists.sourceforge.net
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1332769480-28069-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, 26 Mar 2012 19:14:35 +0530, Shubhrajyoti D <shubhrajyoti@ti.com> wrote:
> The patch series does the following cleanups
> - Converts the spi to module_platform_driver
> - Use the devm functions so that the freeing need not 
>   be done in the driver.
> - Makes the driver use autosuspend
> - Folds Benoit's bus_num removal patch in the series
> 
> Changes from the previous version
> - Makes the driver use autosuspend
> - Folds Benoit's bus_num removal patch in the series
> 
> 
> This is also available through
> git     : git://gitorious.org/linus-tree/linus-tree.git
> branch  : spi

Hi Shubhrajyoti,

I'll queue these ones up for v3.5 unless you make the argument that
they are bug fixes that must go into v3.4.

g.
