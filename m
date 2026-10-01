Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BCD49D583;
	Thu,  1 Oct 2026 11:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790855940; cv=none; b=eZoKrAU4CiUyV8AJ8ztjLH/yt5bzg16+K7c0/oBWkrk6iKfHObckJKm0SyR0gDQX0uQRsdOwljkBdTtj6MYjRQ1N3ls3BTa2NQ9LJJlAENmw2XU7f+KpCs7MwilmwP0JsCxb9CmyXAe8n5AmdZnbB1mCfBlx/A7uqqAnJ/C4nN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790855940; c=relaxed/simple;
	bh=0DY28tVKEOHcKCjQoTQR0pahu7Gw1k7TkxbVk4W871w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c1hxAYHQ9YNZHVmBG3YH36jCSPmhZ91+BU8gSGTgH4STDYmozADnGlcZu21ot4nTIoI9sbfeH+Xll5zlVfq4Y8ZSYg+RwKIdB4NtNu14zkI9K1eN3bH2/xLX8yMs9WoUbFLoDDdZGCvTSXXerY/tTRhZsOOswpcUzyyvHagnomQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4BsY0qr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4BsY0qr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C87041F000FF;
	Thu,  1 Oct 2026 11:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790855936;
	bh=4FrgFUUOctZxubrnk+e4k4rTcez5Up8VT4yYhIW7BSg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=H4BsY0qrK+AQY/TP+m7HbS3BAramdgvvgKFTeMIxtrAVcf8YpGYqJhfF1j2ZkGHGD
	 UyuSnbU0ORv/AtKwB44xMmuEGfUmsdBBttGfLcZHhlK2nJ4OkV1G+ZJ1daEErF+Ipb
	 o52KLyFq9ePfTf2sO0vxKiurt/cb/foCzU2dvRofL8NTOiMkiylhGDid7sbYZrt/NM
	 /YqimIet4zQGaOcGKFUH1iuHvZGKAVqzd31cJ+8OOnhL6WjeJA2PUu5jnUHhJTT5sU
	 JTEAsuqxCYq2d5M+IBTRS7u92+WzmFP4g0P1CE0W5Z+evWpv1pG6YQ4JDtvjmc+s5i
	 xABX2waflwQ0Q==
Date: Thu, 1 Oct 2026 12:58:52 +0100
From: Mark Brown <broonie@kernel.org>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com,
	michael.hennerich@analog.com, jonath4nns@gmail.com,
	andriy.shevchenko@intel.com
Subject: Re: [PATCH v2 2/2] spi: axi-spi-engine: fix stale SYNC IRQ pending
 in trigger_enable
Message-ID: <f0b918c9-2ede-4ff6-9ccf-6b819b972f38@sirena.org.uk>
References: <cover.1790731588.git.Jonathan.Santos@analog.com>
 <b1573f16b8e30f22877677026bc2296420a0c527.1790731588.git.Jonathan.Santos@analog.com>
 <8ba05b99-36ac-4a76-ac11-e6ad92c631d4@sirena.org.uk>
 <a1fb38b1aef69d344d31235fbb4bb55d75aaa1d4.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="r6vfNSllxNR3TG7A"
Content-Disposition: inline
In-Reply-To: <a1fb38b1aef69d344d31235fbb4bb55d75aaa1d4.camel@gmail.com>
X-Cookie: Do not stamp.


--r6vfNSllxNR3TG7A
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 01, 2026 at 07:55:45AM +0100, Nuno S=E1 wrote:
> On Wed, 2026-09-30 at 14:09 +0100, Mark Brown wrote:

> > I'm not seeing anything here for the issue with ensuring posted writes
> > are completed before we drop the lock?=A0 The write may not be visible =
on
> > enother CPU, we need a read from the controller or something.

> Just for my understanding, why would it be an issue? The trigger register=
 seems to
> only be accessible from the trigger callbacks which are protected by a lo=
ck where we
> have implied barriers. Im sure I'm missing what can go wrong here :)

Are you sure that's true for mutexes?  I thought they only covered
memory, not device stuff, but ICBW.

--r6vfNSllxNR3TG7A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmq+SvsACgkQJNaLcl1U
h9Aspgf/f+vLyXCQsNA5I34OCgn1WEPgAAE3OVXFNzmSAZoLTBcSxMvqxCI3GhjD
V2b7QKNwpbdKHJWCyNDQDkAfDmtYlh6XNMToJ9vaBCG82lmzc1ATDk7JCjW2p/jS
GnRNIuFJ7GkbW3F/LcYe6JshFEqGMdTeu4jiyAT8Ivucr0XxzH4+vfOStlSQLeZS
z7dv2AndPaDzKjlvbM1n9LVUG2PMy4JkRto7Jv4M7VlJPZywEBRKzp6rB1tbBKv6
vvhz+ONHsd+Ln1ZUp2e+83gqzcwZaQprgkctsSGt1L8sLAhI5iA9IZ48uGnaq7ef
f+0dsOCdrit6rZI3GxXMfLiDS1EX1A==
=WbVS
-----END PGP SIGNATURE-----

--r6vfNSllxNR3TG7A--
