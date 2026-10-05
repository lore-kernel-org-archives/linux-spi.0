Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2970F31578E;
	Mon,  5 Oct 2026 08:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791188796; cv=none; b=fTGM/OxZVvgLCiEyr+pn1MzvbkEcoORsMg8+pRvdkVhI+GJObuspFiFHmq2goyvu5dnhy9VXr6DFOJtHvjEdqU9unXgfyOSOrQI3yr4fnHrpbTp47xRXXx5OWo5Vt8WUEcfMVKvYmkHlE/MLYtZ1z7mqTcHGlL6mD/duCwTYbp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791188796; c=relaxed/simple;
	bh=Sn3eYayrOBPCyjo2eZpCtuKeZxDukyJIWkj/nzdogTw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=H9qPnLvP/lLhPT6ALZR67rlGeWfRhP3kb7WV7ZI2ENwaiF+SpYHtruqjc0zDypBvIeaaNxkcZUAufZ/Yd2MHJt+G2QdalGsfdTwf0xD39Auo13CzZfGHXjHD2zjVr0gIJOoAi9u2I7Koagqpm3cVlv6rccH19nrFrIYqB4at7oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YiBcFX9X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YiBcFX9X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1B581F000FF;
	Mon,  5 Oct 2026 08:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791188794;
	bh=xqk28xZRdSDRZtA317ls6P+30aviR4Fq7ab529tSLFY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YiBcFX9XxA1jw2BijSs+c8QvPx4VTAqYHyWThLI0JjYs7Ab/4CDFB4FrpVqOpKfwN
	 JrRZMXlMKsm2rXxJMQxjVeNAwvSX4tlDTDJV0L78OrlCu7lwwJ3tZEuU2osE1fjigx
	 JOFBRUPH4a6R0fvrNEg29YsF85/xR4RpYhXu4QuSMHEhVo/CRsnRZUlZyH3jyEz5LS
	 IcA6AG2/RuXWeNmsbrSyVjTYQ/+COWWxXUN9ckN/VG1EzPxUIaSAaAojJdG3xDcxXc
	 Fpr0JZlJrvFevgSLTfcKFOF/k2TsdUV0S/K6AGYdVc+oXZ79GIyOuK+9UypeS5I938
	 Fl6HQQSX0zqvA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/5] spi: cadence-xspi: Add support for panic writes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Miquel Raynal" <miquel.raynal@bootlin.com>, "Vignesh Raghavendra" <vigneshr@ti.com>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>, "Michael Walle" <mwalle@kernel.org>, "Takahiro
 Kuwano" <takahiro.kuwano@infineon.com>, "Richard Weinberger" <richard@nod.at>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Mark Brown" <broonie@kernel.org>, "Paul
 Cercueil" <paul.cercueil@bootlin.com>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, "Guilherme G .
 Piccoli" <gpiccoli@igalia.com>, "Tony Luck" <tony.luck@intel.com>, "Tanmay
 Jagdale" <tanmay@marvell.com>, linux-mtd@lists.infradead.org, "Kees Cook" <kees@kernel.org>
In-Reply-To: <20261005081141.33688-6-paul.cercueil@bootlin.com>
References: <20261005081141.33688-1-paul.cercueil@bootlin.com>
 <20261005081141.33688-6-paul.cercueil@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 08:26:33 +0000
Message-Id: <20261005082633.F1B581F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] spi: cadence-xspi: missing PHY wakeup in panic write path
- [High] spi: cadence-xspi: deadlock in panic write via ktime_get()
- [High] spi: cadence-xspi: unmasked interrupts leak in polling mode
--

commit 61aacaab4ca9e95d9f29e2f99754ac08cf18616e
Author: Tanmay Jagdale <tanmay@marvell.com>

spi: cadence-xspi: Add support for panic writes
   =20
This commit adds support for panic writes to the Cadence XSPI driver by
checking the panic flag on memory operations. When a panic write is request=
ed,
the driver operates without relying on interrupts or sleeping.

> diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xsp=
i.c
> index 09ed2afbd4af3..0b7162740940f 100644
> --- a/drivers/spi/spi-cadence-xspi.c
> +++ b/drivers/spi/spi-cadence-xspi.c
> @@ -350,10 +350,11 @@ struct cdns_xspi_dev {
>  	void (*set_interrupts_handler)(struct cdns_xspi_dev *cdns_xspi, bool en=
abled);
> =20
>  	bool xfer_in_progress;
> +	bool panic_write;
>  	int current_xfer_qword;
>  };
> =20
> -static int cdns_xspi_wait_for_controller_idle(struct cdns_xspi_dev *cdns=
_xspi)
> +static int cdns_xspi_wait_for_controller_idle(struct cdns_xspi_dev *cdns=
_xspi, bool sleep)
>  {
>  	u32 ctrl_stat;
> =20
> @@ -362,7 +363,7 @@ static int cdns_xspi_wait_for_controller_idle(struct =
cdns_xspi_dev *cdns_xspi)
>  					  ctrl_stat,
>  					  ((ctrl_stat &
>  					    CDNS_XSPI_CTRL_BUSY) =3D=3D 0),
> -					  100, 1000);
> +					  sleep ? 100 : 0, 1000);

[Severity: High]
Does this code cause a deadlock during a kernel panic?

readl_relaxed_poll_timeout() expands to read_poll_timeout(), which evaluates
ktime_get() to enforce the timeout, even when the delay is 0. If another CPU
was halted by an NMI or IPI while holding the write lock for the timekeeping
sequence lock (tk_core.seq) during the panic, calling ktime_get() will hang
the system.

Should this use readl_relaxed_poll_timeout_atomic() instead to avoid
timekeeping functions during a panic?

[ ... ]
> @@ -586,23 +587,23 @@ static int cdns_xspi_send_stig_command(struct cdns_=
xspi_dev *cdns_xspi,
> =20
>  		cdns_xspi_trigger_command(cdns_xspi, cmd_regs);
> =20
> -		if (cdns_xspi->irq >=3D 0) {
> +		if (cdns_xspi->irq >=3D 0 && !op->panic_write) {
>  			wait_for_completion(&cdns_xspi->sdma_complete);
>  			if (cdns_xspi->sdma_error) {
>  				cdns_xspi->set_interrupts_handler(cdns_xspi, false);
>  				return -EIO;
>  			}
> -		} else if (!cdns_xspi_is_sdma_ready(cdns_xspi, true)) {
> +		} else if (!cdns_xspi_is_sdma_ready(cdns_xspi, !op->panic_write)) {
>  			return -EIO;
>  		}
> =20
>  		cdns_xspi->sdma_handler(cdns_xspi);
>  	}
> =20
> -	if (cdns_xspi->irq >=3D 0) {
> +	if (cdns_xspi->irq >=3D 0 && !op->panic_write) {
>  		wait_for_completion(&cdns_xspi->cmd_complete);
>  		cdns_xspi->set_interrupts_handler(cdns_xspi, false);
> -	} else if (!cdns_xspi_is_stig_ready(cdns_xspi, true)) {
> +	} else if (!cdns_xspi_is_stig_ready(cdns_xspi, !op->panic_write)) {
>  		return -EIO;
>  	}

[Severity: High]
Does this leak unmasked interrupts in polling mode?

Earlier in cdns_xspi_send_stig_command(), interrupts are unconditionally
enabled:

    cdns_xspi->set_interrupts_handler(cdns_xspi, true);

If the controller is in polling mode (irq < 0), this code takes the else-if
branch. Whether cdns_xspi_is_stig_ready() succeeds or fails, the function
returns without calling cdns_xspi->set_interrupts_handler(cdns_xspi, false).

Will this cause an unhandled interrupt storm if the hardware IRQ line
is physically shared with other devices?

[ ... ]
> @@ -622,6 +623,8 @@ static int cdns_xspi_mem_op(struct cdns_xspi_dev *cdn=
s_xspi,
>  	if (cdns_xspi->cur_cs !=3D spi_get_chipselect(mem->spi, 0))
>  		cdns_xspi->cur_cs =3D spi_get_chipselect(mem->spi, 0);
> =20
> +	cdns_xspi->panic_write =3D op->panic_write;
> +
>  	return cdns_xspi_send_stig_command(cdns_xspi, op,
>  					   (dir !=3D SPI_MEM_NO_DATA));
>  }

[Severity: High]
Does this entry point fail to wake up the PHY from suspend during a panic
write?

If the system panics while the device is suspended, the controller will
attempt to execute STIG commands while the PHY is still suspended, which
could lead to bus faults or hardware lockups.

Should this path call cdns_xspi_configure_phy() to wake up the PHY before
sending commands during a panic write?

[ ... ]
> @@ -831,9 +834,11 @@ static bool cdns_xspi_is_dll_locked(struct cdns_xspi=
_dev *cdns_xspi)
>  {
>  	u32 dll_lock;
> =20
> +	/* Busy-wait in case we wake up the PHY from suspend to do a panic writ=
e */
>  	return !readl_relaxed_poll_timeout(cdns_xspi->iobase +
>  		CDNS_XSPI_INTR_STATUS_REG,
> -		dll_lock, ((dll_lock & CDNS_XSPI_DLL_LOCK) =3D=3D 1), 10, 10000);
> +		dll_lock, ((dll_lock & CDNS_XSPI_DLL_LOCK) =3D=3D 1),
> +		cdns_xspi->panic_write ? 0 : 10, 10000);
>  }

[Severity: High]
Is this code reachable during a panic write?

The comment indicates this handles waking up the PHY during a panic write.
However, this function is only called from cdns_xspi_configure_phy(), which
is entirely omitted from the cdns_xspi_mem_op() panic write execution path.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005081141.3368=
8-1-paul.cercueil@bootlin.com?part=3D5
