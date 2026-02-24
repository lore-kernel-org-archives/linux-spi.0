Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E75128F50F;
	Tue, 24 Feb 2026 17:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771955699; cv=none; b=Zs3Pe391B/ZcSRuxjEa/4iU33xASsAYbTMBka/gvs3Sj0+nHNHJ4g+M6B2CvVWvddJt64xOPfCbrXIoLSeVLSoB/rCSof2sUeqb/2afVgm5nro4XAmtXWow9D4vzl9N+9sI0Dg93fliSKhs6EPeexnd9TbIp9I0yazyga9nPE9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771955699; c=relaxed/simple;
	bh=Gn2h2zOyye5SBxdkla9WuhYaZHjOLfaYbHzyqJi0ELo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cpDcQBe8laI5SUEo8Klddj3KQHQ2cAKe3k88e0HRzrvqilZV456V9ClAJC1eX+13aO2/ZOluycfyfidCxWJalHndTclTFnmcWWeZEwIAA2/tcdv4cfh3bsgVakzoiMqE2HhwQ2okqU6SmpqnRlYRZElOj+zFBak2T8BG0dhU0K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PCN5ahYS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PCN5ahYS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E257C19422;
	Tue, 24 Feb 2026 17:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771955699;
	bh=Gn2h2zOyye5SBxdkla9WuhYaZHjOLfaYbHzyqJi0ELo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PCN5ahYS8xfyl/e7vql9GDB9b3VorvhxYAh/6KqilOwVUKlfU0A/L70lB8cA6Dspf
	 mdsv9SnMGRfRBwp0yc2Aq3Z5CZzcq/naktqkkgglzia7fkGzqHpOMN3DeLm38xFKQj
	 5Ba21OiZGnN/0SwfwBlYHxU4HKmaqEPoWoakroC3mwVDO2yVIPgFjtQ2/iqIolU6si
	 pQdrPcntXHWXIOch1s+5yWM5Fkq+LJzyAf079FQZuE70CfrDgPcVbdJu7or3D1amP5
	 LrwRHDBPJCJi0anlMBUasYnoT2OssUFBh0lREQ3VBaMmt6Wkxb4vNGteUtbNfNibDP
	 ij7gXXboX6J+g==
Date: Tue, 24 Feb 2026 17:54:55 +0000
From: Conor Dooley <conor@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v1 1/1] spi: dt-bindings: snps,dw-abp-ssi: Remove unused
 bindings
Message-ID: <20260224-overview-humongous-efae202d01d8@spud>
References: <20260224115218.3499222-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Lcxi7HRZtYlHyi1T"
Content-Disposition: inline
In-Reply-To: <20260224115218.3499222-1-andriy.shevchenko@linux.intel.com>


--Lcxi7HRZtYlHyi1T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--Lcxi7HRZtYlHyi1T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaZ3l7wAKCRB4tDGHoIJi
0ir9AP9JT0fqPEiq9lqqP+Rb/kDcySR46AdCFrIZbOB7wAvSJQD+JRjVTiO1XVY8
4XdUbjrgCdKsZHgD86w6I+Q5J9pJ3AE=
=R6/D
-----END PGP SIGNATURE-----

--Lcxi7HRZtYlHyi1T--
