Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37A1426EAA;
	Wed,  3 Jun 2026 16:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780504179; cv=none; b=rXXnBHqEPI3d/oPQj+SWt7qLBAcSy+kGPwPYn6Q+BYZqK+JYs9vIlpNG6ytXP62e11b+Dyaz2tGYt5bdaCgPeC3+k71gBi2RgsLW5hzbJFOle7M82C/psSmu3C+u1aw+4X2sePg+Ii5SjA3mUaGhKlVBFflLW9Na7jowsiKDXM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780504179; c=relaxed/simple;
	bh=evJt7jmzVDi65ASf5TV7iH2Zz3iluscmSfjgvIWeKvo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=feRKmq3PNHzyICNxXQm3iRAieT9/26GR2+hRoExVdy9QZWaUYTD63fiW/+DtGo+EdEaDoc6BGzZbA8hwbwsHDFVNgAopvyXspL9zpW0r9lYDcBEk9Wp9MuypYfK+A9KRDKocyDLh/l3Rq/ZF47rfU7rKvbaGewSfuIVsf57jOZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=j0+LeAkK; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="j0+LeAkK"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 15949C63443;
	Wed,  3 Jun 2026 16:29:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E53485FA0A;
	Wed,  3 Jun 2026 16:29:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B54DB10888CCF;
	Wed,  3 Jun 2026 18:29:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780504172; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=evJt7jmzVDi65ASf5TV7iH2Zz3iluscmSfjgvIWeKvo=;
	b=j0+LeAkK88BbWrccUSUayANR5ESpZBgsiz/KRZIKU/qnUFp7VrLXTMIRxvkSG8haI5oJPp
	+FiKfGoDdHHpQ5rWPYhHIObzT7sLN+ghTk3GGk5YD1GxgddcjdX8LNk6XR3jIklJMxrz++
	sO3TPVXrKTsAlRZBcngPPo/HwdisCGHSCyxebtrWqhjY0O8gDQMB5fgzdNjQzmJOeRpHUB
	Abfq6u9XCz+NxpxkAI7mmWw9yalVcEk06S1VssIK2Q3FqJUN9B1ixeiv5UroML0g41TYQP
	yQTCHj4GUrRzmsxkQQM1BX+MATmUP5PmvN7ObRmh+PJe6F2wn5NKd9Ed0C+QSQ==
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
In-Reply-To: <20260603-neatly-twine-e89b923f5cb6@spud> (Conor Dooley's message
	of "Wed, 3 Jun 2026 17:07:21 +0100")
References: <20260527175527.2247679-1-s-k6@ti.com>
	<20260527175527.2247679-2-s-k6@ti.com>
	<20260528-clergyman-kindling-20971775ba78@spud>
	<eaa75113-2b89-468d-aca8-932bc7e33a7d@ti.com>
	<87cxy92llq.fsf@bootlin.com>
	<20260602-aptly-bunkbed-1bd3a8d63d54@spud>
	<875x3zzkji.fsf@bootlin.com> <20260603-neatly-twine-e89b923f5cb6@spud>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Wed, 03 Jun 2026 18:29:27 +0200
Message-ID: <87o6hry4d4.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3


>> >> > The non-PHY frequency is a controller limitation/capability rather =
than
>> >> > a flash characteristic, so it seems more appropriate to keep it in =
the
>> >> > controller driver as Conor suggested.
>> >>=20
>> >> The non tuned frequency is the maximum frequency one could use
>> >> reliably. It is not controller specific. It is mostly board specific,
>> >> and to some extend may also be chip specific.
>> >>=20
>> >> The tuned frequency is the maximum frequency one could use reliably
>> >> after line a controller or chip specific training procedure. It is
>> >> also the result of an aggregated set of non discoverable hardware
>> >> limitations:
>> >> - board routing
>> >> - chip capability
>> >> - controller capability
>> >
>> > Right, and this I guess is what scuppers letting the controller driver
>> > sort the configuration out itself and leaving the property as-is.
>> > It could be that the speed in spi-max-frequency is lower than the "base
>> > speed" of the controller but because of board routing or device
>> > capability that the tuned mode is still required, right?
>>=20
>> I do not actually expect any tuned mode/frequency to be mandatory.
>
> I think you misunderstood my use of "required", I meant that the new
> property/information was needed in the scenario I described, not that it
> should be a required property in a binding.

Yes I misunderstood the term indeed. However I still fail to catch what
you meant here, I'm sorry. Would you mind rephrasing?

Just to clarify, tuned modes are only bonuses.

Miqu=C3=A8l
