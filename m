Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458912E62A9;
	Mon, 28 Sep 2026 14:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790607095; cv=none; b=Jm64Xda7N45HvECcq7RkFAy1n1kE1bPfodq5AB0i658BkoBsWhhtj0/mD4GtP1arHS9xuw2Nf71vUHUch1f8MZYNwXZRTYNvIGjr/sZL8InOlwVVp67OiL6rkazTxvnQLhGYMzLPwi0mUix7+7NuoBUdyigGyiWKj7mC0sfIz7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790607095; c=relaxed/simple;
	bh=FyexpH87LgklUhqlR9v+v+IvjXLmick6WliVpt2wPHY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YCUfLTS9A+NAS03YqId5mJpsoZNimHIcxplzQqdcFI/XQMzI83hMa2m5ob57KrgMHedpHPW1WQZuUir16RBbjCj0URrFnTjgJQJRFMAC4rU0hF1Y9D4BYiaWpZpxmJy10iEtwRuGxR4D2oxB/DWg7riUffY+CIZSj6oGvld9NKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=uCwQKrcF; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="uCwQKrcF"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B09F44E41021;
	Mon, 28 Sep 2026 14:51:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8279A601BD;
	Mon, 28 Sep 2026 14:51:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2BF8A103290CC;
	Mon, 28 Sep 2026 16:51:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790607087; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=FyexpH87LgklUhqlR9v+v+IvjXLmick6WliVpt2wPHY=;
	b=uCwQKrcF+jYXLjOWljmksk2AEK2VxbDoTqeI7cbS/XkcxeHqVornX6+RwcYcRhTp3ijaiW
	2AVzquiHnmoxvG4j4d72N9/7iVNOemKMbqHbIgtSBr16STKO93JzyKhQJJUt7U7ZrCPILN
	84dpJx8l4tfRpqCUp054DICPOmmNrG/+iZDADPF1nIvah00iClkHqocDBqliNP3Od8ypW/
	WDJuYQATI4YiRnpGeL9Z0q1E84KdT/cd++Gpb+ZQkvNQR3rPmC4yBsIEQ5ZmFwJHf75HTG
	9i2GKymL5HlyGSu60rDj5wkROdxAkP32FB7v50T13ZscW881ApWYH8pqwKgVPQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
  linux-spi@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-mtd@lists.infradead.org,  Michael Walle <mwalle@kernel.org>,
  Takahiro Kuwano <takahiro.kuwano@infineon.com>,  Pratyush Yadav
 <pratyush@kernel.org>,  Steam Lin <STLin2@winbond.com>,  Santhosh Kumar K
 <s-k6@ti.com>
Subject: Re: [PATCH 0/4] spi: spi-mem/mtd: spinand: Prevent SPI NAND
 continuous reads on am65/am62
In-Reply-To: <878qa7dzke.fsf@bootlin.com> (Miquel Raynal's message of "Tue, 28
	Apr 2026 14:44:33 +0200")
References: <20260326-winbond-v7-0-rc1-cadence-cont-read-v1-0-0d626e1dfb2b@bootlin.com>
	<878qa7dzke.fsf@bootlin.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 28 Sep 2026 16:51:21 +0200
Message-ID: <87mrt177km.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hello Mark,

On 28/04/2026 at 14:44:33 +02, Miquel Raynal <miquel.raynal@bootlin.com> wr=
ote:

> On 26/03/2026 at 17:47:14 +01, Miquel Raynal <miquel.raynal@bootlin.com> =
wrote:
>
>> TI errata i2351 explains there is a problem with CS handling, SPI NOR
>> are immune to the problem, but the CS being deasserted spuriously when
>> there is DMA arbitration on long accesses (every 1023 bytes), SPI NAND
>> continuous reads cannot be leveraged.
>>
>> Link: https://www.ti.com/lit/er/sprz544c/sprz544c.pdf
>>
>> I created a 2-page read setup for testing all variants available on a
>> W35N chip wired to this controller. I reliably observed all variants to
>> always (in my tests) report correct data, except the 8D-8D-8D
>> variant *when setting an extended number of dummy cycles* (>=3D 12, so 24
>> dummy bytes). In this case, I got the first 6144 bytes correct (over
>> 8192), the rest being full of ones (0xFF), indicating the CS has likely
>> been deasserted there. This is not exactly 6 x 1023 bytes (?), but
>> close.
>>
>> This series shall be applied on top of the SPI NAND continuous read
>> series that I am also carrying, but ideally not too far in the future
>> because there are Winbond (continuous read capable) NAND chips mounted
>> on TI platforms AM62 based which could make use of that new feature and
>> expose the issue described above.
>
> Applied to nand/next (except the spi patch).

It seems like the spi bits have not been applied, can you check if you
can still apply them? Without these, people using this controller with
continuous read capable devices may observe spurious issues hard to
debug (due to the CS possibly not being kept asserted during long reads,
leading to the continuous read being cancelled by the SPI NAND).

Thanks,
Miqu=C3=A8l
