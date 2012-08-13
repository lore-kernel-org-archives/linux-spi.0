From: Guenter Roeck <linux@roeck-us.net>
Subject: Unbalanced calls to spi_master_get in coldfire-qspi and s3c64xx SPI
 master drivers
Date: Mon, 13 Aug 2012 14:44:25 -0700
Message-ID: <20120813214425.GA19547@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Ben Dooks <ben-linux@fluff.org>,
	Kukjin Kim <kgene.kim@samsung.com>
To: spi-devel-general@lists.sourceforge.net,
	linux-samsung-soc@vger.kernel.org
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi all,

looking through SPI master drivers, I noticed that the following drivers call
spi_master_get() in their suspend and resume functions. Yet, there is no
matching call to spi_master_put(), meaning the reference count will increase
with each suspend/resume cycle.
	spi-coldfire-qspi.c
	spi-s3c64xx.c
Other SPI master drivers also support suspend and resume, but do not call
spi_master_get() in the suspend/resume functions. The spi-pl022 driver calls
spi_master_suspend() and spi_master_resume() like the above, but does not
call spi_master_get() either.

This leads me to believe that the above drivers will hang on unload after a
suspend/resume cycle due to the extra references.

Can someone please have a look and confirm if my understanding is correct ?
If so I'll send a set of patches to fix the problems.

Thanks,
Guenter
