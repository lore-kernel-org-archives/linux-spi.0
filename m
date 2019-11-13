From: <Nicolas.Ferre@microchip.com>
Subject: Re: [PATCH 1/9] spi: at91-usart: Use dma_request_chan() directly for
 channel request
Date: Wed, 13 Nov 2019 14:18:51 +0000
Message-ID: <05f47be4-f58a-d61f-92e1-c4985c4c3680@microchip.com>
References: <20191113094256.1108-1-peter.ujfalusi@ti.com>
 <20191113094256.1108-2-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Cc: <alexandre.belloni@bootlin.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <krzk@kernel.org>,
        <linux-spi@vger.kernel.org>, <vkoul@kernel.org>,
        <kgene@kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
To: <peter.ujfalusi@ti.com>, <broonie@kernel.org>,
        <radu_nicolae.pirea@upb.ro>, <shawnguo@kernel.org>,
        <s.hauer@pengutronix.de>, <linus.walleij@linaro.org>,
        <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <andi@etezian.org>, <ldewangan@nvidia.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191113094256.1108-2-peter.ujfalusi@ti.com>
Content-Language: en-US
Content-ID: <E9B225392312DD4A83975A3892B8473A@namprd11.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 13/11/2019 at 10:42, Peter Ujfalusi wrote:
> External E-Mail
>=20
>=20
> dma_request_slave_channel_reason() is:
> #define dma_request_slave_channel_reason(dev, name) \
> 	dma_request_chan(dev, name)
>=20
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> ---
>   drivers/spi/spi-at91-usart.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/spi/spi-at91-usart.c b/drivers/spi/spi-at91-usart.c
> index a40bb2ef89dc..88033422a42a 100644
> --- a/drivers/spi/spi-at91-usart.c
> +++ b/drivers/spi/spi-at91-usart.c
> @@ -132,7 +132,7 @@ static int at91_usart_spi_configure_dma(struct spi_co=
ntroller *ctlr,
>   	dma_cap_zero(mask);
>   	dma_cap_set(DMA_SLAVE, mask);
>  =20
> -	ctlr->dma_tx =3D dma_request_slave_channel_reason(dev, "tx");
> +	ctlr->dma_tx =3D dma_request_chan(dev, "tx");
>   	if (IS_ERR_OR_NULL(ctlr->dma_tx)) {
>   		if (IS_ERR(ctlr->dma_tx)) {
>   			err =3D PTR_ERR(ctlr->dma_tx);
> @@ -145,7 +145,7 @@ static int at91_usart_spi_configure_dma(struct spi_co=
ntroller *ctlr,
>   		goto at91_usart_spi_error_clear;
>   	}
>  =20
> -	ctlr->dma_rx =3D dma_request_slave_channel_reason(dev, "rx");
> +	ctlr->dma_rx =3D dma_request_chan(dev, "rx");
>   	if (IS_ERR_OR_NULL(ctlr->dma_rx)) {
>   		if (IS_ERR(ctlr->dma_rx)) {
>   			err =3D PTR_ERR(ctlr->dma_rx);
>=20


--=20
Nicolas Ferre
