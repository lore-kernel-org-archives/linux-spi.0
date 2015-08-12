From: Jonas Gorski <jogo@openwrt.org>
Subject: Re: [PATCH] spi: Mediatek: fix endian warnings
Date: Wed, 12 Aug 2015 16:45:25 +0200
Message-ID: <CAOiHx=mrDhxkMd5WVTpayyyxXHUDRTELubErynN3qd-v5qpCfw@mail.gmail.com>
References: <1439289789-29026-1-git-send-email-leilk.liu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, linux-spi@vger.kernel.org,
	linux-mediatek@lists.infradead.org
To: Leilk Liu <leilk.liu@mediatek.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1439289789-29026-1-git-send-email-leilk.liu@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi,

On Tue, Aug 11, 2015 at 12:43 PM, Leilk Liu <leilk.liu@mediatek.com> wrote:
> This patch fixes endian warnings detected by sparse:
> - sparse: incorrect type in argument 1 (different base types)
>           expected unsigned int [unsigned] val
>           got restricted __le32 [usertype] <noident>
> - sparse: incorrect type in argument 1 (different base types)
>           expected unsigned int [unsigned] val
>           got restricted __le32 [usertype] <noident>

This doesn't "fix" the warning, it only hides the warning and leaves
the actual issue unfixed.

>
> Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
> ---
>  drivers/spi/spi-mt65xx.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
> index 4676b01..ae645fa 100644
> --- a/drivers/spi/spi-mt65xx.c
> +++ b/drivers/spi/spi-mt65xx.c
> @@ -359,9 +359,11 @@ static void mtk_spi_setup_dma_addr(struct spi_master *master,
>         struct mtk_spi *mdata = spi_master_get_devdata(master);
>
>         if (mdata->tx_sgl)
> -               writel(cpu_to_le32(xfer->tx_dma), mdata->base + SPI_TX_SRC_REG);
> +               writel((__force u32)cpu_to_le32(xfer->tx_dma),
> +                      mdata->base + SPI_TX_SRC_REG);
>         if (mdata->rx_sgl)
> -               writel(cpu_to_le32(xfer->rx_dma), mdata->base + SPI_RX_DST_REG);
> +               writel((__force u32)cpu_to_le32(xfer->rx_dma),
> +                      mdata->base + SPI_RX_DST_REG);

The issue here is that writel already does a cpu_to_le32 conversion,
so the extra cpu_to_le32 calls are actually bogus and need to be
removed. Else it will do a double conversion on big endian systems,
resulting in the data being written in big endian.


Jonas
