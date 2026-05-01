Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356691D89EF;
	Fri,  1 May 2026 02:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777601761; cv=none; b=p9jYDN4Pib3s4nGUVtOQtxPpYl0quVYN9VZF4AgY7T9P0ok/v/Me091JunNh5uAi/1Sv5QLPsneHGCZM9+FKCTex/LOsYEeRbmMyZ44QQnV4FY1eInY/V6WGTlOrEX1Wa1mikTBoHlVxZsR7ZvOwufur/qUAXGjbzsM3X6QDUMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777601761; c=relaxed/simple;
	bh=IkfRi0MRN4wTosJ4N4obcRn5okG4YNpT+RpEtcqmPIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jNS68Qu72IHNQARY4hREA9bx59dA4y6koH5Oov9s0pC4iIqJtOk+EblaEwUt2fHldmmtN7UShTaTBl/46VKiAeZyTVkDwejIZAWLulyHuR1hMgZzYmhgM4cn1ub+5+6Id8f84uKcWEllup6sru3o9Rx7smK35UodkchC+9A0XqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0J5NbgZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0J5NbgZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAF51C2BCB3;
	Fri,  1 May 2026 02:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777601760;
	bh=IkfRi0MRN4wTosJ4N4obcRn5okG4YNpT+RpEtcqmPIE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D0J5NbgZF1mK/wdP7ERxeykRw2HpSXjJX+AGLux6l7BN4NW8tDY9ezrdIDSk2KtS0
	 +T9rerErGU4ziupECxiXg70WTrRm/89efkBblqlE8GxKkQTI9p4LvgVz/E9BCpGZaz
	 kmPT18p8mgmN8ZQvU/KdAxZQdvy3KsD2h8ejLyFlxigchjW2IfX32PR2XAfPzuRPXg
	 77ma2nSp2VhGl3ikoxIEC02WNtc9AJLhCNp/71HdlxobKm0tSMtegWp1qfEnN0wjPS
	 oux6IJVD/WXTloCFgaK3h8c0iV1xjgThKlQ0UV1oMuTOAXWfo81r1t0/01vQEQfsMY
	 t01VY5QI2Zuwg==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 292451AC5863; Fri, 01 May 2026 03:15:58 +0100 (BST)
Date: Fri, 1 May 2026 11:15:58 +0900
From: Mark Brown <broonie@kernel.org>
To: Vishwaroop A <va@nvidia.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	smangipudi@nvidia.com
Subject: Re: [PATCH v2 1/2] spi: add new_device/delete_device sysfs interface
Message-ID: <afQM3kPwsig6kkQp@sirena.co.uk>
References: <20260420031417.291442-1-va@nvidia.com>
 <20260425173425.622042-1-va@nvidia.com>
 <20260425173425.622042-2-va@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="27f4pE97/W8jpf1w"
Content-Disposition: inline
In-Reply-To: <20260425173425.622042-2-va@nvidia.com>
X-Cookie: Garbage In, Gospel Out


--27f4pE97/W8jpf1w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Apr 25, 2026 at 05:34:24PM +0000, Vishwaroop A wrote:

> +	mutex_lock(&ctlr->add_lock);
> +	status = __spi_add_device(spi, NULL);
> +	if (status) {
> +		mutex_unlock(&ctlr->add_lock);
> +		spi_dev_put(spi);
> +		return status;
> +	}

The locking on unregistration is conditional on SPI_DYNAMIC - I think
this feature needs to be dependent on SPI_DYNAMIC since it's adding a
new way of dynamically instantiating and removing SPI devices.

--27f4pE97/W8jpf1w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmn0DN0ACgkQJNaLcl1U
h9Bmlgf/fv99pwAjATmIrtsVv7tALnVveQw6oK0wVKZ+bfqkWL5TsGhwhtxC0zb2
vIYXajDEKPiHowAy+gHd79jaUd006jhoa+YdaSGkh8vbiTBW1PDM5DzFVaV+ougy
ciGfcw5eBPtDvbH1J9zgg3xh8TOF+pJPcaTTRgSRS1XxBEhqSNqk90du9VISUOmq
oe+gETo5t3DhMprRIH2ioRYC79Nm69drlQNMMa8m85XCRfG23ylEpJIHbg/1VqxD
Xju+i6Of4kBjwwS567Yqgzk7DeScNcNP5vFjDoVGoWoehtIe3dkgwPXJoVZ2NkS2
ekD8mNwMmT//Z0MIlLHejinSKrQEsQ==
=gsBG
-----END PGP SIGNATURE-----

--27f4pE97/W8jpf1w--
