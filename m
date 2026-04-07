Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C5B392C2A
	for <linux-spi@vger.kernel.org>; Tue,  7 Apr 2026 07:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775546795; cv=none; b=saq5JmucvZfSuqBgCyyp65pC0oIiI9LOqiNo1+k/qxPiR23QXZzVNlWct9bbZSGZxt6CUGATdjAi24pmTSp6CFfa4nDscAXV8pg5cZguTNQGezwSmvIIAhJepQwI4YySwmxgeOC9x2GLyQBdC+8drtHbtW6QGXn+19ZbJf9xaJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775546795; c=relaxed/simple;
	bh=MXtuXubv+uE7L5iOol/TNJwkm5e+LKLTwPmtzRxIYso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uYugUTfXof1e3U5yF+c05CG2bTzwdJ4yM25V6C5fJUz2XKwsjyAQ5Pv+HQVPZx0CFK+HiO3HWnQiQfJR1YKjGmY9byzt08M7Rc2opn+xXgBM1aFGHo70zhQ9vWEGDgbAA1EWhctyYlGytPLnOBSoWlcZd5TFS1YI9xe03+wKJTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 15288c4a325311f1aa26b74ffac11d73-20260407
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:53894c7f-3703-429d-8003-cd38803bdc3f,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:d08578642a4a2fcd9191a12797752f6e,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|898,TC:nil,Content:0|15|
	52,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 15288c4a325311f1aa26b74ffac11d73-20260407
X-User: xiaopei01@kylinos.cn
Received: from [10.42.12.251] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1313178304; Tue, 07 Apr 2026 15:26:24 +0800
Message-ID: <3cf2a965-27f4-40e2-99ad-0b386fbc8831@kylinos.cn>
Date: Tue, 7 Apr 2026 15:26:22 +0800
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] spi: mtk-snfi: unregister ECC engine on probe failure
 and remove() callback
To: Mark Brown <broonie@kernel.org>
Cc: gch981213@gmail.com, linux-spi@vger.kernel.org,
 linux-mediatek@lists.infradead.org
References: <cover.1775273351.git.xiaopei01@kylinos.cn>
 <09ac1024a0f1626efaa47ceefc5cfb8ee5dd9418.1775273351.git.xiaopei01@kylinos.cn>
 <d4871bdf-15bf-4491-be5c-5b38a065d810@sirena.org.uk>
From: Pei Xiao <xiaopei01@kylinos.cn>
In-Reply-To: <d4871bdf-15bf-4491-be5c-5b38a065d810@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2026/4/6 20:53, Mark Brown 写道:
> On Sat, Apr 04, 2026 at 11:44:58AM +0800, Pei Xiao wrote:
> 
>> +	ret = devm_add_action_or_reset(&pdev->dev, mtk_unregister_ecc_engine,
>> +				       &ms->ecc_eng);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, ret, "failed to add ECC unregister action\n");
>> +		goto release_ecc;
>> +	}
> 
> This should either be dev_err(), in which case ret is not a format
> string and this is buggy (I'm surprised it compiles without warnings...)
> or it should be dev_err_probe() in which case the arguments are correct.
ok, thanks a lot, from a person make bug.
I will send v2.

Pei.
> The latter is a little better, though it's unlikely to make a practical
> difference here.

