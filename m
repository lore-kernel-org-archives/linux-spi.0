Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F321E3D8909
	for <linux-spi@vger.kernel.org>; Thu,  6 Aug 2026 07:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786001397; cv=none; b=jF+HR3nAycQB7taRUQjXSQ5E82il1h0kOkke6srPppVNZoqRIqyDO0Jonq0A4/xIOzkbSG6U9QwoNQDqwS4OcF5CVls7IwPLqh6og+e2QfBSjNVPbJ048ZlhD10nHeO5L0H+GPFTd1eEk7w3Q1CEXhddnW/H9OdDhkh9aurO024=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786001397; c=relaxed/simple;
	bh=7dEfZ/MO7PfWW2b/sX7zrZr06DdtfX/8meGgTZKq7/o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HgNhjV7SVHB0XXtPlXimws3IZcwOBOJo2HMKwemkj5QJKycojqkxYjyd9Bx2zJPNJG9SUjlZQxp3O8lsimqbQEiF33LDVf/q4FSI46K1spuqzX2LFPHDjiPXY9bkAJ+zZq4Y3dV9obLXVhj7ry1OK98IPXAby5kI8hCc/EkUM3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=YEjbvOkf; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="YEjbvOkf"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49554ebb87dso16344155e9.3
        for <linux-spi@vger.kernel.org>; Thu, 06 Aug 2026 00:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1786001392; x=1786606192; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WpTrq3KT7PoBd2S/V9sh/mcnOd8WakjPdDWB72Qu55g=;
        b=YEjbvOkfFlDE9imkFug9UsYlkxTiLmFiOey1stQrLHIxF5q9MjBPSeOUlEMqCH5VlF
         lU7u6eHm/LZ31qsWOJSqju0OLvnLL4SWfc6rJ2Gh5eFAo+ZrTd40oRMdGporK13+Gxuf
         tK47hRxFUVNTWQ/pl3xa33AZq3MyKT8TK0H/5ARhbqJupxMQIIVazOChV9xyPqNguAc3
         qPFKfyo4rLHCbQXDb11/gaGGUfe39EFuUQUFXfJeSAa2Anr4ZU6qqp3Ypn2QyIpzrcs8
         abNZQBGZX6uIsamsubjq6+6fBut7zY6CjcWim5sc6M3gCJR4n/uapOrqLg/kzxEn2awn
         Km9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786001392; x=1786606192;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WpTrq3KT7PoBd2S/V9sh/mcnOd8WakjPdDWB72Qu55g=;
        b=qYKxZUX6M1lOW7btb+9cPa4TJQcRn9nPbQlnCBIr5prv8/Yq1pQq67/quxANvEOtEY
         cW+/dkOXwiViZ0IcTjYmdSbmSTRSe0URz/s97GX6PcnRHppAzlCBod/I7Dt1GcygU/ZZ
         LsS9xqHMGzA0dUX3QtjlWZRYNwvlzqouk9EzvTdGV1uooFUjhT8Ca9qHgM3xtjKcOA0y
         ruPCcGQOznG6MqDao2mkZ+Rnfv9iyKyMNn5Pgujx5WPUEftFX0hHcrsosN0pyO2ai/hV
         t5094GVvjSWMBtEdrUN0zHDuf3p4fgJimCxU7s4dURW5tk7Pn7wGFw1mqnbf0CEW/838
         hH8g==
X-Forwarded-Encrypted: i=1; AHgh+Ro+cO3wduhOce4IotynkUoJxOYlV71CShXitCGsoLq1x7ZH4GP1tOvplIsGzLd4zVSfbsD5F7Ia8hA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4YJWtZ2dq00YGTvALApcSIY+OziUs6vQgPtwtoZdkMz3fWYH6
	xuuAjy9G7coU6VMxwJdIVW8webdakPuWncqRaSELZ7FHR5iItfYVCJJyGiYaO9sFqbg=
X-Gm-Gg: AR+sD12nTPofmz0n+ojM/J6kAziDQ8xAkUkAKGXvkGa3u+XsDmSfPPBOfR1IjPQPMnv
	ifK6E6wLDyfboRgE3rXprnnUkN8U8eQ98kMbijLLMALtKCnygi1UW3lvXv/KQVktlLRzDHc/+MN
	oj9odXicZ1qhJ97KNGHFsVZRiCV/aAjp87xrEupX3MmdNrNObraYQLVi6PCUpbVZlxeRot/e5VX
	YbsV0lFE/mzIly7K1swgCvkT8XcHIm5YdM/fa5IRuyxN6A1iwxCoA7dKsoxJ8KEbyFrQmjAIIup
	WwQQF2AvYBjJ4X+Mjtp56D1AOlEitXZb9vQJCS48dN9ZaD9HjZvFqcHksunMNijcuo6B11BDL0I
	SP0FCXhNOzDOcw7NNMh6Uek3kAl6MpWS9KqnILtwrITC/YPUi7gDWkN6DGUPyoUCfoFwxG5KP8U
	2RJoIRbR7sy9qiljHWAeqB4EiJqoGV0ralYZ+zqGB69cXRCE+HO+vS8//ODsY=
X-Received: by 2002:a05:600d:6446:10b0:495:641a:bd3f with SMTP id 5b1f17b1804b1-4994e7c5d9amr144919805e9.13.1786001392307;
        Thu, 06 Aug 2026 00:29:52 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:fc32:5991:4f4b:f361])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-499542135cesm41789625e9.4.2026.08.06.00.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 00:29:51 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Mark Brown <broonie@kernel.org>,  Rob Herring <robh@kernel.org>,
  Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor Dooley
 <conor+dt@kernel.org>,  Chen-Yu Tsai <wens@kernel.org>,  Jernej Skrabec
 <jernej.skrabec@gmail.com>,  Samuel Holland <samuel@sholland.org>,  Maxime
 Ripard <mripard@kernel.org>,  linux-spi@vger.kernel.org,
  devicetree@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
  linux-sunxi@lists.linux.dev,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: dt-bindings: sun6i: Add compatibles for A733's SPI
 controllers
In-Reply-To: <20260805210739.6da82d16@ryzen.lan> (Andre Przywara's message of
	"Wed, 5 Aug 2026 21:08:27 +0200")
References: <20260805-allwinner-a733-spi-support-v1-1-7bfd1141ebc9@baylibre.com>
	<20260805210739.6da82d16@ryzen.lan>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Thu, 06 Aug 2026 09:29:50 +0200
Message-ID: <1jpkzvln9t.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On mer. 05 ao=C3=BBt 2026 at 21:08, Andre Przywara <andre.przywara@arm.com>=
 wrote:

> On Wed, 05 Aug 2026 15:53:26 +0200
> Jerome Brunet <jbrunet@baylibre.com> wrote:
>
>> The A733 has six SPI controllers with the same IP as the A523.
>> Like the A523, one of them (spi1) also supports DBI mode.
>>=20
>> Add SoC specific compatible strings, falling back to the A523 ones.
>
> Has this been tested? Can someone confirm? We should avoid adding
> bindings prematurely, not that it bites us again as it did for the H616
> DE bindings, for instance.

Yes it was. There is SPI-NOR on the cubie A7A. I did a quick sanity
check on it to verify it was functional (writing and reading back).
I should probably have added an note about that.

I have been submit a few changes like one lately. I'm doing that so we
can get on with DT as soon as possible, without waiting on the bindings.

I would normally submit the corresponding DT change at the same time
but DT is currently blocked by the main CCU and pinctrl.

>
> Cheers,
> Andre
>
>
>>=20
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> ---
>>  Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml | 7 =
+++++++
>>  1 file changed, 7 insertions(+)
>>=20
>> diff --git a/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-s=
pi.yaml b/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
>> index 6af4ff233158..be47c6e00409 100644
>> --- a/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
>> +++ b/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
>> @@ -36,6 +36,13 @@ properties:
>>        - items:
>>            - const: allwinner,sun55i-a523-spi-dbi
>>            - const: allwinner,sun55i-a523-spi
>> +      - items:
>> +          - const: allwinner,sun60i-a733-spi
>> +          - const: allwinner,sun55i-a523-spi
>> +      - items:
>> +          - const: allwinner,sun60i-a733-spi-dbi
>> +          - const: allwinner,sun55i-a523-spi-dbi
>> +          - const: allwinner,sun55i-a523-spi
>>=20=20
>>    reg:
>>      maxItems: 1
>>=20
>> ---
>> base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
>> change-id: 20260805-allwinner-a733-spi-support-e30a9ac057a3
>>=20
>> Best regards,
>> --=20=20
>> Jerome
>>=20
>>=20

--=20
Jerome
