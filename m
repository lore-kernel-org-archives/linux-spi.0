Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA213C553A;
	Thu, 14 May 2026 07:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778742506; cv=none; b=YeOjKHsXHUq5NcMfq404m2Iuq5crRn8qX3ZXqgu6yoLcHZgHjHt1ZItn8pxgaNZU5SM18KT6Z2jYOO3gtSV8Rk8+iYK/N3xIGqdM4nms6bYijSSLfzzHZkh4d6ust1de2zEDbG0XtU0xq290IX+JlcK20Btx69W2zs7hQYKKyN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778742506; c=relaxed/simple;
	bh=H10JNB4IjRUruaX40v1zVCNcDlqN1CX0zevkX4XYUqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZNt4sKHq6V7Pm5TuIlxbOXHhZ/j3NeqLkCE6wEdg5AVMKCc+mGRSatxy/FgbtYIlmPURGN65vMAUrXafEwo1DDqEk3Lr70IdWy9/jjATwyGXfmOF1eY/lz0Pe90MpTL2pPBth6CCknru0gC419uI0j3Znbf8cXNoDZYxslzA5TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WxD1lgpo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WxD1lgpo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14478C2BCB7;
	Thu, 14 May 2026 07:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778742506;
	bh=H10JNB4IjRUruaX40v1zVCNcDlqN1CX0zevkX4XYUqo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WxD1lgpoin1mtAeXne49p8NRofv6/TlhJdOa2ULY8whVcPxJAkAfibyzloahbAX+K
	 zDNN0GU6Jj0/+MqGqzEnDJ6AgVi2zHAxLpICInYbqFoZN9EO786osU5Oyj63eDoznn
	 NuA6A1GHEGC1vz55gsxrI4zrRYErN81xOZr6Wolog/V2l3wvpnIPGUnQOZ8JmNTBZ1
	 LJpmQhKvGymU61AZ5d60gEGOdBW1CweKJZZRD/0S02HR/kqoYoIqcb3sOQ6XQCzUZe
	 AmeyyMbShq2JxoX9fFRYSnOWqvGpWKA83NraDFfOBEdbH9W86UmaS/LKsb5EICeByn
	 ykeGXwoBpyenQ==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id A46E11AC58D3; Thu, 14 May 2026 08:08:23 +0100 (BST)
Date: Thu, 14 May 2026 16:08:23 +0900
From: Mark Brown <broonie@kernel.org>
To: 958028483@qq.com
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	huangchao <huangchao@kylinos.cn>
Subject: Re: [PATCH] spi: Add spi_for_each_controller() helper
Message-ID: <agV05zvHUatL5NuR@sirena.co.uk>
References: <tencent_5C9EA0718E363D0AFFDC86E03AABD362F707@qq.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="etOhQryj/4Nmz7/s"
Content-Disposition: inline
In-Reply-To: <tencent_5C9EA0718E363D0AFFDC86E03AABD362F707@qq.com>
X-Cookie: Truckers welcome.


--etOhQryj/4Nmz7/s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 14, 2026 at 02:13:08PM +0800, 958028483@qq.com wrote:
> From: huangchao <huangchao@kylinos.cn>

> Signed-off-by: huangchao <huangchao@kylinos.cn>

Your email address and (non-)name don't match your signoff at all so I
can't really verify that you're the same person, could you please bring
the two in line somehow so I can verify that there's a valid signoff?

--etOhQryj/4Nmz7/s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoFdOYACgkQJNaLcl1U
h9BFEggAgdb+dCjLXJ3xAa9SJ45grd8uuknIrFjnnp61AGvJ07TbAi10Dv4LFdaz
gwVSbANynjpobxj9ba53u6UOJEOBeb+CAXRTJJRAteD65dznLiGs8f883jwah/ko
rRCPlR3qCB8SiNY03a8vzujvjFTHYl1U8UyE57MCWh/oxbIU9t9iyvd4gwdw4IDk
cHs382Aat0qCcVUgktmQZCaHWV1tW3V3iB0BbvUm46+03Jaeu5hcmjjFNUvIn9HB
bum6qQKvBqZGy5sN6oEroVEeAZsjtRoKqt+9+3UuCZmzOaDE4AM1LFdngnE/AII6
2dbrFy13/RPgTlx36wN32st1aodwPA==
=1fep
-----END PGP SIGNATURE-----

--etOhQryj/4Nmz7/s--
