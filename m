Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9F456C62A
	for <linux-spi@vger.kernel.org>; Tue,  8 Sep 2026 15:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788882836; cv=none; b=BjTDClwgwNBGWyP0Z76yLRw2U1apBQYvjRfEdAyHjzQ7dRf1npgskhvp+KlL5qM7rFKiuyHybYKw5IWbRK8yp4sRyMmgmVGPNenRtxrMJeZ7K+BAhGCtacrOWgZNOT+11bbt/G0mUtj6hj7BJUFyWTV3myYZiS++3cccQaO9hfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788882836; c=relaxed/simple;
	bh=+9ZX6iUvTXoNNNKinZjrVHtPFgtgsfyDB8XUbt38Gg0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D1NM/DPKd/UCPQYypYqmp92q4SIhkGb2DZevR0UAfrmsGoY2EZ4uuufrzoWnBFec+n/XHwArgn8HTq0FUbkAiGGC0BS7N6Q8sy2AnKianI6C48gQKlrb2DSzmDereXEH5GHpkXNklTDH1dbyXUiwCdkkV1ixtjymfYQD7ShBgps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PZp8CVOw; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PZp8CVOw"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id F0FB71A1A5A;
	Tue,  8 Sep 2026 15:53:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BD1116031F;
	Tue,  8 Sep 2026 15:53:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E9EC511C7AF29;
	Tue,  8 Sep 2026 17:53:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788882831; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=+9ZX6iUvTXoNNNKinZjrVHtPFgtgsfyDB8XUbt38Gg0=;
	b=PZp8CVOwDSspntsDUPYJnO+MRHUjRzwv+MX1qDXl+x5LMTo+9tsGeQ3r4mp5+wnf5o8b11
	qjSvUZkeDaAp8Bch4Gkid6aSahCEE3cLkKRPSy+YEsyRHvyANBfZ5AhLZDaCadHcYph0V9
	C1Fa/EsMIVn9nUfi5wYALS06YSKhc+a2V3ThX4DV4tBoXb1kDDF53F+BprUbQd1b456KQi
	LTyC1Wh90A0TLqC/anmOVP0jKnX95rwK9VjcpfWgbZYni59yUTTFzT+dFA0l/cP+st+R9Z
	dkQSP2fnpaCjIlPH1+zKtmTOZ6UUMyk/BYouIJqJXrvNLnkIVutPUwiGftps6g==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Santhosh Kumar K <s-k6@ti.com>
Cc: Mark Brown <broonie@kernel.org>,  <robh@kernel.org>,
  <krzk+dt@kernel.org>,  <conor+dt@kernel.org>,  <richard@nod.at>,
  <vigneshr@ti.com>,  <pratyush@kernel.org>,  <mwalle@kernel.org>,
  <takahiro.kuwano@infineon.com>,  <linux-spi@vger.kernel.org>,
  <devicetree@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  <linux-mtd@lists.infradead.org>,  <praneeth@ti.com>,
  <sebin.francis@ti.com>,  <u-kumar1@ti.com>,  <a-dutta@ti.com>
Subject: Re: [PATCH v9 08/18] spi: cadence-quadspi: add PHY tuning support
In-Reply-To: <f8eaff92-1bda-4c3b-9d3b-83a156b95615@ti.com> (Santhosh Kumar
	K.'s message of "Tue, 8 Sep 2026 18:35:18 +0530")
References: <20260825171737.776052-1-s-k6@ti.com>
	<20260825171737.776052-9-s-k6@ti.com>
	<8aac0c42-fad5-4146-a2a3-b60bdab71a20@sirena.org.uk>
	<ebf61988-9fe6-495b-b1e2-eaeba9f6b98f@ti.com>
	<875x0m7ns3.fsf@bootlin.com>
	<f8eaff92-1bda-4c3b-9d3b-83a156b95615@ti.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 08 Sep 2026 17:53:48 +0200
Message-ID: <87a4pru4c3.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 08/09/2026 at 18:35:18 +0530, Santhosh Kumar K <s-k6@ti.com> wrote:

> Hello Miquel,
>
> On 03/09/26 13:46, Miquel Raynal wrote:
>> Hi Santhosh,
>>=20
>>> The DQS bit in CQSPI_REG_READCAPTURE is used for read data capture and
>>> it's not consulted during writes.
>> In the end, how do you know you can expect a DQS signal during reads?
>> Will that work if the chip does not enable it? I still do not understand
>> how this can work.
>
> The current implementation derives 'use_dqs' from the DTR flag in the
> read_op rather than querying spi_mem_has_dqs().
>
> For SPI NOR flashes, this works with the current SPI/MTD flow as the
> device is switched to octal DTR mode before the execute_tuning() call.
> The current NOR mode-switch implementations enable DTR and DQS
> together, so by the time tuning callback runs, DTR on the read_op
> reflects the active DTR and DQS mode. This is consistent across the
> current octal-DTR NOR support.
>
> For SPI NAND flashes, this series only supports SDR PHY mode, so DQS
> is not involved in the NAND path.
>
> The gap is that the NOR path relies on the implicit relationship
> between DTR and DQS rather than tracking the DQS state through the
> SPI-MEM API. I agree that checking spi_mem_has_dqs() would be the
> proper approach and would also handle any future case where DTR and
> DQS can be controlled independently. I'll address this gap in a
> follow-up series.

Clear. Thanks for the feedback.

Miqu=C3=A8l
