Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567703A7F41;
	Thu, 25 Jun 2026 16:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782405299; cv=none; b=HaVQzqi7S/hOI11LA5OL54uFrGPQTIZdW8l1zrykw9r6RjvNUzvScjwO07gplQ5+vqjpM/z4Gwxj0MU2jAhX3j9oRxajqcFPd94I4mo/ph6cZ71aexTSN6jaQ7norz8HFtBrLCYf2Bu33Olk4pCkVJrgxgSFERg9n17quB3xrRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782405299; c=relaxed/simple;
	bh=Pr3pDYbeloS9ZBEUPJo6GMR5fF0kPmCcEgRGN23WLJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EsYxLQ6f2ZZD6yMpUvCy8ge71L1zlE0kS6xIolekDDVnc5QOMzgM83H0tdGa45DNSIfFMSZaVs1iQFzciY+QVYMY0KACL0tWMmFld/7WJmUBa7FSKG7eKZnjcg938eUat8DboX2xudgMWE7rUiqO0fPb5AKlScFBgadQ77K3dR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A/IlxFk4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A/IlxFk4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4994D1F000E9;
	Thu, 25 Jun 2026 16:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782405298;
	bh=Pr3pDYbeloS9ZBEUPJo6GMR5fF0kPmCcEgRGN23WLJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=A/IlxFk4NmEMjtJt4FMt46/qYZbCtXBoRhVBzQykp2wfaN5hSRGZM8N2f88bs8Cby
	 exK1ViB1prA6qpwPotUn+6q6t74AXxmmc86Glj3LzTbzukSZjUNQhDxAL8DIJyGTGP
	 +ALAP/GNOIDcjSgDsKuuzedwfoWI1OonChmqXaWfUPgAjaosKAazcEOp2ZisFFA1LH
	 XyDVmAPqzbU1BnozhWqpRflqGp3UtnHyvv0JfZ9Wv5p3QaQC/pyI6rnT9UnrN+dryn
	 3WBNQUiKjkOgAPa4ttOXWTD9fCWG9ag2TU8DLp+FdJ+lKhhabQtYNYyZjBU2jJndiu
	 K4Oh+E5lOGSfQ==
Date: Thu, 25 Jun 2026 17:34:54 +0100
From: Conor Dooley <conor@kernel.org>
To: Udaya Kiran Challa <challauday369@gmail.com>
Cc: tsbogend@alpha.franken.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, skhan@linuxfoundation.org,
	me@brighamcampbell.com, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] spi: dt-bindings: microchip,pic32mzda-sqi: Convert to
 DT schema
Message-ID: <20260625-omen-stark-6bb827ebcc43@spud>
References: <20260625060903.14661-1-challauday369@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UbhGQTDbkok7ej+s"
Content-Disposition: inline
In-Reply-To: <20260625060903.14661-1-challauday369@gmail.com>


--UbhGQTDbkok7ej+s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--UbhGQTDbkok7ej+s
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaj1YrgAKCRB4tDGHoIJi
0mr7AQCuu1XoRIyvP+GyycPJ+B0Lv30+TxbFb/gGoWssyNlGWgD/SgDDxVZ6gY7b
Uen8sdjB5kRYyOUidhYy8j51WYJddQU=
=QuXN
-----END PGP SIGNATURE-----

--UbhGQTDbkok7ej+s--
