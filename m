Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AF1382289;
	Fri,  5 Jun 2026 06:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780641185; cv=none; b=mlr2Yg8ctLtuT0QeP4bxjSb4+GL14AQ1MyJaLj8hkpQmxZGwdPP1W5Ht+vSePQDH5z9oCWNv1kHvAYI3oYNEol2tpLqGDjF5oMU6F/QHd0GTb76yZ0K6zwd9EXjLKqeH67T1Leu0Roin7XWSmkNOOuUB05kr+pQkOCB1FmTd3tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780641185; c=relaxed/simple;
	bh=oZ+ZvFYXgt3BlDHLx3H6UKrGgUH+GXfiB8/jp4bvNtM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EazN1BqIcCCkXb6715A34hOvHU3JVaLWlLFPX5anbbWOHsP/rVgj68h2rotPur3UimbaxuxSInRT1fajB2bI8Byxd5n/v9KFcMGCLh81G4QNwFuvbuLRAey2Tlb1wrJKI2J0sZMn1UofSqdc0wBhmfWEOkp/qv1+Xcd75419DdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=sH7jIIJW; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="sH7jIIJW"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 7D854C5846E;
	Fri,  5 Jun 2026 06:33:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E41095FED1;
	Fri,  5 Jun 2026 06:33:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9172B106A1D96;
	Fri,  5 Jun 2026 08:32:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780641182; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=oZ+ZvFYXgt3BlDHLx3H6UKrGgUH+GXfiB8/jp4bvNtM=;
	b=sH7jIIJWFPZR4hP+gJQg9HmaSqE1LeB2WEN6Po/fsKY9cA/HNSdDG0U1CgzeUcCesWx90b
	lSCBbKqwsoc9zmbFlWtMDWn4qHzjZXHzfecQeiVqxOIfXx/dOtyaCPHB25uJMMGJSmFmzn
	Qft13lRSJQi8vRmG9Bfg2fuLF/HWp3Dms3fdfUsP+YMydeKnTGwZwRFX9b86yMkphOlM7p
	9x18LnAC/szhbJNdYaqZpyc7DWog5+nX8Eh2NsgnONIUpW5v0+01/3E5Ljjp/HtzAhvIMI
	MtA3y4trl10T711ZDtIOHTAh4oWqLj0RMj4Qd53Pl7BgwXPXKoqtRxzqAwfFkg==
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
In-Reply-To: <20260604-shrunk-acclaim-25368d7ad63e@spud> (Conor Dooley's
	message of "Thu, 4 Jun 2026 09:36:49 +0100")
References: <20260527175527.2247679-2-s-k6@ti.com>
	<20260528-clergyman-kindling-20971775ba78@spud>
	<eaa75113-2b89-468d-aca8-932bc7e33a7d@ti.com>
	<87cxy92llq.fsf@bootlin.com>
	<20260602-aptly-bunkbed-1bd3a8d63d54@spud>
	<875x3zzkji.fsf@bootlin.com> <20260603-neatly-twine-e89b923f5cb6@spud>
	<87o6hry4d4.fsf@bootlin.com>
	<20260603-balance-encounter-94f69e1577f3@spud>
	<87ik7yydyv.fsf@bootlin.com>
	<20260604-shrunk-acclaim-25368d7ad63e@spud>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Fri, 05 Jun 2026 08:32:56 +0200
Message-ID: <87a4t9wl7r.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 04/06/2026 at 09:36:49 +01, Conor Dooley <conor@kernel.org> wrote:

> On Thu, Jun 04, 2026 at 09:14:16AM +0200, Miquel Raynal wrote:
>> Hi Conor,
>>=20
>> >> >> > Right, and this I guess is what scuppers letting the controller =
driver
>> >> >> > sort the configuration out itself and leaving the property as-is.
>> >> >> > It could be that the speed in spi-max-frequency is lower than th=
e "base
>> >> >> > speed" of the controller but because of board routing or device
>> >> >> > capability that the tuned mode is still required, right?
>> >> >>=20
>> >> >> I do not actually expect any tuned mode/frequency to be mandatory.
>> >> >
>> >> > I think you misunderstood my use of "required", I meant that the new
>> >> > property/information was needed in the scenario I described, not th=
at it
>> >> > should be a required property in a binding.
>> >>=20
>> >> Yes I misunderstood the term indeed. However I still fail to catch wh=
at
>> >> you meant here, I'm sorry. Would you mind rephrasing?
>> >
>> > I was talking about a scenario where you want to use the tuned mode to
>> > achieve the maximum rate because of the device and/or board configurat=
ion,
>> > but the rate is below the point where the controller would need tuning.
>> > Say the controller needs tuning above 8 Hz but the conditions require
>> > tuning to achieve more than 5 Hz. In this example, if the device can do
>> > 6 Hz, spi-max-frequency (in the current form) would be set to 6 Hz, and
>> > the controller would not enable the tuned mode, leading to problems
>> > because the inflection point determined from the controller compatible
>> > of 8 Hz would not have been reached.
>>=20
>> I don't think this is a real situation. If the "conditions", as you say
>> (ie. PCB routing, mostly) require tuning above 5, then spi-max-frequency
>> should be 5.
>
> Then tuning mode would never be used.

Well, this is exactly what we propose in this series, a way to indicate
two maximum frequencies, one that just works (like before) and a higher
frequency that is only reachable after an extra tuning procedure.

> Remember, this is a theoretical world
> where spi-max-frequency would contain the tuned frequency and the
> controller was using compatible-specific speed thresholds to determine
> if tuning was required.

That is not what we are proposing. I don't think indicating the "after
tuning" frequency in a property that has long been used for an always
reachable frequency is wise. Hence either the use of an array (the
second entry could contain a higher frequency) or a secondary
spi-max-frequency-whatever property.

Thanks,
Miqu=C3=A8l
