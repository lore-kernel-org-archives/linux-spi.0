Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E222BE033;
	Mon,  5 Oct 2026 08:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791188479; cv=none; b=NoAbJLekuuAORbeZNtL7xInFjgUJkmCt2rZpXAxyjn0k0nx4YAIxKRGJYVN+fJT8Jl3H8mrcPhLT0ljZE4i2Hn+E72RIoa8bcUHdX724mexqH1TQJrWyAHiMJMWHUnujtUjLWY7Ph8vhffAa7sQtYkybZk69N486heybLhIF77U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791188479; c=relaxed/simple;
	bh=npM3+cA0q+QeJUr+douMJJ4JVbTbXucb6thhFs04TFY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HIrBqUkygPwK8HQ/v5Krdk30lRxE69SIUd+DSOSje22HROL6m9I8aT20YIiRMJPE50PrNqtdDde6NadFeOcwzWLzbW7fHfZNibCc+h1/yzTD1iAMDMxavyg3GLDVm4etM5crCR1C7ae9Sqvhpj0cRH5z4nt2XaVqhlQADTabLXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g7wuFhSX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7wuFhSX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 717511F000FF;
	Mon,  5 Oct 2026 08:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791188478;
	bh=c/G1XSRkKImry3vyKFaUvjIQzmHGHq4zy54WQCT7DR0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g7wuFhSXu0X/70AdYFbtvGM5nhuZJ70Z3jVz1/6fz7uHw8AGjKOY4zS7U1NZc/zP1
	 SABaVCdYbXsyc4GsEU4HquXXkAUCcvVbNU92nfm+9W4a4N6py9dGKT8T2Bi40KkPjt
	 Zi9/Sgd+2ITCWSiEnhpeA4V+wJNtzP/Ha86a/MRv/3qvpk4yDJJ1PhrUrKc+6TAQiK
	 QZI7nXt/oHR62chN/AVRKxMtr+Cq2Q3KdBVmky/xSFbIEDGSMvsspiBOcMYPEwG+zy
	 3DCt5o7oAPpvnPcmv0LW/DTjMOLUSlmo90GhuDJKzbnQi4DDOtItXufpDfNJXhrmcQ
	 DErNeL001FeRA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] spi: cadence-xspi: Don't use infinite timeout in
 register poll
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paul Cercueil" <paul.cercueil@bootlin.com>, "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Mark
 Brown" <broonie@kernel.org>, "Takahiro Kuwano" <takahiro.kuwano@infineon.com>, "Richard
 Weinberger" <richard@nod.at>, "Vignesh Raghavendra" <vigneshr@ti.com>, "Miquel
 Raynal" <miquel.raynal@bootlin.com>, "Michael Walle" <mwalle@kernel.org>, "Pratyush
 Yadav" <pratyush@kernel.org>
Cc: "Kees Cook" <kees@kernel.org>, linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, "Tanmay
 Jagdale" <tanmay@marvell.com>, linux-mtd@lists.infradead.org, "Guilherme G
 . Piccoli" <gpiccoli@igalia.com>, "Tony Luck" <tony.luck@intel.com>
In-Reply-To: <20261005081141.33688-5-paul.cercueil@bootlin.com>
References: <20261005081141.33688-1-paul.cercueil@bootlin.com>
 <20261005081141.33688-5-paul.cercueil@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 08:21:17 +0000
Message-Id: <20261005082117.717511F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] spi: cadence-xspi: deadlock in panic writes due to non-atomic poll=
 macro
--

commit 3f62b2245460c33dcb6fb6615d7fdf03de827776
Author: Tanmay Jagdale <tanmay@marvell.com>

spi: cadence-xspi: Don't use infinite timeout in register poll

The commit modifies the register polling functions to enforce a non-zero
timeout even when the sleep argument is false. This prevents busy-waits from
switching to infinite timeouts. The change anticipates future panic write
handling support.

> diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xsp=
i.c
> index 7cf52bcb05df6..09ed2afbd4af3 100644
> --- a/drivers/spi/spi-cadence-xspi.c
> +++ b/drivers/spi/spi-cadence-xspi.c
> @@ -374,7 +374,7 @@ static bool cdns_xspi_is_stig_ready(struct cdns_xspi_=
dev *cdns_xspi, bool sleep)
>  		ctrl_stat,
>  		((ctrl_stat & BIT(3)) =3D=3D 0),
>  		sleep ? MRVL_XSPI_POLL_DELAY_US : 0,
> -		sleep ? MRVL_XSPI_POLL_TIMEOUT_US : 0);
> +		MRVL_XSPI_POLL_TIMEOUT_US);

[Severity: High]
Does this unconditionally trigger timekeeping functions in panic contexts?

When sleep is false, the panic write handler can deadlock.

The readl_relaxed_poll_timeout() macro expands to poll_timeout_us(), which
unconditionally calls ktime_get() when a non-zero timeout is provided.

In a panic context, timekeeping is suspended.

If a system panic occurs while another CPU holds the timekeeping seqlock
(tk_core.seq) and is stopped, ktime_get() will spin endlessly in
read_seqcount_begin(), deadlocking the system.

This prevents oops/kmsg crash logs from being written to flash, which is why
the <linux/iopoll.h> API contract explicitly forbids using it in atomic
contexts with a non-zero timeout.

To safely poll without sleeping in panic contexts, should the driver
conditionally use readl_relaxed_poll_timeout_atomic(), which relies on
udelay() and cycle counting instead of ktime_get()?

>  }
> =20
>  static bool cdns_xspi_is_sdma_ready(struct cdns_xspi_dev *cdns_xspi, boo=
l sleep)
> @@ -386,7 +386,7 @@ static bool cdns_xspi_is_sdma_ready(struct cdns_xspi_=
dev *cdns_xspi, bool sleep)
>  		ctrl_stat,
>  		(ctrl_stat & CDNS_XSPI_SDMA_TRIGGER),
>  		sleep ? MRVL_XSPI_POLL_DELAY_US : 0,
> -		sleep ? MRVL_XSPI_POLL_TIMEOUT_US : 0);
> +		MRVL_XSPI_POLL_TIMEOUT_US);

[Severity: High]
Can the same deadlock occur in the SDMA polling loop since this also calls
readl_relaxed_poll_timeout() with a non-zero timeout when sleep is false?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005081141.3368=
8-1-paul.cercueil@bootlin.com?part=3D4
