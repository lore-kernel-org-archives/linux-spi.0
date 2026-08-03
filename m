Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77C13C8C5E;
	Mon,  3 Aug 2026 12:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785760257; cv=none; b=DzWUVRFvtxYTspOBtNSWXEwBj0VkwGdL3ixOVY4Qj3Unn9CmtcUbAS0cZAvT9P3tFa2Y4fHlkazIFuE8kllwKxxJx1TAi0reJGOLWvG4UEpr2TyVwZJtmlMzTkYhMGeY3KmPgsFIp6agkMz1WZzekemI/WhDSyioePGSvwrB4Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785760257; c=relaxed/simple;
	bh=plnJ8BbmlRPMSZORSJnXKsHzbaveK/NmnGipN6gocjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kJ0sqV9IGHSvocpA7YyTuywB0xU+mzrKWP1OYzk1DWDmm65islUnP7wV4c+NT0NSnAskHVPvCX5DshYgqXOyMQFbMrQwTgV9sIJQUENjIj+dr/JV07rjV01ZdITFuwZ2hC4noIAWHEIiaoOOrubY72N7WEkpteGdHVoAU0BAYco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j07AiIBR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j07AiIBR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E831F000E9;
	Mon,  3 Aug 2026 12:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785760256;
	bh=plnJ8BbmlRPMSZORSJnXKsHzbaveK/NmnGipN6gocjg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=j07AiIBRwfplAF4+BPjD9ptcTBXIzqzezrLohUlp67oAQaBkOaIRjlKIRCS/zxpWT
	 BpXxXj5JEF5phQz7IQ2YBHgB+L9YN7j829JdWj3k7n9HkLbuws59SKndPDsMcF1WMB
	 xj76aDasV70Bf7ShniB9S5lri5p+Ly9SaluPd3lQ8PR3DD3PicHI4NmEAYiLs4H7yf
	 ThNHXVFm0YIgrfKs4eDOOOmwoZ5hAMOgl6e6USjCcp9wbn+tRbiPzn34MH7Obe7oNf
	 ALX8vCQ21nsaRxKqtlUUmi+vVhYH/rX5JE7yp962X7UZTiPUuqoAlqVCWP4nwkIp+W
	 9DtnRBzVgntiQ==
Date: Mon, 3 Aug 2026 13:30:52 +0100
From: Mark Brown <broonie@kernel.org>
To: Chi-Wen Weng <cwweng.linux@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	cwweng@nuvoton.com
Subject: Re: [PATCH v3 0/2] spi: ma35d1-qspi: Enable GPIO chip-select support
Message-ID: <edabced4-b7b1-4b2c-a358-d47e4b7e8e9c@sirena.org.uk>
References: <5769eae0-1b40-419f-8311-0d919bf619fa@sirena.org.uk>
 <20260803074913.1656675-1-cwweng.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AWRhvsoPupBsFgwE"
Content-Disposition: inline
In-Reply-To: <20260803074913.1656675-1-cwweng.linux@gmail.com>
X-Cookie: Prunes give you a run for your money.


--AWRhvsoPupBsFgwE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 03, 2026 at 03:49:11PM +0800, Chi-Wen Weng wrote:
> From: Chi-Wen Weng <cwweng@nuvoton.com>
>=20
> The generic SPI controller binding allows GPIO-based chip selects, but
> the MA35D1 QSPI driver currently supports only the controller's two
> native chip selects.

Please don't send new patches in reply to old patches or serieses, this
makes it harder for both people and tools to understand what is going
on - it can bury things in mailboxes and make it difficult to keep track
of what current patches are, both for the new patches and the old ones.

--AWRhvsoPupBsFgwE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpwifsACgkQJNaLcl1U
h9Dn9Qf/bSsUzn62duJGPpvb13LHWgFo49vaM5o/K2aqsWO18YnTykBSgks0ISbL
lgn7sVTDvY63/hLe01Yl//Gj4Rjwqmy4hIBBMubhvvKO9XFDg5jMWMnsetEYISAu
FPwaVGwL75kXjIN80AZ/wJdDjbL7M30wT5/+PDSfsaC1aejh0zeQcob2R4Udjte9
AGl1Bq+z0F90LlY2rwGX6I6vNRx7vmIxvdIedaRImF1U157TbD0YBlu4dQ3lIRTz
WDoDFCYFseMGZuYz5g423OtVJyoFAX1RtesMEYt3CMxOyh8+mP4YR9OJXM5EV5WU
pawRqimuEHXWBo8OmLkDVrwjvnzupg==
=SfVA
-----END PGP SIGNATURE-----

--AWRhvsoPupBsFgwE--
