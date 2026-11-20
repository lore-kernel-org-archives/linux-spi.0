Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795176003;
	b=xO/AUXNBNtUnM5ypcUbsGo86gXUPjD2msdP/HynZybU9BTo+hcVASiVt5/aVjvrFVeKY
	 Uiq63vpvCAjR+B6uosqHAZOXm29HtQtGRCYq2iOlhEmTYnY7vfFri08cLOIW4+5hOsWD8
	 B9u+6+jPBFKmmMjD8EqD+nW1jQwZQxjWMsm49J2Cldy+0mK4daxaYPtKOPsMBX8o2azmk
	 d0ig+YzB4agcy7tFKMjbLJEmz4SLUeJcWYXLuKexIs5RW7Q/t1vKJz2Qx7qAwFRmMxp1s
	 RktADO95bvJ6qASk6wjbZFE9XwxxvhAMJt3sLTfehLjLpwVDzua/xyLgoEE7Cm2SjgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795176003;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=KLUTSIveEurvUqHqIjngzrWjsY2g92AlHoHn4R1Phnk=;
	b=cHsF7yxTqULUmPdpNUR6yLIbSxXa9XOQAL8pJhbl3I40QHForc61kHiP3lz8RWbijFJ+
	 znxejrVlLsYE9BGSYUEBMvsCRDCnI/TedLmYN+gTMRIKPFQsGiYRFetUwfZmJ9ILpiITi
	 c9M0b/VicV7cEdJYvrPBcxcIUqUR8VOPT+Lmi5aWMRk88+2yMG8VnKzhZJzx9NapP2DM+
	 PoElku0eD+lONZd1tNOBVxcbHJQFt4inLZoIS5so5PCvJdc4SIy0z1Ui+CGjpe4VpGclq
	 IpsZ+yvUrs+wlTwC1Q/fTRsOqcEHYNLZB/gPPv8UaI/y3mO4CwOmfOB0bP6HkQd/9LA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nIyQwCfN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3937D606A33B;
	Fri, 20 Nov 2026 12:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nIyQwCfN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCC471F000F4;
	Fri, 20 Nov 2026 12:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795176002;
	bh=KLUTSIveEurvUqHqIjngzrWjsY2g92AlHoHn4R1Phnk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nIyQwCfNw0q2bcaPZ9MUGSS4h/2F8oapmy/EdlaFhJviZUWEN6Vxo2Pte4MX4L+jk
	 lSf4KKb3/XjcGHT+FiDNmC7v16ecemwrkpfP6dV4QlL/d15UEFbjJMa2pv06BCyS2m
	 I4/aAHJizYUdXZmJze9Fz+6ywTFMk4gLCQ4Xext9oHkAJ2wX6X9TaCJxsE6C3u31rD
	 DFnYb5jlUHKmi4HKTACr9nV2sdaPc/094qNi8P6pUtws+DO9I3S1Hlb2nlGwvGpe3c
	 GtrGmN7+aH8qJS4iX9FPCsh0DoCnrkPqzvQis0JNYogBLS9I1K00LvBqGbme7BTBTy
	 G8b6GHi1yNY7Q==
Date: Fri, 20 Nov 2026 11:59:58 +0000
From: Mark Brown <broonie@kernel.org>
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: rdunlap@infradead.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/spi: Return failure from spidev_fdx on I/O errors
Message-ID: <7ef05c23-9038-4886-ae5e-618ffc7eeb2d@sirena.org.uk>
References: <20261120061922.98182-1-zhujun2@cmss.chinamobile.com>
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
	protocol="application/pgp-signature"; boundary="joXPQyofIiPowM9P"
Content-Disposition: inline
In-Reply-To: <20261120061922.98182-1-zhujun2@cmss.chinamobile.com>
X-Cookie: Error in operator: add beer


--joXPQyofIiPowM9P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 20, 2026 at 02:19:22PM +0800, Zhu Jun wrote:
> spidev_fdx logs failed ioctls and failed or short reads, but always
> exits successfully once the device opens. Return an error from the
> helpers and translate it to a failing exit status after closing the
> file descriptor.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--joXPQyofIiPowM9P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmsANj0ACgkQJNaLcl1U
h9DhWgf/fxW8PVku+fLvFyvU7Rk9PbTXKD1+BvuM3ajWzXG+DolqmiN8+PQyt40/
VMXhq6FhbV1HKKvQtTxfTwxS1D6B2IV4Y8ZqRUDm0u3Acv2I+1jt1z6v0DnIMU8t
S2XlKqClhn2CPBv+Alr5q7298y9Sg+4H1fIhx6PaMph6hTXa9Xw1pAnrrf+dwAFE
V9DokzqMQz5VSqeZdvf2L1Utxk1Lw76/r480a2w9wYKDwZUEr+VEdWj2zTGJRFxT
+hrs1S1CxOfiyH2M7jt8ZZX8lBueeF+6Qt6hmFBk9LoPSM01uCUEhqBlwoZnpTmY
orJ7S9J9A8YUxSobfpHn4amUdeYuWg==
=tMZr
-----END PGP SIGNATURE-----

--joXPQyofIiPowM9P--
