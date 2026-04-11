Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C11F1F936;
	Sat, 11 Apr 2026 21:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775944668; cv=none; b=jGBcXoHVcAUxUhDJt/QG2aj5dj7ZRsLd8oLcLX8FIabWhMsmSRz++7GQ+eexHXyb6tEsl4QmaXef1xp6VCMbWkwks2++ug+RpgZdNpU0t38DW9G1pX8zC/2iWf65ka0s3t+ELE4kb9hNQxwLcl+tL09CrOic9faoYcXrL7o2Q60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775944668; c=relaxed/simple;
	bh=5TkzBwy6tsw51wDeX5pNXpNxr8hIlKnh3x3I4Y0n1q4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mu8kpYG16SIWhggo5V5EhUrN4h2MW68bL3LWhdRdwwtB0FTlC3IWrvL7Slh72r0GlJG9+Jv91crtspKOMedDf4iarmwL0pFwY67NHlMSHreppLf052Mzah4rB2U2Z9vwVdRd651n937oOnPxeboO6EbywcSbxvTbDAI6jP7t/+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C5rQOqXj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C5rQOqXj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EA3BC116C6;
	Sat, 11 Apr 2026 21:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775944667;
	bh=5TkzBwy6tsw51wDeX5pNXpNxr8hIlKnh3x3I4Y0n1q4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C5rQOqXjHaq5C2/Cz5WjDhxKGc5LY52d6og89TdZeOJbGTifzWRztNsi1nK1bcRHo
	 +nAotZEx9EUrbLJRZx2sBtV7TAbSknMxahhhnCAGhqC4FJFmhjYYVM4pE8vdHA+tv+
	 jjKYbhS6Bzn0f4z+t7uxiwL9TPWSH5vDxF96LKE5EMQ0xAALc0pIfo8ARnDH8zwnXr
	 tuVwo+RquePc5kx385mrUiayXM2kvyvBoGWQhFRswJcksNIdQNAi8AtFtC590wjVN1
	 TZs43ZP5257E5uF2igvphukrJB+68eMUYex+/wod2X6cmYv/X2SdqpJOgxujsLZ662
	 v3cVTEST2YH/Q==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id BB4CA1AC58C1; Sat, 11 Apr 2026 22:57:44 +0100 (BST)
Date: Sat, 11 Apr 2026 22:57:44 +0100
From: Mark Brown <broonie@kernel.org>
To: Khalil <khalilst@gmail.com>
Cc: hdegoede@kernel.org, ilpo.jarvinen@linux.intel.com,
	rf@opensource.cirrus.com, linux-spi@vger.kernel.org,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Fix CS35L56 amplifier on Intel LPSS SPI with
 broken ACPI cs-gpios
Message-ID: <adrD2BrO11tQq49R@sirena.co.uk>
References: <20260215135524.1171065-2-khalil@rentman.nl>
 <20260411180414.481427-1-khalil@rentman.nl>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YvlfXJkyw/fm60h0"
Content-Disposition: inline
In-Reply-To: <20260411180414.481427-1-khalil@rentman.nl>
X-Cookie: You will be divorced within a year.


--YvlfXJkyw/fm60h0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Apr 11, 2026 at 08:04:11PM +0200, Khalil wrote:

> This is v2 of the patch series fixing dual CS35L56 amplifiers on HP
> laptops with Intel Lunar Lake and broken ACPI cs-gpios.

I can't work out what these apply against, please submit against my
current tree.

--YvlfXJkyw/fm60h0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnaw9cACgkQJNaLcl1U
h9DqSgf/c46kiKmYcNbzMk6RDUssL5ZaB4McUIOQLOyk4/GmbE1E8RfjMBnOJNP/
nT1CGYDdLBoOEGuxj1A2O688P6W/uZIxEJMnd0uZD7+qQ9x3Fs2nmsNA4PTY5L0e
TkiO2u+CBqXal4+hyhrE5tNo+/kWSNk/5RzuSOh550YPWlDVlrnuk9WqVMcsQYtN
lc/yjQMsoLUwOShI3bfw0mSM/o+c0+gYEvd1r7n9RxcsRP+39TiOGUX5/ynxNZPB
NALEXzQXBhMLUe9Brbg0R1pN8h8cObg0hB0UB2K4lQttKiL5U+MZ4WgBWcj9nhmA
pxJoAXyz4ksOjkInap0YgObPSoDS5Q==
=+Lcw
-----END PGP SIGNATURE-----

--YvlfXJkyw/fm60h0--
