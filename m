Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99E948F84A;
	Fri, 25 Sep 2026 10:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790331815; cv=none; b=qhSXlG6+ApaZyAT9dMxdzF7amngUYq44cSXusKFW2la1YWpaxLy7OL/q0h/0CPmM4Cry5lpTb+CrIu59h0Og43BvA6upsrffU1eYQPk3i0ZoFBQs2MF4irIwBtlpFwoW1AK2HXY4MnXWX4IGf10CLNitfYg4H2UekybDaxUeX5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790331815; c=relaxed/simple;
	bh=W3ofDq4a6rYUY4Czd8wCezviz7X0eedZ6demP0APXwg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=exN10YAKc4lpRMY3HqHJDNuuOdQGBtrZ0Taj0hOqHxh8oaBki+xdIiD2kppPwZ7Ok99IorPv8l3yM9qUnJPdcK7pa9kFKihAW+UlO2rMl8emtdfPb0V3T9qRvAkQQTLO3CwYBKh5clmRtNSejlHa/5JGYdXPBMFIocQBTJ9FGF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XXkwearN; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XXkwearN"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 0D2F04E4106E;
	Fri, 25 Sep 2026 10:23:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CE92C6073B;
	Fri, 25 Sep 2026 10:23:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0AC4B1032959D;
	Fri, 25 Sep 2026 12:23:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790331810; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=3szgY9zm9EvPd+IGHLd9mHO0PhxaT/u5j83BrGfC9yY=;
	b=XXkwearNrO2Owi+No8Tkk9ZXP4+olA6HVlP1/rb1tHjpkYrQ1/5BiHvnB+0CPIHRG+jC/A
	lgYLxJycCtmWfqCGYflng9l+RIv5XfeuZoXcD/+PSKU0/YeS7gXiB/r+nh0D9k0YOxsF7H
	218DJz2HgLAjCJXBx77gf0i+VvaqXjX8fwmETvMb0SYJYGpBuu/IgJOqg5gUZgfsye4c2E
	++enOXuvW8m5c/0aicGbSJqncQoInSu6Xu+f54BTxOkP5uWQ0HJ6P1D51IASgRjvXvZWx4
	MNnRUaE21cw88nGzD44wFF7QNXQLBsYTmSkLq2oLx+2lBcjQUfISPLUYJGKWWA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Nuno =?utf-8?Q?S=C3=A1?= <nuno.sa@analog.com>
Cc: Mark Brown <broonie@kernel.org>,  Fei Xie <fei.xie@horizon.auto>,
  Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Rob Herring <robh@kernel.org>,  Krzysztof Kozlowski
 <krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>,  Parshuram
 Thombare <pthombar@cadence.com>,  linux-spi@vger.kernel.org,
  linux-mtd@lists.infradead.org,  devicetree@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/4] spi: cadence-xspi: add ACMD support for SPI NAND
In-Reply-To: <arZHjbzUEFhydnHt@nsa> ("Nuno =?utf-8?Q?S=C3=A1=22's?= message
 of "Fri, 25 Sep 2026
	11:14:01 +0100")
References: <20260921093701.1341766-1-fei.xie@horizon.auto>
	<20260921093701.1341766-3-fei.xie@horizon.auto>
	<arFEjzkHGMbecWWV@sirena.co.uk>
	<20260923061211.1608907-1-fei.xie@horizon.auto>
	<67f4e1a4-fc0e-4b2b-b41e-8dbb33227302@sirena.org.uk>
	<87pky1ll4g.fsf@bootlin.com> <arZHjbzUEFhydnHt@nsa>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 25 Sep 2026 12:23:21 +0200
Message-ID: <87ecehljdy.fsf@bootlin.com>
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

>> > I think that makes sense, that mirrors some ideas people have had for
>> > optimising SPI mesages in general - submit the sequence to the driver =
to
>> > see if it can do it in one, falling back to just running individual
>> > operations if that doesn't work.  See spi_optimize_message().
>>=20
>> The spi-mem operation-sequence interface seems very complex to handle
>> correctly IMHO. I fear such a solution would also require major rewrites
>> of the core. It is always hard to make fit hardware in code bases not
>> thought for them. Most of the time being spent in I/Os and wait states,
>> I am wondering how much would be saved by packing the commands. Do you
>> have benchmarks?
>
> You can see my replies for a more verbose thing, but the TLDR for me was
> that the gains in performance did not really payed off (vs the
> complexity we would be adding).

That's precisely what I was expecting.

> The real gains
> for me came by using the nand continuous mode so that using ACMD (and
> DMA) so that we can actually ready chunks > page size. Of course this wor=
ks
> for nand chips supporting cont mode (which hopefully newer ones all do).

I am very happy to see this feature being used! It already caused quite
a bit of churn in the core :-)

> As for PROGRAM and ERASE commands I really did not saw any added
> value.

Yes, most of the time is spent in the wait_ready, which is not getting
faster with hardware automation.

> So below is my version of this:
>
> https://github.com/analogdevicesinc/linux/pull/3478/changes/477e609550854=
6552071b825a66522cf697c27c2
>
> I pretty much treat NOR and NAND the same thing. Only when you want to
> do thing like having the controller sending commands itself (or walking
> pages), then knowing about the chip geometry becomes necessary.

Thanks,
Miqu=C3=A8l
