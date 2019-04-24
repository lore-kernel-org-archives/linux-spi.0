From: Ludovic BARRE <ludovic.barre@st.com>
Subject: Re: [PATCH] spi: stm32-qspi: manage the get_irq error case
Date: Wed, 24 Apr 2019 17:35:53 +0200
Message-ID: <a8f7a11e-5aa9-8d91-ac57-641fec2ca899@st.com>
References: <1556119140-3319-1-git-send-email-fabien.dessenne@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
To: Fabien Dessenne <fabien.dessenne@st.com>,
        Mark Brown <broonie@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Christophe KERELLO <christophe.kerello@st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1556119140-3319-1-git-send-email-fabien.dessenne@st.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org



On 4/24/19 5:19 PM, Fabien Dessenne wrote:
> During probe, check the "get_irq" error value.
> 
> Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>

Acked-by: Ludovic Barre <ludovic.barre@st.com>

> ---
>   drivers/spi/spi-stm32-qspi.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
> index 11a89aa..42f8e3c 100644
> --- a/drivers/spi/spi-stm32-qspi.c
> +++ b/drivers/spi/spi-stm32-qspi.c
> @@ -574,6 +574,12 @@ static int stm32_qspi_probe(struct platform_device *pdev)
>   	}
>   
>   	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		if (irq != -EPROBE_DEFER)
> +			dev_err(dev, "IRQ error missing or invalid\n");
> +		return irq;
> +	}
> +
>   	ret = devm_request_irq(dev, irq, stm32_qspi_irq, 0,
>   			       dev_name(dev), qspi);
>   	if (ret) {
> 
