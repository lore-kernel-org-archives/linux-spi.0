Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9053B6C0C;
	Fri, 29 May 2026 21:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780091788; cv=none; b=RE8laUptrGjHfaYfuOkYMENDG4DfyykxRsAB9Se1uWGVnWLWFW5Gj6yFJLt9IBqCG++opyywHQCSHgSzjGwZ4cKPPnhrQ2iS/AMv/QkOoKcjMIc/toieKAokeTi1/c1ZDI+zuTs6guTdKARxY+QKR/8e6EiFkuX2NW9C5uBKIpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780091788; c=relaxed/simple;
	bh=QV56WG8EPVP8qKxXVqIgxIXQTA6XQ0Vlcst6vjBR8gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vnhi16Nb4A5fuv7GCLtLwv2KxpBuKbyVDwNXZu0jiEEbcHNMZhJmpOPYmzplXdY0wbdGaUr2dMaZuxnZxuxsbzX+t5vvJHa2+IVzjLoe20vJYI/iGRggnnKKdVTu76qBfeornLAXoDj7T4vxIUPxsIgdZ/c5Sybd6xKj16I9rLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iROJ9bN8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iROJ9bN8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A0841F0089B;
	Fri, 29 May 2026 21:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780091787;
	bh=acTCS0LvaDF89BF+Cj+gYo2+9u/eqmnlFCtNM+WWmL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iROJ9bN8LD1J7YwwWVpQa7zaV84RbIr//sdlD6E8V2/14VPBEf8IB1yLEPcBZLe09
	 TAJ7VUByi3Z9+A6o6hlslXVG8FljBsPHI1VTiHEVboJNtnbEzbkLN/u46nw4SlJ1Ht
	 Yk4KRXSeqJK5jnfFXsU+OL3JNcexIbhgVgQ9DOkJ7NcO70tYKhgtYiN5+zCkvjCmaU
	 DFYr/c0shDkPdg9rvXjUx5McstBCHswX21KN1aFxD7jWAmQUXMLwfJOhbGk1AIoaKV
	 tobXMHMjBDb8tuXdlhqX5f2Du8/vARa/zKzeD7/v0kPEAxkxYqX6VhsBr+clT+DmWR
	 Qs7k5Eu3AgGTg==
Date: Fri, 29 May 2026 22:56:23 +0100
From: Mark Brown <broonie@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Peter Collingbourne <peter@pcc.me.uk>,
	Jani Nikula <jani.nikula@intel.com>,
	Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
	Christophe Kerello <christophe.kerello@foss.st.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2] iopoll: use udelay() for initial polling
Message-ID: <19509a36-cf7b-4f2b-a25c-2c1293c19b6c@sirena.org.uk>
References: <20260519102446.209723-1-peter@pcc.me.uk>
 <ag23HbvCqhmK0Ph1@intel.com>
 <CAPQLkRhtdV5Whv3ZNtZ8Xwq5V0chaQ8_tUbh7VnTexezid6EfQ@mail.gmail.com>
 <d602e4ec24533aa239f04901574b4f4826640455@intel.com>
 <4e8d842d-790a-44ad-8b80-a0a8df1fde2b@sirena.org.uk>
 <CAPQLkRi1aP3N2d7GzrRfXF0xDyamt_n9AKzFvV1WdpNk0ZymJg@mail.gmail.com>
 <20260529122016.0059f55d@pumpkin>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xwlB7K8CcKpO6LYY"
Content-Disposition: inline
In-Reply-To: <20260529122016.0059f55d@pumpkin>
X-Cookie: Equal bytes for women.


--xwlB7K8CcKpO6LYY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 29, 2026 at 12:20:16PM +0100, David Laight wrote:

> I think I remember someone saying that the spi hardware interface normally
> generates an interrupt when the request completes?
> So for spi this is only fall-back code for a few systems.

For something like spi-mem I'd expect to have interrupt support, we go
all the way down to fully bitbanged though.  You also often have
copybreak cutoffs for smaller transfers (and quicker operations) where
it's more efficient to poll for completion than use an interrupt, or
PIO rather than DMA.

> The code has this comment:
>     /* Wait for the write - typically 0.6ms (max 5ms).
>      * In spite of the datasheet values, I'm seeing 200us writes. */
> It waits 200us and then polls every 50us for 2 seconds.

You can also get fun with things like contention on shared buses.

--xwlB7K8CcKpO6LYY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoaC4YACgkQJNaLcl1U
h9CFOQf+LDfTuNiV0Sbn3qqr+LCSrj2x1NPjSHlgGqY+c10MWbYWVHPH3uJaKjYT
beYFzGeWp6nJbanSNW3fRE5jq6uv06YlhVO4N3IDngveUtuoj1YnCahUuB/oKk4h
58+qv7CTIQ3xQFPwyYqSm++xB7dS1sYmJHFFcbsDV6uiICUl0ergVkRb9ub2Bdt7
atKoEOzoXy+kX5EUnAIfnNzxNKJVMWtswaO5LkLVKMWODgbYnAM1HMrUtQSXC4sg
te4q2wlgsg0Lg30BRsbRNiHL0w8x1PjC1/oVWcOYrbV68wOY6kTyMiSqCrjsqtyb
XrJoY4Jl8s8mtaDRnbhmnu0aW1r9FQ==
=KANW
-----END PGP SIGNATURE-----

--xwlB7K8CcKpO6LYY--
