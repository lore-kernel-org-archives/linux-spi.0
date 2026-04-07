Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3550B394498;
	Tue,  7 Apr 2026 11:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775562731; cv=none; b=SQdkE/+vSpxSM2qsHU2G4hQBUbRfSGPrG864pevaPYfmtSkQ6sxpM592mqNkXM/Zy6BjvZBp/WzLskIdJ+pGu0skqaihldUJCyGSp7GSIJUW8OZ2gsrdfQPfkhjgonB6MgJ+657Ceokr3JXpcoRZ5a1FA9BiWMUd0dfxG6nSaig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775562731; c=relaxed/simple;
	bh=zF75wGoEBx9cLBe18NoiTa6RhLmy9PY+hNZSJh9GW5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qZ0jNj9kQmHImQO3LiMtvaCZe/3AIeeS2lvuricLWVyxliP639ARWY5l1h3lVjztQh6PF4xD1jivsTioJYzaoRrUB087yVt6NJTWgO8Tgf7jnvnmPrDO2uQOm/KLougN7vg3qSDa03Z0l9IWh6Vmy3vPClcit1UmbV8EIVj6fHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LY0sT5Ne; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LY0sT5Ne"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AA56C116C6;
	Tue,  7 Apr 2026 11:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775562730;
	bh=zF75wGoEBx9cLBe18NoiTa6RhLmy9PY+hNZSJh9GW5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LY0sT5NeWvQME/oib3PqnJVBTKzgHV+jZLYMkVRAba7e5oxEh8qRd0MngNHQpMzrt
	 eKUPLhVCPSxDW0jCbIVPL3WPNFiCo9/eNn8d8Q37HpoFmHwxhyDex97J3NoGaODUDL
	 xJsgjR82wGsL+zc0h5/AwQUQhXFhI+r2sUfbMgcQJVconbQyVKv3cWaNrDYmKESR2M
	 +PcMrOmJZnVEblGBSPz2Zy+hqNlO4GATvnYUc0DgwHaNw7p4eyUjsFFqy4bbaLpBWa
	 Mb/jML3Ujefbatpcgk4ZGmSHybFzT2EohMxLPNaPuYLeG7TwiCfFRnW/WpJrbjF7MX
	 GdwGuU+Vnk9SA==
Date: Tue, 7 Apr 2026 12:52:06 +0100
From: Mark Brown <broonie@kernel.org>
To: Pei Xiao <xiaopei01@kylinos.cn>
Cc: michal.simek@amd.com, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V2] spi: zynq-qspi: Simplify clock handling with
 devm_clk_get_enabled()
Message-ID: <6c302906-6560-4f5d-a20e-3b35717d74ec@sirena.org.uk>
References: <24043625f89376da36feca2408f990a85be7ab36.1775555500.git.xiaopei01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8CfVjSKAxBmRz6UA"
Content-Disposition: inline
In-Reply-To: <24043625f89376da36feca2408f990a85be7ab36.1775555500.git.xiaopei01@kylinos.cn>
X-Cookie: Now, let's SEND OUT for QUICHE!!


--8CfVjSKAxBmRz6UA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 07, 2026 at 05:55:08PM +0800, Pei Xiao wrote:
> Replace devm_clk_get() followed by clk_prepare_enable() with
> devm_clk_get_enabled() for both "pclk" and "ref_clk". This removes
> the need for explicit clock enable and disable calls, as the managed
> API automatically disables the clocks on device removal or probe
> failure.
>=20
> Remove the now-unnecessary clk_disable_unprepare() calls from the
> probe error paths and the remove callback. Simplify error handling
> by jumping directly to the remove_ctlr label.

You've not mentioned the fact that the enables in _setup_op() were an
actual bug independently of the cleanup, causing us to leak the enables
since there were no corresponding disables.  No need to resend.

--8CfVjSKAxBmRz6UA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnU7+YACgkQJNaLcl1U
h9A1GwgAhbjR/DKzJvB3fHxdk2DeKDcTIuEIsXjbny5bPvdG6MjLh4f19vfCuFYV
udQJ+F+4K+uClzHW1wSpEj8QQ1mfovqlcqYljLRxvY0n+16c3hF9UC+CJ61rB9rj
+INzdwudBh0u0AWofzoWj3Ov6u33MjArZgzgIgZClkLp9Gp0CKBoSRQNyRjHT5Zh
1Jl/D+WS6PSndPL7kK6rM6XJ3mGqo7Nc3oOERM1x6X62fnZ84Dz86ZzqC84pl1WE
3feZ4YCwuWyFIrlMISTUBZWNRAxJhEGvr3oipTX0ZbRIxoFeQUZTfvylsxgprHiV
ffGw6ZrTbqy2PpRB9JUorWQ7mtRIdw==
=F6qO
-----END PGP SIGNATURE-----

--8CfVjSKAxBmRz6UA--
