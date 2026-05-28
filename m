Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1663B36C58F
	for <linux-spi@vger.kernel.org>; Thu, 28 May 2026 09:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779960814; cv=none; b=jKQEgxVHOwo9fIsn5U9aGG/HyFK8vbaYRqxZwORDprl8BtVxq/bewL0eLv5ObypV006dCjX3S6gCGw8n+ZkfvPC7iS7hH3CruAzj5Oskd0VSRzw1E+FGCDsrjgaolIeVJtMN6v8XFzJw0+Iuar0bK7EC+tCUaUXRmiDgZkW1zOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779960814; c=relaxed/simple;
	bh=7wBWFmX7A2K5Kn1PWUGG3OttcMWxMxuRHQAzITMWkro=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iWKrLrzuRbTTJhzZKUiSZ/pclT01bJdyuqoPvK9gZmYti0TAk0Hvx1Riirf3LWD38vky+ti6OBjTaD3spob2hhFnBJrK1qcHNZLzAS+KHPUFFCu92EMkJ2bT3q4bDpX1JMV/dZNpWYlwJl1zDwdHmNkMXLO7KkDygIxafcnD9EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GF3u8C2i; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GF3u8C2i"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id AF1B31A3704;
	Thu, 28 May 2026 09:33:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 79A7F60495;
	Thu, 28 May 2026 09:33:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8EE441088805F;
	Thu, 28 May 2026 11:33:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779960809; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=7wBWFmX7A2K5Kn1PWUGG3OttcMWxMxuRHQAzITMWkro=;
	b=GF3u8C2iZBrGmJms36EOr/WK4DYqgLLTjFyoc7YS9Fv5tsyQPYwCnlTWR9T4nS2dwcolYk
	9yshvGHj7seczzL/xclWdmidkK42ZGdldHLQfdvY9WaNuC6Mcg2U8eSucGLAEHyDXzq9UF
	HH5WM0oqtttYL+dIjxFqMqomdSt6k/J1KhXkUelbeDF5EIO7qCKC+8zDoeOTfURsixDRxl
	njPq8w3xujdHyBrZCiXZxw4OMKyTc+YCVw/IJsNE4FizEXN+50atnaKbUZfQ2OdRe6L2K1
	DWwbny8omVGniZzt8sdH4UqqHY3JDQMT10mp5UFehsZYtsPy4kgQr9+rEDaVDA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: "Michael Walle" <mwalle@kernel.org>
Cc: "Frieder Schrempf" <frieder.schrempf@kontron.de>,  "Frieder Schrempf"
 <frieder@fris.de>,  "Mark Brown" <broonie@kernel.org>,  "Richard
 Weinberger" <richard@nod.at>,  "Vignesh Raghavendra" <vigneshr@ti.com>,
  "Han Xu" <han.xu@nxp.com>,  "Eberhard Stoll" <eberhard.stoll@kontron.de>,
  "Tudor Ambarus" <tudor.ambarus@linaro.org>,  "Pratyush Yadav"
 <pratyush@kernel.org>,  <linux-spi@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  <linux-mtd@lists.infradead.org>,
  <imx@lists.linux.dev>,  "Santhosh Kumar K" <s-k6@ti.com>
Subject: Re: [PATCH RFC 6/7] spi: spi-mem: Call spi_set_rx_sampling_point()
 for each op
In-Reply-To: <DHHRLJLX9AVS.CRZTDV7TP1DO@kernel.org> (Michael Walle's message
	of "Wed, 01 Apr 2026 13:00:20 +0200")
References: <20260303-fsl-qspi-rx-sampling-delay-v1-0-9326bbc492d6@kontron.de>
	<20260303-fsl-qspi-rx-sampling-delay-v1-6-9326bbc492d6@kontron.de>
	<87wlzlnioh.fsf@bootlin.com>
	<a1a711c4-d9df-4bba-8831-2ec787f84cc4@kontron.de>
	<87ecl09wtv.fsf@bootlin.com>
	<633fee13-a397-410f-a595-db95e04b8110@kontron.de>
	<87ldf881gr.fsf@bootlin.com>
	<fed5fba7-0536-4f92-8372-f4b47c89b1c2@kontron.de>
	<874ilv84j8.fsf@bootlin.com> <DHHRLJLX9AVS.CRZTDV7TP1DO@kernel.org>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Thu, 28 May 2026 11:33:26 +0200
Message-ID: <875x47g9p5.fsf@bootlin.com>
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

>>> Let's say for a worst case scenario a chip has an RX delay of 20ns (the
>>> highest I've seen in datasheets so far is 8ns). In that case the maximum
>>> clock we could safely use for reading the ID would be 1/(2*20e-9) =3D
>>> 25MHz. Do you think it really makes much of a difference if we read the
>>> ID (only a handful of bytes) at 25MHz or full speed (e. g. 104 MHz)? I
>>> mean this should be fast enough either way, no? But maybe I'm misjudging
>>> this.
>>
>> I am honestly not a big fan of the global penalty, but I am not totally
>> opposed either, especially since you just said you only observed 8ns
>> delays at most. This is 62.5MHz, which is already above what most
>> designs use, so the penalty would be minimal. What about taking this
>> approach and see if that fixes most of our use cases?
>
> What are the actual numbers we are talking about here? I mean, at
> least for SPI NOR, we only read the ID *once*. And it takes about 56
> bits (command + id length of 6). That is about 2us at 25MHz. I'd
> guess the setup and the software handling takes far longer than
> that.

I haven't got the time to resume my SPI NANDs to tests this yet. I
wanted to instrument the code and check the actual impact because we do
several ID reads in SPI NAND. I am still in favour of keeping the
penalty minimal though (see my previous answer) if possible. Frieder,
you are welcome to proceed with a formal follow-up series.

Thanks,
Miqu=C3=A8l
