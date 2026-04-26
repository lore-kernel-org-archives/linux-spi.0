Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0B11DE8BE;
	Sun, 26 Apr 2026 20:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777235797; cv=none; b=jRt/NabRQEafehDM+D03tP8vmYwMC0gc9Pus50+REH467pS7dSoA9zO1vOjAw9G+BPN5gtnwhVvh5SZXRkr28lAl1iQm+irKL1IIrz5QtUsuVBwqW/I7mM95UNesFgnfr/Q78hGfrb8yj6YRT7XKbqqoN43fQHL/MWCus48MqkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777235797; c=relaxed/simple;
	bh=vmLW+gcURuqyj6IuXHCZNkXaqIw1olQJu4lyUHHjuzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h5o+30Ec241C6zJBedIhWk9GJqVzMeaczqIyzFxDwBPhsnWnOcrK6FNGsvTRopt91WA+mrwMK+nq4MzLFLhhVXzBgEwoBo3ArYXsyWGXxyHnKDqv8JGfHWqR7TX1zbEiw82lF6+1jb3DMx8lzD/ds0q7r95tThpSgc34G/57QFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PemhRQtf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PemhRQtf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2141DC2BCAF;
	Sun, 26 Apr 2026 20:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777235797;
	bh=vmLW+gcURuqyj6IuXHCZNkXaqIw1olQJu4lyUHHjuzA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PemhRQtfVlUQaoZ/fz74gV89B06h6bN2JGqJRk73+BU0YWAjEdh09AhplT8Jk6OqX
	 XkuW5YNGck0h17wYJYaRYpNW0CQy/23BAikr+snLE2KqXWdZvyXFqluYS5g2IMSeek
	 wRTGvWu9kO2f0LZZP7PAfGqrdfZv4cV3f/hHqkc2Gnu2sd+k1xuSt2wbho2uJ+d0Sr
	 V7YpXyFcb5Q4X1RbB4z+tw9TYPdcSVb4SaXvCdKY09iArm3WloTaXafjtU0dNmeeDW
	 3Dr+TRW9mFbl12/guudSdiIuNJxHXniCVkzqmn56nR/UvlELSDIIDP5agZbQJfy/bB
	 ok9bQHXI4Ua0w==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 60AAD1AC5821; Sun, 26 Apr 2026 21:36:34 +0100 (BST)
Date: Mon, 27 Apr 2026 05:36:34 +0900
From: Mark Brown <broonie@kernel.org>
To: John Madieu <john.madieu@gmail.com>
Cc: heiko@sntech.de, jon.lin@rock-chips.com, linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] spi: rockchip: Drop dead zero-check on fifo_len
Message-ID: <ae53UlXrMIhARp7U@sirena.co.uk>
References: <20260425092936.2590132-1-john.madieu@gmail.com>
 <20260425092936.2590132-4-john.madieu@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GZHxFyYmxwXKHcnL"
Content-Disposition: inline
In-Reply-To: <20260425092936.2590132-4-john.madieu@gmail.com>
X-Cookie: Victory uber allies!


--GZHxFyYmxwXKHcnL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Apr 25, 2026 at 09:29:36AM +0000, John Madieu wrote:
> rs->fifo_len is assigned from get_fifo_len(), which returns 64 for the
> two known SPI controller versions and 32 for everything else - never 0.
> The subsequent

> 	if (!rs->fifo_len)
> 		return dev_err_probe(...);

> is therefore unreachable.

> Drop the check. If unknown controller versions ever need to fail probe
> explicitly, that should be expressed in get_fifo_len() itself, not
> through an impossible post-condition.

That looks like it's intended as a "you added a new hardware type and
forgot to fill in this field" type check intended to never fire in
production?

--GZHxFyYmxwXKHcnL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnud04ACgkQJNaLcl1U
h9AdIAf+JpSwV7HySan1dwT9+shLQY9YkAKLnc+sowrUMW5dB1wKPWvSUXjXYdfd
85c8dEba84NojF6lPbmaXyUHJ2CQqqhNXTy9po0skxo1cn/BivbK97uHrRNEK97A
eFyNhoNK3gtuHGi7ZxLBvESYSi9TPR/4vqjNuw0xprnxekzimoSnQ3UspAPwMVOV
XQJ0DzfjDdMnrFsNmdUN0MVM621s0l+051qYlkqt9FNMyKYUuuIX9we9OyHV2S7O
TPZ6udetrEHEg+TBxwmuLM0NgdDoLKObAD7DHWoCTOVXvy/Sn9OZ8xhyVxZaTCR4
fU7vMbcx5v7+Nih/4qhz0vWAR/aReA==
=BPiw
-----END PGP SIGNATURE-----

--GZHxFyYmxwXKHcnL--
