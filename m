Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BFE1DDC1B
	for <linux-spi@vger.kernel.org>; Thu,  4 Jun 2026 07:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780557266; cv=none; b=SK/aEwrFc8mDurL1JAlRfC1aCgO/HkOG85UEeuc9rSeaMlFj1WgtxRA8/MIj77YT6WrR9486f7PJz0ORKXef1v5aNenkjfKkHnyKBVOMy7tqCj5gvL3ila10hlOlrvVyFLoc9no04vX24J0MOIhFJvlRCPJXUdjZJlo2aAlHYdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780557266; c=relaxed/simple;
	bh=Mch2Bg7cryJTjKT8MYD1B/J4muhxyP20EtAZ3/VXcdA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cNKJIFrF0TuYWgIEC55fMxHFTErW59Mb1pft9wagmqSNjCB9+tVxG5YjmrLKNyLbM4JHKPaGAtDWKYxgjKCYoujdf1HkiKLrnK0nhyHhfvMTz8iNgmarrlus5yyFJ1FsRHUiDQoZBiYA0CydrH/cc671T9YhR+ip6towlrtScmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=g4CCWlRq; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="g4CCWlRq"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id BF4FA4E40503;
	Thu,  4 Jun 2026 07:14:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 910585FEF7;
	Thu,  4 Jun 2026 07:14:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B3CD8106A173C;
	Thu,  4 Jun 2026 09:14:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780557261; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Mch2Bg7cryJTjKT8MYD1B/J4muhxyP20EtAZ3/VXcdA=;
	b=g4CCWlRqCPHFmctTPJZrGv/lHwBZoYZJfY82Uov46VdGISP3Ol0WtQjBizs0npkiHcVgiR
	fmaD1FHs3F3fgInEirfZ9SwbUKPH2NlYQf2qbp23yLfBCWNKkwAJKtGQ+YDKXG43ieaxXi
	vQ75VE/PCZJEOabzNNUNORO/TmFcjLyM65wDaiut99qScvAGyQtvTb/bY7dJKqFiNVG/EC
	0MRiTAeKvoRTFfnDVUvWfRkOf1T4lxAcGWsIHAYiUKT72LhjeLbJf3O6S3WWBXBJ6kGsP8
	JpdpqnK0JGcpG1S0TKz7GB3a24RK+eiWPkEqe7HJkbRoa2jkqleMe1rbD4xwPg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Conor Dooley <conor@kernel.org>
Cc: Santhosh Kumar K <s-k6@ti.com>,  broonie@kernel.org,  robh@kernel.org,
  krzk+dt@kernel.org,  conor+dt@kernel.org,  richard@nod.at,
  vigneshr@ti.com,  pratyush@kernel.org,  mwalle@kernel.org,
  takahiro.kuwano@infineon.com,  linux-spi@vger.kernel.org,
  devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-mtd@lists.infradead.org,  praneeth@ti.com,  u-kumar1@ti.com,
  a-dutta@ti.com
Subject: Re: [PATCH v3 01/13] spi: dt-bindings: allow spi-max-frequency to
 specify a frequency pair
In-Reply-To: <20260603-balance-encounter-94f69e1577f3@spud> (Conor Dooley's
	message of "Wed, 3 Jun 2026 17:40:15 +0100")
References: <20260527175527.2247679-1-s-k6@ti.com>
	<20260527175527.2247679-2-s-k6@ti.com>
	<20260528-clergyman-kindling-20971775ba78@spud>
	<eaa75113-2b89-468d-aca8-932bc7e33a7d@ti.com>
	<87cxy92llq.fsf@bootlin.com>
	<20260602-aptly-bunkbed-1bd3a8d63d54@spud>
	<875x3zzkji.fsf@bootlin.com> <20260603-neatly-twine-e89b923f5cb6@spud>
	<87o6hry4d4.fsf@bootlin.com>
	<20260603-balance-encounter-94f69e1577f3@spud>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Thu, 04 Jun 2026 09:14:16 +0200
Message-ID: <87ik7yydyv.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi Conor,

>> >> > Right, and this I guess is what scuppers letting the controller dri=
ver
>> >> > sort the configuration out itself and leaving the property as-is.
>> >> > It could be that the speed in spi-max-frequency is lower than the "=
base
>> >> > speed" of the controller but because of board routing or device
>> >> > capability that the tuned mode is still required, right?
>> >>=20
>> >> I do not actually expect any tuned mode/frequency to be mandatory.
>> >
>> > I think you misunderstood my use of "required", I meant that the new
>> > property/information was needed in the scenario I described, not that =
it
>> > should be a required property in a binding.
>>=20
>> Yes I misunderstood the term indeed. However I still fail to catch what
>> you meant here, I'm sorry. Would you mind rephrasing?
>
> I was talking about a scenario where you want to use the tuned mode to
> achieve the maximum rate because of the device and/or board configuration,
> but the rate is below the point where the controller would need tuning.
> Say the controller needs tuning above 8 Hz but the conditions require
> tuning to achieve more than 5 Hz. In this example, if the device can do
> 6 Hz, spi-max-frequency (in the current form) would be set to 6 Hz, and
> the controller would not enable the tuned mode, leading to problems
> because the inflection point determined from the controller compatible
> of 8 Hz would not have been reached.

I don't think this is a real situation. If the "conditions", as you say
(ie. PCB routing, mostly) require tuning above 5, then spi-max-frequency
should be 5. It is the frequency that is reachable without any
tuning. Tuning is just a plus. If tuning fails, we fallback to the
regular "base" speed, which just works.

Thanks,
Miqu=C3=A8l
