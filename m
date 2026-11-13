Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794530157;
	b=ZBWCnQVEsU7CDoGV+mJ5OXdzm3qJiyQMG2yLlmQZn5jaCrYYLHAsJFFnyXeqXwVHBcqN
	 fktvXagWCTgca311AFbJvWlp1N5ooh0jsIQ9kDL7JnVszqR8JXIhar7LhE2jjITSn53/P
	 EfZkCQAd11CgdWqyQxaOqhtk+XcclSIkC1mEM50UhjCLk7qZZRa/drT2L1l8W8p7aYXZI
	 kmFc8VBlF3IztR43+Pxf+lAiHJ6LGhzvEC3kpUN7FEOv0Zds7YfWAYSYx741TVj2Wikyw
	 lvnUAqHWGX7RLGs/1dci75fvXrDDFKLbO1Bxtwh73QKHDSOWpyqqZXGxa+iruwsF0FQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794530157;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=kTNrEmxNbCnmj9l3gKKv43Fyixiy3ZR1yX2zY41P3W0=;
	b=KY5uDY8JVn4CRPKdAhcArVHj5+1fZrtrxpocsyppLRt9TMiYFLGvARcprkfXVgO3wBFc
	 RJP6o5NznwTP9ovOJuDRhycGK26eGOYOcMOWf7MuHaJTlI6wVxVzC7APD7EmzAuTJZFKG
	 Rf/mWYZTaDO8LDQL0OaPH11bmhATEcVmXyiW0zZcYSX9nbIaifTbQSOJtR8oxx4CJlVrc
	 icH31ey7zUFOUFuK4jXxWhRU2hIcHKQaJl4ni9fBfkckktNJqJu8j/2W8D6o0qjEIPLO3
	 OLiPhCpQFI6mQ8D45+a/BZwcV1wNs16iuO0dWjjxJ+pSMTbzy0nSFvKboZZQUOMWqNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pm4bRzhY;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65DB606C270
	for <linux-spi@vger.kernel.org>; Fri, 13 Nov 2026 00:35:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A65DB606C270
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pm4bRzhY
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a1b07c3c5fso4885915e9.1
        for <linux-spi@vger.kernel.org>; Thu, 12 Nov 2026 16:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794530155; x=1795134955; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kTNrEmxNbCnmj9l3gKKv43Fyixiy3ZR1yX2zY41P3W0=;
        b=pm4bRzhY2y3ustnK/cV3mx2MU4TpafN1DP6eVrVfEWP6zwyrwZ8WcDJbBpaSn4PCS1
         q9/VX/T7EbPj4GABXhTxz1EpjBBlJ5C6LjvWS8+R1MyrkwtZqFceJNwX44oFw+7COG4F
         1gfOA+vK6jEPJTD/xSnbdkkUcNMj3shVBA1DlbgDKzaydRB4LWv4xwEw4b0FU73Ik21N
         +vouDhlWEkCOD4DZamc4To4pzA8LXBUO2O7oFaIdM7cWs47aP2/ISYgSiypk/Ibch+NN
         iUQoIvdKBDkOBgZw/fIiTtBmgSBvjcKDT5zuJIZZ/Wp8eQMkuKNaarb7YNm3NG1cX3MH
         ShMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794530155; x=1795134955;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kTNrEmxNbCnmj9l3gKKv43Fyixiy3ZR1yX2zY41P3W0=;
        b=w0NVUh+YVCMOeN7YKd0+ZwvEf6r3+tmI7xCXAGTUnLu9hZWH2tFQ5TrJXATgTOccac
         ZjV0ZYryOEpngEcmNQCWh4qw3Ut9JpxaTAMcuZqJ43v8Z6xUsbYvSLK0FKn866IDORV7
         cHjNpMBiI51gkbJIbk7V5pcpy3ZV4Kh64BgvUW6//NEuBr89fvbjFae2hfHs24zzTyuT
         OTzmigIxP577rqEXEP8cBzrgtvC39umgAAPrUBmnSpPFRWRMKkfgSa/30j0mRTtaxuye
         w8rCCBT5w4E42eFUPdy70/IMo5aMYGFyrMFNsQ4Bcwscra9ASzXk4ZyMMxdkF08sdSzF
         dq9g==
X-Forwarded-Encrypted: i=1; AL+hErHcTpU6rn/vjM6CPkwfatdisMpPwsPvVGvb0BnFhRRSnRhQV0TPMRNqWOHLz9usGToov06eEEY3SzQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+clI3FyXsAp+TWh4qEDansB7rZjRorDe6wY4LjZjFlVK2sVaxn
	SeddewKj8Z7UvSQZUrzC4GpnD83ssLgr1gZ6x2MelMu7s86Owtphnqf5
X-Gm-Gg: AYBFou2OPHcX4TYmC6B4xUeLaO5O3PvspTxr/OfdkluN5GS7cEye11PsS+H5esCSYc0
	NiuArk53qL0HeCLfxgzDe/SO0vFc1d+K9lGKjth120wLS9VAjGapHNrzNrRMHw64b14dqPKEDE6
	JJUL+/3pOTTQbxAZ3j0WElQZjvFKFwQam+TMPvhagyviWxCGJ6cRCUNFAbVQqocl5wlZ0Ydc3tV
	gNrj2NE9NPxohqsRhF3xeD41hezW/tUW9/iNC0aDcg2EPvOWneSAGuwjAz/8zAt0MQ2RQ3GWsmy
	B7wLzYDaHzhOjL4y/tkH4lnwrK3DtKATgkrsevPr7W3H9CV48LlAOpH4rYg1srfCbOILd9AbM/x
	kOBKKE37Q2BCl1g54AjUjVsync4PQcBuSZWUmRLCUnO5CZKzWbql8iF0ZI65arYmx1C7JNONU1h
	6+cUaQ3lrWhiSMyXOifV/adJdJrRAByv6Xn+4LLi2A8xwp7xy3qLswOzRrBEpJHcMZH+6nBN3yO
	JPi/QSVurz/Gsk12FJKJLT7lY0uB7tNIy27ndRDoIGmFMC6dbH4qsA4oz/gq13RXXAGhJ60W5OP
	PF9hERfJjQ3rtkMQ36wSadX5wai/F7CKKncr1eF7La1zVaUWqiNyZF3k9KGwI/jbwmaam5zf61H
	7mlsCbWNmKfxzlqqj3QGfsS0SVFpjoAhnnJGGNHpYGxBF0TNNWyxXaoH/e1kal6v7DWOZW6d8KU
	ajroNc2qQ0vWKaiyNK
X-Received: by 2002:a05:6000:2508:b0:498:a72d:c097 with SMTP id ffacd0b85a97d-49c70ed7c56mr2426773f8f.19.1794530155089;
        Thu, 12 Nov 2026 16:35:55 -0800 (PST)
Received: from navid-pc ([2a01:4b00:a856:6220::a11])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c7da37b19sm1497029f8f.5.2026.11.12.16.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 16:35:54 -0800 (PST)
From: Navid Ghahremani <ghahramani.navid@gmail.com>
To: =?UTF-8?q?Stefan=20D=C3=B6singer?= <stefandoesinger@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org,
	arnd@arndb.de,
	krzk@kernel.org,
	Mark Brown <broonie@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 20/24] spi: zx: Add ZTE ZX family SPI flash controller driver
Date: Fri, 13 Nov 2026 00:35:53 +0000
Message-ID: <20261113003553.3661566-1-ghahramani.navid@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <jjb8MyAPSXaXqHtedDkkwQ@gmail.com>
References: <20261014072109.1759502-1-ghahramani.navid@gmail.com> <20261014072109.1759502-21-ghahramani.navid@gmail.com> <jjb8MyAPSXaXqHtedDkkwQ@gmail.com>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Stefan,

Thanks for looking at the changes. Since you plan to submit the driver
yourself, I am dropping the SPI patches from my series, so this is just
to answer your questions.

Stefan Dösinger wrote:
> So IOW, this function should primarily configure ZX_QSPI_TIMING_REG. If the
> target clock can't be achieved with the controller input clock (e.g. divider
> is larger than ZX_QSPI_TIMING_REG supports or clock rate is lower than
> requested SPI speed), then a change to the wclk is in order.

Agreed. I only changed the wclk because that is what worked on my
board, and I never checked whether ZX_QSPI_TIMING_REG has a divider.

> > +	ctrl->min_speed_hz = clk_round_rate(qspi->wclk, 1);
> > +	ctrl->max_speed_hz = 50000000;
> This looks wrong - the max speed is probably the highest possible wclk rate,
> the lowest speed the lowest possible wclk rate divided by the highest possible
> divider.

Agreed.

> > +	/* Ensure proper data sampling point */
> > +	reg = readl_relaxed(qspi->io_base + ZX_QSPI_TIMING_REG);
> > +	if (!FIELD_GET(GENMASK(17, 16), reg)) {
> > +		reg |= FIELD_PREP(GENMASK(17, 16), 1);
> > +		writel_relaxed(reg, qspi->io_base + ZX_QSPI_TIMING_REG);
> > +	}
> I don't know what this is doing. Can you elaborate?

That value came over from the earlier driver I used on this board,
which always wrote 1 to bits 17:16. There is no public register
documentation for this SoC, so I kept it, and v2 only writes it when
the field reads 0. The sampling point in the comment is my guess at
what it does and I have not tried other values. If it matters for your
driver, I can try 0 to 3 on my board and tell you which ones read the
flash correctly.

Best regards,
Navid
