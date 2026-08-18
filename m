Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9819A3D79FD
	for <linux-spi@vger.kernel.org>; Tue, 18 Aug 2026 13:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787060153; cv=none; b=TKEJDf40UzEewtsO3ZrFLqvakIXIZMcdgT1d/vdN5QRtohLR0xg2AxUwS96yXsdvo85Xt2BPfXj7Ciyfd3AGKooxq6isfTRs/Y11jaeQ6iKzIeo+byThlgc7h0US7v3mKDAtaUnEAlhPWrPhENiO3Ch9GmvobfZVGtv0EgmEocc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787060153; c=relaxed/simple;
	bh=b9+9VK7ZgIkaTBn1ix/JRiNUIDJtESnszUpwVXTZZEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qr59uAkmEJ1Gy+4JJxv395sh9q0vZQS7VQGL4KkAs4dKCffeiS+kEF61zbg26/4epXZAu8IXBTQIbFotLlfgbh9N2RuZefxO4fzmkpiN8FruFp/iVk+t5XvEVF06YPkcMJmgk2kNj2AAYRWxyCgUMXUTguBxK5bi+l6jtYLjM6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=frSXRH7/; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="frSXRH7/"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-836c8bdac50so60515687b3.0
        for <linux-spi@vger.kernel.org>; Tue, 18 Aug 2026 06:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1787060149; x=1787664949; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V7f38/EmNRZHytT0gisWN0N6kF/rwrajhGatAT+LppU=;
        b=frSXRH7/tAviGKvGhGwVXUduUNJ7OhblbJE1sb8ku/12hZ7FRqw44ZMjuvpYxf+1NB
         nlLT9pge2gQDykiv6bQFfXwaVwiAnGapPFI+hssmEUmTuCYH1qFezjAu9cw8tM/xy5LX
         ZS1HHA53JQGB+/Z8rQ30L+azI8EvHU5LAsAmwTQB6wt+eD9iN2bp+XYYOG5KIag6067C
         IaatdvvETPjhOxLcnULWtxIoxrOvDQOM0WpVfAnFe5F2RpxzEb0NMNAhZY6OSFxvhmNe
         TWZSaNK6l9zj7dX1QRJwcBcqLIMf3AH2mj88xKkRX8XTkkQ3aNg3MZ6MQEuRRH8Pgrdc
         Dgxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787060149; x=1787664949;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V7f38/EmNRZHytT0gisWN0N6kF/rwrajhGatAT+LppU=;
        b=KlbUN88n7gzi87+xW4dASby/WMXwrNKHKDciwaJ/C3EuFTmwq31mKvgGTFsn5kZ09p
         0SDAyjJP3dPNvqQJ8bLTnaI1M2nXacVwAOzhrAQzOxSmCB9S9nmGsUBExepFVYH5PGrC
         FLBs1aiqyIO4nupCHzG6zXIUMLyQOqYmzzLqB7oKhkiSUu7ZWzuReg/18NAtkwVxELWp
         SU4U+rIwpftmnIRiz5jmKIL15SV4Eb6Lb8AC9Up5xEIkr7ophoH29yWjbEUbl/NBaFTM
         8qeEoqCYKQL1tV2kbNwSNyYcXBoW0uFTm7McYSkt6K5KXL9EDg9QxuECY8NNilWWGpJT
         +aGA==
X-Forwarded-Encrypted: i=1; AHgh+Rr8kLaWAqWDCoAqXr85uOSlzK44gVSj118ocZM2/bP1YT+zNp2glVDtDV9Id30/TATAl9plMRE3xCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyvsakTnU/aljJnLH53kGRS/Is7EnxuLjoHqzhKoeuoc6Xs7Ry
	Bt8yCKCgRKLMQYLaXQhzMibS8h6iCrM1UTlEwEKYzCTak1LxGQlq9hv9C2Tr+NeUzpo=
X-Gm-Gg: AR+sD13YQH3s2dDDP7vrqnDIZBdj08pv09eZDQY86PpWk9EarXujmvFO48liEldCVvU
	TNk0Ywl0W+6B3qqoe9pGzt+uzyTmo0kqRWHcpernnuN2TiBprQo8ofCvEhbGLL5OiBbwZqd6t4w
	4BVrcXk3kMvAV7W9pdDS22kIlpd1O+h5N/n5ayGgrdxggcj2yo8/vu/qlY0YkXYyyw49jgCKEY7
	3d09+1U4uvoP04L9UrdZpw9Rq0H6fDWVzXi5Wf75X6tQ4Sz+4DjUodkpsnLCwcZibS4rQOMN9lQ
	RzgA8teWRtjC0wuGw+IZ95stc6pS4dayQpFX+J5uff7LHFfhqkeuV+9BLbUG2mUrHWPltaGL252
	PIHjDKyIXsGz2T4Dr+kZUO6iVbbKbPxgLOBa/w4EPWLRhW7b/SRVm93HB7JUQL3YHP1YyrR9pp7
	dpXJIOUye+29Bl6cXLny8M8oDoQZluFF0qeyxYYXwdP2cohRfyNCzIhTrPdVTIk6J+Zm3GlOHcS
	HNReHYjMo3ttyZsnKcHrjuzjrwkzQ/oUvHHhyk=
X-Received: by 2002:a05:690c:d8a:b0:81e:c736:acce with SMTP id 00721157ae682-84133581f6bmr33869367b3.32.1787060149507;
        Tue, 18 Aug 2026 06:35:49 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:1cf0:fc72:ac61:29db? ([2600:8803:e7e4:500:1cf0:fc72:ac61:29db])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-84068d1a5a1sm21389947b3.14.2026.08.18.06.35.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 06:35:48 -0700 (PDT)
Message-ID: <c546d6a2-9f4f-4d2d-85b0-2510730b9c78@baylibre.com>
Date: Tue, 18 Aug 2026 08:35:47 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] dt-bindings: iio: adc: ad7768-1: Document
 multidevice support
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Jonathan Santos <Jonathan.Santos@analog.com>, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: nuno.sa@analog.com, michael.hennerich@analog.com, broonie@kernel.org,
 jonath4nns@gmail.com, marcelo.schmitt1@gmail.com, andriy.shevchenko@intel.com
References: <cover.1786973376.git.Jonathan.Santos@analog.com>
 <d19a27738ac13307191dd09cd4a3ac5df7f7ba32.1786973376.git.Jonathan.Santos@analog.com>
 <ed671312-71e0-4ffc-b86c-140f51360f6a@kernel.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <ed671312-71e0-4ffc-b86c-140f51360f6a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/18/26 1:46 AM, Krzysztof Kozlowski wrote:
> On 18/08/2026 01:32, Jonathan Santos wrote:
>> The AD7768-1 family supports aggregating up to four devices on a single
>> SPI controller, with each device occupying a dedicated CS line and a
>> single data lane.
>>
>> Extend the `reg` property to accept up to 4 entries (one per device).
>>
>> Add `spi-rx-bus-width` property to declare the per-device lane count.
>> Since each lane is bound to one CS, the number of entries must match
>> `reg`. Make it required when `reg` has more than one entry.
>>
>> Add an example for a four ADAQ7768-1 aggregation, with shared DRDY and
>> SYNC_IN pin.
>>
>> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
>> ---
>> Changes in v3:
>> * New patch.
> 
> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC. It might happen, that command when run on an older
> kernel, gives you outdated entries. Therefore please be sure you base
> your patches on recent Linux kernel.
> 
> Tools like b4 or scripts/get_maintainer.pl provide you proper list of
> people, so fix your workflow. Tools might also fail if you work on some
> ancient tree (don't, instead use mainline) or work on fork of kernel
> (don't, instead use mainline). Just use b4 and everything should be
> fine, although remember about `b4 prep --auto-to-cc` if you added new
> patches to the patchset.
> 
> You missed at least devicetree list (maybe more), so this won't be

Also missed IIO.

> tested by automated tooling. Performing review on untested code might be
> a waste of time.
> 
> Please kindly resend and include all necessary To/Cc entries.
> 
> Best regards,
> Krzysztof

