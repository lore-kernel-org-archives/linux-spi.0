Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFEF4CCDE3;
	Mon, 31 Aug 2026 17:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788198497; cv=none; b=KvZYRD4NzokX2uA70+FVbNjIFCst5ECVtWyrw88LUivK/4KL18OOUcPf++dzvBmaj003R/8oRXMqkynghZMrswg9AmJUmsgl7Ej1EKoCJjse9SUjG6QRjfjAbiAN4KYmsLKR+l47lV12ax/DfuOVGlIJkIE4lfdnVGetqJR26Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788198497; c=relaxed/simple;
	bh=wbO4FN7CCabZt8UHD6/mZvwW1+J7zI2RVsnN2vpuxEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g2jhEQkmv3ymIJvzRxwSUZ2+DRjKSpBFKeFFnGMPMwBoMytHGjT+clALPzPE7JUnGG9UEhxoPQ+p/+3572Aa/EgXH+0hNajq8LEJKpOKYBGvrDDav51jpjamZjG9iUTXa24IEH4EezMUMyMrit8uRCXbc0KHY4gNRWa/kk9ZJg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jRLrHlKo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jRLrHlKo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE2C1F000E9;
	Mon, 31 Aug 2026 17:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788198495;
	bh=wbO4FN7CCabZt8UHD6/mZvwW1+J7zI2RVsnN2vpuxEo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jRLrHlKorwgutcnZqJFX+QPI9HoW7kuLvK/RMtidHcZsuAVflL0TXDDTss1LQ7c0r
	 qLqEIi9Kn5RQYX6CwuwVA/ohQYbhHXCoVW91EGRMpUTV1RwyFoQ+G8jTLwTg3MM2ds
	 qcL5gK3rU9iW2VxfLKpigDMTdix58fBxkqx8IUIfacquOVoCQMhL39peSIcjWUkhQz
	 r6BKflOd2TPTAcKcJKdvXoRx7B110SJr2Bs/OIqHLkXIgr5WgKXrGEm5ldo2YyctBP
	 uJa7xYfP4UY54MsFuimp75TSdfFqXVad9A5IMQulQ5pyf1XaZnBJbRXfptbBuOoZAn
	 7UUMldRYJsnsA==
Date: Mon, 31 Aug 2026 18:48:10 +0100
From: Mark Brown <broonie@kernel.org>
To: Jingcheng Ji <ot_jingcheng.ji@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Project_Global_Chrome_Upstream_Group@mediatek.com,
	jarried.lin@mediatek.com, vince-wl.liu@mediatek.com,
	justin.yeh@mediatek.com
Subject: Re: [PATCH] spi: spi-mtk-nor: Get clocks from devicetree in bulk
Message-ID: <b03aa685-3632-4a8e-a292-4d0897ba2c3e@sirena.org.uk>
References: <20260821090046.2353986-1-ot_jingcheng.ji@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iiZjd5K58NJ/2Uds"
Content-Disposition: inline
In-Reply-To: <20260821090046.2353986-1-ot_jingcheng.ji@mediatek.com>
X-Cookie: snafu = Situation Normal All F%$*ed up


--iiZjd5K58NJ/2Uds
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 21, 2026 at 05:00:22PM +0800, Jingcheng Ji wrote:
> The driver currently gets a fixed set of clock inputs by name. This ties
> the driver to the clock names used by existing devicetrees and silently
> ignores any additional clocks declared by a future platform.

This doesn't apply against current code, please check and resend.

--iiZjd5K58NJ/2Uds
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqVvlkACgkQJNaLcl1U
h9AcCAf+IF424GXDSYuGasJOVMsE660FZzM74ZGUdS2CC+p8NKO1Ldpn5dXhFPit
AZlouTOhqQ6yYMeILwK/2wO8rFathl0SNEENSZyNJ9Wg7ZuFq1GS45P9BCuLd0D3
giMwfnadXQW+0vWF6J5Yt1v7g9jsFq8+GzAxijTZ5Xm4GFO/93AwXPgG+KBRvkB1
P1Dw0LGLBc+yjwI5go3bS0kmtaDLvoze9xvHBT0ON7odTo0Xw49DoBEf8c97V0Bp
/CjQparCNFFYOwmeqbBqBwaVArHppA4lNNDqrwiy5HlNyq8EOYptWSDC+EQ/g3rq
INTsNBdB7/X4yF1rn5mA78dsOnyaQw==
=B1qX
-----END PGP SIGNATURE-----

--iiZjd5K58NJ/2Uds--
