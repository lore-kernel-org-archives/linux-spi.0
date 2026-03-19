Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FC91C84A6;
	Thu, 19 Mar 2026 01:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773883104; cv=none; b=pZiZUjygl0AJV3MbhQgNJLhfTVqi6AWVZSABABlvvX4Qjw/tTTHj0YkWLMIIN9exhdNFHUgeIol6oLssEuKq7fQvmYBj7fwkeSicT95avmCIwoI5F/FLYKfJWoFqAxgOS0C3XMeuHXy2XQv6aXCj61rgRPgnXkQAO5vr2uxsqfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773883104; c=relaxed/simple;
	bh=A6J6ql4V7xJXDjbneyWjGL2ZCp/icKuB/9OlsjFPdXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F9STuj5VbKvEupWjBRL41bKyWh8seBVdTtyusDf7SGnJvu4rAnnWtY22GJEiIHXe8SKThqbOh3YHH2UIx5zvxxoiKOSBylOlcB5LlNCFNGtU2WHBDBH5XMkMQOlS5FdOclJc0uPHjDoIuU/0DnLETOceNZ1l3//KAGPMu9NPWt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 81b4d91c233111f1a21c59e7364eecb8-20260319
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:fb59812e-4e9c-479a-88a8-7a31cc522676,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:89c9d04,CLOUDID:9d8bd4b2b37dc44e774bc6e5c878740c,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|898,TC:nil,Content:0|15|
	52,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 81b4d91c233111f1a21c59e7364eecb8-20260319
X-User: xiaopei01@kylinos.cn
Received: from [10.42.12.251] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1941724218; Thu, 19 Mar 2026 09:18:16 +0800
Message-ID: <aab5d40b-bc5b-4fab-b687-b7e2a8dd703b@kylinos.cn>
Date: Thu, 19 Mar 2026 09:18:13 +0800
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: hisi-kunpeng: prevent infinite while() loop in
 hisi_spi_flush_fifo
To: Mark Brown <broonie@kernel.org>
Cc: shenyang39@huawei.com, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <d50f1f46b2ee2bba05de9e2d4199353b545194e3.1773820898.git.xiaopei01@kylinos.cn>
 <ac696e0b-530f-48f3-88bf-334f2dbf43b2@sirena.org.uk>
From: Pei Xiao <xiaopei01@kylinos.cn>
In-Reply-To: <ac696e0b-530f-48f3-88bf-334f2dbf43b2@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


在 2026/3/18 21:17, Mark Brown 写道:
> On Wed, Mar 18, 2026 at 04:02:43PM +0800, Pei Xiao wrote:
>
>> Also add a ratelimited warning when the outer limit expires, to aid in
>> debugging hardware stalls.
> That's a bit of a separate change, should really have been a separate
> patch...
ok.
>>  	} while (hisi_spi_busy(hs) && limit--);
>> +
>> +	if (!limit)
>> +		dev_warn_ratelimited(hs->dev, "SPI busy timeout\n");
>>  }
> The limit check is a postdecrement so we read the value, compare it to
> 0, subtract 1 and then break out of the loop - that means that when we
> come out of the loop the value of limit is non-zero again and the
> warning won't trigger.

yes, my fault! I will use   '--limit'.

Thanks for your review and response!

Pei.

