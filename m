Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.11.138.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794578197;
	b=SnCkeOHLWX4PoyxQdj60d/ovyFrKhjVnT6YGRejxbeEq0q1v8vgxWNRsDhazpzzU7bRn
	 UwzrDD4yf+muIsJUR9cXmYNRJBzsFtXo7lYThnM9wMSnWBcGwvEFws66Hndi2x/6VSwns
	 a9PRGPWkLt0ZXQ9WwhgD1QAWlGNUdbeaL5DEv2H5WpQEIV0y3Wp2RAqX3nc+mGmGsgoGy
	 A+4k7FRBRvhx/y7D5kyfTL4T9zFFmHEzx9cFEzB+Qs9WvZVQPDhrEb68PdSUknnpIxqoN
	 Mi+Wvk175i58/OiiThLN0Gnvn/b2g4YKXakVnQ0/rKVW1TaHJOAdVgjbeb/UnqOdAtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794578197;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type;
	bh=HWRK07tgReotE1rio8vCvygSDsW8NPJiLK9qpH0uLVI=;
	b=ZIgH6xxjxquWea+83gex38XYY5NqBweJkkqy1020mXG3BFnzzw8uotyNsdsZ64uDOUaP
	 a2BXzn76qM9r4W4cr7MW3Zv2llb/TNzn492hs55iBaSzny3ro1od8NzTktjRtkc0X7qhZ
	 8mU1NeBP9B1GXosasVuds9D5kH5pIxi8cLLyF5WbB/v86Pfecyx7Mp3a3oE/dKocx0LOW
	 0G3VVOnJ3lelbIRjg/L7rTmYr1WMk78qG3znQo4J5UwmsCyDewrz+le1PBRFrXPW9FClS
	 +V8YiBO3KNGxk7ujJWWQvrrf8mEJuMyTt4eGcXBUFAbgoKyPdJtDs3bEbgMCEX1Eg2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sntech.de;
	spf=pass smtp.mailfrom=sntech.de;
	dkim=pass header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=QoBpCjFS;
	arc=none smtp.remote-ip=185.11.138.130
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C21F606A880
	for <linux-spi@vger.kernel.org>; Fri, 13 Nov 2026 13:56:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C21F606A880
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=QoBpCjFS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=HWRK07tgReotE1rio8vCvygSDsW8NPJiLK9qpH0uLVI=; b=QoBpCjFSa2OWprOAFfkHYM7cjM
	Cb0dffrp4VgwLL2L7XeIQaLiSjV/PceuZeACZgIMxSVC0jahSBalv7xV9yBSD7iUJDG5HpsxQH3+s
	NXbu5jadPcowe/g5C3NKVq8yXxkJhfk0AAyEuwSo6fQUF8bu3G5J34ivcwqj9VXdMdgF62qzT3mC2
	uNLCsdX9plzpRiNDZx7TEOTxIntaMdtLQxPaMzzmuKYaKj80sehFQ16vMUQ4FM/810xjBrzJV+Lfk
	Cy3NCu+FoaIzvaKe0CHrnK4p2NdBViJFrCrwBOCky3Sk/dB6blp07fso9AEtr3y+SkUUvqm6fGb4z
	vpD9Q0gA==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: broonie@kernel.org
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, quentin.schulz@cherry.de,
 Lee Jones <lee@kernel.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: Re: [PATCH v2 2/6] spi: Export spi_set_cs() function
Date: Fri, 13 Nov 2026 14:56:33 +0100
Message-ID: <9kep3BO9ROGEepQWTWqwnA@sntech.de>
In-Reply-To: <20261113135017.1047959-3-heiko@sntech.de>
References:
 <20261113135017.1047959-1-heiko@sntech.de>
 <20261113135017.1047959-3-heiko@sntech.de>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Freitag, 13. November 2026, 14:50:13 Mitteleurop=C3=A4ische Normalzeit s=
chrieb Heiko Stuebner:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
>=20
> While spi_set_cs is currently only used when the SPI framework manages
> the core transfer function, it contains a lot of functionality that
> can be used for the upcoming atomic transfers, where a driver implementing
> that atomic transfer could profit from not having to duplicate the
> chip-select functionality.
>=20
> The only sleeping part was the spi_delay_exec function doing the
> chip-select delays, which can now also run in atomic contexts.
>=20
> So export the function.
>=20
> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
> ---

Dang, overlooked spi_toggle_csgpiod() called in spi_set_cs(), which does
gpiod_set_value_cansleep().



