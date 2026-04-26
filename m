Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390F427587D;
	Sun, 26 Apr 2026 21:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777237440; cv=none; b=A2fhYBiTTVKfeG0BFtmtm5ZDOxk8n59VJjOBlpnuNLu+HZTncvBXddZbf3CsxO9zVceKlFF0RBw93IU01AyGL9pYXIWbJjpxAIk7NQdgLSLUwwOoid1MnQNbsUQkXn+g6uYSBnueB6JaWbBJuDMtf5kSYXmEw34B804DnAxmFqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777237440; c=relaxed/simple;
	bh=Wrf41ig11pDPmW5Xx8GjFOOc6XdqNtHGR6ps8dwVaJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lik6g61hm2jr5mu77Pi4hAEYF+DMfmklfhRiuSs22/9i2b8GQMj34rhv1hNgxWFCHKPG2nKW6Mo8+s8T33z7dX7Z6n3fhNPKleVm08Wf/iPav3kx6i8DsUnQvMiExMZJW+8pm+tSPjzoor6Qg4djZrGBK8fVISkgTGzrumR1lAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d7LX8tYZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d7LX8tYZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A020AC2BCAF;
	Sun, 26 Apr 2026 21:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777237439;
	bh=Wrf41ig11pDPmW5Xx8GjFOOc6XdqNtHGR6ps8dwVaJo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d7LX8tYZlfN/8NDFiacDb9uc7ExAMb9cH/drPCCn0/LkFnMgwx+pGnrBMd4TGhuMK
	 GpabIVGaJEG0CxRIavF70Hgc6HKx+ZRQ3VzCzYng7F0cPwErWeM2J++E7eUawABzn2
	 D/wDCICbCnnpYHolIPex5WILqeJU2CHgG08BZAdhdSdR3FdMv/qnF1ZFYI4nx7Moqh
	 gPts1BlVOhB1MZaLhnjnG459W4shVbM70eOPqDlFJHmsdnzKMvNRXGaa9gFHZbzykt
	 wwpYO1Q39wVARBJiKrBlTrrIi3W4njoUAWWwQNC3qzji8FkCx9jKZEiD5CLcw0SKqs
	 e9J+pGoh1aQVg==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 6735F1AC5822; Sun, 26 Apr 2026 22:03:57 +0100 (BST)
Date: Mon, 27 Apr 2026 06:03:57 +0900
From: Mark Brown <broonie@kernel.org>
To: john madieu <john.madieu@gmail.com>
Cc: heiko@sntech.de, jon.lin@rock-chips.com, linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] spi: rockchip: Drop dead zero-check on fifo_len
Message-ID: <ae59vaZI41jM3L6Q@sirena.co.uk>
References: <20260425092936.2590132-1-john.madieu@gmail.com>
 <20260425092936.2590132-4-john.madieu@gmail.com>
 <ae53UlXrMIhARp7U@sirena.co.uk>
 <CAM9Qs9B8SSGXrR47toj9P+_EUHzrwKwHnu9askVhGxm9WFzQCQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KIaGwllxa/Orm8ak"
Content-Disposition: inline
In-Reply-To: <CAM9Qs9B8SSGXrR47toj9P+_EUHzrwKwHnu9askVhGxm9WFzQCQ@mail.gmail.com>
X-Cookie: Victory uber allies!


--KIaGwllxa/Orm8ak
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 26, 2026 at 10:57:31PM +0200, john madieu wrote:
> Le dim. 26 avr. 2026 =E0 22:36, Mark Brown <broonie@kernel.org> a =E9crit=
 :

> > That looks like it's intended as a "you added a new hardware type and
> > forgot to fill in this field" type check intended to never fire in
> > production?

> Yes, that's a fair reading. I missed that angle.

> Should I drop this patch and resend the series (v2) with just 1/3 and 2/3=
 ?

No need to resend.

--KIaGwllxa/Orm8ak
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnufbcACgkQJNaLcl1U
h9CyIgf7BegAvKVp9/ZSHceh6ufR917hLKiQ8W6vR2blwvPGEDbo+L+ZQ3w7eTRH
lQuTj7gJ6Z77QIVGw3ZuLLWBHfyM0E3yP3KnDsHseHlaON/3PXA/7NiC6as5RXdM
phoJ3j/dmQZHvGzFwncq4+RWyDNYkBLcziixgsjMfzfPRn2kkanjlmBMSQlLpfkh
DwyKp4NPAE0eFwlsZUNqqOPJlCJI+u9yilys1z177dcvCCbF/40r9Sh7fD9Gunfb
Ko+PbIX3V/9t40ASbvwNQQkcoqgaEg1GoyS++YV/OAd3hHMkp03GrMXw9l4MbyO2
ngxNqYlZAiwISLuKILVJXJf2vCbxXw==
=aRJn
-----END PGP SIGNATURE-----

--KIaGwllxa/Orm8ak--
