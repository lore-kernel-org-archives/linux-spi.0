Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205589;
	b=gC2ccy6FbL24e9Sh5NhJMTAN3PV2Ob9fbWELH3IOAaCtKsr4KQ7fquzTtqlfWsDbqKyk
	 wvWFHkMt6r5lSrYcrbkKlljUxSdo9AOTNJPy1Xm/aOuLqnSLhcOSXmsqoI8RZAnqlQ9bI
	 tdekPm3inndgP12Y6zfk6Z2aGdGGpoSZVT+jzrmb+QozmqILYO9M+O+UjrHee3VxdZhBC
	 0CmVvVqiInqE9QVHAWP3krYZCUw/LzRW55/JgwjphB7QxAgRMTknjnIA0GzLBSngVXPxU
	 6OQ0JbTl9o20qdjGcxWjyAgpJIFe1F+EYf8QQRlQ4EapIbS5uOwVsnJIRTZ8zz+KbJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205589;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Date:Message-ID:
	 MIME-Version:Content-Type:X-Last-TLS-Session-Version;
	bh=d047tn7ZyUAE4CZJF6OwqmbdpCg4ZRFaWnDJv2Xlu+8=;
	b=GpvfjNrzWJwMoY0BaD53rP38nYFMTs7vWXxtHT3iGwLyUiTD8vaWqJJ90oCCx0CQTVRK
	 9+6Nkyg1TaMdECoxht7Ak16993uXHJhKMVgD2lNSNg6xrBdLXktFzUT1JXJPNGE7PevxW
	 c4v6s7Xu2Zo8TmhiH2Nx+11+WZw/4zMwOiyF/ZAzE5wlXJVjU+fhGvEFN2lbhA7RiP5/G
	 sNCrInB1O5nrMK5ecVVc6exM1pj2fc5B0TkedW1LyTrdeg6XdZ3qxS+Gr3NB2R4vKyt8S
	 VdXseuS7meXKNqah4knm9o1q5mpGFKQ2TclbK8nnt6rSNIUcix1KXm6harI0/NBow0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=qCMpHgry;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25937606A32D
	for <linux-spi@vger.kernel.org>; Wed, 28 Oct 2026 16:39:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25937606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=qCMpHgry
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 63874C4FED5;
	Wed, 28 Oct 2026 16:40:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 54A7E60769;
	Wed, 28 Oct 2026 16:39:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C4ABD103290D5;
	Wed, 28 Oct 2026 17:39:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793205580; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=d047tn7ZyUAE4CZJF6OwqmbdpCg4ZRFaWnDJv2Xlu+8=;
	b=qCMpHgryog1vBCpYw2HnRskue6gsLgB9uoaHyNvM0YNItQkxRCo1T8oI+12cGb5oxg6MgS
	EKhcVHkSpJmnXgfq03mwJGrHU6ylLbZNOshuzLyT1eTX31bfoylyj6RjFTeTa91PVNX3uA
	CFDxOIL63kdYVpkQfQtYyg/55KilXBl/VU1++SiVbKEjHIqY3qphAdZqMYGB+2bC8GGbl/
	4MOIDH9pwJEfT7Vdg+fVsuEpQIAxgZ3O10KHXWyo4M32AwlQ2xslc/Y1AAmDKDqMFHMV4q
	LTGC39X7sUZYIBe9gi1HS29LySxXbrl1x144YQZPz+lqRxwlrLlStqOmUUvgtQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Changhuang Liang <changhuang.liang@starfivetech.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Michael Walle
 <mwalle@kernel.org>,  Takahiro Kuwano <takahiro.kuwano@infineon.com>,
  Mark Brown <broonie@kernel.org>,  Richard Weinberger <richard@nod.at>,
  Vignesh Raghavendra <vigneshr@ti.com>,  linux-spi@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2 2/5] spi: dw: Add DDR (Dual Data-Rate) support for
 enhanced SPI mode
In-Reply-To: <20261028121100.79667-3-changhuang.liang@starfivetech.com>
	(Changhuang Liang's message of "Wed, 28 Oct 2026 05:10:57 -0700")
References: <20261028121100.79667-1-changhuang.liang@starfivetech.com>
	<20261028121100.79667-3-changhuang.liang@starfivetech.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 28 Oct 2026 17:39:32 +0100
Message-ID: <87a4nxg4or.fsf@bootlin.com>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-Last-TLS-Session-Version: TLSv1.3

On 28/10/2026 at 05:10:57 -07, Changhuang Liang <changhuang.liang@starfivetech.com> wrote:

> Add support for 1S-xD-xD DDR transfers in the enhanced SPI mode of the
> DW SPI controller, on controllers that have DW_SPI_CAP_DDR.
>
> SPI_CTRLR0.SPI_DDR_EN switches the address, dummy and data phases to
> DDR all together, and it only applies to the Dual/Quad/Octal frame
> formats. So in supports_op() only accept DTR operations where the
> command is sent in STR on one line, the data phase uses two lines or
> more, and the address and dummy phases are DTR on the data lines.
> DDR instruction phase (8D-8D-8D) is not supported for now.
>
> For DDR transfers the dummy phase takes two bits per clock on each
> line, so the wait cycles must be halved. Factor the wait cycle
> calculation into dw_spi_enh_wait_cycles(), so that supports_op() and
> exec_op() use the same value, and refuse dummy phases that are not a
> whole number of clock cycles.
>
> When DDR is enabled, program the DDR_DRIVE_EDGE register. The
> recommended TDE value is SCKDV / 4, clamped to SCKDV / 2 - 1 and to
> the field width. The register is only written when the controller
> supports DDR.
>
> Finally, advertise DTR to the spi-mem layer through a dedicated
> dw_spi_ddr_mem_caps when the controller has DW_SPI_CAP_DDR.
>
> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>

Looks correct to me.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
