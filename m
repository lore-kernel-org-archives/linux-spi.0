Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7072D8DC4;
	Thu, 24 Sep 2026 18:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790276164; cv=none; b=SI1P0MvetjTZD2GAB6vx8PrflfmfsCpd2J0zQGFTYqxNfHZ4CTLSsKFSI80taGEkrxwVGp7sYBd7G/IhbXExuY+IBSi9RJMf7eV9SqOnokHbniyL97N66VNYStBPTcCJroZ8QUm6vTd3eCDhd605pNQ8rZYDdq9xn/20YmOgEng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790276164; c=relaxed/simple;
	bh=+oTCqkxdL2RHiWv7EsR1AVOi3MdopJuGUmM2tSiGQ0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sWR4vth6nDRFmNLYDwpS04v9h0TABXULFM6IcYyGGLg8+dXUEjIReOgwuz5hF/ASrpY3MDlvS5lEQ9lzIXofMU70Yy8lvAlrgFM+N5V13fkkcqZN0Zhfa/DrpnAqMyFz+NszDzSK7TA+yLLJ6gyLwRFVcVuNJ8VikXgqwzXQQBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iMFZnU+l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iMFZnU+l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B623F1F000FF;
	Thu, 24 Sep 2026 18:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790276163;
	bh=dWsSriTFP/l1SThxOsNHAT5Wuz8a/YdKnSltBFmwQqk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iMFZnU+l7QFuhCk+LgUxioaavEExOWoLtZg8A7iqDMCkUeIwy9OMZB7KEw5kPVkVs
	 wIp3OvawKyufdtjI7eBoMgXaArbykQJgnmHBgJUJCbH+52ztwBVc3fSFDc3PA3SeFH
	 EmArRX5e4THFokYSIONgh6cN0/NyZCXfOjrunAY6h0TuGVwI5UlWWZooHhgftwG8r5
	 XKif8T2srnA/0K/GZ6T35JG+saHeZs7UP7NV17OGvMXxaKAT8a+zaFekm1/bEZHsSh
	 UU8C5BinIJkyA76Lzf90NhgrTBGC4ptxzejeWtzSMAh9cx9s3ZW1pqWx+nxCECR/sO
	 n6/8wbo4aeL3Q==
Date: Thu, 24 Sep 2026 19:55:58 +0100
From: Mark Brown <broonie@kernel.org>
To: Fei Xie <fei.xie@horizon.auto>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Parshuram Thombare <pthombar@cadence.com>,
	linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/4] spi: cadence-xspi: add ACMD support for SPI NAND
Message-ID: <67f4e1a4-fc0e-4b2b-b41e-8dbb33227302@sirena.org.uk>
References: <20260921093701.1341766-1-fei.xie@horizon.auto>
 <20260921093701.1341766-3-fei.xie@horizon.auto>
 <arFEjzkHGMbecWWV@sirena.co.uk>
 <20260923061211.1608907-1-fei.xie@horizon.auto>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GGC4+w1wYRwqkSmg"
Content-Disposition: inline
In-Reply-To: <20260923061211.1608907-1-fei.xie@horizon.auto>
X-Cookie: Oh, so there you are!


--GGC4+w1wYRwqkSmg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 23, 2026 at 02:12:11PM +0800, Fei Xie wrote:

> The difficulty is that the hardware ACMD sequencer needs the complete
> multi-operation sequence to be described before it is started. For
> example, the SPI NAND core currently submits PAGE READ, status polling
> and READ CACHE as separate spi_mem_exec_op() calls. The STIG path can
> execute those operations individually, while the ACMD hardware combines
> them into one programmed sequence.

> Would an SPI-mem operation-sequence interface be a reasonable direction
> to explore? The NAND core could describe the ordered operations and
> polling condition, and the controller could either execute the sequence
> in hardware or fall back to the existing individual operations. This
> would keep NAND-specific knowledge out of the controller driver.

I think that makes sense, that mirrors some ideas people have had for
optimising SPI mesages in general - submit the sequence to the driver to
see if it can do it in one, falling back to just running individual
operations if that doesn't work.  See spi_optimize_message().

--GGC4+w1wYRwqkSmg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmq1cj0ACgkQJNaLcl1U
h9CgUAf/UWAcE2/VgHsBHsrdWIvev7pY5jSrNTWfchc/Eeek0coOo6mIyxBMphDc
t+q4GKwk3QWJNRuaXmzFkhmNWlEkcVxY1YNUluq5vIP5XtzyXHBoTs0W+ueCNLiG
fEfY0Wlay87obn08uduCMJ/4v7RM6JyuRI8Si4qqeKXKwBiNcjZFsMLcuiDxkIkt
5yAQJQRsvEf4v9UaptOdGqxyTWQP+H1z33hBflXX7jMFvc3uMWMp1ucl2lC10odO
uHMInH0MXNz4mv8/nGiGOZzsVhOZ9abOhFBWhQF/MU5SX3MCuzaec6Db3Ms6/pRv
k/Wzf8uRQPiTBVpWhBhFTPqnzwzN3Q==
=b69J
-----END PGP SIGNATURE-----

--GGC4+w1wYRwqkSmg--
