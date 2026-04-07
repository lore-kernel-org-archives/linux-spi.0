Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C6C165F16
	for <linux-spi@vger.kernel.org>; Tue,  7 Apr 2026 00:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775523408; cv=none; b=hyj6OQ5Xlbg2OV8aGmpQqi0S3fRaJ67FZwzam/cfZsDsPXBsKQVFkVYqK9PYZqLMwe2gVu0PgtVo3wYiv2RUAMKR/gabdF8Bgs6+URSnoQe9z2nMbM2yebHdmPqa/btjnhv71JeOf1BjnvM5UKwwjt087Cu1d+3Ka3UTCxi2C3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775523408; c=relaxed/simple;
	bh=M7nWyKLJ3GY+PGFL+vjpFHGa6ttk4FgnKiPYY7Zvq7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dNdbcJch6jvmAd2hN7RBWyP7fISFHP+hwHLRam7wYowJGpW0dy89SxeMNPefFM9k2RgGdENyPV/49PAB6GOJYRwM3OpAESrn5XHz6uCNtDWTdMOuIZNh09G3qi5GGReSG3INRd8kGFfNKQZLd4sM9xNS13Ol9/sycMSAjbhu8Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 9f3b7bfe321c11f1aa26b74ffac11d73-20260407
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:cc9bbc31-450b-4d3d-972c-498906ae5eea,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:d15443dfe2878fbd3dc5f1755faea8d8,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|898,TC:nil,Content:0|15|
	52,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 9f3b7bfe321c11f1aa26b74ffac11d73-20260407
X-User: xiaopei01@kylinos.cn
Received: from [10.42.12.251] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 273538086; Tue, 07 Apr 2026 08:56:33 +0800
Message-ID: <507ccb74-1b56-4cda-b401-e8b32595d748@kylinos.cn>
Date: Tue, 7 Apr 2026 08:56:31 +0800
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] spi: uniphier: Simplify clock handling with
 devm_clk_get_enabled()
To: Mark Brown <broonie@kernel.org>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Masami Hiramatsu <mhiramat@kernel.org>
Cc: gch981213@gmail.com, linux-spi@vger.kernel.org,
 linux-mediatek@lists.infradead.org
References: <cover.1775273351.git.xiaopei01@kylinos.cn>
 <ceacbce51039b10e13ec9317cd46ed2fb0354952.1775273351.git.xiaopei01@kylinos.cn>
 <b78ec8d7-feb9-4588-b51a-ced8d8a35a23@sirena.org.uk>
From: Pei Xiao <xiaopei01@kylinos.cn>
In-Reply-To: <b78ec8d7-feb9-4588-b51a-ced8d8a35a23@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2026/4/6 20:56, Mark Brown 写道:
> On Sat, Apr 04, 2026 at 11:44:59AM +0800, Pei Xiao wrote:
>> Replace devm_clk_get() followed by clk_prepare_enable() with
>> devm_clk_get_enabled() for the clock. This removes the need for
>> explicit clock enable and disable calls, as the managed API automatically
>> handles clock disabling on device removal or probe failure.
> 
> Copying in the maintainers for the driver, you should generally copy
> maintainers when posting patches (and to avoid large CC lists it's often
> better to send patches per driver unless the series is actually related,
> this one isn't).
> 
Yes, I only sent it to you to avoid CC'ing too many people. 
I will send these patches separately to the corresponding maintainers.

Thank you!
Pei.
>> Remove the now-unnecessary clk_disable_unprepare() calls from the probe
>> error path and the remove callback. Adjust error labels accordingly.
>>
>> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
>> ---
>>  drivers/spi/spi-uniphier.c | 18 ++++--------------
>>  1 file changed, 4 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/spi/spi-uniphier.c b/drivers/spi/spi-uniphier.c
>> index 9e1d364a6198..1b815ee2ed1b 100644
>> --- a/drivers/spi/spi-uniphier.c
>> +++ b/drivers/spi/spi-uniphier.c
>> @@ -666,28 +666,24 @@ static int uniphier_spi_probe(struct platform_device *pdev)
>>  	}
>>  	priv->base_dma_addr = res->start;
>>  
>> -	priv->clk = devm_clk_get(&pdev->dev, NULL);
>> +	priv->clk = devm_clk_get_enabled(&pdev->dev, NULL);
>>  	if (IS_ERR(priv->clk)) {
>>  		dev_err(&pdev->dev, "failed to get clock\n");
>>  		ret = PTR_ERR(priv->clk);
>>  		goto out_host_put;
>>  	}
>>  
>> -	ret = clk_prepare_enable(priv->clk);
>> -	if (ret)
>> -		goto out_host_put;
>> -
>>  	irq = platform_get_irq(pdev, 0);
>>  	if (irq < 0) {
>>  		ret = irq;
>> -		goto out_disable_clk;
>> +		goto out_host_put;
>>  	}
>>  
>>  	ret = devm_request_irq(&pdev->dev, irq, uniphier_spi_handler,
>>  			       0, "uniphier-spi", priv);
>>  	if (ret) {
>>  		dev_err(&pdev->dev, "failed to request IRQ\n");
>> -		goto out_disable_clk;
>> +		goto out_host_put;
>>  	}
>>  
>>  	init_completion(&priv->xfer_done);
>> @@ -716,7 +712,7 @@ static int uniphier_spi_probe(struct platform_device *pdev)
>>  	if (IS_ERR_OR_NULL(host->dma_tx)) {
>>  		if (PTR_ERR(host->dma_tx) == -EPROBE_DEFER) {
>>  			ret = -EPROBE_DEFER;
>> -			goto out_disable_clk;
>> +			goto out_host_put;
>>  		}
>>  		host->dma_tx = NULL;
>>  		dma_tx_burst = INT_MAX;
>> @@ -766,9 +762,6 @@ static int uniphier_spi_probe(struct platform_device *pdev)
>>  		host->dma_tx = NULL;
>>  	}
>>  
>> -out_disable_clk:
>> -	clk_disable_unprepare(priv->clk);
>> -
>>  out_host_put:
>>  	spi_controller_put(host);
>>  	return ret;
>> @@ -777,14 +770,11 @@ static int uniphier_spi_probe(struct platform_device *pdev)
>>  static void uniphier_spi_remove(struct platform_device *pdev)
>>  {
>>  	struct spi_controller *host = platform_get_drvdata(pdev);
>> -	struct uniphier_spi_priv *priv = spi_controller_get_devdata(host);
>>  
>>  	if (host->dma_tx)
>>  		dma_release_channel(host->dma_tx);
>>  	if (host->dma_rx)
>>  		dma_release_channel(host->dma_rx);
>> -
>> -	clk_disable_unprepare(priv->clk);
>>  }
>>  
>>  static const struct of_device_id uniphier_spi_match[] = {
>> -- 
>> 2.25.1
>>

