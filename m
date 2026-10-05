Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CA1384CCB;
	Mon,  5 Oct 2026 08:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791188649; cv=none; b=kuI3Du6AP8JX6FAJCinRzxpykkk9iSMvYM3xjrgXg2nyqo6jI2II+NjSj5Kk+8FAbFlwGnS+x+1f0iBi9Q+R/3yyNBoEFnVWI7s8yP/dNoax18N6LGcwsJw45oGiyB2IqukyQOHqmPfqL2fgxD0SxjVsyTLLRKhnP3NjrqCO3/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791188649; c=relaxed/simple;
	bh=Q7XM34nLKB4Kz9KD7Xu9z77yAb/LTgwOQCWTAFjxiFs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HPKLqEIgkHWmRQKb2gz5jdpa/WVtbgNZ7pUqbHsY5QePq/u7JUca5kEoH0ObQb+T+YjgQDdPqZgKOb6jCucghGf4tlywMPxKhIgmNI4AgbAg3GFHoaA8PrwxiAQvMD3GdtIRvW8ekCtWquzH7d4aSSW2rnTQT/fQUb7aHpjHgX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nw3TIRcw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nw3TIRcw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D18B81F00898;
	Mon,  5 Oct 2026 08:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791188646;
	bh=mo8jDsq2x/sPYYjNNC4oneZ7ADjFoHWG7Rk3AGCOwAg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Nw3TIRcwrnU05+v7gBFQdKalXqjWShEYCDwx2F5Np5ZiTDq189C5FuX2ak5KYtZY+
	 43HJbDZZeNja8rWVYiIHKZPDIGFHU2Lc3ZzF1qLiq1SxmbuQQRLYZ94a5D9gMrlM3g
	 SeQCTixqzXBBUs17erUY2EETiVsU1+XXwxXN+ALbPjEAgh1cPfJiyRpzGCrCHGQsk5
	 C41UiM3s/HiYmAjfCo7i8dJNSM8uPCFMyeMi5JuMM8FQ77JKEdOAGM2Nig6HKzW+uL
	 PQZcENA8D4jd+9GD2cul1Hoe2uBIrFZs+Kl2T/TIw0Nsa/jyUxTFgrm/5XcUFL7a0y
	 b4xaS6GEPjcBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/5] spi: cadence-xspi: Add irq-less support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pratyush Yadav" <pratyush@kernel.org>, "Vignesh Raghavendra" <vigneshr@ti.com>, "Richard
 Weinberger" <richard@nod.at>, "Takahiro Kuwano" <takahiro.kuwano@infineon.com>, "Paul
 Cercueil" <paul.cercueil@bootlin.com>, "Miquel Raynal" <miquel.raynal@bootlin.com>, "Mark
 Brown" <broonie@kernel.org>, "Michael Walle" <mwalle@kernel.org>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>
Cc: "Tanmay Jagdale" <tanmay@marvell.com>, "Tony Luck" <tony.luck@intel.com>, "Kees
 Cook" <kees@kernel.org>, linux-spi@vger.kernel.org, "Guilherme G . Piccoli" <gpiccoli@igalia.com>, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261005081141.33688-4-paul.cercueil@bootlin.com>
References: <20261005081141.33688-1-paul.cercueil@bootlin.com>
 <20261005081141.33688-4-paul.cercueil@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 08:24:05 +0000
Message-Id: <20261005082405.D18B81F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] spi: cadence-xspi: unhandled interrupt storm in polling mode
- [High] spi: cadence-xspi: SDMA W1C trigger bit not cleared in polling mode
--

commit 85002136114ad45055d6ac972dbcbdf8c8e3d6b2
Author: Tanmay Jagdale <tanmay@marvell.com>

spi: cadence-xspi: Add irq-less support

This commit makes the interrupt line optional. If an interrupt is not
provided, the driver resorts to polling registers. It modifies
cdns_xspi_send_stig_command() and probe functions to handle environments
without a dedicated IRQ.

> diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xsp=
i.c
> index 39c868a5b171c..7cf52bcb05df6 100644
> --- a/drivers/spi/spi-cadence-xspi.c
> +++ b/drivers/spi/spi-cadence-xspi.c
> @@ -365,6 +365,30 @@ static int cdns_xspi_wait_for_controller_idle(struct=
 cdns_xspi_dev *cdns_xspi)
[ ... ]
> +static bool cdns_xspi_is_sdma_ready(struct cdns_xspi_dev *cdns_xspi, boo=
l sleep)
> +{
> +	u32 ctrl_stat;
> +
> +	return !readl_relaxed_poll_timeout
> +		(cdns_xspi->iobase + CDNS_XSPI_INTR_STATUS_REG,
> +		ctrl_stat,
> +		(ctrl_stat & CDNS_XSPI_SDMA_TRIGGER),
> +		sleep ? MRVL_XSPI_POLL_DELAY_US : 0,
> +		sleep ? MRVL_XSPI_POLL_TIMEOUT_US : 0);
> +}

[Severity: High]
Does this leave the W1C (Write-1-to-Clear) trigger bit set?

It appears CDNS_XSPI_INTR_STATUS_REG is a latching W1C register (as seen in
cdns_xspi_irq_handler() which reads and writes back to clear latched events=
).

In polling mode (when irq < 0), this function only reads the register. For
base Cadence hardware, cdns_xspi_set_interrupts() doesn't clear this either.

Could this cause the CDNS_XSPI_SDMA_TRIGGER bit to remain permanently set
after the first SDMA transfer, leading subsequent transfers to falsely see a
ready state and potentially access memory prematurely?

[ ... ]
> @@ -562,16 +586,25 @@ static int cdns_xspi_send_stig_command(struct cdns_=
xspi_dev *cdns_xspi,
> =20
>  		cdns_xspi_trigger_command(cdns_xspi, cmd_regs);
> =20
> -		wait_for_completion(&cdns_xspi->sdma_complete);
> -		if (cdns_xspi->sdma_error) {
> -			cdns_xspi->set_interrupts_handler(cdns_xspi, false);
> +		if (cdns_xspi->irq >=3D 0) {
> +			wait_for_completion(&cdns_xspi->sdma_complete);
> +			if (cdns_xspi->sdma_error) {
> +				cdns_xspi->set_interrupts_handler(cdns_xspi, false);
> +				return -EIO;
> +			}
> +		} else if (!cdns_xspi_is_sdma_ready(cdns_xspi, true)) {
>  			return -EIO;
>  		}
> +
>  		cdns_xspi->sdma_handler(cdns_xspi);
>  	}
> =20
> -	wait_for_completion(&cdns_xspi->cmd_complete);
> -	cdns_xspi->set_interrupts_handler(cdns_xspi, false);
> +	if (cdns_xspi->irq >=3D 0) {
> +		wait_for_completion(&cdns_xspi->cmd_complete);
> +		cdns_xspi->set_interrupts_handler(cdns_xspi, false);
> +	} else if (!cdns_xspi_is_stig_ready(cdns_xspi, true)) {
> +		return -EIO;
> +	}

[Severity: High]
Does this leave hardware interrupts permanently unmasked in polling mode?

At the start of cdns_xspi_send_stig_command(), interrupts are unmasked
unconditionally:

    cdns_xspi->set_interrupts_handler(cdns_xspi, true);

However, when irq < 0, the corresponding teardown call:

    cdns_xspi->set_interrupts_handler(cdns_xspi, false);

is skipped because it is guarded by if (cdns_xspi->irq >=3D 0).=20

If the physical IRQ line is connected or shared, could this cause the
controller to assert it indefinitely, triggering an unhandled interrupt sto=
rm
that forces the kernel to disable the IRQ line?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005081141.3368=
8-1-paul.cercueil@bootlin.com?part=3D3
