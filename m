From: Amelie DELAUNAY <amelie.delaunay@st.com>
Subject: Re: [PATCH] spi: stm32: return the get_irq error
Date: Wed, 24 Apr 2019 14:52:16 +0000
Message-ID: <6c11793b-bcfc-e069-56db-7e963d22dc6e@st.com>
References: <1556109524-21874-1-git-send-email-fabien.dessenne@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Fabien DESSENNE <fabien.dessenne@st.com>, Mark Brown <broonie@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre TORGUE
 <alexandre.torgue@st.com>, "linux-spi@vger.kernel.org"
 <linux-spi@vger.kernel.org>, "linux-stm32@st-md-mailman.stormreply.com"
 <linux-stm32@st-md-mailman.stormreply.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1556109524-21874-1-git-send-email-fabien.dessenne@st.com>
Content-Language: en-US
Content-ID: <A12641FDC7F83E418048CC3BBE567653@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

On 4/24/19 2:38 PM, Fabien Dessenne wrote:
> During probe, return the "get_irq" error value instead of -ENOENT. This
> allows the driver to be defer probed if needed.
> 
> Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>

Acked-by: Amelie Delaunay <amelie.delaunay@st.com>

> ---
>   drivers/spi/spi-stm32.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
> index 4186ed2..b222ce8 100644
> --- a/drivers/spi/spi-stm32.c
> +++ b/drivers/spi/spi-stm32.c
> @@ -1839,8 +1839,9 @@ static int stm32_spi_probe(struct platform_device *pdev)
>   
>   	spi->irq = platform_get_irq(pdev, 0);
>   	if (spi->irq <= 0) {
> -		dev_err(&pdev->dev, "no irq: %d\n", spi->irq);
> -		ret = -ENOENT;
> +		ret = spi->irq;
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(&pdev->dev, "failed to get irq: %d\n", ret);
>   		goto err_master_put;
>   	}
>   	ret = devm_request_threaded_irq(&pdev->dev, spi->irq,
> 
