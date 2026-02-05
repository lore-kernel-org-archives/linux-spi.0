Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D010C3624B1;
	Thu,  5 Feb 2026 09:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770282969; cv=none; b=bMilwalKwLnRQELDtTEtVCpQUbpvaspDWQlxMUH3t4ZhNb7Iobuwr+OxMOGD5Oeng7Ax+SCyUjaefHp+2SxLjYE4dqynSkmoQ1Kg9Gdw96JRgVYrcHCLR1bum4+SP7w+cTncGJljOjpCgh/QYPpHEDupV3Sg/EQLpV+oHSIHn4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770282969; c=relaxed/simple;
	bh=lfyDH/EtMDxUMAlHqjlG/srZY4gDA1nFKslB8ivNFGc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G40xVKD0uuOXi9I1OO2qAJXLHDMACyFqwk9xsepRye7lW/fg0IUJ1vWLUx/Iiaas1SBu9hIPVMFa8BUywVEbpGAq6Dz2kcVCxfhK+EGZhunSebNqpGpE07+L9KYNUSsAVSZfjCjQ2LmnpFtqYFNl9ljVNqbHLsJV32VGRph8z24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kYrOM7L7; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kYrOM7L7"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 4C9A11A2C1B;
	Thu,  5 Feb 2026 09:16:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1FD9F606FD;
	Thu,  5 Feb 2026 09:16:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8BC00119A88F7;
	Thu,  5 Feb 2026 10:16:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770282966; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=9nFcXg3tPp7Xl7rf98Pg7rTcjp+5AL6yQ44qr6m3xjk=;
	b=kYrOM7L7Vso54SE4Gz3sQZDTUQGFuWZKxMDIfA/x36iBlzHe0/Q+vD+Y3DFl5/SRwttAMG
	Csp2a1atP4Kk6cihcXjB+vYJg/CJxMwNB59mrCY88qQK86crIPf98G2CSPCdstk+bxAL4T
	RM4sNUqQaolDXq+9psRRjtqZJ2wmY2k+f9I5hRgArQBDQnjy5XRV7o3jmghks3M5AyvPi9
	WDh7egCmZX2Vek0IqZedG+9gCaHARhMN6XlZ4VewuEQTTae6SEl0wxKEeCzDwwy7FboQmW
	X1HNqb7SWmGDLSUCox7WXykDEvvY3kBy2CVPWc/P4QUYq5wElvXbND2K8AGHsw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh@kernel.org>,  Krzysztof Kozlowski
 <krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>,  Geert
 Uytterhoeven <geert+renesas@glider.be>,  Magnus Damm
 <magnus.damm@gmail.com>,  Vaishnav Achath <vaishnav.a@ti.com>,  Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>,  =?utf-8?Q?Herv=C3=A9?= Codina
 <herve.codina@bootlin.com>,  Wolfram Sang
 <wsa+renesas@sang-engineering.com>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Santhosh Kumar K <s-k6@ti.com>,  Pratyush Yadav
 <pratyush@kernel.org>,  Pascal Eberhard <pascal.eberhard@se.com>,
  linux-spi@vger.kernel.org,  devicetree@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-renesas-soc@vger.kernel.org
Subject: Re: (subset) [PATCH v4 00/15] spi: cadence-qspi: Add Renesas RZ/N1
 support
In-Reply-To: <176968523282.21695.1970063208785534195.b4-ty@kernel.org> (Mark
	Brown's message of "Thu, 29 Jan 2026 11:13:52 +0000")
References: <20260122-schneider-6-19-rc1-qspi-v4-0-f9c21419a3e6@bootlin.com>
	<176968523282.21695.1970063208785534195.b4-ty@kernel.org>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Thu, 05 Feb 2026 10:16:01 +0100
Message-ID: <874invft4e.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi Mark,

> Applied to
>
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-ne=
xt
>
> Thanks!

[...]

> [02/15] spi: dt-bindings: cdns,qspi-nor: Add Renesas RZ/N1D400 to the list
>         (no commit info)
> [10/15] spi: cadence-qspi: Kill cqspi_jh7110_clk_init
>         (no commit info)
> [14/15] spi: cadence-qspi: Add support for the Renesas RZ/N1 controller
>         (no commit info)

Git was actually smart enough, it solved the conflicts without asking
during rebase :) Shall I resend these 3 patches (+ the typo reported by
Geert) updated after a spi/for-next rebase or do you prefer to wait for
next -rc1?

Thanks,
Miqu=C3=A8l
