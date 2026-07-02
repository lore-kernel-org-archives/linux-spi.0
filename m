Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FAA31326C
	for <linux-spi@vger.kernel.org>; Thu,  2 Jul 2026 13:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782999347; cv=none; b=QUV1nYZ9FEVSIdXxhb0hQ4oRC0SA8jKX8ZHODvl1odAaFhFqTkAq+aKBy6v73iCzSVy+gF6GPMGyUoCVRy/Q6rlmthZz22xIj3Qc+ez/RtgFgHWETIc8K6yVaRgAz6ozOK6lm8wUprqTYJ6k2VUlJ5e2scuq3S8Oip5F3/0dbFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782999347; c=relaxed/simple;
	bh=eTs0mhGl/SeBIYNMIXqeKsF9rqOKc8GWF9ed4Q0P7SA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DkaXDOGybmJck0NorgHXEsjoAqOEwEJwDkVP4RJ0ocN9I6mDTGmpd0nswZxlzqsFegulIkyr2xKnDeFp20GZka+JeOdBuAp98FyupHtg4+OhzcambrYIJwQq9lyoYtVCX2JLfNlfFHa/z30ZiNqcvOOBvMoqvvAnvC7ZYhmhw4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=zdN+vbMM; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="zdN+vbMM"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 6994C4E40C32;
	Thu,  2 Jul 2026 13:35:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3610F5FF03;
	Thu,  2 Jul 2026 13:35:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 191A5104C956E;
	Thu,  2 Jul 2026 15:35:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782999343; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=CBdRz6iknUEQ47UfMkZ0PQpUwrts4qpKzRp1pEV7AME=;
	b=zdN+vbMM5MPZgJ+2UNvTPZ0nQf0Y1tOm9dt6c/LG228i69OQuglY4DQzck9+oFL6LWGu2p
	cmBD5tQnTR26dWpfmYVmBa5gXC+4Oy/jDqbn95jmWZNDOCwL3ipXX+zn+A1JB/KGp5qZJ9
	+wW+Unv/8QTNtLMp8NuqbP8DEDB1k6NV+QHxUkjjW2N4tko0fbYBMMRrfLG2B+43ro6zMt
	iSrRiWfbRfJzAbtZMYV20AgmCgm0IfIYsEQ/Q9oQ9ttlwgO0JHJRfv8DNIjvf/8lnIF6gh
	iKXSD0B2Hj1kHz+M2Er7NWFg9N2aYXmt2J59oiY2o1JfPRzLjcSMv8yhog8mXA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Santhosh Kumar K <s-k6@ti.com>
Cc: <broonie@kernel.org>,  <robh@kernel.org>,  <krzk+dt@kernel.org>,
  <conor+dt@kernel.org>,  <richard@nod.at>,  <vigneshr@ti.com>,
  <pratyush@kernel.org>,  <mwalle@kernel.org>,
  <takahiro.kuwano@infineon.com>,  <linux-spi@vger.kernel.org>,
  <devicetree@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  <linux-mtd@lists.infradead.org>,  <praneeth@ti.com>,  <u-kumar1@ti.com>,
  <a-dutta@ti.com>
Subject: Re: [PATCH v4 09/16] spi: cadence-quadspi: skip DDR PHY tuning for
 2-byte-address ops (i2383)
In-Reply-To: <20260618073725.84733-10-s-k6@ti.com> (Santhosh Kumar K.'s
	message of "Thu, 18 Jun 2026 13:07:18 +0530")
References: <20260618073725.84733-1-s-k6@ti.com>
	<20260618073725.84733-10-s-k6@ti.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Thu, 02 Jul 2026 15:35:40 +0200
Message-ID: <871pdlqztf.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 18/06/2026 at 13:07:18 +0530, Santhosh Kumar K <s-k6@ti.com> wrote:

> Erratum i2383 on AM654 locks the address phase in PHY DDR mode when a
> 2-byte column address is used. DDR PHY tuning must not be attempted for
> such operations; non-PHY DDR usage is unaffected. [0]
>
> Add CQSPI_NO_2BYTE_ADDR_PHY_DDR quirk and check it in
> cqspi_am654_ospi_execute_tuning(). When the erratum applies, return 0
> with read_op->max_freq cleared.
>
> [0] https://www.ti.com/lit/er/sprz544c/sprz544c.pdf
>
> Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
> ---
>  drivers/spi/spi-cadence-quadspi.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-=
quadspi.c
> index 72768292a32b..22df5f3bdb96 100644
> --- a/drivers/spi/spi-cadence-quadspi.c
> +++ b/drivers/spi/spi-cadence-quadspi.c
> @@ -49,6 +49,7 @@ static_assert(CQSPI_MAX_CHIPSELECT <=3D SPI_DEVICE_CS_C=
NT_MAX);
>  #define CQSPI_DISABLE_RUNTIME_PM	BIT(10)
>  #define CQSPI_NO_INDIRECT_MODE		BIT(11)
>  #define CQSPI_HAS_WR_PROTECT		BIT(12)
> +#define CQSPI_NO_2BYTE_ADDR_PHY_DDR	BIT(13)

Can we rename the flag to make it more readable? I would propose:

#define CQSPI_NO_PHY_TUNING_WITH_ODDR_2B_ADDR	BIT(13)

Long, but more self explanatory.

Thanks,
Miqu=C3=A8l
