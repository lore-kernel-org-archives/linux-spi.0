From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 29/30] spi: s3c64xx: move to generic dmaengine API
Date: Wed, 17 Apr 2013 22:05:35 +0200
Message-ID: <201304172205.35526.arnd@arndb.de>
References: <1365638712-1028578-1-git-send-email-arnd@arndb.de> <1365638712-1028578-30-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>,
	linux-samsung-soc@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Padma Venkat <padma.kvr@gmail.com>
To: linux-arm-kernel@lists.infradead.org
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1365638712-1028578-30-git-send-email-arnd@arndb.de>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thursday 11 April 2013, Arnd Bergmann wrote:
> @@ -713,9 +836,9 @@ static int s3c64xx_spi_transfer_one_message(struct spi_master *master,
>                 }
>  
>                 /* Polling method for xfers not bigger than FIFO capacity */
> -               if (xfer->len <= ((FIFO_LVL_MASK(sdd) >> 1) + 1))
> -                       use_dma = 0;
> -               else
> +               use_dma = 0;
> +               if (sdd->rx_dma.ch && sdd->tx_dma.ch &&
> +                   (xfer->len > ((FIFO_LVL_MASK(sdd) >> 1) + 1)))
>                         use_dma = 1;
>  
>                 spin_lock_irqsave(&sdd->lock, flags);

Can you try just reverting this hunk? It's actually not required and
comes from an earlier version of the patch. I assumed it was harmless,
but it's the only think I see that should actually make a difference
in my patch for the case of !CONFIG_SAMSUNG_DMADEV.

	Arnd
