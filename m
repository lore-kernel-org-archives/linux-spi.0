From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH] spi: Mediatek: fix endian warnings
Date: Sat, 15 Aug 2015 22:17:15 +0200
Message-ID: <4559739.Ziakvog9nM@wuerfel>
References: <1439289789-29026-1-git-send-email-leilk.liu@mediatek.com>
 <1871097.B3YgX5rNy0@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
 Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
 linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
 linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
 linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1871097.B3YgX5rNy0@wuerfel>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Saturday 15 August 2015 22:16:03 Arnd Bergmann wrote:
> On Tuesday 11 August 2015 18:43:09 Leilk Liu wrote:
> > @@ -359,9 +359,11 @@ static void mtk_spi_setup_dma_addr(struct spi_master *master,
> >         struct mtk_spi *mdata = spi_master_get_devdata(master);
> >  
> >         if (mdata->tx_sgl)
> > -               writel(cpu_to_le32(xfer->tx_dma), mdata->base + SPI_TX_SRC_REG);
> > +               writel((__force u32)cpu_to_le32(xfer->tx_dma),
> > +                      mdata->base + SPI_TX_SRC_REG);
> >         if (mdata->rx_sgl)
> > -               writel(cpu_to_le32(xfer->rx_dma), mdata->base + SPI_RX_DST_REG);
> > +               writel((__force u32)cpu_to_le32(xfer->rx_dma),
> > +                      mdata->base + SPI_RX_DST_REG);
> >  }
> > 
> 
> This looks wrong: writel takes a CPU-endian argument, so the value returned
> from cpu_to_le32() is not appropriate.
> 
> The warning is correct, and you have to remove the cpu_to_le32() conversion
> in order to get the driver to behave correctly when the kernel is built
> as big-endian.

Nevermind, I now saw the issue has already been raised.

	Arnd
