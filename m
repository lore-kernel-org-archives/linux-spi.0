Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D8A363C4B;
	Tue,  9 Jun 2026 15:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781018725; cv=none; b=ixIzrwp7JRIo1aBXrN9Ej4Xj3lspKE8ml8GWwfG6YClLUv54EClxYRonj0ZwxTDi/Nny/s/4J0Ti2XgXJ/5XZ2VHeaYbGcksH1iHNLzZMd+jjR6ufK3qZuOps0K58mR+ypvJOJuOR9Mn2ITqijUmQ7OONWfUT1PkcJc+8GScbCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781018725; c=relaxed/simple;
	bh=+JfcPP+gULOjOmDwuaNl05HjBy4ikgSwaTQ7biMDM4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=edVre9KA3Dm2qgY+arwNzxrN53RNEwbI+8wbpaMRgjDnpfLXFXli1q7nWudae9vqmAPWdMEPVa/eNFVy1vZHVoL7P3YXmP9tQMgpWNiNojmHJNahJHaL/PReom6xKQpLCzINPqWl7oMi5tiDgae0/ymeJcoAEJqgwN4sqXEIFq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M5xaxWMA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M5xaxWMA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 782701F00893;
	Tue,  9 Jun 2026 15:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781018724;
	bh=+JfcPP+gULOjOmDwuaNl05HjBy4ikgSwaTQ7biMDM4w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=M5xaxWMA66yfWY27vemV3bWNZg461GRlr8uFKKZD/tx+eG3p3ri0/YRZauKmilSP2
	 80wtYUCb6O0mf6ZkGKEzZoR80ECL7q8LATbaN63OXnKjiNhi+yzsixs7zwKGVINkdA
	 9zgMRZ0xlD3lQHE+ulTi+g6DvGmGF+RVG9ORCj02cNjUaRTscNP0gz1mz1lT0hEg7Z
	 q2yMrK6YiCDaZ2xdC3dcso41/5Ilti10ffEjFxAesCHTEi02ZGMD+piuSq3LoHZ+P7
	 Oayau87FOLqinlUnzPSWNPjJK5agjvHt44PBJcJAYB5+6xmEOiipGpt6GBoW5lzsMJ
	 n7J/pET7NGSUQ==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 699131AC56AE; Tue, 09 Jun 2026 16:25:22 +0100 (BST)
Date: Tue, 9 Jun 2026 16:25:22 +0100
From: Mark Brown <broonie@kernel.org>
To: Ninad Naik <ninadnaik07@gmail.com>
Cc: Rob Herring <robh@kernel.org>, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, me@brighamcampbell.com,
	linux-kernel-mentees@lists.linux.dev, skhan@linuxfoundation.org
Subject: Re: [PATCH] spi: dt-bindings: octeon: Convert to DT schema
Message-ID: <aigwYpXmVhEnyw6v@sirena.co.uk>
References: <20260607142356.2844008-1-ninadnaik07@gmail.com>
 <20260608143259.GA2569066-robh@kernel.org>
 <20260608150040.GA2675433-robh@kernel.org>
 <c6cc71bc-7256-46a3-ad4a-a1ec4b38400b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VZ1ibPzhW4gpbaRb"
Content-Disposition: inline
In-Reply-To: <c6cc71bc-7256-46a3-ad4a-a1ec4b38400b@gmail.com>
X-Cookie: Leave no stone unturned.


--VZ1ibPzhW4gpbaRb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 09, 2026 at 08:46:44PM +0530, Ninad Naik wrote:
> On 08/06/26 8:30 pm, Rob Herring wrote:

> > Maybe not. Seems this is used on newer Octeon platforms like cn7130
> > which aren't that old. Some Ubiquiti devices use it and run 5.4 kernel
> > with OpenWRT:

> In this case, should I keep Mark as the maintainer?

Whoever originally upstreamed the bindings or driver is probably a
better candidate.

--VZ1ibPzhW4gpbaRb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmooMGEACgkQJNaLcl1U
h9Busgf/ZuDtAPL3EuWIZZeZJ/yzyuO3W5PNIzbpiMcz0RcsZlsqQvyyVR8Bu3zK
l3+2Rp6OKp93VGdW5ZBRN+/pEGmlzryXXOo7Iv/ECkmnKDbvLOQugFZe0GE8ji0S
GGoegu95vmQPLVl74Gr9WHYGblxv0XNYSj0fuBCEGW+FXHgrshm3PPGaTvBgqEZr
fH4bf6hfzbq/DkckBoDwMbPZ/ReYu+vqYAZzDjmwiM/42VFc+huq54gtNQ5vXJlZ
MnDV8eAhqf9Zja6XrXovfquOjnFYoPCt5zyhuRD39nUIob1U11x/v0RPXsb5lyv7
617Eghxrwxj8bPUbNlPtdaBLg7ya1g==
=530m
-----END PGP SIGNATURE-----

--VZ1ibPzhW4gpbaRb--
