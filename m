Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE55E31A7F6;
	Thu, 19 Mar 2026 03:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773889725; cv=none; b=WvFFVPvOe95duV8+RprVlKLGy/lSvfMVGDliMBtuverLcJH5j0VbydnpvEWE5rsmZXOu62qwyRVAPfPCjEo2gV9Pm6k/urWSNZ5lPd0BxikyZnLkPk9UwN+R6uO9Gz4nGBaWRh58hJJ6f60AdiGJlVOZdqEcMFO7bLx+kZjviqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773889725; c=relaxed/simple;
	bh=o57yyxYN6qIkTDxLr+7UrzVqsZ4jMx1i/tODxgn68qI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CaIzZGw9InxokADe09G0UhtRaBeMn5mfdqV7GyH2FMF5Uplc09rS1UDACFKp+U4FP/P7XLNzjlAx+2IDfClhZqHXPoJQQY5XQUWmQBzAc+u6hWfhrSH20pBbUKd0cu503pmHE81D6JiqE7b/5rMm84yOmbIFtb+WVkmuRYglbso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ede21af0234011f1a21c59e7364eecb8-20260319
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:e682d56c-4d86-4ffe-b2cb-678bbc4f41f9,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:89c9d04,CLOUDID:feb92d4a4bfa68fa18be3aa2a06e1800,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|898,TC:nil,Content:0|15|
	52,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ede21af0234011f1a21c59e7364eecb8-20260319
X-User: xiaopei01@kylinos.cn
Received: from [10.42.12.251] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 161129151; Thu, 19 Mar 2026 11:08:40 +0800
Message-ID: <18e01ff4-5c4a-4888-afdf-6a91a0fb2477@kylinos.cn>
Date: Thu, 19 Mar 2026 11:08:37 +0800
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] spi hisi-kunpeng cleanup and fix
To: shenyang39@huawei.com, broonie@kernel.org, f.fangjian@huawei.com,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1773889292.git.xiaopei01@kylinos.cn>
From: Pei Xiao <xiaopei01@kylinos.cn>
In-Reply-To: <cover.1773889292.git.xiaopei01@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


在 2026/3/19 11:06, Pei Xiao 写道:
> Hi Maintainer,
>   I might have wasted your valuable time again. Please help check the two
> modifications. Thank you!
>
> Pei Xiao (2):
>   spi: hisi-kunpeng: prevent infinite while() loop in
>     hisi_spi_flush_fifo
>   spi: hisi-kunpeng: Add timeout warning in FIFO flush function
>
>  drivers/spi/spi-hisi-kunpeng.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>
sorry for I didn't modify the verision number.
