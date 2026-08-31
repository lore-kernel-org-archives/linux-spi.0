Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FD43DC857;
	Mon, 31 Aug 2026 12:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788179887; cv=none; b=AItZJHal2eFkewH3Z8RkC/QL5Sy1s8KRqje1IFjxHPDfHL4rPrl/4w0sit9MMtv7OkX+/mZqRddPxvNGCMH2eQjLt6T804dNGC4b/QodzcU+Vz5esx/daKcG2rwOm/8Xgr/tmLCqKx5nXWaAISvOnBba+nNhi3bsVPeYvzyzkfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788179887; c=relaxed/simple;
	bh=44HEUT+C3W+ilUb7UcbYs5fMKrnmF+7s17BG/zpNRJo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=Qkdd9WBitcQU5ednCITBB8l2YVD3GZYv/uvjdYgZrImrIQ9q0ByVKaZOrtM93JFhzYKzq+UIKLN2vdV9IbM9NlOMADQm92Gcwjmc6I80VxSpZCRk6y5kvukbio5DKVCDaw2YYR8YWKThmBYcv7qEcqJPB3/MxxAc5s/rNDjKLvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nx3YiC3X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nx3YiC3X"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 8DDA01F000E9;
	Mon, 31 Aug 2026 12:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788179883;
	bh=44HEUT+C3W+ilUb7UcbYs5fMKrnmF+7s17BG/zpNRJo=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To;
	b=Nx3YiC3XxAdlbDnvXZDynYQDcp1UodNmioZi5CJPtXDDmWP0ibyvXNbWigJwoXKV4
	 t0sYC6s+f3yY3zznMfuPmo7Z+VgvorRyi6FDGolAt8z8K5RU6t+RzK6s8iqXIu+5+w
	 zhMHbJe5aObbMVNv0yLe3BzVvDgG4IOhhQmFLqljS0bQezl//MfhDOduZeATOqCvm/
	 hHUPbVR31ZcacaQ35TI0R60oWlJFGRG8jsKw2u0U6HuamEjx//mRCbXDTPGmmdzpwf
	 2jPq6gnMaMQWwhj+LcwfCsLnprc2sdmGu7wPUVZS+WsWjCOAEYvzEKQYKTVXqd5lT9
	 AwUThfyvRANvA==
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=2961015be12d425803f6c4a8d0b54a27036011ba812b444aab554b003a36;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Mon, 31 Aug 2026 14:37:59 +0200
Message-Id: <DL34V3WU5UY1.3FYYB7UPWYY83@kernel.org>
Subject: Re: [PATCH v2 0/2] Report platform enforced SPI flash write
 protection
Cc: "Mika Westerberg" <mika.westerberg@linux.intel.com>,
 <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <linux-spi@vger.kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: <tjakobsen84@protonmail.com>, "Pratyush Yadav" <pratyush@kernel.org>,
 "Takahiro Kuwano" <takahiro.kuwano@infineon.com>, "Miquel Raynal"
 <miquel.raynal@bootlin.com>, "Richard Weinberger" <richard@nod.at>,
 "Vignesh Raghavendra" <vigneshr@ti.com>, "Mark Brown" <broonie@kernel.org>
X-Mailer: aerc 0.20.0
References: <20260831-spi-nor-platform-lock-v2-0-6cc75b909241@protonmail.com>
In-Reply-To: <20260831-spi-nor-platform-lock-v2-0-6cc75b909241@protonmail.com>

--2961015be12d425803f6c4a8d0b54a27036011ba812b444aab554b003a36
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

On Mon Aug 31, 2026 at 2:05 PM CEST, Tobias Jakobsen via B4 Relay wrote:
> Patch 2 adds the only user, spi-intel, which already computes protected
> range state at probe but has had no way to expose it since the SPI MEM
> conversion removed its visibility of the MTD device.

Where was it removed, though?

-michael

--2961015be12d425803f6c4a8d0b54a27036011ba812b444aab554b003a36
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCapV1pxIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/i5xgGA7ArXnBusxj07GfQmaHEW6Rz4IqPDGCQ+
H0i5OHS3K16b8dJ3/4a9hBy8rxzU2uCVAYDnV9AGj9cHlXRPwAaK2DSeWfCxOkET
lEdVoA5hL/sz4UcH/lY3Zl72vxXx3RM6efo=
=znIg
-----END PGP SIGNATURE-----

--2961015be12d425803f6c4a8d0b54a27036011ba812b444aab554b003a36--
