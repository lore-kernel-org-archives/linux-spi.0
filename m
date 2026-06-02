Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD14394EA6;
	Tue,  2 Jun 2026 12:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780403787; cv=none; b=TZuH2FPUW28GArV77kshQVvGcgejqxzP+8qlx/2YTQ/cc/mvCJBRYnh0F783hy3bOFyTcWq5LiQjwYg+vBv534jaCN20R/3MHajdY/hFG+SGdjs+vLJRxrdvib27fsA4AEh1dhQPomtaONOn43Ib938mMBQVQXrq0cU628gkzH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780403787; c=relaxed/simple;
	bh=SRPRaAh+bKL/wfIfWcgbiLpj4JaAtntWVoPHMgKJ5hk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aFzCUsUUTyCQWphJ2iZacqVF/PnJTyC9Cp2XIgCJkWWu/qTomCFrIThlJK+Dhb2oOwIrsaPb2CdHYAoXpQUMr1c++1aQiQYnNb9ExCwUHpV2VsVeEmUX8yWlp/o3ThuLa8d8+AQpbcvI+APDqBsyWJj17C8wIaICv19qY/xbUbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IzdBcF7K; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IzdBcF7K"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 71FE54E42DC0;
	Tue,  2 Jun 2026 12:36:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 43069603BC;
	Tue,  2 Jun 2026 12:36:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5CE99108883E7;
	Tue,  2 Jun 2026 14:36:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780403782; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=SRPRaAh+bKL/wfIfWcgbiLpj4JaAtntWVoPHMgKJ5hk=;
	b=IzdBcF7KMuSb7rZ5XB+aZYiM0E5ckcEKMIFaaFmESlAG2XXd/oPBYuAePWkIA+1XVt8AnE
	Uaae1GYa00ns3rwjBIIHI8NNiSRjpJ/HlnFxpC3VQjR21RTIaezCw4oUPpdI0Vb4S8sBE+
	9YG3xXTIGSm/2KP05PNUZNU5X1zOOayandiof2fO57ZKW4Cna75LUsxYSzHOF4SSldoRgs
	XZMzpGuHNAMXLxwgIKqtuZPCl1GVYEweyOfHNkDN699VQawnNiUZabi3YJ79OVIGpwCqRZ
	PDPoMjuKitoxIWOn2lQn18DJxCtPkpODwqQcIjYPub9VBM+0aypiC4umizGmHQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Santhosh Kumar K <s-k6@ti.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,  <broonie@kernel.org>,
  <robh@kernel.org>,  <krzk+dt@kernel.org>,  <conor+dt@kernel.org>,
  <richard@nod.at>,  <vigneshr@ti.com>,  <pratyush@kernel.org>,
  <mwalle@kernel.org>,  <takahiro.kuwano@infineon.com>,
  <linux-spi@vger.kernel.org>,  <devicetree@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  <linux-mtd@lists.infradead.org>,
  <praneeth@ti.com>,  <u-kumar1@ti.com>,  <a-dutta@ti.com>
Subject: Re: [PATCH v3 02/13] spi: dt-bindings: cdns,qspi-nor: add PHY
 tuning pattern partition property
In-Reply-To: <4a570d36-dda6-4f3d-9c16-d3e57ac55f1c@ti.com> (Santhosh Kumar
	K.'s message of "Tue, 2 Jun 2026 12:00:36 +0530")
References: <20260527175527.2247679-1-s-k6@ti.com>
	<20260527175527.2247679-3-s-k6@ti.com>
	<20260530-original-peccary-of-cubism-af68ed@quoll>
	<2f091813-fa28-407f-892d-bbbbe3cac4e4@ti.com>
	<063fe976-9a28-4670-90df-921fbc1c3a8c@kernel.org>
	<20260601-stirring-tested-mayfly-e97c14@quoll>
	<4a570d36-dda6-4f3d-9c16-d3e57ac55f1c@ti.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Tue, 02 Jun 2026 14:36:17 +0200
Message-ID: <87mrxd15mm.fsf@bootlin.com>
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

>>>>> I also have doubts that this is per-device property. Your commit msg
>>>>> suggests it is per controller.
>>>>
>>>> This is a per-device property. It is consumed by the controller driver
>>>> only to locate and retrieve the offset of the PHY pattern partition
>>>
>>> So with two devices on a bus, you need two separate partitions for tuni=
ng?
>
> Each SPI NOR flash device needs a partition to store PHY tuning
> pattern.

If I may try to explain a bit what is behind, the read tuning procedure
is about reading data from the spi memory cache (some kind of internal
SRAM) over and over again, while tuning the controller parameters until
we get the best stability (the controller driver knows the pattern it
must get). While SPI NAND chips have "write to cache" opcodes that could
be used to load the pattern into the chip without any actual read from
the memory array, this is not possible with SPI NOR devices which do not
have such capability. Since we want to keep this training procedure
memory agnostic (and also somewhat simple), we shall expect one pattern
per memory.

Thanks,
Miqu=C3=A8l
