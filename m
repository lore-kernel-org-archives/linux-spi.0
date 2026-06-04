Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DE4397E8D
	for <linux-spi@vger.kernel.org>; Thu,  4 Jun 2026 07:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780558117; cv=none; b=TvFC36cvAgI52vKd/A5BOn6IZ62tP3h4izUCLherst3b/CC9ZdU7fLmFSQpp8hXDT6rg89iZA02EqxCBAFO2lFz7pL92m8hatERe5yquzinJM0kpSnJ/qJxTihuTtfSP8TRvPUPBuTzad9ur4LEVZSINBynxm4Mrlj7mc3lUE6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780558117; c=relaxed/simple;
	bh=N3FYJH0Na6n0IvoTQRLh82Jz6KolB+LqBxz9CxTQz94=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hVn1U90s0bLKaQMaihAWuIfF5TfGBl+ghYsM9HVoSkrGc12JSWHGjmAbPZREG/G8cUFBaxrQkKlBWaohl8GlSmSfE91LEfRjRow8Cw4lgZAbAFLha+friT3ipKGjFXk6sgx00PbwdZPeIWZQqIy2T86f9T6FdaMyheNs/XW9SDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dMdEvho4; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dMdEvho4"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 0CA894E40505;
	Thu,  4 Jun 2026 07:28:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D1AD45FEF7;
	Thu,  4 Jun 2026 07:28:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 456D4106A1395;
	Thu,  4 Jun 2026 09:28:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780558113; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=N3FYJH0Na6n0IvoTQRLh82Jz6KolB+LqBxz9CxTQz94=;
	b=dMdEvho48GdK6q0uOpDC6L/F42yGqD6zMP7d3/DWu1YG2xKyP41yvy8Ls25V2u26R+R6mw
	Ll8krPj+hKwrsNoDpMuj6gqO1kVC+8FcKaFegFHR63i2FrG67i9r6U8z8dRxVmTqI13OQA
	NX2h+kXu06x/b60IjPtlrP5XOA2ctB2D1VbJrrCyv+UqChU71mwngXqLITHqc0KydvPqmL
	cbnLanbbpXYvPYaGr97h/TB2WNJjKlhWQgdfl1rKPz0RdVX3ZtPAm+UGv36GIz2XtI32oW
	GfA4m28YL1V5ltQLEpS1UbcvdoPPjQ7phMVD5k/7mEnV5IG5CEJjfLEZJXDryg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Rob Herring <robh@kernel.org>
Cc: Santhosh Kumar K <s-k6@ti.com>,  broonie@kernel.org,
  krzk+dt@kernel.org,  conor+dt@kernel.org,  richard@nod.at,
  vigneshr@ti.com,  pratyush@kernel.org,  mwalle@kernel.org,
  takahiro.kuwano@infineon.com,  linux-spi@vger.kernel.org,
  devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-mtd@lists.infradead.org,  praneeth@ti.com,  u-kumar1@ti.com,
  a-dutta@ti.com
Subject: Re: [PATCH v3 02/13] spi: dt-bindings: cdns,qspi-nor: add PHY
 tuning pattern partition property
In-Reply-To: <CAL_JsqJwxgcFOB=kE7bVQYDn740-w4RppMF5W-3Ne9=9qV9OrQ@mail.gmail.com>
	(Rob Herring's message of "Wed, 3 Jun 2026 12:38:46 -0500")
References: <20260527175527.2247679-1-s-k6@ti.com>
	<20260527175527.2247679-3-s-k6@ti.com>
	<20260602164945.GA475455-robh@kernel.org> <87zf1by5oc.fsf@bootlin.com>
	<CAL_JsqJwxgcFOB=kE7bVQYDn740-w4RppMF5W-3Ne9=9qV9OrQ@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Thu, 04 Jun 2026 09:28:29 +0200
Message-ID: <87cxy6ydb6.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 03/06/2026 at 12:38:46 -05, Rob Herring <robh@kernel.org> wrote:

> On Wed, Jun 3, 2026 at 11:01=E2=80=AFAM Miquel Raynal <miquel.raynal@boot=
lin.com> wrote:
>>
>> Hello,
>>
>> On 02/06/2026 at 11:49:45 -05, Rob Herring <robh@kernel.org> wrote:
>>
>> > On Wed, May 27, 2026 at 11:25:16PM +0530, Santhosh Kumar K wrote:
>> >> PHY tuning requires a known data pattern to be readable from flash.
>> >> When no partition is explicitly identified, the controller must search
>> >> all available partitions to locate the pattern by label, which adds
>> >> overhead and relies on label naming conventions outside the
>> >> controller's control.
>> >
>> > I agree 'label' is not the best choice. Software should not care what
>> > 'label' contains. It should really be 'compatible' instead.
>>
>> But compatible does not seem relevant in this case, right? We are just
>> flagging the location of "some useful data for the controller".
>
> compatible is what tells us what a region contains and how to use it.
> That seems exactly what we need to define here.

We usually talk about "programming model" when it comes to compatible,
here we just need to point at an offset which is in no way different
(from a hardware standpoint) than the other offsets. I honestly feel
like a phandle property would be simpler, also because compatibles in
MTD are already quite complex to manage and I would prefer not to add
more complexity into the parsing logic.

>> >> Add cdns,phy-pattern-partition, a phandle property that allows the DT
>> >> author to directly reference the flash partition holding the PHY tuni=
ng
>> >> pattern. The controller uses this partition during calibration, avoid=
ing
>> >> the partition search entirely.
>> >
>> > Do you have any data that this approach being "direct" is faster? In
>> > fact, it might be worse. Instead of searching just the limited number =
of
>> > partition subnodes, you now search the entire tree for a matching
>> > phandle value. We do have phandle caching, so that might save you
>> > here.
>>
>> True, but besides performance considerations, I personally do not find
>> elegant using a partition name/label, but maybe that's just personal
>> taste :-)
>
> I agree. That's true for all the partition nodes with only node name
> or label to go on. We should fix that at the source. However, you
> already have to support using label,

Hum, no? There is downstream support for labels in TI kernels, but we
explicitly asked Santhosh to drop it for mainline inclusion. His commit
message may be a bit misleading on this regard because he is mentioning
labels like if we were already using them, despite the fact that we are
not.

> so anything else is supporting a
> 2nd way whether it is compatible or a phandle property. Is it really
> worth it here?
>
> Rob

Thanks,
Miqu=C3=A8l
