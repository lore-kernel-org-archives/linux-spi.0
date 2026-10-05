Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E4A3839A0;
	Mon,  5 Oct 2026 08:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791188654; cv=none; b=nTyBWaZAMGmbKqxHui0iyOBr3YZRL0SZsvsiDXygq586qcWKA6AyT5LffsG0Lnyk825fVYHB+hWOzWViaSKvkqrf8QCaH1sW6NRU/B9n/dY096tDIUmE5ZLDEQE1fUq9fkw8GfYw7KxMWx88+B5bfEaiFT2frVeXxrmy+jGdKwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791188654; c=relaxed/simple;
	bh=zBX/WOwlmT5IkklqpKt11Xi4EPSm9YxxqALdTG5NVyM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jG2ATNrhOdSZMxkRsrWMlmBbN96H57Iv58Nn6i6RFVPfjQZHRARnvKmOf46ih9+UiME+IK2MQTNZCsm5dvmLQV3ecq6KS4/a8J0avOq+5ANvJx0c0XwkByTzpYKfYjWBkqdBs989NipK7U/Fz92YnBWN1P+ogyK6eBt8VWDTU0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JXI5hjXW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JXI5hjXW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 262381F000FF;
	Mon,  5 Oct 2026 08:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791188652;
	bh=Ir06SkW2fBmZ6iTU9J+gZxFmECKR9OLomFBtlF9+75g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JXI5hjXW7zk4XGtV1VNQJ7mFCNkHrQPKAdvP7Y78uOnoExbpFahvFBxsJ1UiGRTJB
	 IEwmLCDgMc/ZKDCwP2OMpthPXoBywhxDyFCJ8EwuCDj6dQYgKf6acVBGUPq4fC6Sgb
	 QfvbNA4eeHz3UpQtBLRxPj64HwCC/U4+k58yMYidb0kfQzEvGzoX0B4xUsyPEZ+jVN
	 RO5t5C38T7EDhJbyPyYEr6VkFW+6KzNdQWSV4FyzjlfiVUR0oL4hzdmzo8VC4A1/sz
	 CyfNCsn48fTpERD+x41/kbx8mjPJdfuhSGIRNr7h/+q1KTMQTxUNHE4GqUv/d9QiIO
	 1/F6KBy1hHEew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/5] spi: spi-mem: Add support for panic mem writes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pratyush Yadav" <pratyush@kernel.org>, "Michael Walle" <mwalle@kernel.org>, "Richard
 Weinberger" <richard@nod.at>, "Paul Cercueil" <paul.cercueil@bootlin.com>, "Takahiro
 Kuwano" <takahiro.kuwano@infineon.com>, "Vignesh Raghavendra" <vigneshr@ti.com>, "Mark
 Brown" <broonie@kernel.org>, "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Miquel
 Raynal" <miquel.raynal@bootlin.com>
Cc: "Tanmay Jagdale" <tanmay@marvell.com>, "Tony Luck" <tony.luck@intel.com>, "Guilherme
 G . Piccoli" <gpiccoli@igalia.com>, "Kees Cook" <kees@kernel.org>, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org
In-Reply-To: <20261005081141.33688-2-paul.cercueil@bootlin.com>
References: <20261005081141.33688-1-paul.cercueil@bootlin.com>
 <20261005081141.33688-2-paul.cercueil@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 08:24:11 +0000
Message-Id: <20261005082412.262381F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] spi: spi-mem: panic write deadlocks system by calling spi_mem_acce=
ss_start
--

commit be9ac542fea508a1fa056661e5ddb8e23cf4a7c4
Author: Tanmay Jagdale <tanmay@marvell.com>

spi: spi-mem: Add support for panic mem writes

Add a panic_write flag to the controller capabilities. When set, this
indicates the SPI controller can send commands to a connected NOR or NAND
memory in the context of a kernel panic, without sleeping or relying on IRQ=
s.

> diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
> index b94680b60af95..89710f9f555ed 100644
> --- a/drivers/spi/spi-mem.c
> +++ b/drivers/spi/spi-mem.c
> @@ -398,6 +398,31 @@ int spi_mem_exec_op(struct spi_mem *mem, const struc=
t spi_mem_op *op)
>  	u8 *tmpbuf;
>  	int ret;
> =20
> +	if (op->panic_write) {
> +		if (!spi_mem_controller_is_capable(ctlr, panic_write))
> +			return -EOPNOTSUPP;
> +
> +		/*
> +		 * Only support panic writes if we'll go through .exec_op().
> +		 * The regular SPI path (spi_sync(), etc.) explicitly mentions
> +		 * that it can only be used from a context that may sleep, which
> +		 * is not the case on a kernel panic.
> +		 * If this changes in the future, this could be reworked, but
> +		 * for now this will have to do.
> +		 */
> +		if (WARN_ON_ONCE(!ctlr->mem_ops || !ctlr->mem_ops->exec_op))
> +			return -EOPNOTSUPP;
> +
> +		if (spi_get_csgpiod(mem->spi, 0))
> +			return -EPERM;
> +
> +		/* On panic IRQs are disabled so we cannot wait on locks */
> +		if (mutex_is_locked(&ctlr->bus_lock_mutex) ||
> +		    mutex_is_locked(&ctlr->io_mutex)) {
> +			return -EPERM;
> +		}
> +	}

[Severity: High]
Does this unconditionally invoke sleepable operations during a panic write?

If the mutexes are currently unlocked when op->panic_write is true,
spi_mem_exec_op() proceeds and calls spi_mem_access_start():

drivers/spi/spi-mem.c:spi_mem_exec_op() {
    ...
    if (ctlr->mem_ops && ctlr->mem_ops->exec_op && !spi_get_csgpiod(mem->sp=
i, 0)) {
        ret =3D spi_mem_access_start(mem);
    ...
}

spi_mem_access_start() explicitly calls mutex_lock(), which violates atomic
constraints and triggers might_sleep() warnings, and calls
pm_runtime_resume_and_get(), which may sleep.

Additionally, spi_mem_access_start() unconditionally calls spi_flush_queue(=
).
If the SPI message queue is not empty (for example, from an async transfer
queued via spi_async() right before the panic), spi_flush_queue() dequeues
and executes pending regular SPI transfers using the driver standard
callback:

spi_mem_access_start() ->
    spi_flush_queue() ->
        __spi_pump_messages() ->
            .transfer_one_message()

For cadence-xspi (the driver supporting panic writes here), the callback
invokes usleep_range() for polling delays.

Executing usleep_range() or other sleepable wait mechanisms in a panic
context where interrupts and preemption are disabled will result in a
system deadlock, preventing the crash dump or panic logging from
completing.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005081141.3368=
8-1-paul.cercueil@bootlin.com?part=3D1
