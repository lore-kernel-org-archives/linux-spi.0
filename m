Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7410630674A;
	Fri, 22 May 2026 14:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779461468; cv=none; b=Q/nMa9c6DN7j63mW5G0dLopIp9O2caolZsYmWq6Gn77QH97DZN9BgG4GSPXRea2g4Cw3f237oTm4WCTjXFpiGPiOBa/r4ZEi7iinpivgvdsHffAs0LufsiGT2xznOc1Id6rfHZ6CDHZODe91hL4sBSf65BEMUSikMolxlkB/buQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779461468; c=relaxed/simple;
	bh=VKifsvz72wakbXJnmD6ggagUTXurtLLsueCswLC1AIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TdqDw9a2hD1R7kNlCxrp0cqQgRpbRELIgMe0WaAmjldDRix6XrtKkauM1Kg1cGNzebSvfm4jhsbFamKJkjSU0glMOERCu+QfdmXJrsIQXOnn7Dj9rX9ZfaBF9eADhSyx9GB5+2Kl9L82rQeHrRHXNbcIwQKIMMhrqRKEj0Ll98A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mzioNVZr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mzioNVZr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E8471F000E9;
	Fri, 22 May 2026 14:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779461463;
	bh=9r/7ESFBBf0EBfmB69vKP8jZBNgvzS9T3axn2jiJId8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mzioNVZrKwNkb5+M5x9F8wz5u+Z9alBo2XJ4O1IQ428aNC3R3NPv6ANkZa+5oKbFs
	 LaC2pQQgc8bH/u0XvMzrau526x+spX+yniXMWAxNwQQtmemNjCp3CvYTZ7c/tbi0Wr
	 Zaor6QDOuTIxmZpvLo7I3Ai6tJmUlTPFX1P86OPJYBvk/rAOd8bLr2JledS1DWl04Z
	 xyxFtwUdTZ81f6Vlb4jfgiH7YzwxEvqpllU5Uc199q6XSXZDKhjEF0lSwJt/vRY3xU
	 0/YlCWrCw2xA0Nz/pg053vBm+oJ669s+P+D0cVOO6phhKv46QOBl6QyAB8l3E29uCC
	 BN3S0Nc8Cr16g==
Date: Fri, 22 May 2026 15:50:58 +0100
From: Mark Brown <broonie@kernel.org>
To: Jani Nikula <jani.nikula@intel.com>
Cc: Peter Collingbourne <peter@pcc.me.uk>,
	Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
	David Laight <david.laight.linux@gmail.com>,
	Christophe Kerello <christophe.kerello@foss.st.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2] iopoll: use udelay() for initial polling
Message-ID: <4e8d842d-790a-44ad-8b80-a0a8df1fde2b@sirena.org.uk>
References: <20260519102446.209723-1-peter@pcc.me.uk>
 <ag23HbvCqhmK0Ph1@intel.com>
 <CAPQLkRhtdV5Whv3ZNtZ8Xwq5V0chaQ8_tUbh7VnTexezid6EfQ@mail.gmail.com>
 <d602e4ec24533aa239f04901574b4f4826640455@intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZN2ssdl7pWtWe9vD"
Content-Disposition: inline
In-Reply-To: <d602e4ec24533aa239f04901574b4f4826640455@intel.com>
X-Cookie: Celebrity voices impersonated.


--ZN2ssdl7pWtWe9vD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 21, 2026 at 10:03:28AM +0300, Jani Nikula wrote:
> On Wed, 20 May 2026, Peter Collingbourne <peter@pcc.me.uk> wrote:

> > That's what I had in v1; we decided this approach would better handle
> > misbehaving devices.
> > https://lore.kernel.org/all/20260517150253.031dec09@pumpkin/

> I think the problem with trying to adapt to everything within
> read_poll_timeout() is that every step like this adapts to a *specific*
> use case, and once it gets specific enough, it's no longer usable to
> other scenarios.

> Having to reimplement the whole thing in drivers is much worse than
> having to do two calls.

> Could a staggered approach work?

> 	ret = read_poll_timeout_atomic("short delay/timeout")
>         if (ret)
>         	ret = read_poll_timeout("longer delay/timeout")

> Then you have better control of the behaviour in the driver, instead of
> adapting a generic function to a specific use case.

If we're doing that it still seems like it'd be better to have a helper
than just takes the two timeouts and does the right thing with them.  My
original feedback here was that we should have helpers which encourage
good patterns, and TBH I expect there's probably a bunch of scenarios
where some fixed cutoff would be a worthwile improvement for very little
effort on the part of users.

--ZN2ssdl7pWtWe9vD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoQbVEACgkQJNaLcl1U
h9DPXggAgzSxPKcsaEcV/0IMuUnU5Owew088svr2nXu29cCo8VIjBkHcDWzqICd4
YKCmiqZ+lj2D9YNcJHcroJb3ANw7/x758TwsBlvBqDlsKzbMU7xAuBUUBMi4H4KF
xG9an3xqhw7id5QuoKF5+LY/cPlZM7aY9KG9r7RwHCOrZxuGfw3pg15XxGGn2KHK
5e0EVKVZoa5EMRcz3l5nHJz3l1lUHUv73pZEs0SkO43B2O7ex+rv5BNKit5Nc0gb
HTKuAcLmzNXeYOjGnJ8UkS9JDQhU/Jk/IIpm1vMDbP5CZpi9IeFqlEdTEe4PjmwI
+gmQkjmvmdENpxRpAEaglRFc2K/+wQ==
=a9rW
-----END PGP SIGNATURE-----

--ZN2ssdl7pWtWe9vD--
