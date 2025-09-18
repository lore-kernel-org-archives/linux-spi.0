Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588C230277A
	for <linux-spi@vger.kernel.org>; Thu, 18 Sep 2025 12:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758196807; cv=none; b=oRX7uBC8KIRpQggmKbgqHxNEcZ5ql4UYUY3qxKt7Nr3Wc2ResLmY+mzawcnB0gmYdvPy2JJTaAYG0Ih23sOrF0jOaAX8zSdLxQ5EGKjZqjD6Sb5EjgkdmcS8hNi/KdlEO51O2zh+Vd8e72GnDE/1Jxhs/Eu43EGgFyAOnc4RfbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758196807; c=relaxed/simple;
	bh=BiCnS6nvRQt9QJIQu21OOgBTBUSKKpEDfAYCnnRz0ZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nEJY/6c4u4GqMi8G0eu5qgiP2Ai66SMh7jPQR6Ng2WZywG31MW3/Bl2pZVVVMJLCdanNHaC9VxyuLjZlbXnfbUm/UZaC7S5VJM2PIzpE4E/egUbjXNRpAfkRRTBa9vU2vvV8KTplYbgJFj+2F2SO/Zpu6HYturbgJkstQPbqPaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=h2u7dmfD; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="h2u7dmfD"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-4242bb22132so7840725ab.3
        for <linux-spi@vger.kernel.org>; Thu, 18 Sep 2025 05:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1758196804; x=1758801604; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=24dAp6S0Mw7uy79hEDvqIYLysQ8ECFwST6qu+5oIS60=;
        b=h2u7dmfDvRl0BTM+JWf+bCfpVib3YGcBFEpDktZycUTpJPkacyqJGDwEvFSkyA2rOv
         8hiaamcrVTh87aoIMm0CK4o5cvaIuYWTP5ybJ4XIH1GA1EAHsuEHWVzVGXnUmuuGzcdN
         LZV2TujwsTVDhiKqbyUW9ytxbt6minzRDdEG+k37CisQJ8vUhHiixbfwOKCDYkEVWjn0
         St5UK5SHhT7j/3VKsg/lLd0ANQWEgTF6opACKxgBLl8XR/2J3bFHrDiG9fzugut012o8
         /nS0u+zVDYEcDKY62bRlymTGVAE0nV/yhRFCiJiISBJIQtr9D5lg/rVvgN9g7F6N8NHO
         uRpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758196804; x=1758801604;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=24dAp6S0Mw7uy79hEDvqIYLysQ8ECFwST6qu+5oIS60=;
        b=qdi3xGKWvNnC6OX4LHaiFoodsWp2V/GgVLyMHKf5Hr9xlzLaMIDcviRKaqndPist6U
         r1mHeEqEu1XuXycJDd4pqd2aulqyg6nlCDKG3lpOjF2NiR/7zCZFmJ3UMCjgjA5+65Sc
         RwCCMOW119S1mltM8FGyibGXpxYLpZQHm3CKLIk7v4N1lyF+45f4+Xx1BiN+2kFMJ6Zc
         EO79ArerRb+x4xEIkKIetqVm9RblSQlXfaFCs/H6m/oXbkVaYZXQP8UvwgnKfq+QkLaC
         zibF2CThWKwFPI7fxVf3u46bPWZXVbY2esy9vOP4dcvs4BNaFscAQoskwgzuJRZC3Voq
         bNUg==
X-Forwarded-Encrypted: i=1; AJvYcCV4jHB5Sh8ox2PC3k5FY/Sa7BQvJb6Jd5XftccvNZBKkctScly8WEeclVn93XZGJ/SXwJgPQwVWRl0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB8+Qb2cM19AJehGlzjyPA6AJ5Q3wlFDBQ0fK+zW/GE219OqE6
	EhitV5VcrnlZIbMv4aMo8NBH1WEwMA+iNzRS2nTjTcBRcb/7iAX0MQwBMuG9HdxL3vA=
X-Gm-Gg: ASbGncsuQ7nFw1ScVbpZYJJjQH/La/wVvXBDH54XCoa7Xgr/I0WABvj+p/vPTQ9c930
	AUC+W4gSUbQpKwgTSXRcC9P4msh5JoItxFiZogkpTpJueVeME1EMRPXGUVbD8AZQgIIAfZSE1h8
	A8GD8hQNKHcvwEJLXvt/zp8vDePGYzudcwEy7rwOWl4VD5C9IwKsVOjFtg3oAELODiLVwr7a0YH
	WZPam9yXikbaVAfqffGALcpxP3KulpsGBeOA1/0hLeiwXsF526t2VGcEB3xmjnsvc9DAYMxNZ9Y
	eEGuqVCQ/9alyuZnAOBJGUGTxW9cUptc7ZdHm6zlxXcoRTAY1FhyB8Bob0UBsmAJ2c+8h1IpfUX
	/SJ6azXjHKSqIWPoisqB1TIisvxK/3rV4bCc1iVfHlh3uVBUezU0Sz66epe1HXlPKuB+g6yL8PQ
	sG92IRdg==
X-Google-Smtp-Source: AGHT+IFijlR8XeEU0nDd9FqF6SZxYszafUFzoDoP3bqBLd4TIHjKMZRHmvYVFqpT9XVP5Gq1Y4eDhw==
X-Received: by 2002:a05:6e02:1707:b0:424:485:1f03 with SMTP id e9e14a558f8ab-4241a4d26ecmr81727265ab.13.1758196804240;
        Thu, 18 Sep 2025 05:00:04 -0700 (PDT)
Received: from [172.22.22.234] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-53d50aa5dc6sm876180173.47.2025.09.18.05.00.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 05:00:03 -0700 (PDT)
Message-ID: <88833bd7-dad5-4613-b29e-2db05d60f3f0@riscstar.com>
Date: Thu, 18 Sep 2025 07:00:02 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: spi: add SpacemiT K1 SPI support
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>,
 Yixun Lan <dlan@gentoo.org>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 alex@ghiti.fr, p.zabel@pengutronix.de, spacemit@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250917220724.288127-1-elder@riscstar.com>
 <20250917220724.288127-2-elder@riscstar.com>
 <20250917231520-GYA1269891@gentoo.org>
 <3b815302-21f2-4ee2-bf83-c1dba77ce3d1@riscstar.com>
 <20250918001632-GYA1270371@gentoo.org>
 <f7e12797-ea17-4e92-bd25-cc562c66d2a7@riscstar.com>
 <D2A109C6A8BDED08+aMu4H4xap2GSP50w@LT-Guozexi>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <D2A109C6A8BDED08+aMu4H4xap2GSP50w@LT-Guozexi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/18/25 2:43 AM, Troy Mitchell wrote:
>>> while looking at the code, it seems you can use alias to map specific id
>>> to the spi controller, it even can do non-linear map, something like
>>> 	spi0 = &spi3;
>> I've never used this before, but yes, it looks like it's exactly
>> what I want.  I'll just get rid of the "spacemit,k1-ssp-id" DT
>> property entirely.  Easy.
>>
>>> plese check of_alias_get_id()
>>>
>>> note, I haven't actually verified on board, just look through the code
> This is the right API that Alex what to use.
> I have verified it in i2c driver.

Yes, thank you for confirming.  I've already made the change
and verified it works as desired.

					-Alex
