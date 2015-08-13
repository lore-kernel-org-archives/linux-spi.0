From: lei liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH] spi: Mediatek: fix endian warnings
Date: Thu, 13 Aug 2015 10:11:59 +0800
Message-ID: <1439431919.21454.13.camel@mhfsdcap03>
References: <1439289789-29026-1-git-send-email-leilk.liu@mediatek.com>
	 <CAOiHx=mrDhxkMd5WVTpayyyxXHUDRTELubErynN3qd-v5qpCfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAOiHx=mrDhxkMd5WVTpayyyxXHUDRTELubErynN3qd-v5qpCfw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hello Mark,

 This patch is applied, should I append a new patch or you rollback it?
Thanks.

On Wed, 2015-08-12 at 16:45 +0200, Jonas Gorski wrote:
> Hi,
> 
> On Tue, Aug 11, 2015 at 12:43 PM, Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org> wrote:
> > This patch fixes endian warnings detected by sparse:
> > - sparse: incorrect type in argument 1 (different base types)
> >           expected unsigned int [unsigned] val
> >           got restricted __le32 [usertype] <noident>
> > - sparse: incorrect type in argument 1 (different base types)
> >           expected unsigned int [unsigned] val
> >           got restricted __le32 [usertype] <noident>
> 
> This doesn't "fix" the warning, it only hides the warning and leaves
> the actual issue unfixed.
> 
> >
> > Signed-off-by: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > ---
> >  drivers/spi/spi-mt65xx.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
> > index 4676b01..ae645fa 100644
> > --- a/drivers/spi/spi-mt65xx.c
> > +++ b/drivers/spi/spi-mt65xx.c
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
> 
> The issue here is that writel already does a cpu_to_le32 conversion,
> so the extra cpu_to_le32 calls are actually bogus and need to be
> removed. Else it will do a double conversion on big endian systems,
> resulting in the data being written in big endian.
> 
> 
> Jonas


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
