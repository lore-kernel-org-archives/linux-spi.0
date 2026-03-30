Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A3A2E5B2A;
	Mon, 30 Mar 2026 14:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774881715; cv=none; b=r3LXP3E/QygAGvaVM/3feBYAoBuf4h6SMZW5cBkFA/TvYHsHZSOup9LbFQaA8LR+T2Dab1hemTn0d7x9b8/FKWBGVj9ROZv5X+FgvfEzRS+HwdNq37Pz3zRiuDvXPoTOLtHos+YjUokySjf2+N6QKqfTvXrEMvnl/tuuTj2argk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774881715; c=relaxed/simple;
	bh=tf4kIsFHjJ4ZSOnPO/dFjn2qOeTiZ+kIQ1SlWWdopws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c081onovyuyfr2d7naAdRbBdwfx+3om7e9kMMsPaNQufw2upybfW/jn3oKYEu8XEc0UwX3A/XamnQIqCJHiC5ysUMp/7juke8hg6ZYYEoDX12UgLWJjD5iiFUPkOXIxUJeNdvpp6P3oX6Ev+mR9bAONXbC/Rj5HVJakmTGOAFfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WNWzKMj5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WNWzKMj5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BE3EC4CEF7;
	Mon, 30 Mar 2026 14:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774881715;
	bh=tf4kIsFHjJ4ZSOnPO/dFjn2qOeTiZ+kIQ1SlWWdopws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WNWzKMj5ezcP/nQANoKVKT1//FsPRGnpG72Ai19sxAJAe8LT56ONna38GG9Nux82t
	 /vpXY8FK0x8WAEsX/8b8UacWY0O27mvov0iBxlm2Gm3zM46AkdCqj9dSgWGEKU94wW
	 9+wWHncosyGhE1h0fLzqggiTQTtRoWgLEiyVDZqXbr4cjfDZmyqJW2kHeEnf6e0MWj
	 Urc6KgpjO2Y981j0BzbHpNOCQAFGMveqC9xrOO+o+Bh9bxtI2wJ/BDqyQ13tQSL0im
	 3KtRxic/LY9zqr9WDCUUzhh+2wMUqeewbn59c71/RKjGk9Z21SwCeecjryyWI8ukji
	 1daPkvw0MwVUQ==
Date: Mon, 30 Mar 2026 15:41:50 +0100
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: charles-antoine.couret@mind.be, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2 v2] devicetree: spi: add spi-mosi-idle-low property
 support
Message-ID: <9fec2d81-a423-4f9a-8337-2da27b5a06b7@sirena.org.uk>
References: <20260329125832.2985115-1-charles-antoine.couret@mind.be>
 <20260330-invisible-rich-ant-e7fdab@quoll>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="W91DQDn2mpsvokmN"
Content-Disposition: inline
In-Reply-To: <20260330-invisible-rich-ant-e7fdab@quoll>
X-Cookie: HUGH BEAUMONT died in 1982!!


--W91DQDn2mpsvokmN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 30, 2026 at 09:16:56AM +0200, Krzysztof Kozlowski wrote:
> On Sun, Mar 29, 2026 at 02:58:32PM +0200, charles-antoine.couret@mind.be wrote:

> > This flag means that device requires the MOSI line to be low
> > when it's in idle state.

> There is no patch 1/2 here, even on mailing lists, so probably this has
> messed threading.

Yes: https://lore.kernel.org/r/20260329125725.2984756-1-charles-antoine.couret@mind.be

--W91DQDn2mpsvokmN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnKi60ACgkQJNaLcl1U
h9CkPAf/fF4tycNk01uXxA/f1GnHxxBZeycjMaI4FTmLx6hnhxCmCril/gUC1oVV
xUHIM/r81kkw8NqtcPvuMmQiTN/QEc1h6GWFXrjsjx+CPLq37VIn0Ohve7zTSMKb
mLcw/koo4ahdB2L8DnDhNFq02FrEwTwCv4n2iv4KZanRGFXwVMPTTQMPgANImEBo
4XFe6fKssUowTmlyi60dGrUr3Jm7XRLVPKcAgl4xQA0bvDUaj6O5/920Lv19vATw
FXbbZhrcFEpPieeRXnB0FmQ1MZqg0hGIvFnh1WOqSwqC7Pk2Lw4boXmXcHdKMc4B
4vQwpDAN4cRCk7MCoaDx7q0gqGWabA==
=a/tL
-----END PGP SIGNATURE-----

--W91DQDn2mpsvokmN--
