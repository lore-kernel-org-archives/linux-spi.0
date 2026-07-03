Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9A73B71A3
	for <linux-spi@vger.kernel.org>; Fri,  3 Jul 2026 10:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783072905; cv=none; b=YQrLHab4X2g6W/suIVE0zpBC7Nf1eY+zL4Bz1Z9TkPFJmP3709zmZ3btYnwkZPoR5AITiHjVHbTxIQlMoA0raS8Lmvifv6/upq4uWz+KUH4NZq+O+rdzwMnLjt/IfBGSbjrLpd1P0GCqHw5oQ3lmnrm+kLVKzm8K+5snAWSLpiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783072905; c=relaxed/simple;
	bh=RYeeLX2JG8dp87oYPPrNDLM4wRbMmmAVowH6Gs/X6vw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dd+WZULQ0etCyG8i3Dii3fzM4IdsCNQvwQtylEHUWnmTEtz/57Y6RB2C28AktTP62pM8AJz7bS3P+5IXkJcUq9nOFICOk/JxYsyaerWAfwVXxlstsauHeO2IwaZc3wotepG161eW5i1v76YiwtnOS6+ddeYhWNUKs+Cvd4gO950=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A7V9YHX/; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7V9YHX/"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-698e5859a3cso766422a12.0
        for <linux-spi@vger.kernel.org>; Fri, 03 Jul 2026 03:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783072899; x=1783677699; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iphKavMyEGyoKkZ7flBVPKctJFRcurdGeTwbxLH/hOs=;
        b=A7V9YHX/6P5OlAht23tj0RMGPFoSinD9l1uXNrDG4TPTQp7WTHxT8tXxV+iZlehnoa
         lPLc48BQEtflxSDW3TSmiC2M3IoGKKqoI8Wr1qollpaU81PrGqSz+Qr7AMC06BMOK+BL
         R1rYxp0yzuGoHOnWQjQrMqJ+0MBwn/aMKS8iGmuVDhdxtDTVLz5JrH+QXfJmvwnudQAo
         yLcriQBv8FQy7WbBR8+K7UH/35OSk3PAqDSdcBZ8qKgg1wumB/gX20RXu6xb9thFeZzM
         d0RIaLgusB8tjNciytWwZmzyX8va4aT4orP2S7LqxVeTpWHBURkm4S5y6WrCopp1c308
         GhZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783072899; x=1783677699;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iphKavMyEGyoKkZ7flBVPKctJFRcurdGeTwbxLH/hOs=;
        b=LHEwAQlSF9jbIXar5ORlheDB5TOiyKbpgVsDdNxowjbawMwG34vQ8aA1KagxS8xiqp
         CdUDoiIi2b0JC8yAC3KPBSVFJnXP1w2i2JVitwJQ89tc3D/eiKLMqD5g6SOjOB3wlAcU
         aZ38MGjK54lTiaO+l0SNikKPffchiP89b1CD3ZFksmrDcj333AgU0c3/G40uC1/6CrUH
         hUUUSO7stJLQ8QhHSddAkqABFUs596LGbkh3Q/vdSdZIzeo2LZFV+2eU975Ehb8VIun4
         WplvurLMReKLlc/4U3FWk+MtwN+AcDqH7D0EN/0/Ag9PfKo7cSyjRyGf+YqLIHE1xYUw
         IDYQ==
X-Forwarded-Encrypted: i=1; AHgh+RoSCOEyezX8k+2DRNDpiHHNclrztOm1R+orrQSgCUs5x4zPByCeLdbY2+KcssF0vwoSrqFywdg9Ito=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBBMpVHcNE9PRnYkZQYC8/kNsYZfPWSH/91SvNuDDsbOKiScEW
	2P9CSTRK579xGhaAtYsC4DjvxR7IiQVbx12grHWGT4fo7DDX+gPhxFqm
X-Gm-Gg: AfdE7cni1csYwgkeOFa6gV/jDJHHJXOm7WHyJPE3LAaG1BULRRaoGzFz9UJV3H1uLrQ
	nbzooyF+OTcpCXXC1cpJzqvKcZRdaF7JYyksaAz6oyhN5KXT94BPLNqqDJEuncQzIW4Da+j37mi
	XNJ7NLCXLepfiWGCrVU3KRfVWNxxdmwfxkN+aF6GlHCNzCzLFRZ0Bc1OOv9CQp8Yw4zR1+Ouvy4
	E70ZXalkBPZzPOGAwTfiMFUvlJS7U70qmEgue3LlYT6y4ocU4ag1jtMXZpPe4zAYYvHYRztPe87
	avHtki6rNsSEnXiIvc5ur05IMPAjaWviDI0of5E1n9tmGntWNHFr4at3nxsySaxTSyIR7WW35Bg
	mSL9UCrRjypMhW9wGut7F7DgSj1yCvpy7pXHWiC0WOyvV+0r30V8TpjseomRlYbAikbVT49Putd
	IBH71PY7eyFIUFmsReCcSue/rkrvF867OuQiMX8P2ELOGNXTBSvFG7kQ==
X-Received: by 2002:aa7:c68e:0:b0:698:ff3:85ea with SMTP id 4fb4d7f45d1cf-698c104c5f8mr1030271a12.5.1783072898947;
        Fri, 03 Jul 2026 03:01:38 -0700 (PDT)
Received: from ?IPV6:2a00:1e:db84:b301:ed61:1b51:c39f:49c? ([2a00:1e:db84:b301:ed61:1b51:c39f:49c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-698ad118f43sm2162762a12.25.2026.07.03.03.01.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2026 03:01:37 -0700 (PDT)
Message-ID: <3e094744-8603-443e-8027-8fc2f2817879@gmail.com>
Date: Fri, 3 Jul 2026 12:01:35 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] dt-bindings: iio: dac: Add AD5529R
To: Jonathan Cameron <jic23@kernel.org>,
 Janani Sunil <janani.sunil@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-spi@vger.kernel.org
References: <20260701-ad5529r-driver-v5-0-ed087900e642@analog.com>
 <20260701-ad5529r-driver-v5-2-ed087900e642@analog.com>
 <20260701194103.45541cbe@jic23-huawei>
Content-Language: en-US
From: Janani Sunil <jan.sun97@gmail.com>
In-Reply-To: <20260701194103.45541cbe@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 7/1/26 20:41, Jonathan Cameron wrote:
> On Wed, 1 Jul 2026 08:40:40 +0200
> Janani Sunil <janani.sunil@analog.com> wrote:
>
>
>> +      adi,output-range-microvolt:
>> +        description: |
>> +          Output voltage range for this channel as [min, max] in microvolts.
>> +          If not specified, defaults to 0V to 5V range.
> No way to specify the default as part of the binding rather than a comment?
> I haven't checked but does
>         default: [0 5000000]
> not work?

Tried that approach. But the dt binding check does not accept default for this DT cell-array property.

