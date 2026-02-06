Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106AD30171A
	for <linux-spi@vger.kernel.org>; Fri,  6 Feb 2026 08:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770366461; cv=none; b=f7vm73qx1tKNJXRNOPl+jtV5IJu+Jk6bc0wVeMIF8tDu7K01cE9iZIjsTWC3XxoyJUvmQjVXAr6flZu/kYkMXmPxTpBp9wmZdzh9OmnGj7PsRK3qZLjzIvKSFC1U68aAJ8R4QoKJRkseBq6iAjbZVnuPJqXILxt6hqPGG2sFobw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770366461; c=relaxed/simple;
	bh=vSfvKz3190MDYbEvnmEMFNLWPOV0++lu5jPilm3/UGQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Gl5M7n9Kfu9b2lwihBuqVGBF53MsyP93liAfiQXMJTgZxqn02pXodE+7okdLCSaLY6/8ARntDubXpyVpijGVlIzJxLpGATfhUmTltZs5WbIuxsyknLKUz19PCKVCxaCmHpkKfL8EeiieVPFPQ0eDoLbCOg1dpZ7s0idowSjcj6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=J3cwqmnO; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="J3cwqmnO"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 7928C1A2C4E;
	Fri,  6 Feb 2026 08:27:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4DBB460729;
	Fri,  6 Feb 2026 08:27:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 19EB9119D16FF;
	Fri,  6 Feb 2026 09:27:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770366458; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=vSfvKz3190MDYbEvnmEMFNLWPOV0++lu5jPilm3/UGQ=;
	b=J3cwqmnO3X/9LlKlsIcIe0v7S3wXQOCcJMUPZFtvz7I+Ko3ld1laW1s692x8J202otMQbL
	WBCrC4fxKA14dGWo3e0gJWO9bCLQv47hxxpfq2EM67FuSJIEtW7UnMFHF7VpDpJwTlDDpi
	QDAqkPyPS7XS9jEtD7AlIlGdbqPf8ERtTp3eHr50CamayGSm4aA3yT9UduZ7xXb4Vb371i
	sBTxafYLOApJ9f9VbP4iWdvuHPp5qmo3PZ/EOj+8NTpCnFpsxH+BYAsTcbB1/VwgkFrPmz
	OOWLJiE+Fglv3muSDf9EuFYcmN/bGFo9oV8VbH76eoIMERQXoGrFBScUgbm8QA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
  praneeth@ti.com,  u-kumar1@ti.com,  p-mantena@ti.com,  a-dutta@ti.com,
  s-k6@ti.com,  linux-spi@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-mtd@lists.infradead.org
Subject: Re: [PATCH RFC 1/4] spi: spi-mem: Flag DQS capability
In-Reply-To: <9aaeca54-292a-42f7-90d6-a533ff1f5022@sirena.org.uk> (Mark
	Brown's message of "Thu, 5 Feb 2026 19:11:45 +0000")
References: <20260205-winbond-nand-next-phy-tuning-v1-0-5e7d3976f0f1@bootlin.com>
	<20260205-winbond-nand-next-phy-tuning-v1-1-5e7d3976f0f1@bootlin.com>
	<9aaeca54-292a-42f7-90d6-a533ff1f5022@sirena.org.uk>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Fri, 06 Feb 2026 09:27:34 +0100
Message-ID: <874inuff9l.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 05/02/2026 at 19:11:45 GMT, Mark Brown <broonie@kernel.org> wrote:

> On Thu, Feb 05, 2026 at 08:06:58PM +0100, Miquel Raynal wrote:
>> DQS is a typical SPI memory signal used to help with reading the data on
>> the bus at high speeds (especially in DTR mode) by avoiding clock
>> skews. The chip generates a clock signal synchronized with its data
>> output fronts, also called data strobe.
>
> Acked-by: Mark Brown <broonie@kernel.org>
>
> This seems fine if the rest of the series is fine; if people like this
> approach then it's probably sensible to merge along with the MTD patches
> using it and then send me a tag with the SPI bit for me to apply the
> SPI driver changes.

For sure. This is a prerequisite for Santhosh's SPI tuning series, so if
we go that way, I will merge that bit and offer an immutable tag with
the spi-mem and mtd patches as you proposed.

Thanks,
Miqu=C3=A8l
