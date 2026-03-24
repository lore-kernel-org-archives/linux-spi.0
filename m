Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87923E8668;
	Tue, 24 Mar 2026 06:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774334814; cv=none; b=rsPzs2HFOUPy4t7ih36sJxRmI1mHOVSOfulZiWnBUtPPXG528M2ze05DEp6szMSGZ9cuqsNVt50a/uSfQMyefdW50gjHvQX/bfYZe+vkxujq8zp+dGQO6Aiwkef9bgp3ZG31Gyj3aJqTLDpH7ExMIz8iasYKzW2hRsQEj72J2xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774334814; c=relaxed/simple;
	bh=0pWcvd/aW2rfxKceBG4iYf0JYDeJLmiozIsWTIsl6/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZN0X0/CVgqHs+Z7XQYJwmqvlbJBqjBxswj9i6hJZ0Rv5iUJJCvmKCXwuNW6CbZzAZuAKxYhjwdMOgFPXorhGmg5UOyHQxHn0waNzjaye4V/wN6Y9nG+gjSwEVeH4dp+CejBDcCqMO314tgrcebZjSI7dKMu9i8vUsGe5x4aoQoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 35703176274d11f1a21c59e7364eecb8-20260324
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:502c63d9-27e6-4aac-9b67-3149ec8525f8,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:89c9d04,CLOUDID:31cd9a5d2e26af3804cbf8aa4ad155a9,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|898,TC:nil,Content:0|15|
	52,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 35703176274d11f1a21c59e7364eecb8-20260324
X-User: xiaopei01@kylinos.cn
Received: from [10.42.12.251] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1741746068; Tue, 24 Mar 2026 14:46:38 +0800
Message-ID: <1267145f-5843-4976-a777-5c251cd55fa2@kylinos.cn>
Date: Tue, 24 Mar 2026 14:46:36 +0800
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/17] spi: axiado: Simplify clock management with
 devm_clk_get_enabled()
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1773885292.git.xiaopei01@kylinos.cn>
 <52f7e0ebd2f0ece71929384444e1ae87506e5e2d.1773885292.git.xiaopei01@kylinos.cn>
 <8f92f6e7-93aa-48ab-a183-fe8167dcc517@sirena.org.uk>
From: Pei Xiao <xiaopei01@kylinos.cn>
In-Reply-To: <8f92f6e7-93aa-48ab-a183-fe8167dcc517@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


在 2026/3/24 03:38, Mark Brown 写道:
> On Thu, Mar 19, 2026 at 10:03:57AM +0800, Pei Xiao wrote:
>> Replace devm_clk_get() followed by clk_prepare_enable() with
>> devm_clk_get_enabled() for both the "pclk" and "ref" clocks. This
>> reduces boilerplate code and error handling, as the managed API
>> automatically disables the clocks when the device is removed or if
>> probe fails.
> This driver is doing runtime management of the clocks via runtime
> suspend/resume so this isn't appropriate.
Got it, thank you for your review and valuable time.
Pei.


