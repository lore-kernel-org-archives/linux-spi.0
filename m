Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DB6391E6D;
	Tue,  2 Jun 2026 12:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780401964; cv=none; b=gp6lXjJAjhxMqcDB57cImTMyf7/hV/1b4za61R19W4/RPOgUriRNV6rpgoOjC+L2loROIExTLl40Bte4XHbIx8BKuC458bz7yJ9kvK8yeGDZQ+pO2YyyHQZRJiAm8I5hOzmAIxJNXn6iM8jSPTHab3oMr4PJQRxFgfk9mQihrcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780401964; c=relaxed/simple;
	bh=owdZim6KsYd46rLD3GD+Jz+Use5sF9LDFtAk9cEMNaM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NvbWPTUxr+sc6G0K3Yk9rCkGDXHA7d1AvIgmHNR+F5IyIJX/HFgy1Aws84rgHifPvkJ6zZPSRYvYyxstMJL1ov1iYBUGYinjzdPmEt0ICf1lGUsG8jpJWbbygdzK9NjDfSKBBvWOSE6s3hfonJkxML+Ox+b41MkgCVnYVnDYnh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WO9str+t; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WO9str+t"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 04B7AC6220A;
	Tue,  2 Jun 2026 12:06:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7DAEB603BC;
	Tue,  2 Jun 2026 12:06:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4434C108883E7;
	Tue,  2 Jun 2026 14:05:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780401959; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=owdZim6KsYd46rLD3GD+Jz+Use5sF9LDFtAk9cEMNaM=;
	b=WO9str+tuV5dWyX5XyfMv+Rspu5G+WZ/YjGP5t6EmZYyVlT+YiLiYFgaD0APLZL/4wOWA1
	X7UG2dvYSp/iFn/zMSxpEmDHpLOqrO44Wfp0fIBl+BK2Qi84TKrT9gZp1BUNi5YVNSvR1G
	GrA45i8bXD2eB7tE39rCVFQQS/3rnboaPQmIaSmTSmwZdJuHiwS02SKZu25duSyjRfx1re
	l8nWfMM+y+NGQudYh+tl2+iyhRFzzzsGUgg89kLbf5kl9KTnmQHpCiyyy+YGxm27GT6Ptn
	UPu9056IVeMWKQvzTHAKX48nXH3ej34MkbgKwtMf1C/UruJJHAL707KzXNOomg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Santhosh Kumar K <s-k6@ti.com>
Cc: Conor Dooley <conor@kernel.org>,  <broonie@kernel.org>,
  <robh@kernel.org>,  <krzk+dt@kernel.org>,  <conor+dt@kernel.org>,
  <richard@nod.at>,  <vigneshr@ti.com>,  <pratyush@kernel.org>,
  <mwalle@kernel.org>,  <takahiro.kuwano@infineon.com>,
  <linux-spi@vger.kernel.org>,  <devicetree@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  <linux-mtd@lists.infradead.org>,
  <praneeth@ti.com>,  <u-kumar1@ti.com>,  <a-dutta@ti.com>
Subject: Re: [PATCH v3 01/13] spi: dt-bindings: allow spi-max-frequency to
 specify a frequency pair
In-Reply-To: <eaa75113-2b89-468d-aca8-932bc7e33a7d@ti.com> (Santhosh Kumar
	K.'s message of "Mon, 1 Jun 2026 13:15:59 +0530")
References: <20260527175527.2247679-1-s-k6@ti.com>
	<20260527175527.2247679-2-s-k6@ti.com>
	<20260528-clergyman-kindling-20971775ba78@spud>
	<eaa75113-2b89-468d-aca8-932bc7e33a7d@ti.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Tue, 02 Jun 2026 14:05:53 +0200
Message-ID: <87cxy92llq.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hello Conor, Santhosh,

>> I also don't get the point of this property, why can't you just set
>> the
>> max that the device can do and if the controller can configure itself to
>> be fast enough it will do so, and if it can't then it'll pick whatever
>> the fastest it can actually do instead?

If I may, this is not doable because there is always a phase at low
speed. By low speed, I mean the speed which allows reliable data
transfers between the host and the device. This "maximum low" speed is
non discoverable, it is necessary to describe it. As of today, it is
widely used (and I believe for good reasons) and covers 99.99% of the
use cases.

>> Seems like you're abusing a peripheral property to encode information
>> about the controller.
>
> The controller-side approach you mentioned is similar to what I had in
> v2, where a compatible-specific base_freq is used for non-PHY ops.
>
> Miquel,
>
> I think we should revert to the v2 approach.
>
> The non-PHY frequency is a controller limitation/capability rather than
> a flash characteristic, so it seems more appropriate to keep it in the
> controller driver as Conor suggested.

The non tuned frequency is the maximum frequency one could use
reliably. It is not controller specific. It is mostly board specific,
and to some extend may also be chip specific.

The tuned frequency is the maximum frequency one could use reliably
after line a controller or chip specific training procedure. It is
also the result of an aggregated set of non discoverable hardware
limitations:
- board routing
- chip capability
- controller capability

We must try to think about other (non TI) possible use cases of these
properties and also take into account the existing DT expectations. If
turning the property into an array is too complex, we may go for a
second property, but I believe the name should not be TI specific (but
I'll let the final decision to the DT gurus).

Thanks,
Miqu=C3=A8l
