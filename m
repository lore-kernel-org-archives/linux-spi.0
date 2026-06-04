Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8692F7F0A
	for <linux-spi@vger.kernel.org>; Thu,  4 Jun 2026 09:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780565113; cv=none; b=qJ9fPYh91hRcIiKx1ElvFnTgejWDAtFFEzyW4zZo3IUXAYGrpxA/E7SfC3Z2lw6YZNbpWsRzrBJnsVWefY9F95/s6WSyAIiy7kSbFzhVXmUofv1029sIFX9Dnn1qvAIQq9bDzJNIqE77Ch5ovHzMHIGUnuDkUCX2CIj2khKtZno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780565113; c=relaxed/simple;
	bh=rz20gXhQdVOrTdEhmhCpXq0m1jn6BoI/ZelHshCeHzA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jjgnHYaMmonZgZiJBASaZUMsPGCkmxhLGgLo6x1iarYrbpsZSNd5sGgU1uzzH9Qk00IaDG+37O7MLRSl6HlD0WUavPlch9yaTwNJBTJs1KVRooJqd0K56YEGW+4ElgdI/3niQ6MGxqVpSHnXwhtBci/etTOSSuX5CPk3T0g/HrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nmw+4LnL; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nmw+4LnL"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-36b9ec98144so275732a91.1
        for <linux-spi@vger.kernel.org>; Thu, 04 Jun 2026 02:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780565111; x=1781169911; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rz20gXhQdVOrTdEhmhCpXq0m1jn6BoI/ZelHshCeHzA=;
        b=Nmw+4LnLVpRJV/IdI8giZDLWdDFcOinq0XfLqgygraUWndBHFfgddC/UVbXFelmjHW
         PjYbVmh7cSrtlIBBR+hZuknotPTR1kCt2UJYw/5kyaj9lf55xCBy/o7W3mN0o/WrxvTl
         3n5thIhFRPcJWVoNu1TjEXNZMo+6zNJ0tEcdyn3ZKX7LQSMq8e15qOX/SowNahdDvGxi
         xZbIC9D6dmEIFCiLYxM0nsesZ+fwvnCj6Nyy5Inw1/3k4HDiWTgNxzAOifBNVK4x07Qk
         iK+Wy5xscApkBflsgaFIBMYcBMZv8PC9sxiJFW7rdgApczRQ1EKYEuH3zNh43yKg/3AE
         haEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780565111; x=1781169911;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rz20gXhQdVOrTdEhmhCpXq0m1jn6BoI/ZelHshCeHzA=;
        b=GI34ko245zpjOLL6gARWpM6qAF2gNrSRv/VyI8WpqNhw+U5FUWlBuIKIqYL/DGo2Xk
         44mrWxMUg2kyrGSPJlHeJiAfwonqjTpXCYfCmFhm9JH7BbbLAFSysJLpZScJ3vu2XoA4
         9JX+RLWyYJ+y+3UI3PgtfVZambJpYut8cjyzmqrCG5Na+3jgIWVs/H8AB9s/jjEueGML
         ixFH4jL/o06lLh/m/g1LWyt1qK/lunSSyG3HzdwTsTIqnsOgkLQh/SRl7RxE8TBjUON6
         9Lxds8l5K6eh5B48xWGYx+1hYXWeikPGIFViXMGwcwA8k26rSEK/rmOUfAMZXO5bvnvX
         YOEg==
X-Forwarded-Encrypted: i=1; AFNElJ9eE9Uplt9RLt0UJbzuZSDSkqe7GiRliBpyXk0sq9qIxU3pEVlPnr+eWjIe+oU12ajhp7ac37fajKs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5LwaZDmpTEeMJ4tTEwM2hJ1HBmUVKCTGj7tjCbjxC4wTIOo3L
	yodYc0E2RzrjPtvzAniQ+wHVKhiLPovmuvzdytUltSQz957JmuG/cKYi
X-Gm-Gg: Acq92OFVG0AXmlyq71fulnrDyPsq/fcW48I/Nqg+x54vbnncjl4zBOceSMoP/6PERyz
	su37HPTWmmLcOtbss5Sm7wsnaRo3sSpbtxz/yzd6NlhqVGWsYbcFw6MOOuqiBsnIcI3r77SUv9E
	12Z4bUQaoEEhN2oEGA844ib9Nt8ff5svnIg9FA3evQa2ztyqZQ51YeyrLvkP7jaDffVzVZm1TH/
	VHvMKDs7rPMxgFrePMG/EebnOQEkwVcn9ev1ZRx+WksbpChAUj6SdQ0rA+xG2qC4NG4Hl4lbKYG
	1l5McaN2Ytn9a2LKDscteGE5NO+4g7Sh/b56J8hx1KPkuUXsYeXUcAZP6QsVC4idrTWiuz+yCaU
	o8DVcrnW+pKy9AVSboxr8FnfoYgWXRmzr1mjkSd5KfR1wGxXWK2+qehj0zuaZ60DQk00uN2rrKW
	5oHrHkgoKSGdXGAvZuqb5dU5yk3NC35nozPfWFJeAZC9f0CfNgMQv8W216qH1/Xw49xR1bZFfsu
	S0rXAbztyiVLg==
X-Received: by 2002:a17:90b:53ce:b0:36d:c159:8f11 with SMTP id 98e67ed59e1d1-36e34775d33mr6490845a91.26.1780565111106;
        Thu, 04 Jun 2026 02:25:11 -0700 (PDT)
Received: from [172.19.1.42] (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36e7014f288sm3459212a91.2.2026.06.04.02.25.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 02:25:10 -0700 (PDT)
Message-ID: <b90b4b9e-9e11-40c4-9407-ac9bdc83b0b1@gmail.com>
Date: Thu, 4 Jun 2026 17:25:07 +0800
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: spi: Add for Nuvoton MA35D1 SoC QSPI
 Controller
To: Conor Dooley <conor@kernel.org>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, cwweng@nuvoton.com
References: <20260603043551.1062112-1-cwweng.linux@gmail.com>
 <20260603043551.1062112-2-cwweng.linux@gmail.com>
 <20260603-daybed-absentee-1b64f5caabe0@spud>
 <41914879-5fd0-41dd-b097-2be80096e464@gmail.com>
 <20260604-anthem-jokingly-8d8312ff0c3f@spud>
Content-Language: en-US
From: Chi-Wen Weng <cwweng.linux@gmail.com>
In-Reply-To: <20260604-anthem-jokingly-8d8312ff0c3f@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Conor,

Thanks for the clarification.

I will keep using my personal mail account for sending the patches to
avoid the corporate confidentiality footer, but I will set the commit
author and Signed-off-by to my Nuvoton address in v2.

Best regards,
Chi-Wen

Conor Dooley 於 2026/6/4 下午 04:55 寫道:
> On Thu, Jun 04, 2026 at 03:07:31PM +0800, Chi-Wen Weng wrote:
>> Hi Conor,
>>
>> Thanks for the review.
>>
>>> Missing commit message for one, but why can't your Nuvoton mail be used
>>> here?
>> I apologize for the missing commit message; I will add a proper description
>> in v2.
>>
>> Regarding the email address, my Nuvoton mail adds a corporate
>> confidentiality disclaimer to outgoing
>> external mail, so I use my personal address for sending kernel patches.
> This prevents you sending with your work email account, but you can still
> set your commit author to your Nuvoton address FWIW.
>
>> Conor Dooley 於 2026/6/3 下午 11:24 寫道:
>>> On Wed, Jun 03, 2026 at 12:35:50PM +0800, Chi-Wen Weng wrote:
>>>> Signed-off-by: Chi-Wen Weng <cwweng.linux@gmail.com>
