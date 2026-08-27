Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401EA448B9A;
	Thu, 27 Aug 2026 15:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787845125; cv=none; b=kqu31QtWqwikN8nWl9I8lPAlJRVc1/0z/apRa0XhwnG0Fgqy2nXzQIkpmB/LvqLYdCLpyuTZigug46Y1Jt70caFtXcq1ZIY11wStHucfmurdRzdmMIQ03+HNGByk3GaF8r+WAX6KeSdG5MyM5KHDlaTCB92tnCEGK2TWs0N97t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787845125; c=relaxed/simple;
	bh=521mHSM5BJqZW88mReqJnYqgYws97tVrmMSpaKLStS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GHQf4MWRCIz2X19cuSAIkH4ZCO9zM0CcgQvW3oPvHSGMv8ksrMeaRXARKdJK4uqHRuva+uKKrme8hA4+Js8kbr9cxOZwdMCyemPbm5zDPwgNG7F5aeDbfnGGNr8LMeTdfbL3qg/38SLyX9Lb6WpH6LVwCcEhppINnM22UoCgGFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nG94hv2t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nG94hv2t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57B201F000E9;
	Thu, 27 Aug 2026 15:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787845124;
	bh=U5sS71ijkMIiJx32c1p1EoxWAzNmtSPxJ+sc2YkN9Cw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nG94hv2tO4r2tZ/THXCu/wYZYlog97GRK/gM9cX49ixVI0K4ry3KhBwOHINEZyanR
	 AiZBlBmDZeAuuFs1Jm+cUWPmvo87Xp2QrNOjPfIQmB4Dod7Vpu6QhYgHBBOrQ88UU+
	 sX4UPwy6/ciW6PnFgYKPLw9KK+loBjjwpz6hFGfHd3ZIdX4eZnFMUUxrtAKvrhK4nx
	 SSXYmutpMv/kSxvaDT4Ao8sPMwjJJ5Reej/SSJvGYJ1oobNsIzlP9+bB4tvjXsPuHt
	 /2iMcaosXCXddo4dRa0tcLpES1zm9uGKgX5K/9miJuvnmZkugybReYFlxkqMNr9h3+
	 O3r/+otmSaPdQ==
Date: Thu, 27 Aug 2026 16:38:39 +0100
From: Mark Brown <broonie@kernel.org>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Abraham Zukor <abe@maticrobots.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] spi: tegra114: initialize native chip selects inactive
Message-ID: <c6868d2a-f55f-4196-9914-f096420cbabc@sirena.org.uk>
References: <20260826000517.631736-1-abe@maticrobots.com>
 <420de339-53d2-40d9-b04a-a54428450830@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hnU5T92HxfV03qaA"
Content-Disposition: inline
In-Reply-To: <420de339-53d2-40d9-b04a-a54428450830@nvidia.com>
X-Cookie: Alimony is the high cost of leaving.


--hnU5T92HxfV03qaA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 27, 2026 at 04:18:23PM +0100, Jon Hunter wrote:

> Thanks for updating this. This looks fine to me, the only comment
> I have is whether we should check and warn for any badly configured
> device-trees where the same CS is used on multiple devices even if
> one is disabled? It shouldn't be, but could be good to flag this.

I can see a system having multiple variants with the bootloader
selecting which device is active in the DT based on runtime
enumeration.  Not sure if anyone is *actually* doing that, but given the
state of the world with overlays...

--hnU5T92HxfV03qaA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqQWf4ACgkQJNaLcl1U
h9DbkQf8Chm3XOSx9gFAz8Wi4gZ5e2aw4/NbhK3crDJ3o4WGOJTMBi2DVURqDYYr
ohoH58aa8OCag5Q0WMmFChcDKvF/XSBDWjttn/MIBRUbuibLg7mgJ9pnjb8KtQAA
/l2ht0Tq807jLR1z7LAuyjgkYiIqNsLnQBuVqX+/OLUaYfoJEBhrswx39OmnN/Ol
m6637SsJIiBtu2oUsJ6vfsKHEH/kVgDENfI7M/WAgdgiFEGOXy7q05tweHmmVphY
1TgjBMhGFWfVJ0z4GKac6gP762NwAWQmvUHeEh0PQxlFk4ycAduj1EvAzyF6Q0lc
KHWSyL4wbDC/QoRXeUfYmGBgwz8F2w==
=AiJ8
-----END PGP SIGNATURE-----

--hnU5T92HxfV03qaA--
