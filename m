Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793851394;
	b=Zmkw5R5zXkEG9/44kODth7i2u4k1aSIm+KZcsIndA7yeq6cnGribeETi80yKTHcpJfLi
	 NkOdVAscEkDgEQXUcMSpdmrMLUm3xcV/jomvidlWhY/Fwy+6CQ5oTU9Az5UdhE2bz0oas
	 bAqgr4tZ616XmSUJUoQvzTIu75rvXi8QRmza6t55ZaVWE791XlyUaDEyKUO72Hx4PEZpT
	 rGdk44paS8qMufgJDCMEf3TgBvMgQXIg/j0TDsprhFV2/pbaTNmf6giLBEFb4/SAhqpu5
	 cNEnvMYS+jAIb8YC7G/52EMUVQTOfxszr3osnxJPwnyyUEhJY9dzD8WETU6jZJM/40g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793851394;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QwoTZmoFmjS0P0Cnon0RS+YrqhFNVA2Z7mOMJXSbqhA=;
	b=eORWu7YO4TVwng//4FqvbPUAQnLGa3++HdLQ3rXtO6fAw1Bnk6p9IG/0ghCylZE6cHXv
	 VOBaqXw5cAg7+UttiEWT5aT8XANIS1jDOTxJU5KPr3pSun00+DHNvpkP+zkSMrGKym7jj
	 uNmOSoIYRBqx3bqTgsFv8qbkvDczSpJtxNlBi/+cmH7b0BLm3F164E5OUaUQIZn2EA9g3
	 Hq8DYTgWM8UkeyDJ7YpNa8GJ7ttL71WLIC7HrJrhCHjfdoXZBK1KLxZMlii4KTWmuu9rC
	 okLxpe85HXu4288/+bVJ8hvvqp7tqnQfMZTFRm6JBJf4nYkVVactT3/L+4HIUDMtDlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uvgNXBhX;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586D4606A31B
	for <linux-spi@vger.kernel.org>; Thu,  5 Nov 2026 04:03:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 586D4606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uvgNXBhX
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3b0960fdde9so788768a91.0
        for <linux-spi@vger.kernel.org>; Wed, 04 Nov 2026 20:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793851394; x=1794456194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QwoTZmoFmjS0P0Cnon0RS+YrqhFNVA2Z7mOMJXSbqhA=;
        b=uvgNXBhXiHB/9Xud7deheburxbmyHYTAtjSrot+KzvWJd8e6qQo7H3q2MDv0HxMBlb
         dfVS9Sd0Kvxv5a5UqtPIxAVIYQ3mRoRyqwXICyVKyU40Guai2Uy6t+IiCYk4h8M05Xwy
         vkVmYZPtPKMhafASzsXJ4pLP9fki3TFTLHJcX85HwC4xJvujMQlE86sTsn+ax/GEOK5p
         CEiNQt4yyc9sjouxNIZ3fyNeELrl5DtKR5YN1i7znZTxfi9NQ3L4buhp1+mvbNbNoLjd
         rxMd/lsMapLoU1xu9byI1VRQD1qWBBRVwLRqXpbtSzxP2c84fVxj6kt7pYuORGAiEfr0
         Ga7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793851394; x=1794456194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QwoTZmoFmjS0P0Cnon0RS+YrqhFNVA2Z7mOMJXSbqhA=;
        b=aOYKqB87o+g5ScW35xRvR6ElN2Gp/PFrJVw9zTtVDyRwl0xyS4+3UMSkLUZR+XvuFS
         rgp48ce9EdhtJqX8RzhpWO9Z5yhiZCdgEw9B+3FeHpqWkRcud59Hw6690ppiNhOBbfiq
         J8e/pxlQvkYc806DrW3t7IJGTGGIpKmJyGwAqrvavC9GgOHbX6D5LEReUgRnswg15x0Z
         5X2rJP8D0Cr0IJgyKYb2Cus20zDGjfqbjckX4VoxERCIX2hONBV1MVtCaOmDCBYm1o4/
         XUl4OwLS7lEzvZMqOBJlFaj9kjjoumyHQtOv6vy3WRc8aOaAgQJkKueNanE+MahUUb7U
         cpwQ==
X-Gm-Message-State: APuU4Z8No9h0NprxN+D5KDI3tUldW+XZEpj7lPxLWgBnDwwztPo5+P9E
	8bwzkPAqZpxEzgbYs90ivecCgzBb+DcU4vhze9q2XJSIbeqgN5nb/igp
X-Gm-Gg: AYBFou018ksPCUGaOUi/Tm4Y7YKLw96TbSXcMhNRD2y1DbaRV932gDAFUi2SsceJK6j
	EgHV/5dgXZmlZBceaXcyTrc+jwz4QT5nZ1SSoFLC0b5IcNTx+AuxTUpaaZFiiBoGIaU/cU0ENon
	XA3l1KWFnoIG1NEEM95HSFJ6oPLuz8hDI6HCm7oqyVzzSWZRhWSxjtcar4m66NpNZWCVCgYSHG6
	8miNVazBwar3SnFikFLaAx9zfJ2hUF+TYybybk0TUbisnIu9cKvnMElObKPbjAqOlk0lfiUgTUC
	qxXPkfPxjOnqs+dGlUdniq5nW6HJADsY2LyvPAGXef/jhrG0KFueGLK58tr2oziVqNpVtsD3jRj
	JOT/1gjNDOyljZS2XBRcZYaqeHmhPZZ8pGqWqxgl1/kzWprNCIfeVTnacIm1FJNBaGm4nBqrD8P
	lJkKSwBKeb2G+ThwVDlFR2mGWTBzCvjmP9XqdOv6ASUy69ldOtLiCEb5ec/ioZgUlNeNlFK2iRb
	+rAAaGJ8ROavf5/UAYefrLatekYAUCkTIYpWSBuzCu2px5OJ7Ymu4zpVYZxYQytepzSrHRfIGUE
	EzDrRfd3sRNVhD0J4XyNUbSeRoKIqF8tmhh2ilvr1jIex5gun6oBPzRERBjMi/WMTZ7aBUJmpH4
	lTMNabhqNl05zDjpt52OBVRFkIucaWCofRZZBlzQsWeBtae0dVbCJPalybIna5WLIgXK3bh8Oqt
	7eEhmwkWjUGnIzo6umEIRgco4odZHtD6ZyTR+nbdHgivoo5gqEc53UaMJKAIh9w4duB8At
X-Received: by 2002:a17:90b:5748:b0:3b0:a04f:939b with SMTP id 98e67ed59e1d1-3b0a04fa025mr2545628a91.64.1793851393578;
        Wed, 04 Nov 2026 20:03:13 -0800 (PST)
Received: from josephctchan-96c-1t.c.googlers.com.com (145.247.125.34.bc.googleusercontent.com. [34.125.247.145])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0944eb1d1sm3639685a91.0.2026.11.04.20.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 20:03:13 -0800 (PST)
From: Joseph CT Chan <jctchan@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Joseph CT Chan <josephctchan@google.com>
Subject: Re: [PATCH v2 0/5] spi: lock context annotations
Date: Thu,  5 Nov 2026 04:03:09 +0000
Message-ID: <20261105040309.1550444-1-jctchan@gmail.com>
X-Mailer: git-send-email 2.56.0.398.g882cbad275-goog
In-Reply-To: <fbdbb9e6-40f5-45bd-bf96-acbb90acdc40@sirena.org.uk>
References: <20261103225522.3643901-1-jctchan@gmail.com> <fbdbb9e6-40f5-45bd-bf96-acbb90acdc40@sirena.org.uk>
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

On Wed, Nov 04, 2026 at 02:46:56PM +0000, Mark Brown wrote:
> This doesn't apply against current code, please check and resend.

Sorry, this one depends on the SPI core series too. I will resend it on
its own once that is applied.

Thanks,
Joseph
