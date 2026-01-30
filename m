Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008692D0601;
	Fri, 30 Jan 2026 10:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769768176; cv=none; b=bqdXwQkiNzg67vRgH8BbFzC8XX5mEoMAMkjx269cn7Y6LwCqMjFoKzVlwRGOr6sfgWfsa0i9gvvtuWwH1ZVkI8ANS2+dSwrrsMsivglInDwi7LmrfWFcaNAjcfR31ugMBRnSamnv9c6eCDf7EWhf8QMc7pBqNUgeDLUILNqsoBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769768176; c=relaxed/simple;
	bh=9f6YWadehBkDdkf5Omkg7B6Z03n6pAURFqAXfV0ZPZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kFVVD1fOuaok9X7ZAUmXAZxory8KSH/2tVIxsINuqjzNMujsj1iEvGQPcQ63N+LGgxJH/fgNK4LSKUQl6D8JoDa7n8fIbTFBOIxaJQGVCkbuByGmgTPaI9eSA4AMi1F1Y52zB0lLlC4QwNrDALlSvPsguRWfiVRfcxJfWU9hkA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eDMOaKI8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eDMOaKI8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F685C19421;
	Fri, 30 Jan 2026 10:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769768175;
	bh=9f6YWadehBkDdkf5Omkg7B6Z03n6pAURFqAXfV0ZPZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eDMOaKI8SP9IULFlykjcKVJqqArq2TPmNeW5zShWNCQIsKdqZuKvNRZCZvKESniAS
	 ADdhrQvyJCD1OFrxE07nBoxdoA26+2eq6YGbp2y21Y2J6M3nhL97SjPwRbbtu1rwBe
	 waJuiJeF18lF43imxRk56/i0GYWEmmiodQTiWYVpHsuyiAzbNXg29uR5Q/bdFVD4Gv
	 4U6thvqkCp1UrRAWX8Ysl+6/s1j1neovVCF/u7h6h7B66AK/NwtuQUpyG0Ytai5JVk
	 qOq4zynuwDDIlDKSbCv5TuRJPaAPfFWDCpUhieI3VFBlOMwT1NCJriT0bY/8UkLgnW
	 KSF6hRiBiiFLQ==
Date: Fri, 30 Jan 2026 11:16:12 +0100
From: Thierry Reding <thierry.reding@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Sowjanya Komatineni <skomatineni@nvidia.com>, 
	Laxman Dewangan <ldewangan@nvidia.com>, Mark Brown <broonie@kernel.org>, Vishwaroop A <va@nvidia.com>, 
	Thierry Reding <treding@nvidia.com>, linux-tegra@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, soto@nvidia.com
Subject: Re: [PATCH v2 0/6] spi: tegra-qspi: Fix race condition causing NULL
 pointer dereference and spurious IRQ
Message-ID: <aXyE1kfP4GeOdYs5@orome>
References: <20260126-tegra_xfer-v2-0-6d2115e4f387@debian.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="efufeesp4va7bbg5"
Content-Disposition: inline
In-Reply-To: <20260126-tegra_xfer-v2-0-6d2115e4f387@debian.org>


--efufeesp4va7bbg5
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 0/6] spi: tegra-qspi: Fix race condition causing NULL
 pointer dereference and spurious IRQ
MIME-Version: 1.0

On Mon, Jan 26, 2026 at 09:50:25AM -0800, Breno Leitao wrote:
> The tegra-quad-spi driver is crashing on some hosts. Analysis revealed
> the following failure sequence:
>=20
> 1) After running for a while, the interrupt gets marked as spurious:
>=20
>     irq 63: nobody cared (try booting with the "irqpoll" option)
>     Disabling IRQ #63
>=20
> 2) The IRQ handler (tegra_qspi_isr_thread->handle_cpu_based_xfer) is
>    responsible for signaling xfer_completion.
>    Once the interrupt is disabled, xfer_completion is never completed, ca=
using
>    transfers to hit the timeout:
>=20
>     WARNING: CPU: 64 PID: 844224 at drivers/spi/spi-tegra210-quad.c:1222 =
tegra_qspi_transfer_one_message+0x7a0/0x9b0
>=20
> 3) The timeout handler completes the transfer:
>=20
>     tegra-qspi NVDA1513:00: QSPI interrupt timeout, but transfer complete
>=20
> 4) Later, the ISR thread finally runs and crashes trying to dereference
>    curr_xfer which the timeout handler already set to NULL:
>=20
>     Unable to handle kernel NULL pointer dereference at virtual address 0=
000000000000008
>     pc : handle_cpu_based_xfer+0x90/0x388 [spi_tegra210_quad]
>     lr : tegra_qspi_handle_timeout+0xb4/0xf0 [spi_tegra210_quad]
>     Call trace:
>       handle_cpu_based_xfer+0x90/0x388 [spi_tegra210_quad] (P)
>=20
> Root cause analysis identified three issues:
>=20
> 1) Race condition on tqspi->curr_xfer
>=20
>    The curr_xfer pointer can change during ISR execution without proper
>    synchronization. The timeout path clears curr_xfer while the ISR
>    thread may still be accessing it.
>=20
>    This is trivially reproducible by decreasing QSPI_DMA_TIMEOUT and
>    adding instrumentation to tegra_qspi_isr_thread() to check curr_xfer
>    at entry and exit - the value changes mid-execution. I've used the
>    following test to reproduce this issue:
>=20
>    https://github.com/leitao/debug/blob/main/arm/tegra/tpm_torture_test.sh
>=20
>    The existing comment in the ISR acknowledges this race but the
>    protection is insufficient:
>=20
>        /*
>         * Occasionally the IRQ thread takes a long time to wake up (usual=
ly
>         * when the CPU that it's running on is excessively busy) and we h=
ave
>         * already reached the timeout before and cleaned up the timed out
>         * transfer. Avoid any processing in that case and bail out early.
>         */
>=20
>    This is bad because tqspi->curr_xfer can just get NULLed
>=20
> 2) Incorrect IRQ_NONE return causing spurious IRQ detection
>=20
>    When the timeout handler processes a transfer before the ISR thread
>    runs, tegra_qspi_isr_thread() returns IRQ_NONE.
>=20
>    After enough IRQ_NONE returns, the kernel marks the interrupt as spuri=
ous
>    and disables it - but these were legitimate interrupts that happened t=
o be
>    processed by the timeout path first.
>=20
>    Interrupt handlers shouldn't return IRQ_NONE, if the driver somehow ha=
ndled
>    the interrupt (!?)
>=20
> 3) Complex locking makes full protection difficult
>=20
>    Ideally the entire tqspi structure would be protected by tqspi->lock,
>    but handle_dma_based_xfer() calls wait_for_completion_interruptible_ti=
meout()
>    which can sleep, preventing the lock from being held across the entire
>    ISR execution.
>=20
>    Usama Arif has some ideas here, and he can share more.
>=20
> This patchset addresses these issues:
>=20
> Return IRQ_HANDLED instead of IRQ_NONE when the timeout path has
> already processed the transfer. Use the QSPI_RDY bit in
> QSPI_TRANS_STATUS (same approach as tegra_qspi_handle_timeout()) to
> distinguish real interrupts from truly spurious ones.
>=20
> Protect curr_xfer access with spinlock everywhere in the code, given
> Interrupt handling can run in parallel with timeout and transfer.
> This prevents the NULL pointer dereference by ensuring curr_xfer cannot
> be cleared while being checked.
>=20
> While this may not provide complete protection for all tqspi fields
> (which might be necessary?!), it fixes the observed crashes and prevents
> the spurious IRQ detection that was disabling the interrupt entirely.
>=20
> This was tested with a simple TPM application, where the TPM lives
> behind the tegra qspi driver:
>=20
> https://github.com/leitao/debug/blob/main/arm/tegra/tpm_torture_test.sh
>=20
> A special thanks for Usama Arif for his help investigating the problem
> and helping with the fixes.
>=20
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
> Changes in v2:
> - Replaced the TODO comment to clarify why the lock is being released.
> - Link to v1: https://patch.msgid.link/20260116-tegra_xfer-v1-0-02d96c790=
619@debian.org
>=20
> ---
> Breno Leitao (6):
>       spi: tegra210-quad: Return IRQ_HANDLED when timeout already process=
ed transfer
>       spi: tegra210-quad: Move curr_xfer read inside spinlock
>       spi: tegra210-quad: Protect curr_xfer assignment in tegra_qspi_setu=
p_transfer_one
>       spi: tegra210-quad: Protect curr_xfer in tegra_qspi_combined_seq_xf=
er
>       spi: tegra210-quad: Protect curr_xfer clearing in tegra_qspi_non_co=
mbined_seq_xfer
>       spi: tegra210-quad: Protect curr_xfer check in IRQ handler
>=20
>  drivers/spi/spi-tegra210-quad.c | 56 +++++++++++++++++++++++++++++++++++=
+++---
>  1 file changed, 52 insertions(+), 4 deletions(-)

For the series:

Acked-by: Thierry Reding <treding@nvidia.com>

--efufeesp4va7bbg5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAml8hOwACgkQ3SOs138+
s6G/zg//RLyg+fKkVXQTedNVk7kJBZ4TJinjd7gjvxTVFnl2WIJQhf9/pJPcCqtw
6MzgVCt8zK3yvdQjGW/pyenZg/zBIDaBTWkoX7peZwzDN8Vin26kOUfwF5kohbVZ
qixe6a4/VrUaPHzv4EipM/25XuUdVeLxMc4VWwo/qwc7RmZBOPtdCygFuL90eSWp
XwmjGQ6odJsYBCew0EROZrTagKowuXynON/PQ8NU+naEjaM6fzcoF2VKel5tbOfw
C9sPHG7xEE84QDM0QyXy6PLmLd+aeJQ+wN/sHwBjj4E3gFTJ3o3xfqY7MsLtm2Xw
pYj/tm/fQna0WmYE5C4cLgLevlq3QyxozhTSu6X8dpNTZPPBnaa0y5zVp6PU2hiH
JRQlaP4DJ28EXiajPkzTi/TAD8FddMYVpe0h4LkkYV+J2SU6F7jaSENykR8r5QwM
p18L4X3N/jOXI9ssA3tuIG3ZjPkCNHMSJTa32kMnRNnTdldsez4B+dIr9wk2V1X/
HRKv1esAlA+OvQvudEfg0DPOjTlCIbUHn4+/q3X4Ociy2X4U69FJWBz6HLtiJper
y8MovoM5E+iERQY71Cz5kC/iIARUh4elT/4SE2sfij0XhS1cYO4ruTSRiW3c04B8
iJUQ01XoVPzPwI3/q7HOhip/1+r98nJXouBAXRYGrO1MotH9fds=
=pTtT
-----END PGP SIGNATURE-----

--efufeesp4va7bbg5--
