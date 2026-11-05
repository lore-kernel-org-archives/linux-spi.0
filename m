Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793896986;
	b=sYw4r/ixXpldsnpzDjfV4iexenDhOt+RYRldY3hWXb36ZyCTIG3Pqy/RPGIgLOxnYR98
	 5ngMbciCTYzfkob/F672sm+mt/KvedRZ+QsVvce1d6HRS9gBflMB1qqgGi01Ch0IBZR0+
	 AyPKJfVkRtTj1SriNHwEFRLVxt1FtzpdOaO7w0RbozuFid1t/wK8H9rgd4PHm9gZl3rCZ
	 0GiCYbK7xJ4zcdHkxPQlmFa2iIoptazkMv7NJAgjuHWMPXo0Krcj6IJN6nD/A6gRNksXC
	 NK4H6GMo9ZoWPybUc6P+/8bxqwr6RYkx58WWElWJizVibE9J3urBStjLaDciNG0z+Dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793896986;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:From:To:Cc:References:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=AJSPojTMD5FaksEtjWz2d1lbfmwj8ss6ZBjJxa7pTR0=;
	b=Fz1noOqwSqGJiDAKUtGt46KDZFRBgUW7c4K78vSzl521yBEEkJwLvc8rwx5amZq+jP1o
	 KqYZQa7mdEb746KbGP56sayUvGT2/vFGSYdMZyAGeGJOXsRg3rltF0s1B7uVw/GoKQ4RS
	 QGu4/PEELjiNq5Nq4veGgV/sBw8kHirU/7S0IOAAtGS6ohelSFxxHy3HcfuFOwryeyv11
	 Owbcp+lKMtP0Qq9aK1T/ELKk5TZ/rv0QE4C0gjV0zU0s+g104jDy5LWyxt5aILe2fGYO7
	 jXrQKnktpPvHy6QaZcUcTWR0Ne33poi4hN+mfyaOFesU+nmepDHcACvca0HYQVdHV/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="iVwQ/kky";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87361606A92B;
	Thu,  5 Nov 2026 16:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iVwQ/kky
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A89881F000C1;
	Thu,  5 Nov 2026 16:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793896986;
	bh=AJSPojTMD5FaksEtjWz2d1lbfmwj8ss6ZBjJxa7pTR0=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=iVwQ/kky9CNa8BZ8Pw8ciGpeOuW10hzVJ7jglN6j1zXY7nILyR8A7WNHOxZuhtOky
	 vLYasOdsnjV7UnVmqg03D5ZsQq59dT9POEDCacPahnzz/xwwiEEv8OnfjAyIIFoJf5
	 n2/mnxvWjeFJHzxVsAK1mh6Q+dO41ZDapyPgUHt0mXSwJ2JL4x4p2a1rOsxMoJkffk
	 1KrKsiHWHqYYMwRCUaCwaIPQHLKc47WJlWFPgoauAucEvZ+sgHJ8mJ91OaFnBGapzX
	 eKdnZfpNxQGydVoSDgmVO+jlqNUvhuIwuEUuuwig5DP8AFSeA1D8ueAlLuXAaSCZt5
	 wsakPJ7AGQNKQ==
Message-ID: <f8c6da62-057f-4795-b88e-273986ef79df@kernel.org>
Date: Thu, 5 Nov 2026 17:42:57 +0100
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 01/19] spi: dt-bindings: add
 spi-max-post-config-frequency-hz property
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Santhosh Kumar K <s-k6@ti.com>, broonie@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, miquel.raynal@bootlin.com,
 richard@nod.at, vigneshr@ti.com, pratyush@kernel.org, mwalle@kernel.org,
 takahiro.kuwano@infineon.com
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
 praneeth@ti.com, sebin.francis@ti.com, u-kumar1@ti.com,
 srikanth.boyapally@amd.com, m-shah@ti.com,
 Conor Dooley <conor.dooley@microchip.com>
References: <20261105105832.2134313-1-s-k6@ti.com>
 <20261105105832.2134313-2-s-k6@ti.com>
 <303eec47-bd2b-4ce2-b28f-aedbda21f91a@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <303eec47-bd2b-4ce2-b28f-aedbda21f91a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/11/2026 17:41, Krzysztof Kozlowski wrote:
> On 05/11/2026 11:58, Santhosh Kumar K wrote:
>> Add spi-max-post-config-frequency-hz, a generic property for SPI
>> peripherals that operate at two distinct clock rates: a conservative
>> rate always reachable without controller configuration, and a higher
>> rate achievable only after controller-side configuration.
>>
>> When both properties are present, spi-max-frequency gives the
>> conservative pre-configuration rate and spi-max-post-config-frequency-hz
>> gives the higher post-configuration target.
>>
>> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>> Tested-by: Srikanth Boyapally <srikanth.boyapally@amd.com>
>> Tested-by: Moteen Shah <m-shah@ti.com>
> 
> Drop tags, this did not happen. Please do not add blindly tags which are

^ tested-by tags, I meant. Acked was correct.

> obviously not applicable.
> 
> Best regards,
> Krzysztof


Best regards,
Krzysztof
