Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02195344DB9;
	Mon, 23 Feb 2026 07:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771833065; cv=none; b=dsP2AzRqBc7enaqtuYvYlWneQmcA8ZiGUKC/UjMhmlgDugkKHLDUWzZ7R2msw+MoCSkbn2uVxJOSleUpLwYR2XH2iDPth1SLLh5ZkDiA/3h7hWYwGkgCq0NfmNfSDKf7QyEk3N7jJ+llrnJto8HuZedpCzcG/g1y9yTue9SeC6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771833065; c=relaxed/simple;
	bh=CcdYO0H2lr4AapjaIxb4SfgGL0sUk5hmMECYHWlJuIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tqm7ARHXorQzk3PtD3VQzTjjrKHoa1BvHs+nFOM9/36c4zxPbG476k+EHwcJxRguOdIU9HOYCWPk8rlmzlckcQWVJbqnwtp4TFWR9BRqzLt6JxhJ6jEhU0sIIMHK8AhFAyy5ltfViyiOF0AidaczNK/4wyUiUcLpoYtWzHHIfiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: aa94e1c8108b11f1a21c59e7364eecb8-20260223
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:848b1c9c-ea7d-49a3-96d3-a03448cf6821,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:89c9d04,CLOUDID:76a0bba549b0cd434416357582941d2e,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|898,TC:nil,Content:0|15|
	52,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: aa94e1c8108b11f1a21c59e7364eecb8-20260223
X-User: xiaopei01@kylinos.cn
Received: from [10.42.12.251] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1102517997; Mon, 23 Feb 2026 15:45:47 +0800
Message-ID: <0eb57f44-2adf-4f15-9fac-ffc4f22374b1@kylinos.cn>
Date: Mon, 23 Feb 2026 15:45:22 +0800
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: atcspi200: validate data buswidth to fix FIELD_PREP
 build error
To: CL Wang <cl634@andestech.com>, xiaopeitux@foxmail.com
Cc: broonie@kernel.org, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <tencent_E59C90CD95B9DE440871635139437A79410A@qq.com>
 <aZv1cB0ATB66E5hO@swlinux02>
From: Pei Xiao <xiaopei01@kylinos.cn>
In-Reply-To: <aZv1cB0ATB66E5hO@swlinux02>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


在 2026/2/23 14:36, CL Wang 写道:
> Hi Pei,
>
> Thanks for the patch to address the GCC compiler warning.
>
> While I understand that the SPI framework theoretically guarantees
> op->data.buswidth won't produce an out-of-bounds value here, I have
> some concerns regarding the proposed error handling.
>
> Using a direct return; inside atcspi_set_trans_ctl() creates a silent failure.
> Since the function returns void, the callers (atcspi_prepare_trans and
> atcspi_exec_mem_op) remain completely unaware of the error. They will blindly
> proceed with the transfer, leaving the hardware in an unconfigured or unknown
> state. Additionally, using a forced bitwise truncation could also lead to
> uncontrollable hardware behavior.
>
> A safer approach would be to either modify the function signatures to propagate
> the error (e.g., returning -EINVAL), or at least fall back to a safe default
> (like forcing width_code = 0 for standard 1-bit mode) along with
> a WARN_ON_ONCE().
>
> Since this requires a bit more structural adjustment in the driver, would you
> mind if I take this over and submit a proper fix? I will make sure to add a
> Suggested-by tag to acknowledge your effort in bringing this up.

please go ahead with the modifications, thank you!

Pei .

Thanks!

> Thanks again for catching this!
>
> Best regards,
> CL
