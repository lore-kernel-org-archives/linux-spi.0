Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EA34A261A;
	Mon, 21 Sep 2026 14:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789999299; cv=none; b=u9e1Rh8S3XMVInlwK1cGHID+5jehJqcCz/uhXbQN1Pfp4WX8LUc+t53ixkVST7BJtUvSqvDEO58cB05XDVCE6W3STKE4PHB2443x8m55pS8xHvZV1FX+snpJJpI8+tom+jIvWiKbphDc/l63OASi7BGw6d4sNzCqUwY4ZD7R8gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789999299; c=relaxed/simple;
	bh=ndVjxm8TKIN1nfsjmkl9cnZNSgKhc4ofPbtvhzyMKw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RlL+kcURk7emDrXwlCfszS14LhWNpRhzHUu29pJzy8XFffQZ5JGkAS//nG1OMqnEjHsYbKls2OveGMoq26ohMB1Ejj/t39CaKJ0o3AQo4IaQLTcuN5JmsJfDI5c59zKR8jj6eSsL1o8pXcPx2n5dn9XmgB7LW0zf+JOoxhWiC1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WR3O9xtN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WR3O9xtN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 929FC1F00893;
	Mon, 21 Sep 2026 14:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789999297;
	bh=ndVjxm8TKIN1nfsjmkl9cnZNSgKhc4ofPbtvhzyMKw8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WR3O9xtN97cDw5OLYA/QFj+rHt1l/6xP9ixUtxbXtWT4WYrnd49yKQbJstWfsDx1R
	 ANkgFva6ju34F1SqJtXXWxRgJE43aBen0aiN0G7iHZdexrvADdEnlHuVuAtEHrjWoO
	 Gu5Its2U51ujt1gm+HdIQAIqK25YY8JP6b2uSZL1gqH4glP5Oy5XVq8jMIn8NyXy8O
	 IRwPCMnR5QEGQD6F9WIHrpiZziPkD8iFKt4DdiXBqpQnutsb8fz2AIJYh6dN5xWp+6
	 HotR1695hIBx43lcF3olm5Qsu4NGzPE56DaPv6FgqYeHACtsRrgVOqMhMIW/+shekE
	 350Q3/RcIuPLQ==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 782431AC55A7; Mon, 21 Sep 2026 15:01:33 +0100 (BST)
Date: Mon, 21 Sep 2026 16:01:33 +0200
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
Subject: Re: [RFC PATCH 1/4] dt-bindings: spi: cdns,xspi: add SPI NAND
 compatible
Message-ID: <arE4vVKXS3epjgbL@sirena.co.uk>
References: <20260921093701.1341766-1-fei.xie@horizon.auto>
 <20260921093701.1341766-2-fei.xie@horizon.auto>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WV5wcvrA5GFuPAS2"
Content-Disposition: inline
In-Reply-To: <20260921093701.1341766-2-fei.xie@horizon.auto>
X-Cookie: Too clever is dumb.


--WV5wcvrA5GFuPAS2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 05:36:58PM +0800, Fei Xie wrote:
> From: "fei.xie" <fei.xie@horizon.auto>
>=20
> Document the Cadence XSPI controller compatible used with SPI NAND.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--WV5wcvrA5GFuPAS2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqxOLwACgkQJNaLcl1U
h9BU7gf/T+vYkaqiUknFKroCfHq87SeL86xlWaFcSnDD2lsSJbsi4OUcn8O63RIK
9jMqi2unojQsvmiRMjO4sNVL+TZk4V3KMbPkEI+jNJXGev7gnciJnAIwn+ao0m+q
fGL8Ph7HjeYlKdOSN6DxoZa2dcZpFP8ea84JG9mh56VHre9KnbYwp5Cr87jHXATR
9/uQ1VVBU5JdIrfQWEzpUlReBLNLiBzsXIP5Cyw+Sstm7SKdZzMSEEdowiex/+kl
Dh09cwv3j1dacBovZZ/L+9pIyYb1CKHH8lRVVo3U/HoR7agbZoel+2nRR4gQHKZ4
Owp0NKiLpoNMv48X8sfbNzZ/84Yc1A==
=PwHT
-----END PGP SIGNATURE-----

--WV5wcvrA5GFuPAS2--
