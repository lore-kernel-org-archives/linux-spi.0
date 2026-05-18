Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9634E3E2AB0;
	Mon, 18 May 2026 08:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779092563; cv=none; b=GhMUuzVvJKJZcfb0YkX0bOBCO98nSfvwJTNwKJYhH50liJzHKm1AX2J3aTXKxUGh631yvkH542o1F+Fh3UG060inq+Kkb300+pmePCx2Kcxq5loRJwqlUgl3h9lr8ozqi3RgxipluAMrbw0qIKXg/UOssPMFANQHGxqTZTwfVCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779092563; c=relaxed/simple;
	bh=M+QBwO82Hvson/4pd6sI+Rs0C7M/c4u6RJ8kDXLqlkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pMSCWQMF72BJHMnwsmkq0qHbj76F63xf2GkJuf1AFADqlbV0OCJzHM3skHIJhWQR1svfKNkbCnrxyDPU2C+J7QwIdVCKo77x7cQghZ7SGn41CNffrwx2EqkE3d4yuqddDlkeXTIfBMphnjRBruCnFHo4YTq+fb8jO7vDkkvjFSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eMadNqLM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eMadNqLM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5188EC2BCC6;
	Mon, 18 May 2026 08:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779092563;
	bh=M+QBwO82Hvson/4pd6sI+Rs0C7M/c4u6RJ8kDXLqlkU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eMadNqLMuhwAhD51uZSOBFu3k9tueyd1Q4Y42mFDJA+IkB/Pl6jDE5Py5tr8KXb84
	 WjhPD69MHMWqnwIsjUSUYMXm6bF7E4sfCujuWMJBR/SsTpaBvM3LxpE1BvzHsp/zIW
	 nZyz99Svc/2Gw398Hhtqk91DmbxH5V8pQVje+ZoMgXr5QzExXOydj0z4J61CDxIFsk
	 jYZ5vX+bv/7dKxK/eBwWDfjx+OZ7U7pZi/QnvTz1FICr37EuLe3Z2tw4uZBTqMxZqO
	 kE/Z5CDyWubYdUmr0X5fxUZfTHbfRY32uocTElcqkBpzgL7TeMZsMRfu55vMo6ftOY
	 ILFo7hFfiEJ4w==
Date: Mon, 18 May 2026 09:22:39 +0100
From: Mark Brown <broonie@kernel.org>
To: Chao Huang <958028483@qq.com>
Cc: linux-spi <linux-spi@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Chao Huang <huangchao@kylinos.cn>
Subject: Re: [PATCH] spi: Add spi_for_each_controller() helper
Message-ID: <01917d8a-4b0f-4047-a065-cfebaec9b211@sirena.org.uk>
References: <tencent_4C5A0FCF387BDB37C5512E5D709FD557F106@qq.com>
 <aggTKly_pVAYLVRt@sirena.co.uk>
 <tencent_74D72238CFEAA838A967727CA08D92C23005@qq.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7neIoY3niUjHohrz"
Content-Disposition: inline
In-Reply-To: <tencent_74D72238CFEAA838A967727CA08D92C23005@qq.com>
X-Cookie: She sells cshs by the cshore.


--7neIoY3niUjHohrz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 03:10:26PM +0800, Chao Huang wrote:
> &gt; Do you have an actual user for this or is this just purely theoretic=
al
> &gt; at this point? It'd make a lot more sense to add this along with a
> &gt; user.

> Yes, I do have an actual user for this helper in my project.

> The goal is to provide a new SPI controller API that allows users to
> access SPI controllers by bus number and chip select (CS). The
> `spi_for_each_controller()` helper is used to iterate over all registered
> controllers, find the target controller by bus number, and then operate
> on it.

OK, I would hold off on this patch and sumbit it along with the user -
it's not really something that's clearly useful without that user.

> &gt; When unregistering controllers we do start the teardown process befo=
re
> &gt; we pull the device off the controller list, and drop the lock while
> &gt; doing so. That's probably fine for a lot of uses.
> &gt;

> Regarding the controller unregistration case you mentioned =E2=80=94 do y=
ou mean
> the `spi_unregister_controller()` function?

Yes.

> In my `fn` callback, I call `spi_controller_get()` to safely grab a
> reference to the controller, and later call `spi_controller_put()` at an
> appropriate time (e.g., after the operation is done). This should
> prevent the controller from being freed while it is still in use, even
> if unregistration happens concurrently.

The controller itself will be there but we do things like stopping the
queue before we destroy the controller.

--7neIoY3niUjHohrz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoKzE4ACgkQJNaLcl1U
h9BVKgf6AxPM9stkRX7TS3Nj5x2yx7ohMEKOyEXoXx8lHVChbii5KM7R+clYJdu6
HRHNihOPlSOJprzyCziDmFuGHazdKvI0c6lWirxZ+gOFviUkQxkVD/ecUnrzZTdG
tDD/QMB8paVPkHK0bi8uN9XOoiEJdvRARNmMHb5HdJ+ddZPZFq6EH5wO7X5qk5Qn
qR4niTHFBuncsTwu7gPIv5oqWfXPaS5kwv+YsOeBKFk69qGDduu/5Bv14EFgy1dg
IrMlKi4oBx0WBHcMTjk9yX9F0/5J1tulg7uCpkaKDuSFPpo+uFexfcukqMDMWm0f
eJhgyoucxJ15wK4X8sCdcFofBYlKKw==
=6LRK
-----END PGP SIGNATURE-----

--7neIoY3niUjHohrz--
