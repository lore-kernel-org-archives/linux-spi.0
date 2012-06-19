From: Boojin Kim <boojin.kim@samsung.com>
Subject: RE: [PATCH 3/3] ASoC: follow the updated samsung DMA common operations
Date: Tue, 19 Jun 2012 15:30:00 +0900
Message-ID: <011101cd4de4$f41f59f0$dc5e0dd0$%kim@samsung.com>
References: <011701cd42eb$a4209940$ec61cbc0$%kim@samsung.com>
 <20120607234540.GU14525@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, linux-samsung-soc@vger.kernel.org,
	'Russell King - ARM Linux' <linux@arm.linux.org.uk>,
	'Vinod Koul' <vinod.koul@intel.com>,
	'Grant Likely' <grant.likely@secretlab.ca>,
	kgene.kim@samsung.com, spi-devel-general@lists.sourceforge.net,
	'Dan Williams' <dan.j.williams@intel.com>,
	linux-arm-kernel@lists.infradead.org
To: 'Mark Brown' <broonie@opensource.wolfsonmicro.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <20120607234540.GU14525@opensource.wolfsonmicro.com>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Mark Brown wrote
> > This patch uses config() function to configure DMA transmit options.
>
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
>
> It'd be good if we could get all the older Samsung platforms moved over to dmaengine...
Thanks for your ack :)
And, Our engineer's preparing to move the older Samsung dma driver into dmaengine.
