Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F60A32D0FC
	for <linux-spi@vger.kernel.org>; Thu, 24 Sep 2026 01:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790213211; cv=none; b=fMzD5u+vf8VBrhma+rQpQq1Q0cZBWBxphY+xJUzLjzI6Acj/zkgKsmMMKxZGYPnBiu+NwfYH/ay962JJuc7FFGpQ5u+lw/bWFGYC/gW40QnuXXPSyGggW8nDRrgL7O1X14qvIwut/8abJ/54aFoAEVzsrF6WG2/YOJD9RlJwYVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790213211; c=relaxed/simple;
	bh=QQkaqMHt2bDKYjzTWhhvmF2NKEcpIXUnzBmhkTRoYUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ELSY2gqsjrJYM05dVrVuAc8JrbDSWHIGugVSb+edfZfXVJc5Up1aq3Ae8tRwuqrMhbIUmeXVl8JDyKyXzjpZQF+ipafHjo8MfEp8yBu3bHKJEujr9+1mmZuigx7l5QAq4ME8+TyQBTNArIpF94ahM4sje5xH0Q8FjWmwTf8ARP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gs7TV7jC; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gs7TV7jC"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccda24afso888519a91.3
        for <linux-spi@vger.kernel.org>; Wed, 23 Sep 2026 18:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790213209; x=1790818009; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ce1YuMyYgEbSKo/+e5CLoiv54uIucnRXju66KzgmBcQ=;
        b=gs7TV7jCdXQgYnSsibU1F1/vHINpBCLR3+sKMajId0KNd/qbmRKa8Rk3MiuqhbEqb9
         FD4f/4NZ3qkAREqrJKGn4+Z6OUiWGDLMMHAoAsGyAIdk2ACov7V3eWVBKf0mNYgAq/+X
         fN5G0eQdADLTlhQw1yBa6EBsGYm16LFGsi6vo16Of4YguslEigxHN9Z2lqVOIY8b/MpJ
         fDkgG+5XTRfSq69QFsYRzzVNssr6ScxpISMx0jGQaR5YRhp087TvR5uwJ8KlQ6FmA3xF
         +ipMr+XI4Zy2q4kygx7Jhof1DuGRxyzkgGfpqUCFpfxY3hR7Kdcj+iU9vYzSv0tsRipo
         znHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790213209; x=1790818009;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ce1YuMyYgEbSKo/+e5CLoiv54uIucnRXju66KzgmBcQ=;
        b=wJb8JigcLnDGCx/nMDiz8aT1S4Actnpco9h4lytRYvFFzkhJF8L3QgmXQM/NpdAgPm
         afSBO0xDxHRyJjjfYAw9SCgbuocgd1R7rVMsLEUi6mQC+V2bR3Kea52GGACJt4oc9YsJ
         nQMZ5T+UuZkqez8lEABhsd1RSZOgUawDksQ9SvfxIflDPERpmGq2KIq+doMzDBlCMajG
         k3Fg5dwDD5jCQrwfDgUS9c6otgkgmFxd6kDRovD/17Eka9YkTrMqnpDXa2WyZuP2NzL3
         XIXTEp2/xrNSeLc2UyqF0sxg3chKz96RHdWiKho9zTQGVS1FRML+z3hFpXccnq8oeRiR
         O2Cg==
X-Forwarded-Encrypted: i=1; AKwUvByqHypDKWbdfZhvsVdEyll07afXFfds/MF8LDDhBU+jRSUZPPmCT+6MMZYrQnk3/HnmuPhlINgIipI=@vger.kernel.org
X-Gm-Message-State: AFuF++mARLZ3OsNv3UFZkuwTZlQE9T/P0G4iaD34fVzN+7my04YemvoT
	snj7DAgFz2TXGcpUMmORJz9keZba3+GLwM/3CQgIIqSoQzIhUHI3MPW2
X-Gm-Gg: AYBFou2exe4dau6tvgXsOAIkSeZwQFw3mTinHhH3LexqbSTfC+8ywhy4JGh4VUm1r0R
	lNauiNiCl7fNGsnDXwYeUOfW9mdpqmQ/cFyxwuLPAvLa04LlFS/rJespquM6K3Xhm4uNXFetM1v
	iIHGDvdAxJK/KKfK0ZGgEOyAxC6Z4UUo6RHUqyanFfLE0X0d6dTP64Gwz1/nnzkeSJV357slQWT
	bQItX5uEkYFISD+7jMMw3MwftfWuv1LlfKgnNypPZ47avrRcCKFy2SR1ueG3elqjELhWEujIycF
	aVxcBfr+BaErjtUXMxteIoSM/3yXIv30JhGgGiDNizXB4tfsWSVW4iJ+9nT84O3HheubvXf14ua
	QV3rU46uHvb8n6qA5iTk3xjvjS6nzHZZAdc2gXMw+PZG4+IirQIqV3yC90l/+p11X5UMwnGt1R4
	qUo/GxTY5iuSCBft0c6lPLWYqlUVUWzfOaCgqrWH+xDO7IqHRC8pUsOX15dkY1jQqrdKcgSqYeR
	yNjCyc8X9arN0+OES6SYxG7IKRZA92A1nLmR7giAX9c9TPqunHqC5ZsUwHT
X-Received: by 2002:a17:90b:28c5:b0:39e:6a81:c923 with SMTP id 98e67ed59e1d1-3a098729524mr645400a91.22.1790213209231;
        Wed, 23 Sep 2026 18:26:49 -0700 (PDT)
Received: from [172.19.1.42] (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0972f2cc3sm1698246a91.6.2026.09.23.18.26.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 18:26:48 -0700 (PDT)
Message-ID: <cee8c7b8-88d8-42d9-b425-31adb499ad40@gmail.com>
Date: Thu, 24 Sep 2026 09:26:47 +0800
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: spi: nuvoton,ma35d1-spi: Add Nuvoton
 MA35D1 SPI controller
To: Mark Brown <broonie@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, cwweng@nuvoton.com
References: <20260923041926.425551-1-cwweng.linux@gmail.com>
 <20260923041926.425551-2-cwweng.linux@gmail.com>
 <arO_P5imHln19iV-@sirena.co.uk>
Content-Language: en-US
From: Chi-Wen Weng <cwweng.linux@gmail.com>
In-Reply-To: <arO_P5imHln19iV-@sirena.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Mark Brown 於 2026/9/23 下午 07:59 寫道:
> On Wed, Sep 23, 2026 at 12:19:25PM +0800, Chi-Wen Weng wrote:
>> From: Chi-Wen Weng <cwweng@nuvoton.com>
>>
>> Add a Devicetree binding for the SPI controller found in the
>> Nuvoton MA35D1 SoC.
> 
> Please submit patches using subject lines reflecting the style for the
> subsystem, this makes it easier for people to identify relevant patches.
> Look at what existing commits in the area you're changing are doing and
> make sure your subject lines visually resemble what they're doing.
> There's no need to resubmit to fix this alone.

Hi Mark,

Thanks for the review.

I will update the binding patch subject in the next revision to follow
the SPI subsystem convention, for example:

   spi: dt-bindings: nuvoton,ma35d1-spi: Add Nuvoton MA35D1 SPI controller

I won't resend the series for this change alone.

Thanks,
Chi-Wen


