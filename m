Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF69153B34D
	for <linux-spi@vger.kernel.org>; Tue, 22 Sep 2026 11:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790076431; cv=none; b=htuEw7u+iDDiQPSw3RkkTGH7ENcHXK1rroeDRztl9nLm35SvZG14rxyk5Xc/WncaiI1VX/p+HpanezIUYS99vBGJAxPUUDFFzhzijzwoD1vl6CZSinmNzYdprTxtpeaVb5orrifLdFaL16c7a8Y8GUIT1OYqFfaM7rY8fPRMsVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790076431; c=relaxed/simple;
	bh=uDLQIkIJKt+/lhV4oHQJIKOUsoT9M6Uxd+cZClnoQU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IN/KS0e53UeOO5WHRaJPsubsBrySpaXakLQ8L9Qskakq+xVGs8MA9cUqiPl22hieEZVuJfu8WW8g8ZEcsj32c1EU96Rbhx3bnCc7cvryOl77OCHCTQz5NlF8MQU0PWd7TR3rat9Dj8JBHIFabRTeT+o9m0ww6S7ra4FAZgVoI+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=X4etqeAg; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="X4etqeAg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=uDLQ
	IkIJKt+/lhV4oHQJIKOUsoT9M6Uxd+cZClnoQU4=; b=X4etqeAgmwU+FXnmgjvK
	wXJ5kECOiFklwJu6aTVNuzAXLFhD97de6uJB7e4SknOWBb5EOPuCE1nNE+AFmFFE
	QvgJwoacKnwuNZCDhpfZtEhDCQ2f68PVmNAzadlqNBBBv99gIaT0MNg0ENjf2Cbg
	D3DWhjJdEDsGMmWGmEN+hc6bHABK8t3QFdIcHGp6+ruBdjwwTti++Qdc747eCzBB
	z76GrLvy9ABDeKtoeH7WGjCDlPtk5ojZ6Vfrh00R+PpggpJcQ3p5GvMKlXpbdHCj
	HDPqrD1wHeBzqbmDshBtAYsnxOOAYE8qiUHae0VFKMqhY5juQ1gwVL+PGziZBj8K
	zA==
Received: (qmail 230815 invoked from network); 22 Sep 2026 13:27:00 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 22 Sep 2026 13:27:00 +0200
X-UD-Smtp-Session: l3s3148p1@4csopRBcwINQT+F6
Date: Tue, 22 Sep 2026 13:27:00 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	Thanh Quan <thanh.quan.xn@renesas.com>
Subject: Re: [PATCH 1/2] dt-bindings: spi: renesas,sh-msiof: Add support for
 R-Car X5H
Message-ID: <arJmAGhRbhEc7VMu@shikoro>
References: <cover.1790065451.git.geert+renesas@glider.be>
 <b8f4648eb1151b75d41e561c6b2adbd9bc4c0782.1790065451.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nQ9wOG322N+0qm2+"
Content-Disposition: inline
In-Reply-To: <b8f4648eb1151b75d41e561c6b2adbd9bc4c0782.1790065451.git.geert+renesas@glider.be>

--nQ9wOG322N+0qm2+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 10:27:00AM +0200, Geert Uytterhoeven wrote:
> From: Thanh Quan <thanh.quan.xn@renesas.com>
>=20
> Document support for Clock-Synchronized Serial Interfaces with FIFO
> (MSIOF) in the Renesas R-Car X5H (R8A78000) SoC, which is the first
> member of the R-Car Gen5 family.
>=20
> On R-Car X5H, MSIOF modules are wired to three DMACs, hence increase the
> maximum number of DMA channels to six.
>=20
> Signed-off-by: Thanh Quan <thanh.quan.xn@renesas.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--nQ9wOG322N+0qm2+
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmqyZgAACgkQFA3kzBSg
KbbFlQ//c8bpPa0N/ijbw7xI/fWAt2b5s15t6GCfLmGRv5cfegpX3Ve92XnHFh8l
IMKjslDwBVckiiLqMhXHSj0/wRdtkMy86zmc5SZH3YXwBurP/RvgmpQv7tkjxpfS
NdjNA2nXqyZrQVbF91foIta47rqxCwNDfFS+CilDLY8+mBhWVgTwNdmW/1UXPCmE
Vyrbpd0Hi5O9NJL8AmplW9TFA74ceRHKphVxVcJHsAMUmxcAoIP/4GP94lU748tz
1GvY6D2IOCtdq/WUujOnmWZPAUHwgOy3DNT8+ugcMd6ykuvSZTtdTu/ILYkTLJ+e
nja/XV3ZWIuyO8JXzjZO4SOKGbXCSIvNEHKJhYqG58vchiWditLM9OHpLFsMbW2a
84nasM4RdH7piIT2CPW6ZAwoSEXb4fxW5QFF2NPdcCgdG4Avg6kp4kPi5avbK7Rl
nY50QdzRCBm/JKJoeGPswYGmEmlkM5mkgHursBXzImA8QNwuMP2H6wfydCT4dt7h
nd2NDbzQ33llKW4jpyBY/C6saBRm944Mv6G9i7Flzzk8xZUjzimIloAdu+tn4kNv
mh0NXRurP0RYeNdSkcVRBDtTgLtHdu3+YQpfoDFsJEDTl54lA9R6ZsXiZacvaAZI
8ueE/hsxj6lyhfby5NDOOYsRNulP1URC4hyXA49lm3k4bY6tjVs=
=PrZM
-----END PGP SIGNATURE-----

--nQ9wOG322N+0qm2+--
