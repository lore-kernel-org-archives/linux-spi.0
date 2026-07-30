Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99F33C3F68;
	Thu, 30 Jul 2026 07:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785397062; cv=none; b=Qza1CWob4EIS1cIsddB4KvWUaepfcimyhwHRqXMw1+UwCISad91cZoQOoEFGzc/4d6MtsmhdXZ9MWxUNghGx1ou2OMGAfYC6JDlpY5CJjg9VvhiBWdLAZJSXN/sdXCZx9cKKLBGK7581hPyDuRvahKZs+iXteKUBcU0mDjE1Elw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785397062; c=relaxed/simple;
	bh=3KgoRkJyKXAHYdT+xa4fqZCBbSwdt9rddpR33e1hafQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ql9DgPujEW6cWj1uLo++RgcpzGvgG2bU9gpxgkDkjbIa8joibrIkZYkPAVxgqKahtxcU6aHF9378KuG2cP/mPyjqjpSAHJhoBZhHT6lzBSQpvB+XwzxXKw+L/ON4XRWg12654HoaomVoPRWnHvFjyfPNrcSn+6kkQX2jQRz1jc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=qKwKZchp; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="qKwKZchp"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 3941B4E41000;
	Thu, 30 Jul 2026 07:37:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id F2EDE602B8;
	Thu, 30 Jul 2026 07:37:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C673311C15795;
	Thu, 30 Jul 2026 09:37:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785397050; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=3KgoRkJyKXAHYdT+xa4fqZCBbSwdt9rddpR33e1hafQ=;
	b=qKwKZchpTgq3hol1lT602NCULisSa5RdLUXN+3OcNXyRHo+ECkStzLcj68ja9QesW3B+pb
	MFd/Eg9s5bT7td+4kFAyp1mGgXyijBlxuf5bfqoYlEXPSMeb9/OYiI1p8Z1uNrIQPrJ069
	2cBbY/OwP8/RqRgP9YkpWeQObFmGAps3Z6ox97kGUqOOlBcdAPu551iCrvMkSUHBAzq19Z
	hnZ9YjmkVFDjcmMvUX0OitENLt9cObTYahIiO2fhsKvHvp1pL8KadlXSXVKv6XCp+wMH6N
	fRumHlVP7t0UKpwtcFmYALAvMYkIuugenlieOpYY0hf/7uJTANjAG1ASj9Fv4w==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
  praneeth@ti.com,  u-kumar1@ti.com,  p-mantena@ti.com,  a-dutta@ti.com,
  s-k6@ti.com,  linux-spi@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-mtd@lists.infradead.org
Subject: Re: [PATCH RFC 0/4] mtd/spi-mem: Enable DQS support
In-Reply-To: <e2acbded-b8bc-4f45-a852-0abecec45de2@sirena.org.uk> (Mark
	Brown's message of "Thu, 30 Jul 2026 00:29:46 +0100")
References: <20260205-winbond-nand-next-phy-tuning-v1-0-5e7d3976f0f1@bootlin.com>
	<e2acbded-b8bc-4f45-a852-0abecec45de2@sirena.org.uk>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 30 Jul 2026 09:37:25 +0200
Message-ID: <87tsphj5ca.fsf@bootlin.com>
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

>> base-commit: c5884449d02575c7984000eb30d2a2971c7dfcc7
>
> I don't appear to have this commit and this doesn't seem to apply
> against anything I do have, can you please resend at least the first
> patch against my tree or Linus' tree.

Of course, no problem.

Thanks,
Miqu=C3=A8l
