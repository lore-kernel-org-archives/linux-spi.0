Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D453395D87;
	Thu, 21 May 2026 19:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779392771; cv=none; b=mzKv5WBTR9UR3lqNbfHOIx2V96vfSrvHA3okw4VR8LcozZ+vEuuA4AtEnxZqafs0E00JkaVvZuk9mPKlgVICjSuYObo54jfl4HOXISKm7X2IgEAJ97Q0v2HdCI8PO11M8YsG8Lh23kCY2vFf6dwabFQOicrO5T0Yx1CwZX8bd1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779392771; c=relaxed/simple;
	bh=Fl5Rt2JQDBkzN2IYCYCNYaDmr7KbbjfvidjX3o3GvT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kco9CYjRcEjC51+BDEmcA8jjybCP2EhZ8GLnYx0DEexTbgtSePuSHQdEP1uGbh+oEFy6XHtK9u7h2a7GyAC2ve7ixhBJpLqkn5YyQtWFbAVMNMJpJzidQIUl4rmknkmYMUZKsNbS1iolPOKSUFzwdL0ldrbgxJR1p3vmgPkTT+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KmDSF4Yx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KmDSF4Yx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E29D1F000E9;
	Thu, 21 May 2026 19:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779392770;
	bh=Fl5Rt2JQDBkzN2IYCYCNYaDmr7KbbjfvidjX3o3GvT4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KmDSF4YxGK5lwh/3XI1QId7FTwnvYtyg5GcUHSUYLjdVDqUTh+tz9sXyQZRnVa36W
	 FLZgDGbkeXI5aKbhlWW0rdho0Z+rUjF6Si7m2ePcBUSRKf3sUYHlsTPho0wvE/7Acq
	 efzddQ1TtpyTLtcNg6KO5bIDIJM21Z0ffOGgF1wmWUSWCIhUH4C+hGwWxmaJReYQh8
	 FoN0z0TqL3bpiURNqKHOiMo9W4wLXZi/MKKzX80wFo9nqNrQds0ajaPN6KfzvwMlp6
	 a6+yIEDdcsYwJdeTZ7QIQdjw+4oioynjwxqZZB4VL2ZIbn+IGU+OEyxRPjsT3nY0bl
	 f6/jbTabO8O5Q==
Date: Thu, 21 May 2026 20:46:04 +0100
From: Conor Dooley <conor@kernel.org>
To: Zhengyu He <hezhy472013@gmail.com>
Cc: Han Xu <han.xu@nxp.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	Wei Fu <wefu@redhat.com>, Cody Kang <cody.kang.hk@outlook.com>
Subject: Re: [PATCH v2 1/2] spi: dt-bindings: fsl-qspi: support SpacemiT K3
Message-ID: <20260521-justly-power-2cc7ebc7b71e@spud>
References: <20260521-k3-pico-itx-qspi-v2-for-next-20260521-v2-0-52bce26e5fd8@gmail.com>
 <20260521-k3-pico-itx-qspi-v2-for-next-20260521-v2-1-52bce26e5fd8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Q1v/qv2VOGr4z9Xj"
Content-Disposition: inline
In-Reply-To: <20260521-k3-pico-itx-qspi-v2-for-next-20260521-v2-1-52bce26e5fd8@gmail.com>


--Q1v/qv2VOGr4z9Xj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--Q1v/qv2VOGr4z9Xj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCag9g/AAKCRB4tDGHoIJi
0vF6AP9gFrzDNEgWZsaPmwdKK3f9biN7qcrDFQj/muohigql/gD+Ka6ru1AwIEwJ
P070LTEI8edHNAQk8SECkFyTMhMHlgM=
=VhWP
-----END PGP SIGNATURE-----

--Q1v/qv2VOGr4z9Xj--
