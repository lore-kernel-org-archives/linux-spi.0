Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1022E1C4E;
	Thu, 18 Jun 2026 20:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781813154; cv=none; b=up9Vtzt0IO8J9EKvkdhTCHW3pOvPRN4RU3R90+3M915YLk0iG7rm2pwp3tKDesFwtC+YnxDO811DIxSumSLoPz++k11wVtzUAqgwGbXhXYd4UV0r3NX/1SBY2uwj+v4wQIPp4t11Cj3CGAFdhRnp6KE/lHgd2Vu36e9G8bHx56A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781813154; c=relaxed/simple;
	bh=iSIb+Xnhtkh4603gGlMIYyjgq7gUwu78nAHoewAyslE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MYPbMxIGHJe6PUPNMLu4t5wwsG4uQpw7/7x17fc5lQnqVycK7mCco+lnNa92YhK7SU4y1G33lgfmRswXIgbR7EqSPEvxvHi+oXsAGvKugBbgC77KYo1StAg5LgCQcdIx7x2zCSnZiSobIomqWdG773oJeaHyMBMtsLCoHUOS99o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J2vhPadK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2vhPadK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 647281F000E9;
	Thu, 18 Jun 2026 20:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781813152;
	bh=iSIb+Xnhtkh4603gGlMIYyjgq7gUwu78nAHoewAyslE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=J2vhPadKpAycrCWyQ4VoIP0RnhoBUVb5CokPhYoGcHyMRVnKVYzuzsff/lA5O6tiw
	 JPEbNxYeAmQk3+hnfD7ClJ64gGyrmapE5Hkhf3H31Jo26QAQHMSK2mFbQfTNS4eKcb
	 12E3Ph5ZP31mqde5wMDysHCn3LUTtgY3ZigiAhRSDTF/iL5QyAC/k/D8ndDLaWuiHT
	 o4UyYQBBUA1rXAfbzjobbc0llbl1mgsb+tnn4IibEmVCwqVnIlR/Isg9Q/FrTCUBRz
	 g85oMpqZOL3DRb8/wmA9V97Tjl7PdXUeryUIeNTDGsqJQXthf9tqYdtnnq0lwCddYB
	 SMVrLhXreABVg==
Date: Thu, 18 Jun 2026 21:05:47 +0100
From: Mark Brown <broonie@kernel.org>
To: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Christophe Kerello <christophe.kerello@foss.st.com>,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: spi: st,stm32-qspi: Add power-domains
 property
Message-ID: <2389579c-cde4-420e-8755-44cf4de10bd2@sirena.org.uk>
References: <20260618-add_power_domain_for_qpsi-v1-1-4d7e57bcfb9a@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hafQDUbp9k6UCBdI"
Content-Disposition: inline
In-Reply-To: <20260618-add_power_domain_for_qpsi-v1-1-4d7e57bcfb9a@foss.st.com>
X-Cookie: This unit... must... survive.


--hafQDUbp9k6UCBdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 18, 2026 at 08:46:35AM +0200, Patrice Chotard wrote:
> STM32 QSPI may be in a power domain. Allow a single 'power-domains'
> entry for STM32 QSPI.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--hafQDUbp9k6UCBdI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmo0T5sACgkQJNaLcl1U
h9A/pwf/SgEVdnoxmkZ3v4Lyil4/JLjj62RdAJuYela8TOThYKaczHP/cCRFLOa2
VM6Ff64DIyUiv+VIdyPVSXlXKZ2GwkN9bUd4pIYMeiP9CP2Te6CpPweUwWqv4TKT
vykhSMZ5f3B4vksMlzzsGxX7778ffQjhXUal/yAyPcPwFEaXv2ybKHRFKt+y3Cfg
qd3MY51PLoIu2Chxrg3X1lQSGDlQ9zblJeKnrj00jxVsOO0kWqVNZBZEdr1jCZtf
MFbY+41CDZtsKRZC3aHMseSePvIuSnBnBXm4c1AwYfbbDOcKNWj+4sy8p585PDX1
O7HG+47vGWB5sXxWe2C42ESsdb3yfw==
=8xSh
-----END PGP SIGNATURE-----

--hafQDUbp9k6UCBdI--
