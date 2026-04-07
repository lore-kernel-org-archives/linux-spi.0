Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2043A4511;
	Tue,  7 Apr 2026 10:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775559239; cv=none; b=st5NRhdRSZBN7oo3JmyPefBciPuoQut+j1wL7qprxRkg8qhlTOTALPcUjPvqnljzMzkBzfsGoLFJYl1CLPpKVqoSAomxmBQSNYInBSNam1wvKu7zxXQNYDKgmjS/E4D3AYCdDggubEv7/d94pSxrnQhaHqXQIiVA+h1lXCUoA5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775559239; c=relaxed/simple;
	bh=ms/SAUXorWbtBC+aRlpiLnT/6HZVcc7AC+weWsDGBKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=App/N7KbyAz/oWO9vj8eIEfcHxa6vf5lAcgBvrdlwfTTOyN7/RNxi5F1vFpM/RiAJP2f+M6EL6qFgv67dFDgTH0GzFrfxuk3eb5G6eLp9Hxs444wxUXuYGXognI5j8cu7E3dFdEmaS42oJMfJCz2cm/KXwtfNviviZrtZzDp/9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO iyokan3-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 07 Apr 2026 19:52:47 +0900
Received: from mail.mfilter.local (mail-arc02.css.socionext.com [10.213.46.40])
	by iyokan3-ex.css.socionext.com (Postfix) with ESMTP id BDF0F2091483;
	Tue,  7 Apr 2026 19:52:47 +0900 (JST)
Received: from iyokan3.css.socionext.com ([172.31.9.53]) by m-FILTER with ESMTP; Tue, 7 Apr 2026 19:52:47 +0900
Received: from [10.212.247.199] (unknown [10.212.247.199])
	by iyokan3.css.socionext.com (Postfix) with ESMTP id 3618210A0BE;
	Tue,  7 Apr 2026 19:52:47 +0900 (JST)
Message-ID: <c5a88b29-9a2b-43e7-b75f-3c7f19cfaeaf@socionext.com>
Date: Tue, 7 Apr 2026 19:52:47 +0900
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: uniphier: Simplify clock handling with
 devm_clk_get_enabled()
To: Pei Xiao <xiaopei01@kylinos.cn>
Cc: broonie@kernel.org, mhiramat@kernel.org, linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <b2deeefd4ef1a4bce71116aabfcb7e81400f6d37.1775546948.git.xiaopei01@kylinos.cn>
Content-Language: en-US
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <b2deeefd4ef1a4bce71116aabfcb7e81400f6d37.1775546948.git.xiaopei01@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 2026/04/07 16:30, Pei Xiao wrote:
> Replace devm_clk_get() followed by clk_prepare_enable() with
> devm_clk_get_enabled() for the clock. This removes the need for
> explicit clock enable and disable calls, as the managed API automatically
> handles clock disabling on device removal or probe failure.
> 
> Remove the now-unnecessary clk_disable_unprepare() calls from the probe
> error path and the remove callback. Adjust error labels accordingly.
> 
> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
> ---
>   drivers/spi/spi-uniphier.c | 18 ++++--------------
>   1 file changed, 4 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/spi/spi-uniphier.c b/drivers/spi/spi-uniphier.c
> index 9e1d364a6198..1b815ee2ed1b 100644
> --- a/drivers/spi/spi-uniphier.c
> +++ b/drivers/spi/spi-uniphier.c
> @@ -666,28 +666,24 @@ static int uniphier_spi_probe(struct platform_device
> *pdev)
>   	}
>   	priv->base_dma_addr = res->start;
>   
> -	priv->clk = devm_clk_get(&pdev->dev, NULL);
> +	priv->clk = devm_clk_get_enabled(&pdev->dev, NULL);
>   	if (IS_ERR(priv->clk)) {
>   		dev_err(&pdev->dev, "failed to get clock\n");
>   		ret = PTR_ERR(priv->clk);
>   		goto out_host_put;
>   	}
>   
> -	ret = clk_prepare_enable(priv->clk);
> -	if (ret)
> -		goto out_host_put;
> -
>   	irq = platform_get_irq(pdev, 0);
>   	if (irq < 0) {
>   		ret = irq;
> -		goto out_disable_clk;
> +		goto out_host_put;
>   	}
>   
>   	ret = devm_request_irq(&pdev->dev, irq, uniphier_spi_handler,
>   			       0, "uniphier-spi", priv);
>   	if (ret) {
>   		dev_err(&pdev->dev, "failed to request IRQ\n");
> -		goto out_disable_clk;
> +		goto out_host_put;
>   	}
>   
>   	init_completion(&priv->xfer_done);
> @@ -716,7 +712,7 @@ static int uniphier_spi_probe(struct platform_device
> *pdev)
>   	if (IS_ERR_OR_NULL(host->dma_tx)) {
>   		if (PTR_ERR(host->dma_tx) == -EPROBE_DEFER) {
>   			ret = -EPROBE_DEFER;
> -			goto out_disable_clk;
> +			goto out_host_put;
>   		}
>   		host->dma_tx = NULL;
>   		dma_tx_burst = INT_MAX;
> @@ -766,9 +762,6 @@ static int uniphier_spi_probe(struct platform_device
> *pdev)
>   		host->dma_tx = NULL;
>   	}
>   
> -out_disable_clk:
> -	clk_disable_unprepare(priv->clk);
> -
>   out_host_put:
>   	spi_controller_put(host);
>   	return ret;
> @@ -777,14 +770,11 @@ static int uniphier_spi_probe(struct platform_device
> *pdev)
>   static void uniphier_spi_remove(struct platform_device *pdev)
>   {
>   	struct spi_controller *host = platform_get_drvdata(pdev);
> -	struct uniphier_spi_priv *priv = spi_controller_get_devdata(host);
>   
>   	if (host->dma_tx)
>   		dma_release_channel(host->dma_tx);
>   	if (host->dma_rx)
>   		dma_release_channel(host->dma_rx);
> -
> -	clk_disable_unprepare(priv->clk);
>   }
>   
>   static const struct of_device_id uniphier_spi_match[] = {

Looks good to me.

Reviewed-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

Thank you,

---
Best Regards
Kunihiko Hayashi
