Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96BC426D35;
	Thu,  5 Feb 2026 15:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770306530; cv=none; b=q4UvM1pYPYSwe5eeX6qkuRl4IBJYbURf107HAXH7WXynj4TLAGRKiLrKyAakEL6Z8GCvWm9aLWlIlnXN4rgzlxHP5R16BrBMg+fcAMEybwt3nZPN61PUIOLSk3tTupGk2w1zf8vuRKdgKzGab1ETR7eqz4Qj0PCF+0a2J8smlmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770306530; c=relaxed/simple;
	bh=HJPnJ9eu0kyTcLcp33I81raSy+7gG0mEr1aX2nKrlRo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MIA2atsxV+IbMWxlYCNUhb94HHexQhj9LTA8w2X2l3VjYOH2fHQijDdARIbbjGLSpRYJ6LtKyjZi7h7RrDNiUfaMysIt93Sq0xCaMOLsqslNtlmRKDpXYJ3qxkfIiwpt/fgoqyYo525ZJ5nqTHWjvYEzpU+7IeHfmoHL3x+lThk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CYgj5HUe; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CYgj5HUe"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 141F71A2C2D;
	Thu,  5 Feb 2026 15:48:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C871C6074D;
	Thu,  5 Feb 2026 15:48:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 46527119A865B;
	Thu,  5 Feb 2026 16:48:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770306526; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=zrAc5w0PG3JDItEYuR8KISBaKOhhMORkmCkekqY+adU=;
	b=CYgj5HUe+584jFnaZ9D3XtM+DG7J8wB5C0FKdRCHCSLM+vTp+07qP1p0Sv2AlHKQP455uy
	RDUtCdC3DeL0LfxcDY9rgkonWKJk8KftcRWZnDdUQHcBJiSlZVeVsx11xcU4s+WwG91nLH
	og5SndEI0AEQIvdeaHvKZHYB4c4FgCcKRvhWwfrAAq897jhbnhM65C9tWwaqiU/vcCJ7M4
	/YnZB6T8hCHf4oldNZmo2kp91Chc5pEhPCINOn1DDh7tfWfOJk/Hs0idU+W94eopy5aBLH
	1spAT3krtRKSi2KMQr1HEnYCDKsl+kYgDVvdi+GZ+xPnK7nQT5OgdVbyxnpGvQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Santhosh Kumar K <s-k6@ti.com>
Cc: <broonie@kernel.org>,  <robh@kernel.org>,  <krzk+dt@kernel.org>,
  <conor+dt@kernel.org>,  <richard@nod.at>,  <vigneshr@ti.com>,
  <tudor.ambarus@linaro.org>,  <pratyush@kernel.org>,  <mwalle@kernel.org>,
  <linux-spi@vger.kernel.org>,  <devicetree@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  <linux-mtd@lists.infradead.org>,
  <praneeth@ti.com>,  <u-kumar1@ti.com>,  <p-mantena@ti.com>,
  <a-dutta@ti.com>
Subject: Re: [RFC PATCH v2 00/12] spi: cadence-quadspi: add PHY tuning support
In-Reply-To: <87343ghkek.fsf@bootlin.com> (Miquel Raynal's message of "Wed, 04
	Feb 2026 11:29:07 +0100")
References: <20260113141617.1905039-1-s-k6@ti.com>
	<87343ghkek.fsf@bootlin.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Thu, 05 Feb 2026 16:48:42 +0100
Message-ID: <87v7gbdwdh.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi Santhosh,

> I am surprised by these numbers, I would expect these to get higher for
> SPI NANDs. I will test the series and report my observations, especially
> since there is also ODDR SPI NAND support now (in nand/next, should be
> part of my upcoming merge request to Linus for 6.19+1);

I just tested the series, here are some numbers I grabbed on TI AM62A7
LP SK with a Winbond W35N02 SPI NAND chip (so in the end very close to
your report):

 +-----------------+-----------+------------+
 | SPI NAND        | no tuning | PHY tuning |
 | Unit: MiB/s     |   25MHz   |   166MHz   |
 |-----------------+-----------+------------|=20=20=20=20=20=20=20=20=20=20=
=20
 | Octal SDR read  |   13.8    |    34.2    |
 |           write |    7.2    |    10.2    |
 |-----------------+-----------+------------|
 | Octal DTR read  |   21.2    |     N/A    |
 |           write |    9.0    |     N/A    |
 +-----------------+-----------+------------+

Please mind I used MiB/s and not MB/s (so kiB / 1024), I don't know
which one you used for measuring, as you marked MB, whereas the most
common unit seems to be MiB.

However PHY tuning failed in Octal DTR mode (your series applied on top
of nand/next) with the following logs, can you have a look?

[    2.261647] spi-nand spi0.0: Winbond SPI NAND was found.
[    2.266956] spi-nand spi0.0: 128 MiB, block size: 256 KiB, page size: 40=
96, OOB size: 128
[    2.285257] cadence-qspi fc40000.spi: PHY tuning failed: -2
[    2.290835] spi-nand spi0.0: Failed to execute PHY tuning: -2

The fallback worked well though, the memory was still usable like
before, which is a very good point.

Thanks,
Miqu=C3=A8l
