Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794530239;
	b=mWUsdO8KcfCGZJ+AHbTV1RUbvPUK15HBYRp0GGHk649ZjTBYXKiza2K7cyhypoTSFIQh
	 NHCBHLH2AdmzaeU2YLfET0sIVxkusvPNg1UtmRkagOrAQJ6pFwkW1U13t/xbEeUEgvBGt
	 UMo6QvRCt4pEiEoS7cWCeyLObkyQfrVhDhgG+0DQ2kANSnA0TQUw4buB41GJ832p1UZ1R
	 6CP2uqELHRK6hyYwOGKGcyZ+SS1eMrbflPpmr5A1eRDvq9Fbzo5X7OedLap4e27FsPDZ0
	 AQaAGZA7A76VbpbUKT1YgGBJeGeBgn5AithhLaaHnSu9r2ccYDTj4cN3Zhhnta8pIMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794530239;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=TJKl/9+9/GgYtmdNqCwcVE25Z6LMmrJm+ZVyrujB+G0=;
	b=3uxQ1sBjJGBxmYG2PTsHyOCS5LlByVJjiQ3Foq+2gZcmYycuGjycjNGhkP4Lm3beH+Ev
	 njolH1AQ/a6uXpF9ITmjtkAQ3J4WMCkHUzSc11YfmiAg+OZCdRazVKkGFmmfBrKSqimDV
	 unXNKK0LQQLAuhdmIafEeMV/vrzyau7oCiFe7wjTg1iixWEhoiQSxdExjW5VQss31sOAG
	 l2ws9SoXiK67CzwO48/ztmp8MyyVubaxL8eoZ8arq5htROO2HY2tZwFIXnNVyGy1AAwWo
	 ffNpnqq6aDPpd4rAzd8/3BGFTtuuw0QcSJeVbkAtG+M+g5ZuR2NyRgp4FKn7oZwGxxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TOayCD2S;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3480C606A338
	for <linux-spi@vger.kernel.org>; Fri, 13 Nov 2026 00:37:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3480C606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TOayCD2S
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-490d59c3edaso191474f8f.1
        for <linux-spi@vger.kernel.org>; Thu, 12 Nov 2026 16:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794530238; x=1795135038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TJKl/9+9/GgYtmdNqCwcVE25Z6LMmrJm+ZVyrujB+G0=;
        b=TOayCD2SBEBwrAKAt2MXAD+N+85uu8xaIa48EbZSRV2rG0IIkNrWZc3cxvUbwD4E59
         2cM942obilajBJm8B8olOayUossndYpHM2udVgTz4IK5Fn/25cNTJ7i9tCoW1W5W3TwU
         U6CDp06M2b1JhqUbeDtgQNnP+4PsnMWu7FkvUaYKzdTbZTIc8izEDrIuYYIfj9OhZj8h
         zMX7CV29tkN7QvrfKCrJNZ+ohmktdm69N1YB3vR7QJ8o5Zj1eZykKDYV6GjCYPpNaAWT
         jgeX8zFePd3PU+9OEKZLN6UFrs7bMzlN50vSPRQeEDOhOd4cPwXLdX/WTNPEPcM7K0VX
         AbLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794530238; x=1795135038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TJKl/9+9/GgYtmdNqCwcVE25Z6LMmrJm+ZVyrujB+G0=;
        b=nOXoc31iFDNXSsyO/dE9RcCvvDjIPr2kUuxhqDcrxUigbpysnn9nlhwcb/Kdug+Ieg
         MjK8Vj2/HPrxg4TH31GaVhpKmx9a1FB/GycH5E/0501FF0hIudbIdKKkcMxi4UiTrTqO
         P4s8j1b8QewermJJCbDVv+wPJqM05S/PvgcA5zDcSsDWAQhb5T+6xoXpUCTY76aPm2RJ
         b6ZjtxL5LlLw0ZZzga0koRTz3AZv9XMtF9+wcuhE1hNzRqdW/BKIpDT0zw2kxMtB6Qip
         Se310YtLreagNRpESzs91+rbnuL4s7NatQPLu7IYUWSXQwWrvTO97QGHuqIjM6l12VVi
         5jtQ==
X-Forwarded-Encrypted: i=1; AL+hErGS3EJkYibgW5BsCZcFzuIj3eM143pnFTTb6bQJGjl43lxf0qJ0q9CQYlY/LSXxx2nh6w5Z+XsjaLo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/bhaJofJiQTv/N746ynSNlOLp20aTZ8lZJD3M8FPN0n9SL1dI/
	CfqSlfaCjfevUHBni+8godhZGDoFSPZygFMxb0/jVj7OJLf/aGMd7dvx
X-Gm-Gg: AYBFou1vfOonMhR6YfDABdoQASGE0mcBCaVoXAzXoUJSVBQyXYoaUfcq5MRWTWrmV5U
	0bozNhBOGo6B4fsoGN99d1KGR2F93GJmR31qQ8lz9THs3rpDoi+i+FQykFg+eeMZ4WqOtKKTY/l
	NBqmb1kxH1MPYGS9LWTI7IdqFl+yMLwUd3yFslOl6LE72dgzevE96Klv/hgFNC1h86GhqKQupFr
	+IjTbKBt068U7ToPhVQ1gglZW4iz0Kxm2FrJftwFqMvvq1/GG8pTiQSzSTefB6CvS58Jv1zEI+b
	T7ksxepbCzfDOdk6+vualnWYlKB5z0EfO6KSY2al8enpoCDg5iifHEJC1N5hAtuCgmaIrI/GNdx
	xCiCPXD00wVwOxDM+KQG3qQXW+NvkX30k913cLeAgKJk2mgKVtP7f1mEpqtqxx8PSZMJ5v1PXPa
	NLEocvlcd5pMCu3tyJfuoXoW3JkTHle6Xn6flOpxWLjLtHiYMclLJ988Vcrh+DAjgtU7SZ2LD0n
	5Eylhn45zPAmWK9buxYWyG+fQriMYNK8DUDJ6W7+CuD1b0idPr2cmAd6D105LPQAYd8kFrtU2pk
	lOb9TaLluBNOejIm7BPBJWvjfIXSKGoXp1zZr5s4OQ1uRuo/t9W0C5HUddCj2mEidE0baDrSf8B
	T8cIfZOz75F1dHY/ymzPHjL3GDS6f/5GbddZ1JwGYbxZSq1ctY4ulcRDV5wUQ7xlNEGvKi5EQ0K
	SkIGbcCrOyFQEBm7hfM7ibX82dLpoor9IEnWXxaA==
X-Received: by 2002:a05:6000:4b12:b0:491:1468:a504 with SMTP id ffacd0b85a97d-49c70cee81cmr2469854f8f.21.1794530237680;
        Thu, 12 Nov 2026 16:37:17 -0800 (PST)
Received: from navid-pc ([2a01:4b00:a856:6220::a11])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5f5972a7sm1937527f8f.21.2026.11.12.16.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 16:37:17 -0800 (PST)
From: Navid Ghahremani <ghahramani.navid@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	arnd@arndb.de,
	stefandoesinger@gmail.com,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 19/24] dt-bindings: spi: Add ZTE ZX family SPI flash controller binding
Date: Fri, 13 Nov 2026 00:37:16 +0000
Message-ID: <20261113003716.3666756-1-ghahramani.navid@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261015-khaki-gibbon-of-persistence-a552df@quoll>
References: <20261014072109.1759502-1-ghahramani.navid@gmail.com> <20261014072109.1759502-20-ghahramani.navid@gmail.com> <20261015-khaki-gibbon-of-persistence-a552df@quoll>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Krzysztof,

Krzysztof Kozlowski wrote:
> Where are all other properties your driver is using? DMAs? Resets and
> whatnot?

You are right. The driver used an optional reset and the rx and tx DMA
channels, and the binding described none of them.

> Did you actually test your DTS against bindings?

Not properly. For v2 I only validated the binding files with
dt-doc-validate. I have now run make CHECK_DTBS=y on the v2 H3600 DTS.
It passes, but only because my SPI node also leaves out the DMA
channels and the reset, so the check could not show the gap. The
binding has to describe what the hardware and the driver use and not
only what my DTS uses.

I am dropping this binding and the SPI driver from my series since
Stefan will submit a driver. For the rest of the series I run make
dt_binding_check and make CHECK_DTBS=y on the board DTS before sending,
and I compare each binding with the properties its driver reads.

From your other mail on this patch, none of the subjects in the next
version will have the redundant word binding.

Best regards,
Navid
