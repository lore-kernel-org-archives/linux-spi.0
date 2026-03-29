Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F3B175A77
	for <linux-spi@vger.kernel.org>; Sun, 29 Mar 2026 15:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774798770; cv=none; b=m23law71ftutu7zcvg76VKDbRH0p6EHu2BiURXUPLNl463aWKDt9SRI2NkGangnztx7nIj4YdgoOT4Ab8jqZiPVSwoxFTaUHlzcOsslzjN7Q9GI4JdDoieAhmtGboX2fYyCQG6x/t3g+u4w2vsUtxmjJGyM2utNDL7x3nLs6bo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774798770; c=relaxed/simple;
	bh=f9bkPCnJFcQvISuOfBSlCQeraHO1cZrdldqjBgV+GK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K9WFp/sdIpaRJwRF+v8F53VV8hbSi78DoAiWlMZVbOEF1vj0LEM9Mofh+qGHjWRaFMFgJ/N5PtxR/GT+JyPV3yT2nFPzmMHMxabLY0iGyC6Ot3oJiBHDb09PQVDLHZzI/xGH7m7oI8xDk53HQCJGvU1iRI2CGsQz5ppeXrTnKmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mind.be; spf=pass smtp.mailfrom=essensium.com; dkim=pass (2048-bit key) header.d=mind.be header.i=@mind.be header.b=iIihNvWK; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mind.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=essensium.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mind.be header.i=@mind.be header.b="iIihNvWK"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-486fd5360d4so48743775e9.1
        for <linux-spi@vger.kernel.org>; Sun, 29 Mar 2026 08:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mind.be; s=google; t=1774798767; x=1775403567; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ggrAygJOKHK/5r5umOLbpC4E8qoXEWKCBm/VmuvUDWo=;
        b=iIihNvWKvxtgAO/8fCZ6bJGTdSDdHzqhXAltCWP7PRbO9hvEjvkHSLBitSlxV4baZZ
         swMcpL0r/68t8d1VXw6ICXgO0ljul5aE/MkC52mBYDezv1sXKdn2LC8pg8ZUhM7r5rMy
         wmshrb3D4cTjtm0FYBIkgrYUYgo2jQK9jkpcmqkTMc/v5rOmZwpEP1Ro6N7CINqJogjW
         NK2TPAI6Pv6FPVincg9i+5mE9W/kRoKoma9g5XqJJZIqgabrqZ4jcplbX8UJz6pJLPLg
         Xb8U14z8RXvPppV72lo2vmXTQzODlKAfQGowDdMpRJS0DliEIBKnhoUm00lLOZmHGa12
         /G1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774798767; x=1775403567;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ggrAygJOKHK/5r5umOLbpC4E8qoXEWKCBm/VmuvUDWo=;
        b=FA77sWJjyYokwDkdkkcyIfMLCAA7ZVpAjrUqrxht0va51maVIJBUSBYMBKzWQIcUqh
         B8bqTcoLJ2UMNK+a2DQYAIeOdgPTfXIOeMpFH9Yws/+9MYhMkQ6wtl1NTVytMkwhIFv4
         MuLjJ2dYHV/w8WWD8Jhed4uZ4Qo8PJolUrKDqDv1nKWP+c41tAwsEZbjtN1uii/kzwf7
         CUhUM5lCDUaTJxA26qJyYxzNrwpsllN3G5Zu8pF//q63nSySriVpteRy10+jvTvZvBqk
         ApV2/OWgFUloxZzrzMPtM5bIg4vRYWNu/A2bedZMDZfVBmTx88n284LjR5JNEBCK/cqL
         LboA==
X-Forwarded-Encrypted: i=1; AJvYcCUWRwPjEdj5lj79Jc/x6ZkQEOIknnEb/Ida+zqWDxBzmdBpnhIy1pyqDdNn+QdZm9BRs1zM5mftff8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTAzr7MbL07eRsGFnIv24EDAkYjF895DFk3IK+Xo+a7oh6VJjW
	mdzXaxAOIo6Bkn4MDsuITL/liPZQ5eoENw5lcvYcMOyYeV1z+py/+QQtMV4c7UU8CFA=
X-Gm-Gg: ATEYQzwdn+evoDfXXTha34jta0Rd23WLBoQ/ZdY9dyiadlxuuTMZobXEKhZBtW+jRb1
	3bIXUu1kOKC96D3rgsJ9k+V3ZhpdS5JnaN2ym7mGKyC+z7TuQBW/wjOqQRwstwXefGg+TSxHMhS
	X0BK/zUggkjRFiaVU6YGCKSAv2BwWXfJNXpn84LjdZAr83AWYXzn6d+dkxFc0VNoHM/fZ7E/CnU
	F8paaTYEaDYJLoBk/iul3xy7YBZU03ZMQeIVk1ZBUMXHI+0pJwZwDL39qhAcDE4PK9cPEmUHmJ8
	Y95Ti6/mSg4uYrCQ6hz3hdWfVN8DInbB4zzHpE8GsvByNufLpWEDaDnRMoQ1m6nSysvKhr074wr
	mpajhbdlbG2vh/gbgMpfeMfD5P44amLxfIgmU05igRg2HMWRgdRJ+MoQFSwwUHvPrVfFSqUdi5Q
	4WKE06/Wm2472OGyjD1J8rEmm2oF7CDXVeUmfzE4rFjHYz6xTSr2DTijDHpA4hlxozFWaHrshdy
	0xS8/P/dQ==
X-Received: by 2002:a05:600c:1d02:b0:485:4eaf:eb53 with SMTP id 5b1f17b1804b1-48727ec77b5mr172082365e9.19.1774798767119;
        Sun, 29 Mar 2026 08:39:27 -0700 (PDT)
Received: from ?IPV6:2a02:578:85c6:1101:1ab9:445:1169:11e3? ([2a02:578:85c6:1101:1ab9:445:1169:11e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf21e3602sm12681746f8f.4.2026.03.29.08.39.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Mar 2026 08:39:26 -0700 (PDT)
Message-ID: <3a9dc8f9-0588-44ee-97ba-3a248d4f65dd@mind.be>
Date: Sun, 29 Mar 2026 17:39:25 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2 v2] spi: add SPI_MOSI_IDLE_LOW support from device
 tree
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: broonie@kernel.org, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260329125725.2984756-1-charles-antoine.couret@mind.be>
 <ack2dPiLpO0uE2VE@debian-BULLSEYE-live-builder-AMD64>
Content-Language: fr-FR, en-US
From: Couret Charles-Antoine <charles-antoine.couret@mind.be>
In-Reply-To: <ack2dPiLpO0uE2VE@debian-BULLSEYE-live-builder-AMD64>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 29/03/26 à 16:25, Marcelo Schmitt a écrit :
> Hello Charles-Antoine,
>
> On 03/29, charles-antoine.couret@mind.be wrote:
>> From: Charles-Antoine Couret <charles-antoine.couret@mind.be>
>>
>> This flag was introduced but was not added as device tree property which is
>> limiting the possibility to use this flag on real devices.
> I'm not seeing why a device tree property is needed for SPI idle modes. For
> idling high, the configuration is requested through spi_setup(). It should
> work in similar way for idling low. See spi-summary.rst. If believe a dt
> property is needed despite the spi_setup() interface, can you elaborate on why?

Hi Marcelo,

You're right that for a compliant SPI device, this devicetree option is 
not really relevant and this must be in the driver itself. However, I 
think the purpose of this mode is itself not designed for compliant SPI 
devices.

It's not unusual to use Linux SPI subsystem for devices which are not 
fully compliant with SPI in embedded context and where both options 
(idle low or idle high) can make sense based on hardware design around 
the device or the feature that you want. So having this property in 
device tree is documenting the hardware then giving more flexibility.

For example we used that to communicate with TI DAC161P997 device, where 
"IDLE low" setting can be used to detect when the device is really 
powered or not. But this is an optional setting, this option does not 
affect the rest of the driver.

I can understand this is a corner case and you don't want to support it 
at all, I thought this can be interesting to provide it anyway. If you 
want to reject it, I understand.


Thank you for the feedback and have a nice day.

Regards,


