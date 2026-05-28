Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5C22F3C26
	for <linux-spi@vger.kernel.org>; Thu, 28 May 2026 09:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779958887; cv=none; b=KZoZeIC/uqxXlyfGnYMrzAIcJsRWLjTKoYROoF8t58EnCeY1lihQqWbULP+tYSe18AJez9PrbhVpgiuKfFab6aNmp+2CJz9BHVtcsfjf89M3Bjmq5gcfB6OCnMzJIboumutED5f9jb5xmg0ENcpgYftLqXHjttB5cs3dWQuXT4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779958887; c=relaxed/simple;
	bh=LGZwHtKXO5QyApO5t/htkExHdKfimHHVJYs7dxPr7Ms=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ikl4a5BehWb8HXRCYNeYjEmNs5+etlm5ndBCflL+9W7XSyr0ScIt4SY3+CpkPnXW7kcMUz7oBaLjCoQ/AR+r1/2246Ga8bdCzyACCYH0FT1XqWd3ty1SajTosSYo5e6tF9HRCabxbyUEq0WOnELAb66dCfGowoNl06H/Wo8S5MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DIRrlmux; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DIRrlmux"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 56F5A1A36FC;
	Thu, 28 May 2026 09:01:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 22BA060495;
	Thu, 28 May 2026 09:01:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B81F110888C9D;
	Thu, 28 May 2026 11:01:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779958883; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=CJpI4CzMT+8wAw7NoB3I1or94sKydUL6L2mKBp4EKXQ=;
	b=DIRrlmuxStj9KBs0JSi48AC0JrPQE/twnav1z4XLSjIajztm7yy1shy7cUOhMQ8NpBPH/S
	1jUK1LKuD3yf2gIauHb/jkxUxTR08HfXpL90lpkhhoo82vyYX4A5KpXkWtVXa4jn1ZLLqH
	e0DhknVWndP/8vboFIjB/Rmc/cCcw4injCAM3z7AEMo2jfpkntYNskpCL+H/VnCD6MrNA5
	dwlivWKG6ljsxB0F5daCKxB9oDMODMFj/fXsiUHoUb4j5EoP9ri4gfaBrHHXOPrNktSBU8
	PYzgr3WrXPXDGhR9o89XHqP456EgMXfxf2dXndriUSA72RkSbNO45KkU8/Q87w==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Santhosh Kumar K <s-k6@ti.com>
Cc: <broonie@kernel.org>,  <robh@kernel.org>,  <krzk+dt@kernel.org>,
  <conor+dt@kernel.org>,  <richard@nod.at>,  <vigneshr@ti.com>,
  <pratyush@kernel.org>,  <mwalle@kernel.org>,
  <takahiro.kuwano@infineon.com>,  <linux-spi@vger.kernel.org>,
  <devicetree@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  <linux-mtd@lists.infradead.org>,  <praneeth@ti.com>,  <u-kumar1@ti.com>,
  <a-dutta@ti.com>
Subject: Re: [PATCH v3 09/13] spi: cadence-quadspi: reject 2-byte-address
 DDR ops on PHY-tunable hardware
In-Reply-To: <20260527175527.2247679-10-s-k6@ti.com> (Santhosh Kumar K.'s
	message of "Wed, 27 May 2026 23:25:23 +0530")
References: <20260527175527.2247679-1-s-k6@ti.com>
	<20260527175527.2247679-10-s-k6@ti.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Thu, 28 May 2026 11:01:19 +0200
Message-ID: <87y0h3gb6o.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 27/05/2026 at 23:25:23 +0530, Santhosh Kumar K <s-k6@ti.com> wrote:

> Erratum i2383 affects the AM654 OSPI controller: in PHY DDR mode,
> operations with a 2-byte address cause an internal state machine to
> mis-compare the transmitted address byte count against 1 instead of 2,
> locking up the address phase. [0]
>
> Add a CQSPI_NO_2BYTE_ADDR_PHY_DDR quirk flag and set it on the am654_ospi
> platform data. In cqspi_supports_mem_op(), when a controller carries this
> quirk and has PHY tuning support, reject DDR operations that use 2-byte
> addressing.
>
> [0] https://www.ti.com/lit/er/sprz544c/sprz544c.pdf
>
> Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
> ---
>  drivers/spi/spi-cadence-quadspi.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-=
quadspi.c
> index 508bc5bc4ab5..72208d376305 100644
> --- a/drivers/spi/spi-cadence-quadspi.c
> +++ b/drivers/spi/spi-cadence-quadspi.c
> @@ -49,6 +49,7 @@ static_assert(CQSPI_MAX_CHIPSELECT <=3D SPI_DEVICE_CS_C=
NT_MAX);
>  #define CQSPI_DISABLE_RUNTIME_PM	BIT(10)
>  #define CQSPI_NO_INDIRECT_MODE		BIT(11)
>  #define CQSPI_HAS_WR_PROTECT		BIT(12)
> +#define CQSPI_NO_2BYTE_ADDR_PHY_DDR	BIT(13)
>=20=20
>  /* Capabilities */
>  #define CQSPI_SUPPORTS_OCTAL		BIT(0)
> @@ -1627,6 +1628,18 @@ static bool cqspi_supports_mem_op(struct spi_mem *=
mem,
>  		if (op->data.nbytes && op->data.buswidth !=3D 8)
>  			return false;
>=20=20
> +		/*
> +		 * Erratum i2383: In PHY DDR mode, 2-byte addressing causes an
> +		 * internal state machine to mis-compare the transmitted
> +		 * address byte count against 1 instead of 2, locking up the
> +		 * address phase. Reject such ops on controllers that need it.
> +		 */
> +		if (cqspi->ddata &&
> +		    (cqspi->ddata->quirks & CQSPI_NO_2BYTE_ADDR_PHY_DDR)) {
> +			if (op->addr.nbytes =3D=3D 2 && cqspi->ddata->execute_tuning)
> +				return false;
> +		}

I don't think this is a valid approach. What we want is to prevent
tuning in octal DTR mode with 2 bytes addressing, instead of preventing
reads/writes in octal DTR modes after tuning. Have you tried on an AM62A LP
SK? I bet probe fails..

The quirk should be handled at the beginning of the tuning procedure, so
we skip tuning entirely in this case.

Thanks,
Miqu=C3=A8l
