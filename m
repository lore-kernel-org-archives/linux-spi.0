From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH] Revert
 "spi: omap2-mcspi: convert to module_platform_driver"
Date: Fri, 21 Sep 2012 09:28:24 +0300
Message-ID: <20120921092824.5898787137c388ba54afe2a5@bitmer.com>
References: <1343948917-14760-1-git-send-email-aaro.koskinen@iki.fi>
	<CACxGe6scCYLpsEDGGwaXw_ijAk027w6Mk7D7FSOTZZdC6VkKSg@mail.gmail.com>
	<1343981127.2744.28.camel@deskari>
	<20120803094553.GA731@harshnoise.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	spi-devel-general@lists.sourceforge.net,
	linux-omap@vger.kernel.org, balbi@ti.com
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20120803094553.GA731@harshnoise.musicnaut.iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, 3 Aug 2012 12:45:53 +0300
Aaro Koskinen <aaro.koskinen@iki.fi> wrote:

> So an altenative hack to fix this is to modify the board file
> (board-rx51-peripherals.c):
> 
> 	 /* list all spi devices here */
> 	 enum {
> 	 	RX51_SPI_WL1251,
> 	-	RX51_SPI_MIPID,		/* LCD panel */
> 	 	RX51_SPI_TSC2005,	/* Touch Controller */
> 	+	RX51_SPI_MIPID,		/* LCD panel */
> 	 };
> 
> I guess the proper fix would be to modify SPI core so that it first does
> spi_setup for all the children/chip selects, before calling any of the
> probe functions of SPI devices? (Initializing the controller driver at
> subsys_initcall is one way to accomplish this.)
> 
As the N900 framebuffer still appears to be broken would it make sense to queue above change as a workaround for 3.5 and 3.6?

Aaro: For above change you could add my 'Tested-by: Jarkko Nikula <jarkko.nikula@bitmer.com>'

-- 
Jarkko
