Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AA335DCEE;
	Tue, 27 Jan 2026 16:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769530037; cv=none; b=P0STO8si3onOqbV0UjgkwUkTEKxpeZoRgaDzIz2ZHHa6rC6vut4V+6Dh4KoPuzPm1Z7c9yuApDOzmPOB9w0EigXaIopxdQ71vBT7P9NrzqRAHyUwq4AMDGv1WQEXUcF6Lb61npUDE4DYXo3KpgpYJchOcEFm4p/xp+eoT7UZUlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769530037; c=relaxed/simple;
	bh=8pjznKbhY4l0ckZhG6GITaPAcQ5j5pPvTJWZ16JgFPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EAW0A1v2x+vtHyprda8jz3ee/YQd0eWi80gwEKsS442+Igc9HNeYMwLMyRyxr2ITg1IiyfXAtXGxVZBoeAC8GyGCJEMGZEujal/ELhwI36IC0LzkqeI7yVQws1my2xhlrM06x3LcyKxlqqZfQ6zpqe01sWUxnDUft2FDZCuwiis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hROvFkwE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hROvFkwE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AA5DC116C6;
	Tue, 27 Jan 2026 16:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769530036;
	bh=8pjznKbhY4l0ckZhG6GITaPAcQ5j5pPvTJWZ16JgFPQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hROvFkwEBXvN694FgAAl6vEPBLylXC4naK4OYWeeJy8IT58im8FEFVcc32/a1Xlpe
	 GgoVeWv0gnJ5Rag5t6KW/Vul8sO9O2Thad0tw1795LfxGBxUfsFKnd4EMvtaXFPXH8
	 k6fHvaxHVxJSp/svX4qg68i+l1Qo5w2m32yMWgA1SBZ4FXCu8694f/F6iAV992qsQi
	 NOh859XxU5pQ6BdFub2V0KVy9NNT8PHt3d1lq4QzuqEm9UMG17uMiM3OP2cnVyeyW6
	 DnGVHRm4xDq2lUmPP4Y+8K7NozXBRg2tuONpwhWirslJTz2ZXidu5fmtfa+1EbPP7w
	 uu1qtlOL0RukQ==
Date: Tue, 27 Jan 2026 16:07:11 +0000
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jisheng Zhang <jszhang@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: dw-mmio: support suspend/resume
Message-ID: <6b89afd5-9e6c-45ed-835d-6e0d1906aa14@sirena.org.uk>
References: <20260122155046.12848-1-jszhang@kernel.org>
 <d0bd831a-08dd-4c2c-97e8-896f885cdbe8@sirena.org.uk>
 <aXjhcijjig79ocks@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="G9j7QTNVjI3gUjGL"
Content-Disposition: inline
In-Reply-To: <aXjhcijjig79ocks@black.igk.intel.com>
X-Cookie: I brake for chezlogs!


--G9j7QTNVjI3gUjGL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 27, 2026 at 05:01:54PM +0100, Andy Shevchenko wrote:
> On Thu, Jan 22, 2026 at 05:57:42PM +0000, Mark Brown wrote:

> > These were allocated using devm_clk_get_prepare_enable() so we shouldn't
> > really be fiddling with the state at runtime.  In practice this should
> > always be fine I think but it's not really something we're supposed to
> > be doing, in theory we could fail to resume and then end up doing a
> > double disable on removal.  Probably the open coded version would have
> > the same issue though so perhaps this is pedantic...

> We clearly can call clk_disable(), but I'm not sure unprepare is the stage that
> has no side-effects here.

What makes you say that disable is OK?

--G9j7QTNVjI3gUjGL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAml44q4ACgkQJNaLcl1U
h9CSMwf9HTvw5A8HWEnARv4XhxpJ1kEzH9vglGqWQIcJKuW5KLfA9BGJ3gHj0UlX
laNuGnwojmKppYFxZLaXS9/itbRk10yjn9HkQdQE3wEYfEPSZQwf5/vl3dSyaan8
WsOvUE9AeSJGq57NlJU7xxHqGzFx842PpPapFd7qY0GdK5fyS0Ur6K52JDuiidN3
Ufhdj5BO3+81IZ9/rkyNZ8jvGqjhjPNea/LFNpFG1vQBY+z/vYeNlzvag0rmjR8s
Z+Ip1+qZmverTbkL10DSYnqpFby1cNVsgPjONpW7+D9NB+i3gNnmTTu5hOvWdGBE
fMkQgy0fpZXm++oNMIbupEpvh4uhzw==
=zNcJ
-----END PGP SIGNATURE-----

--G9j7QTNVjI3gUjGL--
