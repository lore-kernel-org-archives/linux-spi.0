Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795086618;
	b=J10g9a4IaaM3vc4EfFts4k3h8kVQWIPq5I2P/3qVEpcEbciSnq4myX7xjCCknL6So8et
	 l7Zz+whCjfHiBlEO/Xle8kxLYnssX9eGnyWck9GGpU9ACKgkA6Vc7JUuw18BP92l1fTs2
	 89CuWFmxPHbr0l0lPcU40PCjPKsM1J25EeCgWDgiYwhCv7iZN8bvS0XGN0F5B2Wxqla17
	 wQdKKsTowpZqdXyJX58XD8/cTuxqswvdTegyRWBDMQnnmVeA3IelBaWAibpRHDlplHIDx
	 Beskd7c1ZlRb55VTOgMNY74Ye2vMzGgUxuIxe3eMQw0VhFabyBuxne2G4z/29TVn/sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795086618;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=vlXcs7mjCdcRGxHYT6jDvDJ2VAf258HQRNLzkFKinuU=;
	b=CKp8Msj25RmPsTEB4CC+VzgA7Mg7yZIVNWZKSEZeIF3w2VnlFMSXJ9wLqzwrCWzKKuGK
	 gDwal/80VyAPirefxycnXZE2i/AxMI1rbJz/ZZDOKXyh1CG9CVKmdW89UwjTKDGCkyjmd
	 +7fHN45wIh2OyV7r8TLonmEb0Z1f1ckjeaY+5y+PURpo402GvBam9t+2MxkQGjISYCoXb
	 ASTJwB8iwyOCbuaV0sEGzYPS9gPNRPGLAg/0rvsvAkFJ1U+oAxWTIbrAEJToC4+a0Rc8G
	 njd+hy7OiLSgx2+JtCXS7eNJExeSD2Nwq5UVT7n7pzWLZe9fP4ua+54BIKj4MSMAG/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eDnVsLn+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F93606A320;
	Thu, 19 Nov 2026 11:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eDnVsLn+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD43F1F000C4;
	Thu, 19 Nov 2026 11:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795086618;
	bh=vlXcs7mjCdcRGxHYT6jDvDJ2VAf258HQRNLzkFKinuU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eDnVsLn+onMpj4FWOq7Ow5lKH+8u3sMUP0vM+4ahBTJwSW49eu3FfkXOjO1QSMXwO
	 hPQIuncMCtLTFwUNXbteH/EA2/vjK6xbXMuM0IEWqffJ23YtdXH7vujJBvY8E5ECj2
	 YKbMElttXoAW3yzULJOegY2BO3Elfar2STT8ews6JIHlLjw4yVFi6jAH1mEuGYCr9+
	 +1jDeJgusrIMn6qwspPXyk5B29/gtA/sWLWlWozLJ+pTokYc2gXOnEpEkHshSoOGkY
	 YY/HcU3zkWUKRouxnLVaA7cgbtIXf2JAMPB5EVXwnDPvg4WomuEiUAbLmktqAhCa11
	 yjRjh9QTrh4Yw==
Date: Thu, 19 Nov 2026 11:10:11 +0000
From: Conor Dooley <conor@kernel.org>
To: Wang Yang <yang.wang@deepcomputing.io>
Cc: Aurelien Jarno <aurelien@aurel32.net>, Yixun Lan <dlan@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <groeck@chromium.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Sandie Cao <sandie.cao@deepcomputing.io>,
	devicetree@vger.kernel.org, chrome-platform@lists.linux.dev,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	broonie@kernel.org, yh_chung@aspeedtech.co
Subject: Re: [PATCH 1/9] dt-bindings: bus: Add SpacemiT K3 eSPI controller
Message-ID: <20261119-celibacy-parole-87117f5578a9@spud>
References: <20261118085742.1817536-1-yang.wang@deepcomputing.io>
 <20261118085742.1817536-2-yang.wang@deepcomputing.io>
 <20261118-backdrop-scrap-1bee34e06336@spud>
 <av4iWQb33bya48G1@aurel32.net>
 <20261119090553.1886090-1-yang.wang@deepcomputing.io>
 <20261119-defy-stumbling-72b230220a49@spud>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ThY01y4AItJZWe4b"
Content-Disposition: inline
In-Reply-To: <20261119-defy-stumbling-72b230220a49@spud>

--ThY01y4AItJZWe4b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2026 at 11:02:03AM +0000, Conor Dooley wrote:
> On Thu, Nov 19, 2026 at 05:05:53PM +0800, Wang Yang wrote:
> > Hi Conor, Aurelien,
> >=20
> > > How is this "eSPI" different to the eSPI described in fsl,espi.yaml a=
nd
> > > implemented by a driver in drivers/spi?
> >=20
> > Thank you, Aurelien, for clarifying this. K3 uses the Intel-defined
> > eSPI interface intended to replace LPC. It is a different protocol from=
 the
> > Freescale/NXP SPI controller described by fsl,espi.yaml.
>=20
> Ah I think this might be confusing af, because that device also
> supports what it calls "eLBC"...

As in, I got confused while looking at the documentation for the fsl
device between what they were calling eSPI and eLBC, and also didn't
realised that it was lBc not lPc.. Too many similar-ish terms...

>=20
> > On K3, the controller exposes a CPU-accessible window for the eSPI
> > Peripheral Channel. The EC client accesses its command, response
> > and memory-map regions through this window, rather than exchanging
> > ordinary SPI messages.
> >=20
> > The proposed controller driver handles clocks, resets, link
> > configuration and window setup. The EC transport handles the EC
> > register mapping and host commands. The distinction is therefore
> > the protocol and access model, rather than the use of MMIO itself.
> >=20
> > I will make the Intel eSPI terminology and this access model
> > explicit in the binding description.
>=20
> Please take a look at a similar series from Aspeed and see if you can
> cooperate on creating something common between you:
> https://lore.kernel.org/all/20260313-upstream_espi-v1-0-9504428e1f43@aspe=
edtech.com/


--ThY01y4AItJZWe4b
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCav7ZEwAKCRB4tDGHoIJi
0uWdAP0eNqiDJGtzGxm6n4vpqjW372f/8LLDhHExDcL1vkJGvQEAmAMw6HF3LruW
HG73JprYThSdt3/6oUWMkUShybcKSgU=
=wznF
-----END PGP SIGNATURE-----

--ThY01y4AItJZWe4b--
