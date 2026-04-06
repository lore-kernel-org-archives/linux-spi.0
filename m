Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2ACD3368B0
	for <linux-spi@vger.kernel.org>; Mon,  6 Apr 2026 12:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775480013; cv=none; b=Jpsaeb1ZCp1IVLHXRms99dhnL3tLlzLz0TAzXmi/cWKJPvP4XmROcAJZry1peSray9Jh2XJyEKZ+QVrwwi9m5oEGlLtFwcxYHZWpwITVWF/qdlIiG1lZb5pEEgaDwdRBYMbktwXlEW09YxsOzfg4jif1Y6FhKarmPkH+R/s9vkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775480013; c=relaxed/simple;
	bh=mPQ/xpAlrlk9I52Qbng8ToGDsSDNUZmp0x8Cnhd0ATE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LKoXS+gZsHYx+UndVNZkho0szrsuJxhTaKeGKJtoTCOU9J+shBNTWTmRzBo4CzLcMtK3+/z88qxTareLYNq2iDOSUmTWCVVkJUXX6OFHUZ+rCCZgyGdIF8P0LgHh6adJtyMNeJGRAvT74p5e7vL6YveaZQ1R2n3KBR7wHNNVfnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3YjwtEP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3YjwtEP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8918BC4CEF7;
	Mon,  6 Apr 2026 12:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775480012;
	bh=mPQ/xpAlrlk9I52Qbng8ToGDsSDNUZmp0x8Cnhd0ATE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G3YjwtEPumdHKYP8BhJyBZ7e5j2rMTrTy+lKEUU/fSMZAvVID7O4njhoOE+81Rkc0
	 0hceYT+yhYIquW1BZdaHh3Q0xHEzsg4OSV1DWv2xLOPrgVxKkdBQwDhk96VUcfcyKa
	 ylDkOPptHY1xdFYPjwHjABomyl6zITUX2t4OVWsOpLjD959ax7tgRJzJvud7ZF9zVM
	 VHlURaovf24lOkqvEL5duA6ONCm+dOdvlOpAOOpG7eVQx8SJNuBdSaOH6Y0y3463t+
	 EdFdkeiuSTG3BWCLBhKc9rEs+48HAjnSDhuN5qYAv6FnayhFaeULPdZkMQ2po2eNCJ
	 QKFwz4oF09x0w==
Date: Mon, 6 Apr 2026 13:53:28 +0100
From: Mark Brown <broonie@kernel.org>
To: Pei Xiao <xiaopei01@kylinos.cn>
Cc: gch981213@gmail.com, linux-spi@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/4] spi: mtk-snfi: unregister ECC engine on probe
 failure and remove() callback
Message-ID: <d4871bdf-15bf-4491-be5c-5b38a065d810@sirena.org.uk>
References: <cover.1775273351.git.xiaopei01@kylinos.cn>
 <09ac1024a0f1626efaa47ceefc5cfb8ee5dd9418.1775273351.git.xiaopei01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bcY2f4OxCKNUI0TS"
Content-Disposition: inline
In-Reply-To: <09ac1024a0f1626efaa47ceefc5cfb8ee5dd9418.1775273351.git.xiaopei01@kylinos.cn>
X-Cookie: Does not include installation.


--bcY2f4OxCKNUI0TS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Apr 04, 2026 at 11:44:58AM +0800, Pei Xiao wrote:

> +	ret = devm_add_action_or_reset(&pdev->dev, mtk_unregister_ecc_engine,
> +				       &ms->ecc_eng);
> +	if (ret) {
> +		dev_err(&pdev->dev, ret, "failed to add ECC unregister action\n");
> +		goto release_ecc;
> +	}

This should either be dev_err(), in which case ret is not a format
string and this is buggy (I'm surprised it compiles without warnings...)
or it should be dev_err_probe() in which case the arguments are correct.
The latter is a little better, though it's unlikely to make a practical
difference here.

--bcY2f4OxCKNUI0TS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnTrMcACgkQJNaLcl1U
h9Bn3gf/Tw/3QaY8d26oeHjBwK7iRpKZDFeEWD14GaAFJjqvItlGkc4O/inmsmL4
+ajauW6rgAK6VdnS7CPbuLbaO1G0BS+ipl1hNiEjeEM5C8L7kAbVNXBl7FEmPL6g
8txAv5ScD12FqhKA+QM58asD2s1jjeFVxHMnzY1Hvk9sF9b5M6z/6Rj0HGlDT8Af
zvO58eJeQ0z7dOjyP1q/cmdZ3uDpMClQsCnmVG8w5GgO1UfhaLTf1stSIfEIjcG+
pfsJsj0TXaDZKDP2iuYPZBMi9ih4vL/m3LS7L7KBuHLlFnUOQo/V6oLXQ5BoHXpo
UJbMneAI729UBtl5jo498yD26wk3Ow==
=Skbd
-----END PGP SIGNATURE-----

--bcY2f4OxCKNUI0TS--
