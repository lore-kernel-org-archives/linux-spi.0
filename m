Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD8243CEC0;
	Mon, 29 Jun 2026 15:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782747719; cv=none; b=gZs1eNyASKH5HWa7vpch41+Vc2lG7ACed4y7LeWMuouBOBDy9iGY1qMivVCuknN6VqrGictQDcWrUii4PtUB/UVlOOQciNeNA85EX+X7imSd03ly0adn6Ei7PyAEz4IfEUZgBXUG1EgR21gxp93amG+jsPtRhNNQXgHY1wfCHjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782747719; c=relaxed/simple;
	bh=K+puyxZopR4gkSTJL3cffNbTGqH96CJtVCWWwQzRITA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Br+POIgRQTThbSNtVDRhyXBbnYB7VTCxeLBraN4GA0vpWRcF86NtuRDrsmGjAZeKBHtcWp69FxhRmtT9o/uRanrQYdghjYy+fAzSYfV24gqgRmNrKKHIkWTh4Dhmrf34xk161b5/uVmxjOxqT5eXXTH0T0xEcf10oE0fwojmztw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=e8JSMcoc; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="e8JSMcoc"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 75F004E40B60;
	Mon, 29 Jun 2026 15:41:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2C4EE5FF96;
	Mon, 29 Jun 2026 15:41:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C710F106F18F2;
	Mon, 29 Jun 2026 17:41:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782747714; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=8J9faHVVv2ntVQAaALWU4TngzNzL0U5Yipge3+xPG7s=;
	b=e8JSMcocsEMdwZIn+IiOh7qSvNcGXscTgT6coAUO5+OOVMv+TIftj7LPjGYJw47OR2hur7
	PMvM/INXhv+nzLgO2uPX+Tp0QRt+0qSCY6IKC1/+ijMQyS3aCLG+DxRk/MJwBWirZiLKna
	f8ba9MbnmL0hEvTNPAHVHPr96b3i16a5oZ+ye6dA/wAK80JbdtcYbeRBVP/UJMWquxMk17
	xdpMkk+ESs51mYYjL71XW5OM4hjSrh8r9LmVXDchkgAuDqibWWVh65vz2PFVCNN3EKg/wH
	JOuqneLoMhx4IbDuOiqybLDaFUJu4qzmaAOSoO4O/7Kq4Y+Y+oBl0XfXoYK9NQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Santhosh Kumar K <s-k6@ti.com>,  broonie@kernel.org,  robh@kernel.org,
  krzk+dt@kernel.org,  conor+dt@kernel.org,  richard@nod.at,
  vigneshr@ti.com,  pratyush@kernel.org,  mwalle@kernel.org,
  takahiro.kuwano@infineon.com,  linux-spi@vger.kernel.org,
  devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-mtd@lists.infradead.org,  praneeth@ti.com,  u-kumar1@ti.com,
  a-dutta@ti.com
Subject: Re: [PATCH v4 01/16] spi: dt-bindings: add
 spi-max-post-config-frequency property
In-Reply-To: <20260622-private-curly-fennec-7e1ad0@quoll> (Krzysztof
	Kozlowski's message of "Mon, 22 Jun 2026 11:14:32 +0200")
References: <20260618073725.84733-1-s-k6@ti.com>
	<20260618073725.84733-2-s-k6@ti.com>
	<20260622-private-curly-fennec-7e1ad0@quoll>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Mon, 29 Jun 2026 17:41:50 +0200
Message-ID: <87bjcts69t.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 22/06/2026 at 11:14:32 +02, Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On Thu, Jun 18, 2026 at 01:07:10PM +0530, Santhosh Kumar K wrote:
>> Add spi-max-post-config-frequency, a generic uint32 property for SPI
>> peripherals that support two distinct clock rates: a conservative rate
>> always reachable without controller configuration, and a higher rate
>> reachable only after controller-side configuration such as PHY tuning.
>>=20
>> When both properties are present, spi-max-frequency gives the
>> conservative pre-configuration rate and spi-max-post-config-frequency
>> gives the higher post-configuration target.
>>=20
>> Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
>> ---
>>  .../devicetree/bindings/spi/spi-peripheral-props.yaml       | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>=20
>> diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.=
yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
>> index 880a9f624566..ece86f65930f 100644
>> --- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
>> +++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
>> @@ -45,6 +45,12 @@ properties:
>>      description:
>>        Maximum SPI clocking speed of the device in Hz.
>>=20=20
>> +  spi-max-post-config-frequency:
>
> -hz
> https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/pr=
operty-units.yaml
>
> and you need maxItems: 1.
>
> Now, please take time and think if this should not be an array instead
> (maxItems: ...) to cover other possible cases, e.g. different tuning
> levels? IOW, having single spi-max-frequency turned out to be
> insufficient. You address that insufficiency with one more frequency,
> but what if this is going to be insufficient next month as well?

It is actually a very good remark. I do not have existing needs in mind
at the momet, but that does not mean there is none.

In SPI NAND we have per-operation maximum frequencies being defined in
manufacturer drivers (you can check drivers/mtd/nand/spi/winbond.c)
because when the speed increases, the number of dummy cycles shall be
adapted accordingly. So we kind of handle the various frequency possibiliti=
es already
(the property added by Santhosh setting an absolute maximum that cannot
be crossed).

However, I do not think SPI NORs have something similar, and also one
day we might have different tuning levels requiring different "maximum
frequencies": we could imagine a first mode where tuning is very fast to
configure and speed gains good, in competition with another mode where
tuning makes transfers extremely fast but with an extra configuration
penalty (this is pure sci-fi in my head at the moment).

It is hard to tell whether this wet finger guessing will realize any
time soon. Maybe the safest approach is to go for an array, though. In
that case, could we add a mandatory name to ease (future) parsing?
Typically here, we might want to call it phy-delay-tuning or something
like that (name to be discussed, because there is the risk to make to
too controller specific).

Thanks,
Miqu=C3=A8l
