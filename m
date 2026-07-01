Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C61A381B0A;
	Wed,  1 Jul 2026 17:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782925446; cv=none; b=WPscg+Uvp9OGuw1ogy38Ow0Xzv9ZxN1jDftBwpJB1WUUEuO7zooGjUqveq8stl+aXt0sPE31ukGfIVLbsZkSbzqp94TXUaJxPJujNqtQ3QXAgwBNJI2l8YVo6d1SKAzblqshbnHTrucj0ALVL3MtsAs5QqiNyT6EsYMRUjUKqbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782925446; c=relaxed/simple;
	bh=VYRiDD5Iy0yRoaO0lkvXQT4aI16OlIvETD0ylWTOlq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jhkfxl1TtU1wlQL1qeNaEgWoGnFD5uF9mZuqEr7e1TfCBrtzfzLo+GEHpIz43NssAHOapJS9DlpeiLO7rQDg+ra74VcH+vMcp8Fh74Ts2cDt4Oebv2HRFWRL1BXPD8j0SWbiiJ4JXTRRyjVD6+sNnpczq1ZOSCnBuYqZPkUOvpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bGcLcNfT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bGcLcNfT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FCC81F000E9;
	Wed,  1 Jul 2026 17:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782925445;
	bh=VYRiDD5Iy0yRoaO0lkvXQT4aI16OlIvETD0ylWTOlq4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bGcLcNfTLHxJHGbdy1TAK6T5uJzDc6t5iOIFRyFqa2mEhzGHPONBbKTlLa495bJo8
	 1R6KEgdWjeGR1323zsB5umuzNttFXGHGftCoi1iW2en4lZq0u0DOdtkZtB4SriMpp3
	 1ivybLoCT+SmW4V2WOj7e4kYv0mZzoog67CJvab62clJ/cS1OgJZoVxgXS9fi5lgTS
	 l3iARQMF8YKkOE0HPRZ0c06Wt5As0TPg7ZuhfLag1OBiy3uQug3i148Hl5tOC8mQZu
	 W4boHneklgKXyRhjdNMVCBmmZRQTp4rjhut3ObKsIcq5DZDEdIc3FC1d9XT0VrS9CH
	 vTGyNoDGez2sw==
Date: Wed, 1 Jul 2026 18:04:01 +0100
From: Conor Dooley <conor@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v5 1/2] spi: dt-bindings: snps,dw-apb-ssi: drop
 duplicated RZ/N1 entry
Message-ID: <20260701-bundle-rocking-14216ad464a0@spud>
References: <20260701131248.4545-4-wsa+renesas@sang-engineering.com>
 <20260701131248.4545-5-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0FbztNpUHJi8R2hM"
Content-Disposition: inline
In-Reply-To: <20260701131248.4545-5-wsa+renesas@sang-engineering.com>

--0FbztNpUHJi8R2hM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: changes-requested
 (by mark)

--0FbztNpUHJi8R2hM
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCakVIgQAKCRB4tDGHoIJi
0kFXAQDlsj4mUWdeSW956sf2mzdL0Iw4t0eHc6HyZ4lAs1b3egD+O8+4Tb1zWA3L
h2g+Q0SP90pwU+fib/mnGp1AwvMM3gE=
=yYiu
-----END PGP SIGNATURE-----

--0FbztNpUHJi8R2hM--
