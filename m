Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1471E308F26
	for <linux-spi@vger.kernel.org>; Thu, 18 Sep 2025 12:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758196809; cv=none; b=IxjdLOpyo6zJti83JCZNTOvarPQZsIFWHPPvtjremrOvGsDg16wCF+U0wb0pnsDiObOeYo7Pnefu81YaHacc1ngApDjOkXimX1arSX9X0wCaxpZbj08okzqGgg5vbJ86fkeDorzmsY0UDTvI4YEsift5dmp1LWLUcJhgjCCc9Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758196809; c=relaxed/simple;
	bh=GMflzAzfPG6U1zOzWU4RjcrfYSa7kAlw9sH+pBQ+zkw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ArBE8raHlah3mexwi+JqtClOkOoYnHQtIVE4RXV/XkP8xv3cK7jxWDBde1gI+Jjvc0qV/bSv9zgZRzM6ZF0c1kjNpyuFiCNy4VDfoldWEPiWtbLtNFFrkLUE220LYtDzrSFlfrn+kRVvPnjrG4EQISyGiDPmIh+TX7Ql2+vFZkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=DZlA+nmC; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="DZlA+nmC"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-42403719ae6so3623805ab.2
        for <linux-spi@vger.kernel.org>; Thu, 18 Sep 2025 05:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1758196807; x=1758801607; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8qhRL1lPN/JJ3TtUo+Jx4GT/xOTZw7lSfANOvM3eSdY=;
        b=DZlA+nmCEsENHO/oNsYbjJqHppU0+0B+m5RCdBEyo0NDdhQsKB2TUAZPQm/+HunVte
         rHLWziKqFhasj9wf9CnBR2Yn2x2CC7SfN/WHV892btMwIzmybsbeBwcuG+SnzeR4eeUO
         0h5r7EOzGfZMc7XOMsI8ggoNjMhb51evlyVqSFwBHuLd46x5rb5WunKYa3uWn4H5QZka
         eoPjYs8ie9Vi2u9e5qMZ2eYJb46TlfgdMazZqSqL5GMcpcnZivyEM4EVp7ziQ/5FVCa/
         Q0aa9hrGathVPJUC/3FK9w+sdlk/EbPmFWjfzvWafMS7SXqDLD44DllCrhK0y49c6i6a
         dKaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758196807; x=1758801607;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8qhRL1lPN/JJ3TtUo+Jx4GT/xOTZw7lSfANOvM3eSdY=;
        b=lvPfT/ydVkVb/RLgT054PWnsIENzxr8543ZKXkXQty3ZnCzipydCEgpCEp/SI0hpE4
         XnZy1SdrzBJ95IKrL4BVvffuxPzOnIpKgseKdAMUVuSa+FX+dD6h2EDLIxpunQG2khaE
         8AjYrmlMb6us1GCx2KriWDHIYuNMbxalUPnHnK2yCCS+nJk8YrioRWCpxxGx937EXNVe
         r4yJVIJeePsivfuLW/O3GJvzZtcQpo2nlzp7VpIrhKScqbDSJXOERe9Jy4n1g7VRttlq
         RqbdJc+8GyeuewjckGK6QTgL39q04e/0K0bYPd5J96peQhCOkuiXjhVvJzS+SJeFP/Ys
         74Vg==
X-Gm-Message-State: AOJu0YxAW5jmrFh2pHEFAtWCEEel44WMptJDbJFL5MuTBLuIgAYOaBEw
	nSb9fyHSY2AX5N/KMAAD8fQW+q2vQIfQ1r1Ify/BhGMdYYMBk5DYn3oF/XAvob3zN2E=
X-Gm-Gg: ASbGncssXtm9Bf++15IDIgmhvS/R4PoiAsSU9gxcMEUwPITiSCX2jVVJvoma7A4A02n
	KfQ4atPZ+pELuJm3X/mopIZxjL6mNr9aszq+rvZzimmE+inn7rD4QzLhDZT3X4zX7Bd4NuSqxqG
	QfeJR07BESISfBHUShygRzzVEVyPI0G3gASGi+a1nkThlviWK01vnDWHVSAbXf0hK1c5+SQ5i98
	qB15GNNKf7dYEvY3hRbw2HeHIHx4pKOpPguGryRVmGyDKBgVc+glYvs809Yt40T2u3Z14NNN3Dv
	YqAl5dMA2I3GWMrVHmxWWJALiNdUFVKDPHmivcTjuCTgovCfHQK36q5d8+bVHVqAb6JyeSNND5i
	BcfeEoq0rWcjflLfMtMOGwiLLkX7NrXXaCUg5uQjabqSLS5VDGX75yDWksbPp0DDcbI6OQwYZIW
	0cmR4/6Q==
X-Google-Smtp-Source: AGHT+IFQAoOoSgU3pp/rBPSgXlJVaHY1FXv4zqmRznbRq1wJRwagCo1+JA2yZnbtsBf93bWGJ+FcbA==
X-Received: by 2002:a92:c265:0:b0:424:bec:49f5 with SMTP id e9e14a558f8ab-4241a52891amr66059875ab.15.1758196807090;
        Thu, 18 Sep 2025 05:00:07 -0700 (PDT)
Received: from [172.22.22.234] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-53d50aa5dc6sm876180173.47.2025.09.18.05.00.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 05:00:06 -0700 (PDT)
Message-ID: <95d9b310-7edc-47b1-ba9c-81390e9a8532@riscstar.com>
Date: Thu, 18 Sep 2025 07:00:05 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] spi: spacemit: introduce SpacemiT K1 SPI controller
 driver
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>, broonie@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, dlan@gentoo.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 alex@ghiti.fr, p.zabel@pengutronix.de, spacemit@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250917220724.288127-1-elder@riscstar.com>
 <20250917220724.288127-3-elder@riscstar.com>
 <4C1E339412373423+aMu5I4jmngaN0rOy@LT-Guozexi>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <4C1E339412373423+aMu5I4jmngaN0rOy@LT-Guozexi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/18/25 2:47 AM, Troy Mitchell wrote:
> On Wed, Sep 17, 2025 at 05:07:22PM -0500, Alex Elder wrote:
>> This patch introduces the driver for the SPI controller found in the
>> SpacemiT K1 SoC.  Currently the driver supports master mode only.
>> The SPI hardware implements RX and TX FIFOs, 32 entries each, and
>> supports both PIO and DMA mode transfers.
>>
>> Signed-off-by: Alex Elder <elder@riscstar.com>
>> ---
>>   drivers/spi/Kconfig           |   8 +
>>   drivers/spi/Makefile          |   1 +
>>   drivers/spi/spi-spacemit-k1.c | 985 ++++++++++++++++++++++++++++++++++
>>   3 files changed, 994 insertions(+)
>>   create mode 100644 drivers/spi/spi-spacemit-k1.c
>>
>> +static void k1_spi_remove(struct platform_device *pdev)
>> +{
>> +	struct k1_spi_driver_data *drv_data = platform_get_drvdata(pdev);
>> +
>> +	k1_spi_register_reset(drv_data, false);
>> +}
>> +
>> +static struct platform_driver k1_spi_driver = {
>> +	.driver = {
>> +		.name	= "k1x-spi",

Oh wow I missed that one!  Yes it will be "k1-spi".

Thanks.

					-Alex

> k1x? iis it from vendor driver? please keep k1-spi
> 
>                  - Troy
> 
>> +		.of_match_table = k1_spi_dt_ids,
>> +	},
>> +	.probe = k1_spi_probe,
>> +	.remove = k1_spi_remove,
>> +};
>> +
>> +module_platform_driver(k1_spi_driver);
>> +
>> +MODULE_DESCRIPTION("SpacemiT K1 SPI controller driver");
>> +MODULE_LICENSE("GPL");
>> -- 
>> 2.48.1
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv

