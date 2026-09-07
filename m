Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E7F4FDE4F;
	Mon,  7 Sep 2026 17:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788802150; cv=none; b=IEdULFbzXalUghl8Q5vssj5bvMKXF/6topD5q9gB1bY0HuvKVo/nsCUYjq/aXAsMv29/MzJU2D+xix0fQssRUuFGCbG5OP3uturt0K6Es7EfwNzf75C/FmpUdiuLr0OUitPaWUEeEUZm40C2tlRC5dBKR/VAu4Q+p08Ok7e1svY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788802150; c=relaxed/simple;
	bh=/1hmG1lehCuUO+ARkkMDQ+c6y5feMnW+gBtd5JoyDHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YflxAtgKUzS0RVrS0BAcZoUM7yKLW2BnJAEIT2YYtR/XEixDtUUkp2pRJYl1tOhbz/APtg1cEhzXMQSCT0eV2TGmwi9JwWLjsupZxNOS/NHj5ds32Nn8oRmE6k7YADFWhuOUDcVfeEP6kPf2QJz68p3RL0IwJ6mOaqSyMjKXNrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ArpM/AG7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ArpM/AG7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7D831F00A3A;
	Mon,  7 Sep 2026 17:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788802149;
	bh=/1hmG1lehCuUO+ARkkMDQ+c6y5feMnW+gBtd5JoyDHc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ArpM/AG7Ta1DlsDiaTnCz1zNCl7xQSCTdf501yXcUna7htnOL8CnXsGen3/PDI0x4
	 Tyqboy+g16sB7aCR6FOFpZ1SEghGsbqBZxxlRwFKaGd5/jSScHAJdyvvc+eyasdt91
	 ZmXOje3QDZrcjgAJ874NcIiwB7qyHzr2O70C4D22YmtWFo1BSNTXQSxmzvUV49taMk
	 /1GQxlS+nuF6JBWtMkIfgue5q/q7YOkcy3WRxQPuc1Uf5//syprYxEewjfddEYyX6u
	 4f2PHzkG7egCFN+9xeJgfeUe0ZecvWw3Cw/YkuRowYm/yNYv9ygWJL/o6IybZOLIGV
	 cZeyVk2W9ufBQ==
Date: Mon, 7 Sep 2026 18:29:04 +0100
From: Conor Dooley <conor@kernel.org>
To: Yu-Chun Lin <eleanor.lin@realtek.com>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, jyanchou@realtek.com, p.zabel@pengutronix.de,
	afaerber@suse.com, devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	james.tai@realtek.com, cy.huang@realtek.com,
	stanley_chang@realtek.com
Subject: Re: [PATCH v2 1/2] dt-bindings: spi: Add Realtek RTD1625 SPI support
Message-ID: <20260907-grandma-extradite-6a15a475db96@spud>
References: <20260906145755.1230079-1-eleanor.lin@realtek.com>
 <20260906145755.1230079-2-eleanor.lin@realtek.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oZ84S2dSrw7uiTva"
Content-Disposition: inline
In-Reply-To: <20260906145755.1230079-2-eleanor.lin@realtek.com>

--oZ84S2dSrw7uiTva
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--oZ84S2dSrw7uiTva
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCap70YAAKCRB4tDGHoIJi
0qC/AQDIGRssxRyDzhZYy19V9Hk2KYPawIpTyzIa26SltTYFGwD/XYlhNpsNIt8N
JCwJh9aCpXZGDOZ873k3+cbEfajHAQo=
=QB0u
-----END PGP SIGNATURE-----

--oZ84S2dSrw7uiTva--
