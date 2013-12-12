From: Huang Shijie <shijie8@gmail.com>
Subject: Re: [PATCHv2 07/10] drivers: mtd: m25p80: Adapt driver to support
 memory mapped read.
Date: Thu, 12 Dec 2013 16:31:46 +0800
Message-ID: <20131212083143.GB1596@gmail.com>
References: <1386339891-32717-1-git-send-email-sourav.poddar@ti.com>
 <1386339891-32717-8-git-send-email-sourav.poddar@ti.com>
 <20131212075536.GA1596@gmail.com>
 <52A9709C.4010606@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: broonie@kernel.org, linux-spi@vger.kernel.org,
	computersforpeace@gmail.com, marex@denx.de,
	devicetree@vger.kernel.org, balbi@ti.com,
	linux-mtd@lists.infradead.org, bcousson@baylibre.com,
	linux-omap@vger.kernel.org, dwmw2@infradead.org
To: Sourav Poddar <sourav.poddar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <52A9709C.4010606@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, Dec 12, 2013 at 01:45:24PM +0530, Sourav Poddar wrote:
> On Thursday 12 December 2013 01:25 PM, Huang Shijie wrote:
> >>
> >>+	if (spi->master->configure_from_slave)
> >>+		m25p80_fill_flash_information(flash);
> >>+
> >You have add a configure_from_slave hook in the SPI, why you also need
> >a same hook in the SPI-NOR framework?
> >
> We need a way to provoke this, currently it is placed in m25p80. If m25p80
> is removed, for where should I handle these in nor framework?

The m25p80 is not removed. it is easy to move your code in the
m25p_read.

Please read the patch 4.

> >And i think the enable_mmap/disable_mmap is not needed too.
> >
> >All the three hooks are used to set the SPI bus controller.
> 
> >And the SPI-NOR framework only handles the issues between the
> >SPI bus controller and the SPI-NOR, or the SPI-NOR controller and the
> >SPI-NOR.
> My controller can be used as spi flash controller as well as a spi
> controller.
> 
If you really think we need to do something before the do the real work.
we can add two hooks : prepare/unprepare.

   for you, you can put the the enable_mmap/disable_mmap in the
   prepare/unprepare separately.

   for other driver, we can put the enable/disable clocks in the
   prepare/unprepare hooks.

thanks
Huang Shijie 
   


