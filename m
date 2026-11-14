Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794622663;
	b=KdCZN0TyiV+zedQh2R10BLACcpnVwmb3joSkewGyaQOxCPEYfsLqECi++2650sOdfECd
	 ELsssfypauTlXd/jmdeRi+Cl8LDREzWHt0f72OawEqIprKSNs8LaNkuQ4hhnTVDuun+ln
	 O6QI9AvG3QetHn4yP1fgpIjvssICD+G57sCQuvf4H8JblFLWOQAZa78/yCWPNgP/9yaeR
	 PpozsXzWyvqYduPhVtvQnYRYlFRXyHlh9n5LOKZGIIVqP3+Yx5++LSWQlAuJJZHA79Dxu
	 Ql7n1EBkQayR0AAUSCdjiWZIgCEQnpqGg+8vufRwWUvyGNZeUK5BVweQyXHOzfsYa6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794622663;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=OfIKBZnhOOiL2WcgTc07r4rHGBprvyQL2SchtUxUdKw=;
	b=xUB7ZGt90aDz22hFJGjbWp32GkHNJWu7cbDmzj8dOOoqytbp19wU0hcWAEaY+M4bWV2C
	 sEb6xTuOI6ggx+F0gxmQ4Kcbou2YCKaDrTJhtgZvqnk+z22fLxw4/AzL/fb3dDo63fJII
	 0FTc89ZWPlQOl6yjalBm6IkSmoy7X6FHkMnJe0w0ZYzHMd8/OgEBTWt3zcM4BskRsPD3q
	 03XJNCxTXPjborIO7ulSS714qAti9WOtgYm2Ckkiw4w25kAG+uTw2Ldev+BCUbPbSChcD
	 m8fCOsRxYINpsDmWkr8mIY6fI3pu11USFZixow7ma8WOE7oyVmYVl3vnMJFvxFeHYqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lBTySpgG;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D285606A337
	for <linux-spi@vger.kernel.org>; Sat, 14 Nov 2026 02:17:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D285606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lBTySpgG
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-37986eb6fa2so792011eec.0
        for <linux-spi@vger.kernel.org>; Fri, 13 Nov 2026 18:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794622662; x=1795227462; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OfIKBZnhOOiL2WcgTc07r4rHGBprvyQL2SchtUxUdKw=;
        b=lBTySpgGD/QnNG/ZxyjrFEiehOFqMoyUzvo5UapiKvWUxbefYbV/Tnr0dOrP4gcfkF
         FY8pZ5GK4hn2Ypxb4dspKTumrL7ODfcwrTWXU2hMoOgrNSlHvyAavT/Bw88ykGvlknzr
         alLcnJKYiR4CqkHanHmZJ5Vd0nMLkIps4gxSjrb6oJfx0lyA8suUqcF4ujAqK8YGjJ3E
         bZhPCUv10u1lZ7vOMWJF1dU7DzNGMHdzLbAhRptsSSZ8NeRIoY5afLXlrmnv4St3VKyJ
         g7YQgUjnNKeeCa7AgWrmXgP2PSirrJoPYMYarW9zzL1cOXx5AXJ/FFwiwASYHvQpyaiN
         j2XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794622662; x=1795227462;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OfIKBZnhOOiL2WcgTc07r4rHGBprvyQL2SchtUxUdKw=;
        b=uJEMlgbDEskvdnKCuL5TlJVfYg0K+rNl6//OfM0LlL6An5WzkTsFWUSs4h6esPlx9t
         pevB5M0xFHIWEGdZq3VvTkw43aSqgaw3LWSQSBXObxIvVSDMPHpyp6kHp1UIWlTWqvwu
         MdyZL9PZUbS8K9SqmrHvsyW5plEb1ntZ6KEway3ErtqHaGsIsoEtKcCyMCHO6ibOAChT
         s/bwPtrOT1WbhYq/CJHwUrv9ZZ2iiaNaXe8V9/D4fKAIWrogsfc26LL27OfKGo/GV71k
         29Es6YemSmWmDMrCjF32LwC0c1VJjQfB0QlwOLdFXmBy5oA2Jgl8lBCYdwor+lzgrGZz
         eXGQ==
X-Gm-Message-State: APuU4Z95fBN7aGBx3GQ/pTD1KlSWDu1RefFxg6XYKAYb1Q7ptnwOEz6b
	oUYoCxJ6LqmLMKqyS20UX9SRTwV3JlB6FAL+PY5rKJ1jaFQC/N7i7s3iK3DHNBseZdk=
X-Gm-Gg: AYBFou0nAlAoBQzyr1MR4LzPj6MOu5D3h3zgBAQYj8/W6gDwoIQRxqwDc4l0BQqLO/m
	vI52S14wnAWpBTMpmIAcbHRB43JBL4jmVtgKaHVArNxnGIkXRo2/Fbw0Uo1xeEwE7/RNnPHPGdO
	C2DQzn/PFBngKagPlEaK07JhHEJmCgADnEXJ+fin1/8mn770JkCuq0YDlM17VFQ29MvD4f7LJbb
	2IdShg4V6rlzkZYjh+nkqNI8KzVkG210cMckfSmmsNmTKXshfjo2CJ94V9gDeKNfFTirJGX+VKd
	ydBxfWoUFWbULWXYU2JXZsx5a5pgVLQlfTRdUgrF7s2Xs3/BV3XWUfkD1nEOuvtNdEBgiHUOZEU
	rxl6pHZFBE4iCKVzODWZuaCwsg6TfLNfJ35d/hZ8LS0xM5cgYU7XBzEDAn2nwcUDiWSz0L6CpPw
	ymRvB45bKTiD29ZnMXtBzg8aIzF/6eJouthos3ObzUGbEEFCcm0IajZFqXwiAOqb4XRj21a4vEr
	uFwN+3dWuBChIEkoVMacJ8FryqTHiTh8ymbIdXw/TPuZrotbVALlv/7JUi77evXHZ+JmJ86BBmh
	m2G2qD3/OlQO0+YrZGoXDT3QIXu3VHimEfPsHRQmkvOXf2spgmD8jZ2nPKn42XBkT1zsj6d1Lii
	NQtN8WsH2BbCFwTnew2lPvKnM
X-Received: by 2002:a05:7300:c8c5:b0:379:e0a2:1a1 with SMTP id 5a478bee46e88-379e0a20687mr3206612eec.35.1794622661423;
        Fri, 13 Nov 2026 18:17:41 -0800 (PST)
Received: from [127.0.1.1] ([2602:feda:30:cafe:ec49:38a8:0:1866])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3795378d7e5sm11298969eec.3.2026.11.13.18.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 18:17:40 -0800 (PST)
From: Yaohan Li <shunsheng1218@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [RFC] spi: handling a stuck queue worker during controller unregister
Date: Sat, 14 Nov 2026 10:17:37 +0800
Message-ID: <179462265760.266954.15125504985835019625@gmail.com>
In-Reply-To: <03d73980-f558-4dd4-8ec1-a8d40bd2474d@sirena.org.uk>
References:
 <CAGTEBTY2EhOHwmWhB0_YdnP-nMyGzzhnwH+ta9yeynHD-Y0JyQ@mail.gmail.com>
 <03d73980-f558-4dd4-8ec1-a8d40bd2474d@sirena.org.uk>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Mark,

Thanks for offering to review a patch.

I tried a core-side fix for the unregister race, but found that the lifetime
rules need more thought before the patch is ready.

The original problem is that spi_destroy_queue() can time out while the pump
worker is still running. Unregister then continues, potentially releasing the
controller while the worker is still using it.

I experimented with tracking active I/O and waiting for it during removal.
This helped with the original test, but I found a problem with my accounting
for asynchronous transfer_one_message() controllers.

spi_finalize_current_message() signals cur_msg_completion before calling the
message's completion callback. In my experimental patch, the pump can
therefore drop the active I/O count before that callback returns.

I confirmed this with a fake controller and a non-sleeping callback using a
bounded busy-wait to expose the ordering. spi_unregister_controller() returned
while the callback had entered but not exited. The test produced no KASAN
report; it was intended to demonstrate the ordering, not a separate UAF. The
fake peripheral driver deliberately left an asynchronous request outstanding
during remove().

I also found that core-side accounting cannot protect private resources that
a peripheral driver frees while its own asynchronous callbacks can still
access them.

I've stopped work on the experimental patch for now. Before extending it, I'd
appreciate your guidance on two points:

1. Is it the peripheral driver's responsibility to stop new requests and
   drain outstanding asynchronous callbacks before releasing private
   resources in remove(), including requests submitted during removal?
2. If a controller cannot terminate an active transfer, should its driver
   ensure that the transfer completes before unregister returns? Given that
   spi_unregister_controller() returns void, would the core need a different
   contract to handle an unabortable transfer safely?

I can provide the test module, logs and experimental diff if useful.

Thanks,
Yaohan
