Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615EB34FF46
	for <linux-spi@vger.kernel.org>; Sat, 28 Feb 2026 19:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772305976; cv=none; b=aiHHLDW/1lUUZapJlER3Jg6ZYqnCvBmp5E/xWttfsX5aYbssaJ221GgJepZrirIQjXlOxq9S7PVo8CXR98pUeSerVO/5gkgb10Frn33bf7UzzQhsZDSft7nJuC62xHG+lJfDxwh80F6CjlgOpuX/oyHd9XrjLOSjz1TmypzT1hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772305976; c=relaxed/simple;
	bh=7vHUIFMe6aqv8rNlp8GpXSth7AdqP3Jvt63LGxY7hZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dt5L2/lBMYfbyPKhBilfPmgv0QVaVWxxK6ahOBnic1vU509q9+R5M2yHEP/BHnuurBpE6OSn32AsH+NVyVixViQge4PDW4ujG0VcZ2Zzt8xMdwvZf/AezeNM1gIlHtSFZwCEbATQAtousBIfWn9/lMufz6KzVQxvAw/LqHfmxDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tvilz9KY; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tvilz9KY"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4836f363ad2so36382555e9.1
        for <linux-spi@vger.kernel.org>; Sat, 28 Feb 2026 11:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772305974; x=1772910774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7vHUIFMe6aqv8rNlp8GpXSth7AdqP3Jvt63LGxY7hZA=;
        b=Tvilz9KYpvIy98x5mEsAFMwEkE94In17AmiHNfuoN0P014uktifJ+s77I6HiYf9oMB
         5l70JVOSZGX6Nz+r0sch0oMqkZY7OJqJTgfyatepXJutWF0RIelrgtqp8FODr3aJ5RVL
         Vam4gmZUbP6npkbu+C+w+doUytlTM/yCh0N160LrlDlI0Zdnv56WB0pQOEmuvDguBEj+
         T36SJOovQYZyKFxlZGv6CCq2wPCLLTN9vpHPeyw2PewxtufG+PWRh+M8O7Iae7hjxERl
         83n0Gdi8/XkE9djOXh7G74Yu6xYw85OFpXzkG9XgnSEYwx2oKRTm/HeZx3o3V+5lr6PU
         9LSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772305974; x=1772910774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7vHUIFMe6aqv8rNlp8GpXSth7AdqP3Jvt63LGxY7hZA=;
        b=mRCyXd0B/6mlLIvQi9yGCMxGdABT2MDpIf1NawxqLDozWb9GyVbJNnETK3vX6ES3Jl
         ZYkb4THyMUPQ4F67b7jVLa3eCCLaigcuZmKfwWJ8cOe/UZpg0fPDsXlLEVb1vCAPz1hy
         Bsj2AG9sOPHZO3vXcfAo5B/j6pHGWnsVmQJ+vBJHZvhqgmw20L58X6mtfobO8M+LbW2r
         krtj6uUlZPbUdqVMOI8O3lSOiqD5Ogg6xlLccOD+yVtcYJZoN/NJKRDzC06X5LLmMUs1
         69iYF1y0PzX5mSoqreip/L++qYzShHc2u0v5qyIzH41bhCy/oZKDQZzPmJ3Ha2/6z0AD
         HAJg==
X-Forwarded-Encrypted: i=1; AJvYcCWQfjl5rpM4gucQEqweGNQwn68uPliOearnfdmTZeWG2LCAuOnXKJQNz+PaVaPFXkbYR+OBXRCbTOU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhmV8onHPHj7XCOkaKnRgQVtOfYaTLAXOHxSUDJLD+wZefJyVJ
	QXKkoTKGrZeKZNbikffdtumqerhW5BFj23M/nEwLe8JYWMAgAWww0wjt83JK+A==
X-Gm-Gg: ATEYQzyv8Spc4BU7E+yI2udA2kOc6UvvPhMl6c8pVwLgkOTq/aop3Om6YCDRObYtEXW
	cuQQpz3oZo4H4Ba/Z87nM8bNrme+WruaPTqCKa8ra/IdMQlSdWXu6uUlX455mcq2/Lttkz+XPK+
	C2BnQo9197pvHaW/Nor9UgqFCKzSaCUZoD3dBWGntstXR9scWds1gM1jMpVH+R7hjxth/m7l0xO
	bHZ/SQQagFQiz+TNQn5xpiHOnx16rq5R3Wk8Fb17PB+M0rNCruU/fFG3L+zhfgbJMefwIGXqZV2
	er1A/hmFq7x6yzEjBVSEe/w9O6BWDkjoZyua4ga918+7xTeF5nIMlHEVvEEORWHvOsVugIKEBlP
	xY5ac1opXew88MgQT26vjNWU7nnsJ92T3fa0XrfDhJsPFL/x7OFqXqTtTJ/bk7ambVU1hVe0Dro
	q6P+eRy0Cfa9yYiKJXvL4UMunXl8EF09t7BtVzH4ZgBwBc
X-Received: by 2002:a05:600c:8106:b0:477:b0b9:3129 with SMTP id 5b1f17b1804b1-483c9bb6573mr114108805e9.3.1772305973660;
        Sat, 28 Feb 2026 11:12:53 -0800 (PST)
Received: from jernej-laptop.localnet ([188.159.248.16])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfcb318fsm141401095e9.6.2026.02.28.11.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 11:12:52 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej@kernel.org>,
 Samuel Holland <samuel@sholland.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@kernel.org>
Cc: linux-sunxi@lists.linux.dev, devicetree@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH 3/3] arm64: dts: allwinner: sun55i-t527: avaota-a1: Add SPI NAND
Date: Sat, 28 Feb 2026 20:12:49 +0100
Message-ID: <5079872.31r3eYUQgx@jernej-laptop>
In-Reply-To: <20260227175157.2339758-4-wens@kernel.org>
References:
 <20260227175157.2339758-1-wens@kernel.org>
 <20260227175157.2339758-4-wens@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne petek, 27. februar 2026 ob 18:51:55 Srednjeevropski standardni =C4=8Das=
 je Chen-Yu Tsai napisal(a):
> The Avaota A1 board has a SPI NAND chip connected to spi0 on the PJ
> pins with support for QSPI.
>=20
> Enable spi0 and add a device node for the SPI NAND chip.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@kernel.org>


Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


