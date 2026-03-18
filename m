Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BD7379EE5;
	Wed, 18 Mar 2026 13:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773839831; cv=none; b=NLFIVZQksNyUi/ZfuwQBl4g6FbQj4pMgOcbhQ3+G1Q10OzoMPz6UL5+Vw9nuTSkCu4E3R+icp7b+3z6ZnDPLRoEcVLBuEx125oUJPATbIxvr2RoNV5euScAs//4wZHXfHxRPlZK3djRZysPQph6o6fZq1+oZjmRp3TAFkeCG8Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773839831; c=relaxed/simple;
	bh=kLYgcApbMpby4pX6N9q6cQoXDnD9l1Bn9ENq/xE9Wsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OqSe6hflj0hnVr9Y+3W9fKZwMi2cVrnNqej9hM53WITphnva8hhZwAALVnTEWPr+llk6Evv+29CIPmnPb4AnT2c8m4lzWEru3QKRlmKK6DMVgIkHFQ4gC56EUktqVSw8uLmXJIovC9DtgupQ6HNy1nYWLEe6xH9tqOY+BNj6wUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GCIEP0zD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GCIEP0zD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93C5EC19421;
	Wed, 18 Mar 2026 13:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773839830;
	bh=kLYgcApbMpby4pX6N9q6cQoXDnD9l1Bn9ENq/xE9Wsc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GCIEP0zDpmM5hmSfSA98d/DqdPPCbLfz08iZpDEIAQfA9F6KPY2Y1U48ESFGCrnxF
	 94Ei3CTuec1k02WUjrnZM5kdVEfG9yX1xXisfGoEtf/vvL+hg5QWb+sPtq4SkD69UT
	 ncpGwZAC4VZ2+KSCubBYeaq32nKQyFQV2p+CUjJ38I8ob9l5dJewTHP3Td4PqoPmCS
	 Vl5lw2xeBvuIjrprVPI9JkTngu8qU08wgmbKH5Opz9eWrxAz6TGPxKDh820ieBSiuT
	 LNplPyXykA2c5DlCXRvq0OblTe+B7yPBis+uIBnGSoS5mCro6UGG8LYvzIpIe6B6TW
	 P9jG7U6z8xf3A==
Date: Wed, 18 Mar 2026 13:17:06 +0000
From: Mark Brown <broonie@kernel.org>
To: Pei Xiao <xiaopei01@kylinos.cn>
Cc: shenyang39@huawei.com, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: hisi-kunpeng: prevent infinite while() loop in
 hisi_spi_flush_fifo
Message-ID: <ac696e0b-530f-48f3-88bf-334f2dbf43b2@sirena.org.uk>
References: <d50f1f46b2ee2bba05de9e2d4199353b545194e3.1773820898.git.xiaopei01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0tYD7rk2rOLTDHPK"
Content-Disposition: inline
In-Reply-To: <d50f1f46b2ee2bba05de9e2d4199353b545194e3.1773820898.git.xiaopei01@kylinos.cn>
X-Cookie: The coast was clear.


--0tYD7rk2rOLTDHPK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 18, 2026 at 04:02:43PM +0800, Pei Xiao wrote:

> Also add a ratelimited warning when the outer limit expires, to aid in
> debugging hardware stalls.

That's a bit of a separate change, should really have been a separate
patch...

>  	} while (hisi_spi_busy(hs) && limit--);
> +
> +	if (!limit)
> +		dev_warn_ratelimited(hs->dev, "SPI busy timeout\n");
>  }

The limit check is a postdecrement so we read the value, compare it to
0, subtract 1 and then break out of the loop - that means that when we
come out of the loop the value of limit is non-zero again and the
warning won't trigger.

--0tYD7rk2rOLTDHPK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmm6pdIACgkQJNaLcl1U
h9DCygf9HViBl/cQymQKzXDlfLLcG6ETerqSvRmNaH+VtWhlSdKXTRVaaYmTnHpT
yzc4iwveKkSVvBKr/lH1B7Qn5hZF5eZhIwPsir77kKDQvAcDTfDzlKFw7zz6+QW5
zzgD0vCO1mIchqoUUWJ1WSnUyuDF+8Wj4axpRjmsK/fpcrJUkDeVjz03D8U0hIXq
AIKn24eqpsQ9/Ev3gVlQ6pKBo8vzzqXhNE7pD6L41YcEdcc8x02nUxKfFEtyetml
DZdxvDHLua7QJ7o8sly7jEx4mT/jcoWgadybThB2Kyv8HPL+6Q/i2yZV0naLeAnT
n7D/w6Ha+9QH1VSHF3UeEQfTWhZSlQ==
=kImG
-----END PGP SIGNATURE-----

--0tYD7rk2rOLTDHPK--
