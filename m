Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3554C041B;
	Tue, 19 May 2026 13:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779196257; cv=none; b=UaJipgbUZxCBq0Q6Eg7VUXxcPZvtYk8v53MJP0t9KDwy3Jo7LypdQZG8h8B8G5D/z9595B4/KRkMdP7FfuHsgJUPkmXCtHXSmCk6tEIoK+5zQ4uui3nYYWn4o/zjM0yyvNa40zSLvGTwfGPXv0USwtEUcJEoYzYo5DHGZIpH/DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779196257; c=relaxed/simple;
	bh=razt78RJ4CTL26eCw5dWKM6IJ/SOe1x3c5Yxz0/SgCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r0GEWpZ8DcUsHuaieL5+Tt1l1FK7e6TsdsCADtFClxLNcGnErVjMTFfuhjJJ/YkmivbvVDnTR+niX0A6knl0HpmuGCLLAKTpbwdX+cjaCzzCb61ouwjv5AoCt7FT/eVJAWBX8QFbVg6GWdrVt4U6rux7E9vvdW91SmkvlS5tElg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOdOU3mF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOdOU3mF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2CC5C2BCC9;
	Tue, 19 May 2026 13:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779196257;
	bh=razt78RJ4CTL26eCw5dWKM6IJ/SOe1x3c5Yxz0/SgCQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JOdOU3mF0sL7xT9C/z85WgNKLpQ6jxiWj/zrLPnjXE8vjCaajzt63MSOQk1mpVBIj
	 lJGOiHHut9Oc2tI0SVHGtBN/6dxZIRBkYk8nBZ1WgysCnvjQZPwgYUswJjcY2LM/Xz
	 ciKDoWr6lGGLBJHGUUeqlH7ACcqL5QBWyWsjkvvPbNXkOI/ZFB7Kq8+WnLdsX7Da+0
	 f7kyWjVWcallJ6dmv4bZDU4XIE81J/IB2u+sU/OeMSFtl07xR7De0Ig55m70O/mONu
	 PEwgHDCmFIRAqt5MREHm1y3dvCaal1Tee74/JycPIDCy3NkCD+ytI5ydh4JolP6Uhf
	 +wRBbipOgSAzQ==
Date: Tue, 19 May 2026 14:10:51 +0100
From: Mark Brown <broonie@kernel.org>
To: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Cc: "clg@kaod.org" <clg@kaod.org>, "joel@jms.id.au" <joel@jms.id.au>,
	"andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	BMC-SW <BMC-SW@aspeedtech.com>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] spi: aspeed: Replace VLA parameter with flat pointer in
 calibration helper
Message-ID: <4efedd52-7b88-4b83-9982-89d921aa9bce@sirena.org.uk>
References: <20260518095708.2502537-1-chin-ting_kuo@aspeedtech.com>
 <20260518095708.2502537-3-chin-ting_kuo@aspeedtech.com>
 <659a6593-0223-4a26-830b-1390326b84e5@sirena.org.uk>
 <TYZPR06MB520319C6F48144C8B8470740B2002@TYZPR06MB5203.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p4rKxTD+lxMaCbrE"
Content-Disposition: inline
In-Reply-To: <TYZPR06MB520319C6F48144C8B8470740B2002@TYZPR06MB5203.apcprd06.prod.outlook.com>
X-Cookie: Huh?


--p4rKxTD+lxMaCbrE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 19, 2026 at 12:43:44PM +0000, Chin-Ting Kuo wrote:

> > This really needs () to make it clear what's going on; the precedence is well
> > defined but not everyone is going to know that off the top of their head.

> Okay, below change will be added in the next patch version.
> while (k < cols && buf[(i * cols) + k])

Sure, looks OK.

--p4rKxTD+lxMaCbrE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoMYVsACgkQJNaLcl1U
h9ABXAf+K7kfpALiXCtanzo+MPWvQBSK1tW5fmc2s/VpszEGZP67VABdJyyHdltK
oChTSEmox6yS8/PEfQxu67hYI7YrJnFiBbenks1PBcT6TlTm1v8g4axGlj0Z5nLk
MQQH3pnX03llGMnO7lqFW1oEM8P9WX5RDby1qc4lC2pPtumnm3dUBieJ3a1nJz6/
4zbxgf4g1wNJfjVJV/AxMYaamH04So7cA+dP8DRo9SigNChP2qsBrZUFwkKoTJxC
xMmfs37og9ilhbtq20PhSZvsNWpw37ZMg/DANqdFShGKkkKlha4QDmuxPP0wKbfI
wozX/aOtz84I5nXvLz5whlwPviaAMQ==
=2idF
-----END PGP SIGNATURE-----

--p4rKxTD+lxMaCbrE--
