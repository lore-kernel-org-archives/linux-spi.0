From: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] spi:fsl-dspi:add dspi tcfq mode transfer support
Date: Sun, 28 Sep 2014 16:52:18 +0800
Message-ID: <20140928085216.GA2383@dragon>
References: <1411640665-20671-1-git-send-email-b44548@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, R64188-KZfg59tc24xl57MIdRCFDg@public.gmane.org
To: Chao Fu <b44548-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1411640665-20671-1-git-send-email-b44548-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thu, Sep 25, 2014 at 06:24:23PM +0800, Chao Fu wrote:
> From: Chao Fu <B44548-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> 
> TCFQ is interrupt of Transfer Complete Flag in DSPI module.
> EOQ is interrupt of End of Queue Flag in DSPI module.
> For adopting of different platform, either of them is a way of DSPI
> transfer data. This patch add TCF support for DSPI module  in other platform.
> 
> The software will be changed in two transfer methods as followwing:
> 		 EOQ			TCFQ
> transfer data: dspi_eoq_write	  dspi_tcfq_write
> receive data:  dspi_eoq_read	  dspi_tcfq_read
> 
> Using which method will decided by paltform soc dtsi file.
> 
> Remove bitbang:
> Add tcf funtions, DSPI module need get cs change information in a spi transfer.
> According cs change, DSPI will give last data the right flag. Bitbang provide
> cs change behind the last data in a transfer. So DSPI can not deal the last data in
> every transfer properly, so remove the bitbang in the driver.
> 
> Merge duplicate code:
> 	dspi_data_from_popr
> 	dspi_data_to_pushr
> 
> Remove clk reference in regmap I/O:
> Set the clk parament is NULL in devm_regmap_init_mmio_clk, it will avoid clk handle
> in every register read/write, and advance tranferring efficiency.
> 
> Signed-off-by: Chao Fu      <b44548-KZfg59tc24xl57MIdRCFDg@public.gmane.org>

It looks you are doing too many things in a single patch.  You should
probably split into several patches to make the review process a little
easier.

Shawn
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
