Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BB03D6471;
	Tue,  2 Jun 2026 12:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780402549; cv=none; b=oB/3xGDOKBZytmZDsgyLhE3i0aVh2q44pfl+c7XdAc5BRJYj3HeIGSjFAsC5e1bN9mcuso/spVnktBNVRcQRm6Zz+mObaymUVO5m81ZqsqEO8Q3RnQPQFJQPdTl2E8+9rmVQDAlGoBX5+BzN0CJkso9TdckZ7IpHfvBzqg+ysUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780402549; c=relaxed/simple;
	bh=cUrj10EkG8zAnWtcNNYGOgmvvRHPFvKHGeFPoIlFAGI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rImYcI2gi5qUbfOijxwWwuhZGP0InIAKR5NHPbm3vGY6GbnwpHBgM0CRtDpXAptG1hwAGqityCWA/jgtJodui6fafEMN0DQz7gTQBejjbgGMImgZu0p2K1xbDxLYCYGPYhivxGmNVWCrqYoUA26MCtzkEy8z1DU6EjepBNYd5aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=zPImwJiE; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="zPImwJiE"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id C3C4BC6220A;
	Tue,  2 Jun 2026 12:15:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 59A10603BC;
	Tue,  2 Jun 2026 12:15:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1CE18108883E7;
	Tue,  2 Jun 2026 14:15:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780402545; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=p03ztj6XSIMc7U28VJy2jGNEbLmsRiEcsPXWwsoNno0=;
	b=zPImwJiEpyRoEUx8ORaIHzQQ70oK9xBRu+e+8Voz+bIj3qh9kKCet36pw+ptqHSD/yuio+
	ankAlAIZHatk1GDUxy41rcvREjNFWsKlEuBqmG7eBeMQbc44MWy+Rk2sROFzuC3xTVpsEF
	0C6jJwhbQ2nxv1xjj7h3AiF0gJj/hCUEBJfdmqhc5o1Yrpy05UaZk1Eq01rtaFM32qZ2Js
	pk1e9Sr7ikQAhL51zhwMLSXb3Wlu6keOk+AHv90bv7od8wJUDIzXYzJm6iA3G7pJVPyMXJ
	LrpQnCp86wMxqu1AXkyzQvbsE9ByR6PNGHlJMf1426IZFcGIihMj+mRoYCIBuw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Santhosh Kumar K <s-k6@ti.com>
Cc: <broonie@kernel.org>,  <robh@kernel.org>,  <krzk+dt@kernel.org>,
  <conor+dt@kernel.org>,  <richard@nod.at>,  <vigneshr@ti.com>,
  <pratyush@kernel.org>,  <mwalle@kernel.org>,
  <takahiro.kuwano@infineon.com>,  <linux-spi@vger.kernel.org>,
  <devicetree@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  <linux-mtd@lists.infradead.org>,  <praneeth@ti.com>,  <u-kumar1@ti.com>,
  <a-dutta@ti.com>
Subject: Re: [PATCH v3 10/13] spi: cadence-quadspi: enable PHY for direct
 reads and indirect writes
In-Reply-To: <e2a354fe-ef25-401a-b8a9-4d51ad12f429@ti.com> (Santhosh Kumar
	K.'s message of "Mon, 1 Jun 2026 14:09:58 +0530")
References: <20260527175527.2247679-1-s-k6@ti.com>
	<20260527175527.2247679-11-s-k6@ti.com> <87se7bgasn.fsf@bootlin.com>
	<e2a354fe-ef25-401a-b8a9-4d51ad12f429@ti.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Tue, 02 Jun 2026 14:15:41 +0200
Message-ID: <874ijl2l5e.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hello,

>>> +static bool cqspi_use_phy(struct cqspi_flash_pdata *f_pdata,
>>> +			  const struct spi_mem_op *op)
>>> +{
>>> +	return f_pdata->use_phy && op->data.nbytes > 16 &&
>> Why is the check looking for 16 here, and 1kiB above?
>
> Direct reads have very little per-op overhead, so enabling PHY is
> beneficial even for relatively small transfers. (> 16)
>
> Indirect writes, on the other hand, incur significantly higher setup
> cost, resulting in much larger break point. (> 1kiB)

Ok, this probably deserves to be defined, eg.

#define MIN_DIR_READ/INDIR_WRITE_LEN_FOR_PHY

And a comment would be very welcome to explain these arbitrary choices.

They can probably be improved further later.

>>>   	ddev =3D cqspi->rx_chan->device->dev;
>>>   	dma_dst =3D dma_map_single(ddev, buf, len, DMA_FROM_DEVICE);
>>>   	if (dma_mapping_error(ddev, dma_dst)) {
>>>   		dev_err(dev, "dma mapping failed\n");
>>>   		return -ENOMEM;
>>>   	}
>>> -	tx =3D dmaengine_prep_dma_memcpy(cqspi->rx_chan, dma_dst, dma_src,
>>> -				       len, flags);
>>> +	tx =3D dmaengine_prep_dma_memcpy(cqspi->rx_chan, dma_dst, dma_src, le=
n,
>>> +				       flags);
>> Not related to the change, isn't it?
>
> Yeah, not related I'll leave this untouched. However, the changes above
> and below are related and belong together in the same patch.

They should likely be done in a preparation patch.

Thanks,
Miqu=C3=A8l
