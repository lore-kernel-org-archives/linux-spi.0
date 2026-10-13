Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8C4525A92;
	Tue, 13 Oct 2026 16:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791907223; cv=none; b=W4X3ZDmdroDibGrImwK617oMrE7G/9IsBQSHWO9BpG+0/plDAzL5hgilKE6/VSuSRK3WE9pSE5onF55V4k85d6KHuSo4GtlrxXNaWxd+ton6lW2RVU14TODlmC2TPk/Bvb678AAPPEngjkKRRex38Nc8yxLzQHMlwLU4rPUL2Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791907223; c=relaxed/simple;
	bh=3BgtPQe1OHP6DHbscyL/0otadAVbXSnbV10qfa+kOgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lp4++eu+tWrNwjHr6c/5dHB7UgCkgd4JmGyPaqtChORi4Ip3oq5B7RQGCA4aZ4P2FbSSRpMsiZyC2zu/nvSJJKJtbXzJPTORVkJd/gA4km02+tS8bO/MPkh8Ep5k2El5RrSOI1yM9JhR7QmtCpcUCCrlZm7itV0XS7T8k+pLLBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dynWNo77; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dynWNo77"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 375D41F00893;
	Tue, 13 Oct 2026 16:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791907222;
	bh=GT89SdLYKcTPHyTDdQVaS2OrKEugrdzMOrAYxnP+pdo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dynWNo77WCapOS3d4Muc2GmGRAiZXjf/klQyxZC82XR2jCeu3vQF83IgCSMOMP1Bt
	 M5ReyTfuZGFwy3BV3bwb0pVs2HObt8xIMESOmh0CZLIXiUG/86ngNw013lm36KtXhf
	 11tsosQOYekiundjXO6y4Tbm4eYDurGMtM87+hj3AjHlca2mR9MRPUm+N7LRGBxURk
	 8fzPKAJQWEIJjB99BLerxagY66cB7iQbY9fv7jDQgLtWoDBZHK81fazfrFXhe7VT44
	 VJSFaA36jEWjUVdGUZ8j7dOMfYMQL2tPIQm7KyTe9xynJFQce4hqg3XUDvRwONB1v9
	 qF5e6QFvh9cUA==
Date: Tue, 13 Oct 2026 17:00:14 +0100
From: Mark Brown <broonie@kernel.org>
To: Paul Cercueil <paul.cercueil@bootlin.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>,
	Takahiro Kuwano <takahiro.kuwano@infineon.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org, Tanmay Jagdale <tanmay@marvell.com>
Subject: Re: [PATCH 1/5] spi: spi-mem: Add support for panic mem writes
Message-ID: <629a4f32-2efe-4212-ac1f-f64c487caa63@sirena.org.uk>
References: <20261005081141.33688-1-paul.cercueil@bootlin.com>
 <20261005081141.33688-2-paul.cercueil@bootlin.com>
 <asdVM883VTQy7WvH@sirena.co.uk>
 <5c94b88bf7123e5a32d5c4bd77217e6a40683c83.camel@bootlin.com>
 <eb16cf0a-6b7e-4ea3-89c5-61ba0729492d@sirena.org.uk>
 <0d2f1d4149cd136ace8c1f08dc48ea7f25c5975c.camel@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sxDT0fBTa5S2qbeB"
Content-Disposition: inline
In-Reply-To: <0d2f1d4149cd136ace8c1f08dc48ea7f25c5975c.camel@bootlin.com>
X-Cookie: Some equipment shown is optional.


--sxDT0fBTa5S2qbeB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 01:00:50PM +0200, Paul Cercueil wrote:
> Le mardi 13 octobre 2026 =E0 11:42 +0100, Mark Brown a =E9crit=A0:

> > Do the other CPUs know they're panicing yet, and what state is the
> > hardware in?=A0 I'm a bit nervous about assuming panic got things into a
> > good state.

> The other CPUs are stopped, yes. At that point there's no SMP, no preempt=
ion, no
> IRQs, no time accounting.

My worry is what happens if we didn't actually manage to stop the other
CPUs - in theory we've shut everything down, but I've been burned by the
bug being IPIs breaking.  Perhaps it's just not worth worrying about.

--sxDT0fBTa5S2qbeB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmrOVY0ACgkQJNaLcl1U
h9BziQf/c8UlsinjekCah8xPvRCat29/XPK8zPS7EEi/EpEDrFQLSCQYdseWqzXI
Ip3mmVz2jGtau0YX//XwQHmdCtgeby1srK/P2PnIQSjfx6l0M5NmCmUGWbVXyMFW
c43NDxwrMridL+TSEPDRNdGeT3400X381QTtnd4F/noddb7bI5RQVEDwk4Cz8v0g
ZN+YIuy//4eBmJBKjzrCNqJh5xHXVoObn2gbGCl3p9VzGI+oBVyTxwdDJtyZA6UP
4CJqQZZMEkYRcNHzhaDdk7vHh4o4jyEUGEKWcOLOXSpqQS81S6Vdgq6Hro1zjeIo
CyxRReQYqaUh6uV+NO267z586riDIQ==
=03eD
-----END PGP SIGNATURE-----

--sxDT0fBTa5S2qbeB--
