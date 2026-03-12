Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455C7344025;
	Thu, 12 Mar 2026 02:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773282341; cv=none; b=l6BSLZlO+rbeK2Zbpk4M4wbUgEYKqSyM7KwE41zm2jsmtV9QCKWivdmwM85ua8LQMVlEcT7YBpyuiF6mVL+x+nfYUjf7ONBocEvRexYZydn4WeCksxtbA8+PqeJ2wmOnlb8WmXw2xzodg01TOai8X875g1ynT+9fPoIcUYV/Ejg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773282341; c=relaxed/simple;
	bh=zCfet0FrY4P9AejQF7385eVfJo6vUwLZGX2o8ICU/VY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZB1ZG20+CVc04vS6XCmOyspyQnqJX4idF30GEDdVYxMaNE/TLBAW0+N9HFgt2MUHLqRnuOgSALAXFcQZHOnRjkcUESpAK8Y8QU+CoOGSVRdnaPWClow+p3kudJqMmM2OUkwCfl2D9IK3SrJ5jzK6i2DCzPS5LnK+nhmKM4vmfYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: bc1adc721dba11f1a21c59e7364eecb8-20260312
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:6dfc24d7-5b16-425b-9438-1fb1105bf179,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:89c9d04,CLOUDID:4a52ff1f88a243828f22a582dc6edf80,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|898,TC:nil,Content:0|15|
	52,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: bc1adc721dba11f1a21c59e7364eecb8-20260312
X-User: xiaopei01@kylinos.cn
Received: from [10.42.12.251] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 2049402193; Thu, 12 Mar 2026 10:25:28 +0800
Message-ID: <c95608b9-4912-4b42-a188-1265d603ddb0@kylinos.cn>
Date: Thu, 12 Mar 2026 10:25:11 +0800
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] spi: atcspi200: fix mutex initialization order
To: Mark Brown <broonie@kernel.org>
Cc: cl634@andestech.com, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1773193726.git.xiaopei01@kylinos.cn>
 <f47d4c292bdff7a0bad8d316c28c83c0fda36a0c.1773193726.git.xiaopei01@kylinos.cn>
 <dd58aff2-2408-4aac-b39a-bca8fe4cd64e@sirena.org.uk>
From: Pei Xiao <xiaopei01@kylinos.cn>
In-Reply-To: <dd58aff2-2408-4aac-b39a-bca8fe4cd64e@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


在 2026/3/11 20:29, Mark Brown 写道:
> On Wed, Mar 11, 2026 at 09:55:14AM +0800, Pei Xiao wrote:
>
>> @@ -551,6 +551,10 @@ static int atcspi_probe(struct platform_device *pdev)
>>  	spi->dev = &pdev->dev;
>>  	dev_set_drvdata(&pdev->dev, host);
>>  
>> +	ret = devm_mutex_init(spi->dev, &spi->mutex_lock);
>> +	if (ret)
>> +		goto free_controller;
>> +
> This means we're now using devm to free the mutex that is in spi, but
> when we pass spi into devm_spi_register_controller() we'll cause spi to
> be freed before we free the mutex.  This pattern gets a bit clunky with
> devm...
Thanks for review! I will use mutex_init() for V3 version.
