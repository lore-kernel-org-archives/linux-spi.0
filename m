Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C12A345CAF
	for <linux-spi@vger.kernel.org>; Fri, 20 Mar 2026 09:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773997877; cv=none; b=RKdD98ddLYdAK5TZ163TTUExqIOAfGO5m1d+OHNGJmorK2UUAeMPsIpT5Y02SiONBdulw8LzK4AVQqYeYmS/ygAmmmsLi9M8sQelN6p9BfuGBu9RBEX9+Yc5lOUVEOGiOoIfBxZpqko2Ddy+Dl4WdwoBdQwXsI1tcVuiuNlvmCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773997877; c=relaxed/simple;
	bh=osPuVGUm/UzZnnch36LBSX5ZBydiJ3syEDW7/rP0ehg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U2jJLqlx340teMNgkdYpK2lIPHEU/KLiQ4Bjlh3cq8SkzdaWc+5MhTC5Xdi+5OwvAAUUSTIRF9EL8TtVXHoTYu/ETEOOlCA9kCiPjZdzy6dOXuQb2u9KKhYozaj4cUPbE7/klXdxutxY3zT9wOgbRaeDSrUI61BMF+9stw6Ymz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=E10iuiHj; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="E10iuiHj"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48558d6ef83so3362485e9.3
        for <linux-spi@vger.kernel.org>; Fri, 20 Mar 2026 02:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1773997870; x=1774602670; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lnvpWrvuYkXuiKq1OQLuzrMxSlnrYn7ohrRGMt5HMQU=;
        b=E10iuiHjIszaS2WGaFn7yUugVwA2m8d+5Ic7sUjvPMClbXlGxOb5+03kYWeCY4DLIJ
         wAnQY/Di5k6ghnD9rzz3LNUz0L1CAgzzvi/T9XeIKvKabO5+jj/EFVcHM/43k4nsVHu8
         llxcjCC8K5XarROMaaT33EGRCRTmFvpGew95d971JOdI3aGGmrhG0zrMf/tzFTtvlRxR
         oeexdmTCS6W+PtY99Ab8i80vpd82rzJlHKZvAiJmsq82H05lnGSFSR0EA3rizJE9E+lv
         SKzmMLmY+v0cYR4aAfVd03IspAzfYyruSQe+lYjwYfwzSH/JHmFpA1JlO2BZkrplbuSB
         eZWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773997870; x=1774602670;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lnvpWrvuYkXuiKq1OQLuzrMxSlnrYn7ohrRGMt5HMQU=;
        b=S4CT6cx4Uc8lqGQlzGBO4kjRGYeQq16WJYI5A1pOCOXgeAHOQaGU6e2wtjD3UcX5RP
         LTwQXXs0gtSAlRm857io+hvi9aCQiIrDuBT4Lo++cUoi+I3JRCwdlOY63xPg5i2x7hBt
         A/P3IkQeN1j9cWKs/41SYBiU8PzkFThASvqu06bGM/l80tWWWKYXt4RubIY/UE5BdaJ5
         t83pS84VsmUyF613J22yxyn+Jo/66KCWQjeZ6h/n0yr3dsHLUhn5E9sRLDQ0GxNzMXFN
         zIDH3gk6a/GnrQh1Bekk5GfGuBw5cblpgaNOH3JrjodY//mBE1YYnStQ6Q6L55nAQYUL
         gsDA==
X-Forwarded-Encrypted: i=1; AJvYcCWI2kf6y2gR0wKxeBco7i8q5CSHyijZhd8WlrJHF7S/yXT+E4OphwC65b376RB4z/Jnnei8PlDckUU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZCS4/Q1YyjVu12PyNtk92aHliTqW5b1cdhgstiLx1P/+spo0J
	Ta7xAQT30H92jg2Mb6bhMHEB8xtaQ89H9c85XIjf4MJNdTQC8YrCwB1vsaisqR9b3H8=
X-Gm-Gg: ATEYQzzY2mOwxPFt/VG+cUzWPeDOTq95wlE0fZpME+DkWZNxw14M49WjDP4nza/woB1
	ey7LFKEodNr/MV+WvMQxzviQXTcHO/W3/eBh3JvwBJhe23JuF9TnWRyVQcW5nodViXwvEa1xiX7
	6szcIy5LPsdPS4IymibYkWZ8QHAx61l+V2RxvWoO5JvbsPSxLNKGk2/Bf+/1R3pRnt2COgz8jiE
	SoJmdwf0n1nDOCDSPFxjhJh+Ol4vhfsb/hSqAo9Z6Et9afX7HUQD3vIyEcMpJRPecIwpYhHIEsX
	rIBpJ9w1X7BDqHwdlOZRLHNivy9jk3TjL8Rp1iHVEBu5D/2Sef82fut8bgHt1elGuKO0xCzWhUd
	p/MsOKeOfyZd7DeVMGwWpsIfPk+qSuBJ1BYUXbwuq8o6oN4hBIEumxBmY2gxIxlwveBeftV5tBK
	8olep8gT/V6U+btsnzIpmpVGf+j7nJK0E=
X-Received: by 2002:a05:600c:1f86:b0:483:1403:c47f with SMTP id 5b1f17b1804b1-486febbc653mr33123025e9.6.1773997870011;
        Fri, 20 Mar 2026 02:11:10 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.216])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486ff118bb4sm18208155e9.2.2026.03.20.02.11.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2026 02:11:09 -0700 (PDT)
Message-ID: <1f684500-6c06-4abd-984a-4cf889acfcc2@tuxon.dev>
Date: Fri, 20 Mar 2026 11:11:07 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/6] Add support for Microchip LAN969x
To: Robert Marko <robert.marko@sartura.hr>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, olivia@selenic.com,
 herbert@gondor.apana.org.au, radu_nicolae.pirea@upb.ro,
 richard.genoud@bootlin.com, gregkh@linuxfoundation.org,
 jirislaby@kernel.org, horatiu.vultur@microchip.com,
 Ryan.Wanner@microchip.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-serial@vger.kernel.org, daniel.machon@microchip.com
Cc: luka.perkov@sartura.hr
References: <20260302112153.464422-1-robert.marko@sartura.hr>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260302112153.464422-1-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/2/26 13:20, Robert Marko wrote:
> Robert Marko (6):
>    arm64: dts: microchip: add LAN969x clock header file
>    arm64: dts: microchip: add LAN969x support
>    dt-bindings: arm: AT91: document EV23X71A board
>    arm64: dts: microchip: add EV23X71A board

Applied to microchip-dt64, thanks!
