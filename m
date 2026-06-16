Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24A4337688;
	Tue, 16 Jun 2026 14:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781618878; cv=none; b=TouD4P7H48WgpBLrT743wTIF91wA1byUH8MFD++IANx2Dl6fwzrsHA6Htf2iul1TiWv8+XbIvlaXEmW6zWrALdHX1x0NubEhwZdMOudfqHt6oj56hqnn1KOfT7sqGy2p7nvyyygSDzmE00rohdhe9Z6bN+RH6eWLSJWVOQP7OvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781618878; c=relaxed/simple;
	bh=bruwJUJS2QFqqbyLUcoq/7bfZL68H3k/rBqZvpobxuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rZiIC2cIDQqH2coRmZPZgf8NgwuJyDs0qGGQ8+zvlOkxBf3ZW7ccy9ZUO3XBxRzN7M57C+J8477CIOJV5z83uSaXClHkmFPNmyLKG0sVcllkEtF0fgllQG5duQqqQuqRRhrsJerFYit4O2HjSEt/N903DTgyGLncKlGbAjV/joI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LSDr2dIy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LSDr2dIy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96D781F000E9;
	Tue, 16 Jun 2026 14:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781618877;
	bh=TOQ0x3V6SwzE8XZBEreDc9vDQUWdmKOgQXUVINOlTB8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LSDr2dIyOzPZjaJamiTIk2x+/9BEVtEh+6VKtUfnSsFyNLGNhhgfaRB7nOiU4Qqu8
	 unLn9O+ZRH1C+thlZVQsU9sEFvmdw+oq91aEtx6ukaJ5I1uUM7kxxcTDQTzizos7QK
	 bi6ywenruApTMlrkCb2sAAbFHEldc1AIBL+0r05qQ8MtWVK+z9muayT5XleWeneQG6
	 cBNU6WGwg/VRoUg/E/mQ+c7Zwjj71NZzxdovVk3hlgV1frpTjYzL6vHQdOjia1Ws4X
	 QpwZ5jwYURQfa75idsK2hoh4dBl8FnAi4aMlADXPbMKF+8M+XhML2lKh3TeN4DFWus
	 y4Ew/iZVmT1ug==
Date: Tue, 16 Jun 2026 15:07:54 +0100
From: Mark Brown <broonie@kernel.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] spi: dw: use DW_SPI_INT_MASK instead of hardcoded
 0xff
Message-ID: <fdb31012-f6f4-4aa8-80fd-4ffb3c2c8d2d@sirena.org.uk>
References: <20260615044039.9750-1-jszhang@kernel.org>
 <20260615044039.9750-5-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CrcVwn9eYGSkQVlz"
Content-Disposition: inline
In-Reply-To: <20260615044039.9750-5-jszhang@kernel.org>
X-Cookie: Password:


--CrcVwn9eYGSkQVlz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 15, 2026 at 12:40:38PM +0800, Jisheng Zhang wrote:

> The Interrupt Mask Register valid bits is bit[5:0] which is well
> defined with DW_SPI_INT_MASK, use it instead of the incorrect(but no
> harm) and hardcoded 0xff.

>  	if (!dws->rx_len) {
> -		dw_spi_mask_intr(dws, 0xff);
> +		dw_spi_mask_intr(dws, DW_SPI_INT_MASK);
>  		spi_finalize_current_transfer(dws->ctlr);
>  	} else if (dws->rx_len <= dw_readl(dws, DW_SPI_RXFTLR)) {
>  		dw_writel(dws, DW_SPI_RXFTLR, dws->rx_len - 1);

This looks like defensive programming in case a future version of the IP
adds additional interrupts that the driver doesn't currently know about,
it'll mask anything that appears in the register even if it's not
currently known which seems safer.

--CrcVwn9eYGSkQVlz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoxWLkACgkQJNaLcl1U
h9B5+Af+KgWib0jo8uCzEz+qHJyW92RnasVkJrWlDhKQe3+oSKnjnQ0Q+Mr0/CBc
y3SkFiDIo6ARqFKhCENz4dcknGWI1QpZ/klLw/ELX3bWsGkSuMn6xCKhtrg1u4HI
aFRzIcOr7TAnybXmIMceLheTqZkNieXY4F2I0kj20BRbTb0uyuOsEfJ2n2quoaix
6XKgwjoNjw043AXsMC/Ksd83/f22vvZuwKswvdG/GESr2RX2ughXB9WOVjBfQcp1
Ht4/bIdOyVlcVjSA1d0Ev2psG96CjwD3ii6PKUucYPsVDWyLEaMS4klG71OEGOX5
gtOXKy4pv9xp2iJMMjH/E+SupL6hYg==
=Zja4
-----END PGP SIGNATURE-----

--CrcVwn9eYGSkQVlz--
