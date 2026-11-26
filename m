Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795691362;
	b=uE8CZsG4+cXjprzF0RLe33v0Gw20/yjBjEL5Eb+kUAgnyigmDjA3Sk0FWkYkXX9+p4WD
	 cQUUYivx78PaT/0C1FNg291Kniyz4nNEZXBBljavEnND+E9wZYRFpOn3SMx+r2W14qveo
	 dgQGjO4kZvQ2wAjPMLxPt/BTGE8DYMfIGzKS6hRmvSdrasVtE6DcOVz7sEhdEuVIH5Lwc
	 Nf81FR3pvAjTj5itl6NrKUUc14taaiaM6sqZt1TICBKFEqRmHuOldo6QwXvzpZRMqimMm
	 fduyRMGeHU8mi8STYH/TiWd1j0d7rJzfnZVKYNxhhTuduglia/nhL3fbdm/taHPe/3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795691362;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=y1/wD7Wi9STowuQTsl3HDTiGkdek0lFr2Qc9ETyKkHc=;
	b=NtqU1x6FBnt2q1Gb548hMKEIlIimhphGWexLr3b+XWCN0QtCEjVk07pVY3509Okqqei8
	 B3FNQPD610pcVDl3ez6s2+LTgP0084/0E7EGDXZt/HV8RAYVdoXzS5gHe8JE4S5T8sQ5p
	 peUQi230ME3W40SJ9kyLT1cKiyf5wwrDtRSvv9Mfi2UMfB39TS4JTus1bP4Cmca39QG7c
	 6R84+Bc7/366NqeW801wdD5YmnTtOwieYdEThRR1Lq3E8L/hQNndFvaNrcc2a2oUyHtrv
	 1Hk3M2jeMwKYudQ2G4IDA99Nshb4/blqMFuo2TTD/vROUYLeBZc8DklSf3Rzs4SpM0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=CT0q90WV;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F27606A31C
	for <linux-spi@vger.kernel.org>; Thu, 26 Nov 2026 11:09:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70F27606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=CT0q90WV
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id AEB021A17E3;
	Thu, 26 Nov 2026 11:09:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7CAF460237;
	Thu, 26 Nov 2026 11:09:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A61D211E6B368;
	Thu, 26 Nov 2026 12:09:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795691353; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=y1/wD7Wi9STowuQTsl3HDTiGkdek0lFr2Qc9ETyKkHc=;
	b=CT0q90WVIJc4zyZoQOxtFRwovUp/lD1tvYC8y28IdlSTZHylCR+SJOmgbdnavDoSIkKJZ7
	UQHzhfp1dRSy6+1mQ58pLkQKWb6rDLC50feZHn9Pd5znOcWpj7D5Q9l8chtedbMZd2oDLJ
	ZmLDRvMzlrHQxZPH5Eic6XzwoJQMgIXhdfgkIsLG7EiBT8CbTTjEdoIHRCvVjU+Te4B3r8
	AQFb4tWn9rZC2cYUS3f3KjYpHTHLUb6guHhBk2tbVLMW1Bfs4Eaee4bo7sjgUwuMgJ4yos
	1IXLZNk6X6lqfWFueUY4owHyk7QJ2sJAxW6L5yGfOuj+wpDnU0wIA23rihiUPw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: Liang Yang <liang.yang@amlogic.com>,  Feng Chen <feng.chen@amlogic.com>,
  Xianwei Zhao <xianwei.zhao@amlogic.com>,  Han Xu <han.xu@nxp.com>,  Conor
 Dooley <conor.dooley@microchip.com>,  Valentina Fernandez
 <valentina.fernandezalanis@microchip.com>,  Daire McNamara
 <daire.mcnamara@microchip.com>,  Haibo Chen <haibo.chen@nxp.com>,  Jyan
 Chou <jyanchou@realtek.com>,  Yu-Chun Lin <eleanor.lin@realtek.com>,
  Maxime Coquelin <mcoquelin.stm32@gmail.com>,  Alexandre Torgue
 <alexandre.torgue@foss.st.com>,  Pratyush Yadav <pratyush@kernel.org>,
  Michael Walle <mwalle@kernel.org>,  Takahiro Kuwano
 <takahiro.kuwano@infineon.com>,  Richard Weinberger <richard@nod.at>,
  Vignesh Raghavendra <vigneshr@ti.com>,  Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  Alvin Zhou <alvinzhou@mxic.com.tw>,
  Cheng Ming Lin <chengminglin@mxic.com.tw>,  linux-spi@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-amlogic@lists.infradead.org,
  imx@lists.linux.dev,  linux-riscv@lists.infradead.org,
  linux-stm32@st-md-mailman.stormreply.com,
  linux-arm-kernel@lists.infradead.org,  linux-mtd@lists.infradead.org
Subject: Re: [PATCH RFC 00/16] spi: spi-mem: Express the dummy phase using
 cycles when relevant
In-Reply-To: <20261125-macronix-upstreaming-spi-mem-cycles-v1-0-fd036402fd37@bootlin.com>
	(Miquel Raynal's message of "Wed, 25 Nov 2026 18:51:14 +0100")
References: <20261125-macronix-upstreaming-spi-mem-cycles-v1-0-fd036402fd37@bootlin.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 26 Nov 2026 12:09:05 +0100
Message-ID: <87wlpzx31q.fsf@bootlin.com>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3


> Convert spi-mem, all the trivial spi-mem controller drivers and then
> SPI NOR to use dummy cycles instead of dummy bytes. SPI NAND may come
> later.
>
> This is only build tested for the moment and sent as an RFC because this
> topic has raised a lot of questions, there may be things I have
> forgotten about, so I would like all parties to agree on the direction
> before I commit into something cleaner. I bet Sashiko will also have
> interesting feedback to make...

I made several trivial issues in the controller's conversions which
triggered a lot of Sashiko answers expressing the feeling that the
patchset was not ready. The important part clearly are the spi-mem
changes, the modifications on top are almost independent follow-ups
showing why this may be useful. Nevertheless, I'm gonna address all
those issues and send a v2 with hopefully less obvious issues.

Thanks,
Miqu=C3=A8l
