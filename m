Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99193806D2;
	Mon,  5 Oct 2026 08:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791188601; cv=none; b=RpHdgWdI+gwEvw5biG044kbheimkjuQ2hgix8fb0ucAgs+EvVmbzuFUFe+KEzLkGrbXi1NDb2YDqOkYsjEUBlGbGqe1Sj1ypKGwVmvijbMsb0l7ubShmH8zZVbcI8Y4mblx76JaQ9B1zmmLS7bZ2HM0hBx3apsHMoMWl2howPQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791188601; c=relaxed/simple;
	bh=DmDo/eXuu0Vq6kXaezgnv12eQiz1QsKS4zjwCzOqRgY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pe7czaN8EZOFGg+UyEZo6uxmO5oie6f2JwxOyie7gAwYmgAo1q4hUBUFsUvzhzK4AmsvVADW9XoRY62Ja8ondDSbb66LiDr7NDHs9yYLdtf09KOmsDU6IuoXre2AmMz8D0IiTiGVu7CD3CaqQF5NNlFsO5P57EIIgOMtK7EbByc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OWy4Gupn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OWy4Gupn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BFFB1F00893;
	Mon,  5 Oct 2026 08:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791188600;
	bh=JXtmNkDO/zngR307i5pw0zwBcB9EHK5hI5rUTmwK4BE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OWy4GupnZgQTGwrkD8RIOQL7DCeuTNOFfU9icdRm7OLmwJ3ziuRjTlb5+IJGNko6M
	 F6CpyrF1S8VhCH1VRnWP/Q1sgg+FfE/C/idCYZXfFQemlk0ZNNQb9w5Z0Q/JpNC8UW
	 pXbQfl/g6rwB7t8TgeK2Ebqj4KYnzUnT+7xNpDz3P8ZWnmWPCmNeyTqh5ZctJK56z0
	 mfHo8+i2VR5C9el/Z/YcBq5pScvVrByf6cYWGw3i+lEv6uAvRouEdbs3xkN8O7WIu+
	 mOGViERr4XwkSMLbmvrZjIfF1RiNCR/nYi/383U0dNZmH94l0qx7KL+My9MSQcNZ0s
	 UTtAgDtzrWVyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/5] mtd: spi-nor: Add support for panic writes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pratyush Yadav" <pratyush@kernel.org>, "Michael Walle" <mwalle@kernel.org>, "Vignesh
 Raghavendra" <vigneshr@ti.com>, "Miquel Raynal" <miquel.raynal@bootlin.com>, "Richard
 Weinberger" <richard@nod.at>, "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Takahiro
 Kuwano" <takahiro.kuwano@infineon.com>, "Paul Cercueil" <paul.cercueil@bootlin.com>, "Mark
 Brown" <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, "Kees Cook" <kees@kernel.org>, "Tanmay
 Jagdale" <tanmay@marvell.com>, "Tony Luck" <tony.luck@intel.com>, "Guilherme
 G . Piccoli" <gpiccoli@igalia.com>, linux-mtd@lists.infradead.org
In-Reply-To: <20261005081141.33688-3-paul.cercueil@bootlin.com>
References: <20261005081141.33688-1-paul.cercueil@bootlin.com>
 <20261005081141.33688-3-paul.cercueil@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 08:23:19 +0000
Message-Id: <20261005082319.7BFFB1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] mtd: spi-nor: infinite loop in panic write timeout via jiffies
- [High] mtd: spi-nor: panic write ignores ongoing_pe causing hardware conf=
lict
- [High] mtd: spi-nor: sleep in atomic context during panic write
--

commit 6866cee3049043ab91dbf3b45f823a4010bb97cc
Author: Tanmay Jagdale <tanmay@marvell.com>

mtd: spi-nor: Add support for panic writes

This commit adds support for panic writes to the SPI NOR framework. It
plumbs the oops_panic_write flag through to the SPI controllers,
avoiding mutexes and blocking calls when preemption and IRQs are
disabled.

> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c

[ ... ]

> @@ -729,7 +738,10 @@ static int spi_nor_wait_till_ready_with_timeout(stru=
ct spi_nor *nor,
>  		if (ret)
>  			return 0;
> =20
> -		cond_resched();
> +		if (nor->mtd.oops_panic_write)
> +			cpu_relax();

[Severity: High]
In spi_nor_wait_till_ready_with_timeout(), the loop condition relies on:

if (time_after_eq(jiffies, deadline))

Since jiffies does not advance in a panic context because local IRQs are
disabled, does this mean the system will hang indefinitely during a panic
if the flash chip takes time to complete or becomes unresponsive?

> +		else
> +			cond_resched();
>  	}

[ ... ]

> @@ -3393,6 +3429,26 @@ static void spi_nor_soft_reset(struct spi_nor *nor)
>  	usleep_range(SPI_NOR_SRST_SLEEP_MIN, SPI_NOR_SRST_SLEEP_MAX);
>  }
> =20
> +static int spi_nor_panic_write(struct mtd_info *mtd, loff_t to, size_t l=
en,
> +			       size_t *retlen, const u_char *buf)
> +{
> +	struct spi_nor *nor =3D mtd_to_spi_nor(mtd);
> +
> +	/*
> +	 * At this point preemption and local interrupts are disabled, so we
> +	 * can't get the lock if it's taken.
> +	 */
> +	if (mutex_is_locked(&nor->lock))
> +		return -EPERM;
> +
> +	if (spi_nor_use_parallel_locking(nor) &&
> +	    (nor->rww.ongoing_io || nor->rww.ongoing_rd)) {
> +		return -EPERM;
> +	}

[Severity: High]
Does this omit checking nor->rww.ongoing_pe?

If a panic occurs while a long-running erase or program operation is in
progress, ongoing_pe will be true. If the lock was released during the
parallel hardware operation, the panic write might proceed and send write
commands while the hardware write in progress bit is set.

The hardware will ignore the commands, but the software will loop in
spi_nor_wait_till_ready() until the original operation finishes, incorrectly
assuming the panic dump was successfully written.

> +
> +	return spi_nor_write(mtd, to, len, retlen, buf);

[Severity: High]
Can this sequence lead to a sleep-in-atomic bug?

spi_nor_write() can call down to spi_nor_octal_dtr_write() which does a
sleepable memory allocation when unaligned addresses are passed:

tmp_buf =3D kmalloc(nor->params->page_size, GFP_KERNEL);

Additionally, the write eventually reaches spi_mem_exec_op() and then
spi_mem_access_start(), which unconditionally takes mutexes:

mutex_lock(&ctlr->bus_lock_mutex);
mutex_lock(&ctlr->io_mutex);

Since mtd->_panic_write operates with local IRQs and preemption disabled,
would these paths cause a recursive panic and completely halt the crash
dump process?

> +}
> +
>  /* mtd suspend handler */
>  static int spi_nor_suspend(struct mtd_info *mtd)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005081141.3368=
8-1-paul.cercueil@bootlin.com?part=3D2
