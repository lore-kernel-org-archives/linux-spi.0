Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4925C36215F
	for <linux-spi@vger.kernel.org>; Tue,  9 Jun 2026 15:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781018212; cv=none; b=V6Ksff7xVA60L6lEZlSqRWzcAi63qoDMFqxrNUeSwZuIgijOg6c2vjw5iL4kcCZaD+vFcQKCKGBc1he+dL+GH6xTeDOmfjqGXEWs3GwRBvte7p7lM0HlySCcxwrBw5JQ7L7TOWL76swU0To8QZU0KW9WAj3bYvu/fQVK5qi3Sv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781018212; c=relaxed/simple;
	bh=A9tfClX8Q5B176EdrnPRG4VsIQcWv2vxdIc/A1y7sjE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lvd5egTizPcuCH+7o8gygV38tQviaoNGH+cEQlugJhqeX7F0w4PfmrRctIcaMoCc6CRaUDawDH1XKp6hrqxmjL7dChH0sBnloQOXzZR0lcvstv0jZvFGXhrxNMeSBWREzRDGb4hecytWcYVGyEA2C/24sDyktwu2VFRk6k5hBL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QnZRTG8b; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QnZRTG8b"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c858dc05ee3so3494453a12.2
        for <linux-spi@vger.kernel.org>; Tue, 09 Jun 2026 08:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781018210; x=1781623010; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X2OVhVGvDZE7tZDpbh1B90htiaNt432NF1Wdfrujw3Q=;
        b=QnZRTG8bMg93PbDjsDGh0hEcKzU3gIXU3t/gnIz/+qwJ8Nd7M+juyObEXgvVqeV67i
         R4UB82WgGcRnjzF2mb3uRCOZ+u4rv9SJRhyxa8kK1jeRKBiGeRf2TSHiXSJWzHZdbsYQ
         Tlv6efzuzmoCtUMFjXCQUwd+H3lK4wMO33J2sp0tFqCbKhSREH+COKrHJE9KBXnqFfLw
         AkSuP5x/oItJ4vB0EqRttYYB6yWNr2Ab47hYjbhj2C4794QDQqEntNwqZSdAAbJjeC1Q
         3Tmlh/Ao73JZtH+Q7gj6adweMHtqHThw+U+ZQ5djq1kaxs7ur/V7657Efk7V0cc2O0+L
         +ACQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781018210; x=1781623010;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X2OVhVGvDZE7tZDpbh1B90htiaNt432NF1Wdfrujw3Q=;
        b=o53YPExgUPyEXWU3B87TM8tk3DY5KuAXUdd0EhDeF+PB5nlmjySwBgx+Y7byolJHZT
         kQf8ygVd1n8+tkwVbsaw0SIDSC4yn79u7TigL7uth/YMVHQITjJ5j09mSWDebMXjqqTl
         icyeZvdwSePBNlYuD5GVn8Q3lb/9BwUmJQ/f9k8KvUOZKhHUCVL1KMZg8Ah8IA8Lek7Z
         gzQPTeyTCg7hU8iPpH6wgmC1B49vfbVRzHQAe+JP/ganW7ZD2p9MYsChBXY6IRC5Pkel
         orZK11DL74+9eBn79wg7rkU6Nf9Z015qGh72oK/1Ym2OpZuBbKD7M9YNpP60rpKXftbd
         nlzg==
X-Forwarded-Encrypted: i=1; AFNElJ+qBDdYM5VkX7QeWYEQwMZ40DWqMhcJ/WP8iqUmhfKauZJS8Oz5X8obKec4DmzM/hk8e6cXXo9uNRc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU7NaMT9uBLJLauaGed6Ogk0eDc3X1wm3V+5L+poim7Ul0hRsA
	hV/pga/ffJm5fSTmYF00vSlFXL+Tga+BLxKtTKPiaV1aFQWmr6EPgVGF
X-Gm-Gg: Acq92OFFQ9iGCppdtivFOYsTKGgW0ApFctZMZgdfM4hLwzFYGjGJNVy0E4LlH4OGExC
	x6gcqgsZB6tbd0SrvY9uSRZg1AvRenBKOERM84lFT4l7wMLdv+982h7LzzrdbgKexTyswiYA3AJ
	pAKbjKkh9Gy1yUzIt8KssQjtipCD0RQZMBAkOozgxLk6Wj8TCqdqvhclraefr3/eEMhmFnvnbYB
	BOpyp4+nsVcUjBf3r9pybDbF9udJylJtKComnWibsTrLam6fHx1KEX1z0dewp9whmEw4/UNMyqS
	VwvWSgvDZlIMb+ADhscILlMM/+as6UHGcWaadl/YpTSwExfb7fMKm1E/PNL9SUNz4xaxFB4i0fh
	gF+FnNw6hQZ0u91lSoZGrxS8Ns+azkHLtYhfN2UTdNG9mUWjBy9XxibT19AzOI37D1fgz16zWwR
	4kKbM4suZ0Iz++vcaTxMR80MNHN3F2qWGxeMPkpm7M7pG2t4cyRsc0m21rF29sdgcdvIbZh4Izf
	pWnKyacMB/g3Hml+evI5UXIjcR6KGq/KPy7c7iRCDIV7A==
X-Received: by 2002:a05:6300:67c7:b0:3b4:b30e:1b4d with SMTP id adf61e73a8af0-3b4cd04c26cmr28149436637.40.1781018209653;
        Tue, 09 Jun 2026 08:16:49 -0700 (PDT)
Received: from [192.168.0.100] ([103.181.54.100])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df03387asm20355865a12.4.2026.06.09.08.16.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 08:16:48 -0700 (PDT)
Message-ID: <c6cc71bc-7256-46a3-ad4a-a1ec4b38400b@gmail.com>
Date: Tue, 9 Jun 2026 20:46:44 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: dt-bindings: octeon: Convert to DT schema
To: Rob Herring <robh@kernel.org>
Cc: broonie@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, me@brighamcampbell.com,
 linux-kernel-mentees@lists.linux.dev, skhan@linuxfoundation.org
References: <20260607142356.2844008-1-ninadnaik07@gmail.com>
 <20260608143259.GA2569066-robh@kernel.org>
 <20260608150040.GA2675433-robh@kernel.org>
Content-Language: en-US
From: Ninad Naik <ninadnaik07@gmail.com>
In-Reply-To: <20260608150040.GA2675433-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 08/06/26 8:30 pm, Rob Herring wrote:
> On Mon, Jun 08, 2026 at 09:32:59AM -0500, Rob Herring wrote:
>> On Sun, Jun 07, 2026 at 07:53:56PM +0530, Ninad Naik wrote:
>>> Convert octeon-3010 to DT schema
>>>
>>> Signed-off-by: Ninad Naik <ninadnaik07@gmail.com>
>>> ---
>>>   .../bindings/spi/cavium,octeon-3010-spi.yaml  | 67 +++++++++++++++++++
>>>   .../devicetree/bindings/spi/spi-octeon.txt    | 33 ---------
>>>   2 files changed, 67 insertions(+), 33 deletions(-)
>>>   create mode 100644 Documentation/devicetree/bindings/spi/cavium,octeon-3010-spi.yaml
>>>   delete mode 100644 Documentation/devicetree/bindings/spi/spi-octeon.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/spi/cavium,octeon-3010-spi.yaml b/Documentation/devicetree/bindings/spi/cavium,octeon-3010-spi.yaml
>>> new file mode 100644
>>> index 000000000000..3dbbb4f3c104
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/spi/cavium,octeon-3010-spi.yaml
>>> @@ -0,0 +1,67 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/spi/cavium,octeon-3010-spi.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Cavium, Inc. OCTEON SoC SPI master controller
>>> +
>>> +description:
>>> +  The Cavium OCTEON SPI controller is an SPI master controller found in
>>> +  OCTEON SoCs.
>>> +
>>> +maintainers:
>>> +  - Mark Brown <broonie@kernel.org>
>> This should be someone with this h/w. But there doesn't appear to be any
>> OCTEON maintainer. There isn't any .dts using the compatible either.
>> Perhaps this driver and binding can just be removed?
> Maybe not. Seems this is used on newer Octeon platforms like cn7130
> which aren't that old. Some Ubiquiti devices use it and run 5.4 kernel
> with OpenWRT:
>
> https://openwrt.org/toh/ubiquiti/edgerouter_4
>
> Rob
Hi Rob,

In this case, should I keep Mark as the maintainer?

Thanks,
Ninad Naik

