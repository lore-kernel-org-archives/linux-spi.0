From: <Nicolas.Ferre@microchip.com>
Subject: Re: [PATCH 2/9] spi: atmel: Use dma_request_chan() directly for
 channel request
Date: Wed, 13 Nov 2019 14:18:37 +0000
Message-ID: <90cd6e97-2eda-934a-3175-b7d93d86115a@microchip.com>
References: <20191113094256.1108-1-peter.ujfalusi@ti.com>
 <20191113094256.1108-3-peter.ujfalusi@ti.com>
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
In-Reply-To: <20191113094256.1108-3-peter.ujfalusi@ti.com>
Content-Language: en-US
Content-ID: <56B4D518BD1BC143B10FEFA116F9DA10@namprd11.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 13/11/2019 at 10:42, Peter Ujfalusi wrote:
>=20
> dma_request_slave_channel_reason() is:
> #define dma_request_slave_channel_reason(dev, name) \
> 	dma_request_chan(dev, name)
>=20
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

I'm not sure we need one patch per driver. If series taken:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> ---
>   drivers/spi/spi-atmel.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
> index 9e84a93083bc..56f0ca361deb 100644
> --- a/drivers/spi/spi-atmel.c
> +++ b/drivers/spi/spi-atmel.c
> @@ -511,7 +511,7 @@ static int atmel_spi_configure_dma(struct spi_master =
*master,
>   	dma_cap_zero(mask);
>   	dma_cap_set(DMA_SLAVE, mask);
>  =20
> -	master->dma_tx =3D dma_request_slave_channel_reason(dev, "tx");
> +	master->dma_tx =3D dma_request_chan(dev, "tx");
>   	if (IS_ERR(master->dma_tx)) {
>   		err =3D PTR_ERR(master->dma_tx);
>   		if (err =3D=3D -EPROBE_DEFER) {
>=20


--=20
Nicolas Ferre
