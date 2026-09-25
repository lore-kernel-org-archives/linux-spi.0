Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC01249CF36;
	Fri, 25 Sep 2026 12:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790341168; cv=none; b=gCbIwi7pkOrVVrgqsL+cVM0WHBtVxX2gQRbJXZnTVvzxMlpmNZxsfaO3n4lJCDo7T8K1+4tqzb0ZiiOsqAYKTm4wotCI8sKj2tgZGEsx2JX8WvnsspbgrriB22+6peaiUioybP8r8ZTP2JzWvI3B2We+/jBU3CSZi9wFMxl1sQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790341168; c=relaxed/simple;
	bh=jD7DCDWYh+jLuvotd+NDLBJYOKmNOc7gFTVePNWWUmU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y/uS69KVs7388eH7ilFfIRFJoQWkpWJepaBrJ4GCWfgjYXRt1S7rS43H1kQ2uu0Zz3c0YRbrqFxN2RMy42g7mNFUont4yCpdPKdc0kjdnN6u7C+qR73Tg03x7zjksaPo5A7wjETxTfM8Ao1JXlL4v8krepUblg5/itDpy9D6sbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ikz5Agrn; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ikz5Agrn"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id CE0CEC653DD;
	Fri, 25 Sep 2026 13:00:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id ECE5B6073B;
	Fri, 25 Sep 2026 12:59:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7659810328315;
	Fri, 25 Sep 2026 14:59:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790341163; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=cXDwAxiBTSKjZRTzIZgNXvVQ0JvFUHv4d7U2rZECKwM=;
	b=ikz5AgrncugT3B89sXpN2kBZ/KcUkmFMoIJSFhTkHi3NRFYgw2m6zrlHDFpsfQTGyKVZyp
	db9jsC7Ej2PcRRVfK6EU8et9fliotXha2zkRcQSZvEATr55GFlFEW6DBliru+M8OyNS48s
	GO1rrdzaYKKDJI6lUia24hlSoCj6A+RyiiVMYj3Ho+njqOk0+/2raxg6VbV8gybwwHtzZH
	Bw+extoXwLLZA7B8wEoJpdt3qsihEQyofN3sW9OFbSmQ8IjHk6SHDjHmQj+brM4KWRana2
	zQ1D812zW5D11CsuOMtHQjjEsFhs++5ZRnUWkr9JqfRylPrNyYVIqvbA3Lt7WA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: Nuno =?utf-8?Q?S=C3=A1?= <nuno.sa@analog.com>,  Fei Xie
 <fei.xie@horizon.auto>,  Richard
 Weinberger <richard@nod.at>,  Vignesh Raghavendra <vigneshr@ti.com>,  Rob
 Herring <robh@kernel.org>,  Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>,  Parshuram Thombare
 <pthombar@cadence.com>,  linux-spi@vger.kernel.org,
  linux-mtd@lists.infradead.org,  devicetree@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/4] spi: cadence-xspi: add ACMD support for SPI NAND
In-Reply-To: <85dc596e-4378-4d23-b48e-80053cb5166d@sirena.org.uk> (Mark
	Brown's message of "Fri, 25 Sep 2026 12:59:49 +0100")
References: <20260921093701.1341766-1-fei.xie@horizon.auto>
	<20260921093701.1341766-3-fei.xie@horizon.auto>
	<arFEjzkHGMbecWWV@sirena.co.uk>
	<20260923061211.1608907-1-fei.xie@horizon.auto>
	<67f4e1a4-fc0e-4b2b-b41e-8dbb33227302@sirena.org.uk>
	<87pky1ll4g.fsf@bootlin.com> <arZHjbzUEFhydnHt@nsa>
	<87ecehljdy.fsf@bootlin.com>
	<85dc596e-4378-4d23-b48e-80053cb5166d@sirena.org.uk>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 25 Sep 2026 14:59:15 +0200
Message-ID: <87qzihjxlo.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 25/09/2026 at 12:59:49 +01, Mark Brown <broonie@kernel.org> wrote:

> On Fri, Sep 25, 2026 at 12:23:21PM +0200, Miquel Raynal wrote:
>
>> > As for PROGRAM and ERASE commands I really did not saw any added
>> > value.
>
>> Yes, most of the time is spent in the wait_ready, which is not getting
>> faster with hardware automation.
>
> It might potentially help a heavily loaded system if you can do fewer
> waits, the rest of the tasks running on the system will have more time
> if we're doing fewer waits for interrupts.  Not sure it'd be enough to
> write home about though.

Definitely, but this is already possible, one may implement
ctlr->mem_ops->poll_status. This way the core can leverage the hardware
to perform the polling. It is not directly visible on benchmarks,
because it won't reduce much the wait time, but the system load will
decrease.

Thanks,
Miqu=C3=A8l
