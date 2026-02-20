Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C654309EE9;
	Fri, 20 Feb 2026 08:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771575702; cv=none; b=XbN2MYGpHUO9pyn5gT00aa6YfQ0whxVweNDGe3eYivFDX9WBpJ95QrB0QZeTqQ3f2XguINfDcXe2RDro/64xW8GZ99LIcwsPCXu61vfHwK3IVl8kMxDnP22mseD1+ejawWz92AL896hpZMqb8jNP0BK42DVDLi8XfZuytMvJSPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771575702; c=relaxed/simple;
	bh=m3LCq1v4f6VsgqqRgj0dFsfM15EC0OKWM7IoAXqpJBQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ug89N8Jfn9VNwagyAC47KYoVMTA+/czKdfv+gzqrHReqX3fXGDAfmgQFrlcVCuErsZDV/tdwAKT0nVnJNHLZM8vqNSWTEUHgDMoqNhJZB6A8TxmtsEd+4F0bYcQbPgc99fgpBVSpMfieVQ1aiys4HpBBQLPfgRc72nGwOkq5ZIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BUAwBgK3; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BUAwBgK3"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 754811A09D6;
	Fri, 20 Feb 2026 08:21:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 41DB65FA8F;
	Fri, 20 Feb 2026 08:21:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5D0F6103687A2;
	Fri, 20 Feb 2026 09:21:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1771575698; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=m3LCq1v4f6VsgqqRgj0dFsfM15EC0OKWM7IoAXqpJBQ=;
	b=BUAwBgK3bv1Kex5xQIYvTcHZ0JROJdSfxpcSeQc2mpdC7AzY14UP8Chix3zR3TOYFVVGnf
	xD+CfdmqHMBWBS3QBePkagWqbav4HvBhvC8XSXLMXk3ufL8D8N2vc1mUTOkDm3rdctnyNP
	+dXImFv1vyZ/XjAxgOkGhGusWk8fXUFpVwdggMpXusWNwcu6V9C1PTVIS5AD5nwZdAIzL2
	F7LAkZMAWi+Eop4zlBeDvHWKAgv1vkCDCWZEqyTkg0KklzaYQjX/3a67vP9iZcvHEmB3Sg
	ZTjyoKdDutu7r9hJfxLqkp1L04mGrDclX2s/112lgT/akg24z0NT29GQdmHcow==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: "Michael Walle" <mwalle@kernel.org>
Cc: "Santhosh Kumar K" <s-k6@ti.com>,  <broonie@kernel.org>,
  <robh@kernel.org>,  <krzk+dt@kernel.org>,  <conor+dt@kernel.org>,
  <richard@nod.at>,  <vigneshr@ti.com>,  <tudor.ambarus@linaro.org>,
  <pratyush@kernel.org>,  <linux-spi@vger.kernel.org>,
  <devicetree@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  <linux-mtd@lists.infradead.org>,  <praneeth@ti.com>,  <u-kumar1@ti.com>,
  <p-mantena@ti.com>,  <a-dutta@ti.com>
Subject: Re: [RFC PATCH v2 08/12] spi: cadence-quadspi: read 'has-dqs' DT
 property
In-Reply-To: <DGIXI3RVPSJW.3J77RFU4JK6O2@kernel.org> (Michael Walle's message
	of "Thu, 19 Feb 2026 13:14:39 +0100")
References: <20260113141617.1905039-1-s-k6@ti.com>
	<20260113141617.1905039-9-s-k6@ti.com> <87h5rvgkjs.fsf@bootlin.com>
	<DGIXI3RVPSJW.3J77RFU4JK6O2@kernel.org>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Fri, 20 Feb 2026 09:21:32 +0100
Message-ID: <87h5rbsu43.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 19/02/2026 at 13:14:39 +01, "Michael Walle" <mwalle@kernel.org> wrote:

> On Thu Feb 5, 2026 at 6:35 PM CET, Miquel Raynal wrote:
>> On 13/01/2026 at 19:46:13 +0530, Santhosh Kumar K <s-k6@ti.com> wrote:
>>
>>> Add a boolean field to struct cqspi_flash_pdata to store whether the
>>> attached flash device supports DQS (Data Strobe) mode. Read this from
>>> the 'spi-has-dqs' device tree property during flash node parsing.
>>>
>>> This is preparatory infrastructure for PHY tuning support. The field
>>> will be used by subsequent patches to configure read data capture timing
>>> with DQS enabled for improved margins in high-speed operations.
>>>
>>> Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
>>
>> As mentioned in my answer to the cover letter, I am not too much in
>> favour of this property because this is something that is somewhat
>> related to the chip ID, thus discoverable. I drafted something to get
>> rid of this property already, I will share it for opening the
>> discussion.
>>
>> However, for now I am closing my eyes on the fact that the DQS pin might
>> not be wired to the controller. In this case we will need some kind of
>> "dqs-not-wired" DT property, that's true, but also easily manageable at
>> the core level later, when/if the need arises.
>
> Usually, a DQS pin is optional. AFAIK, there is no requirement for
> it. I.e. it will probably work fine with slower frequencies and
> using an internal loopback. So if you run your flash with slower
> frequency you can probably save one pin and use it for something
> different.
>
> What I wanted to say is, that not having a DQS pin wired is not
> really a mistake. But "dqs-not-wired" sounds exactly like it.
> So IMHO it should be the other way around and the device tree should
> tell you that *is* wired, if we cannot find detect it otherwise,
> like looking at pinmuxing for example (not sure that is feasible
> though).

I was in favour of the opt-out property because I feel like it doesn't
make sense to fill in the high speed spi property which involves tuning,
without wiring the DQS pin. It is possible, but if you're looking for
speed, it doesn't make much sense IMO. Hence I was seeing this as a
specific case which legitimately needs a property. But I don't want to
bikeshed on that for too long, I'm fine with the opposite approach,
let's make it a "dqs-is-wired" (or something alike) property.

Thanks,
Miqu=C3=A8l
