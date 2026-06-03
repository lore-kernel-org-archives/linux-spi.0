Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BB43B585D
	for <linux-spi@vger.kernel.org>; Wed,  3 Jun 2026 15:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780502092; cv=none; b=gwA7WMtP2jdMyH3hZ7rJHx6fxmfbP7/tQYlT8rPHLzeETxfuCE5TVboD4c6aLzzENQTtvCp/jQ8+ZDANnf+JFIvQpoSJ7PKjff1+WPcGz1r7k7L2gZedduNeTa0+gwYO//L+/D6NDl3B/KWleTNf6QjWrA/dfO8hKILxCUzrkZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780502092; c=relaxed/simple;
	bh=Lo6IT/7MpBt7kiejYK9XQhaa0DR0JIClmkz8iuTUcIk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TKKT7/O3OfXiuyWB46W3y2HRkh0pmbgaD8jjQ2+xNwSTFAlyrO8nCbtkg+EtGU87L8AJus1p8qwjWcLB2ro20x9FnM9+BFKJ9ghJjuCFwhkzpX67G1L3yWibAPRYncx7B01nDsWKqkjhbPRNabnPezPn9jNN5KTqRGUGCiCJN2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gzDMRG/9; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gzDMRG/9"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 677441A011B;
	Wed,  3 Jun 2026 15:54:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 385655FA0A;
	Wed,  3 Jun 2026 15:54:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 95B8810888CC6;
	Wed,  3 Jun 2026 17:54:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780502087; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Lo6IT/7MpBt7kiejYK9XQhaa0DR0JIClmkz8iuTUcIk=;
	b=gzDMRG/9vrsqa1QELcLPHb5nfVqmtUFHd7BrAubSVkCUDkjACpsbUZF7DLhs6dJ3JYktG0
	loDp97FTQe/AB9xWzlISl1MyDrpZZPy5fz0kCg1nR4xXt6sbxG6gkxupnv67R7l3WZTQ3F
	mONARMYljzes5oZ90fSFU5Zy3CsKr+UZqIkcel8UyUW/5HTrEZl7pWMm967Kw6RRofldym
	0W3yKHiaq1TeU5UkRg70GcIATNhn+rzyc+HnoAM9eU18Y0uSaWFwfpt2yDMztyGVDNdj5y
	t16++dLC28TjSVIQLd74+VLV5uFuAdqAd2XGTz36oFleMMPqdqP1m4Vgnc28jg==
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
In-Reply-To: <20260602-aptly-bunkbed-1bd3a8d63d54@spud> (Conor Dooley's
	message of "Tue, 2 Jun 2026 17:18:15 +0100")
References: <20260527175527.2247679-1-s-k6@ti.com>
	<20260527175527.2247679-2-s-k6@ti.com>
	<20260528-clergyman-kindling-20971775ba78@spud>
	<eaa75113-2b89-468d-aca8-932bc7e33a7d@ti.com>
	<87cxy92llq.fsf@bootlin.com>
	<20260602-aptly-bunkbed-1bd3a8d63d54@spud>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Wed, 03 Jun 2026 17:54:41 +0200
Message-ID: <875x3zzkji.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi Conor,

On 02/06/2026 at 17:18:15 +01, Conor Dooley <conor@kernel.org> wrote:

> On Tue, Jun 02, 2026 at 02:05:53PM +0200, Miquel Raynal wrote:
>> Hello Conor, Santhosh,
>>=20
>> >> I also don't get the point of this property, why can't you just set
>> >> the
>> >> max that the device can do and if the controller can configure itself=
 to
>> >> be fast enough it will do so, and if it can't then it'll pick whatever
>> >> the fastest it can actually do instead?
>>=20
>> If I may, this is not doable because there is always a phase at low
>> speed. By low speed, I mean the speed which allows reliable data
>> transfers between the host and the device. This "maximum low" speed is
>> non discoverable, it is necessary to describe it. As of today, it is
>> widely used (and I believe for good reasons) and covers 99.99% of the
>> use cases.
>>=20
>> >> Seems like you're abusing a peripheral property to encode information
>> >> about the controller.
>> >
>> > The controller-side approach you mentioned is similar to what I had in
>> > v2, where a compatible-specific base_freq is used for non-PHY ops.
>> >
>> > Miquel,
>> >
>> > I think we should revert to the v2 approach.
>> >
>> > The non-PHY frequency is a controller limitation/capability rather than
>> > a flash characteristic, so it seems more appropriate to keep it in the
>> > controller driver as Conor suggested.
>>=20
>> The non tuned frequency is the maximum frequency one could use
>> reliably. It is not controller specific. It is mostly board specific,
>> and to some extend may also be chip specific.
>>=20
>> The tuned frequency is the maximum frequency one could use reliably
>> after line a controller or chip specific training procedure. It is
>> also the result of an aggregated set of non discoverable hardware
>> limitations:
>> - board routing
>> - chip capability
>> - controller capability
>
> Right, and this I guess is what scuppers letting the controller driver
> sort the configuration out itself and leaving the property as-is.
> It could be that the speed in spi-max-frequency is lower than the "base
> speed" of the controller but because of board routing or device
> capability that the tuned mode is still required, right?

I do not actually expect any tuned mode/frequency to be mandatory.
What Santhosh calls the base speed is typically what we have today, so
the best of what we can do without any line training. spi-max-frequency
expresses exactly this today.

>> We must try to think about other (non TI) possible use cases of these
>> properties and also take into account the existing DT expectations. If
>> turning the property into an array is too complex, we may go for a
>
> I don't think it is "too complex", but it requires removing the
> definitions of spi-max-frequency from the 4 or 5 bindings that redefine
> it and making a mechanical change to all spi device bindings that
> specify a limit. It's not complex, but it will be annoying without
> tooling doing it for you.

Indeed.

>> second property, but I believe the name should not be TI specific (but
>> I'll let the final decision to the DT gurus).
>
> Yeah, I concur. If not doing the 2 cell spi-max-frequency, then
> something like spi-max-post-tuning-frequency or w/e I think should be
> used. Doesn't seem like TI would be the only people that end up doing
> something like this.

Why not. Might be simpler approach from a binding side, while also
rather easy to work with in the spi core.

Thanks,
Miqu=C3=A8l
