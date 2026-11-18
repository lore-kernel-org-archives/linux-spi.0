Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.11.138.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794999594;
	b=kcuIXIbaciZb02yxX34VRyJnT7XusKqRkI+qtFLVELJbDdN/xMfOyKHw4eePHsLyce73
	 Xfmr+jsY0jsKJab4EJWbFR0osM0X422oZVORmTT4Ubwsb/Q1t1pIh4fcgAWv0JkVdBF/W
	 X9OQP5VFXb2gCQeybjnWXxxeS8vUwKxmwES6m/kNtEWWQHtxUSvJSAY34X29x6cPZhjbn
	 VuJDaUiKzMDsouy4gVt/5tJ8M/gEfsIel4G/kUxpMy/ultQZ/7SLGKRS0V3pyvkiQax9V
	 ZnLF2o5rjKQHupfqYtGW50VRnXqnwMHWXVjzIsVI+ciWxsxkbbdYa22vunjdcH4d4vQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794999594;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type;
	bh=gulFkJpN4JJLUUrFDIJ1uZidMX2ZMDzwOEgh26q791E=;
	b=ynbimsLuNXuP3BU9dmHZ2a2tX4DmovcqZYEjadMTOAqZlZqFOUHsnVCTCUUfpE/Ne7za
	 qbRS6P1dUjFq1Ou06ic+M9v6SN7+ZjFv9YySSmqN6NL0eEF5gzCe74+6F8NbkBAk65BK5
	 nAADpOqk42gzu/icGJ2lEob/cAHOkO75k3XVnhH3PtY7O+mJeoemwT8dwqSC0gBlUIt6a
	 YuZlYNZkDiHKOcgu6YofwNqbz2llCmCDQomkmbwKJGMmN5XOKoc0Dxuofple1wBZSjqw4
	 /qAC3U45LRo+eN6d39lUSs/AszzPwBeFh4YBajZFX6lAeE/kxzRRfw0Z6B87yKBmpZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sntech.de;
	spf=pass smtp.mailfrom=sntech.de;
	dkim=pass header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=csgAyA94;
	arc=none smtp.remote-ip=185.11.138.130
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1643606A31C
	for <linux-spi@vger.kernel.org>; Wed, 18 Nov 2026 10:59:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1643606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=csgAyA94
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=gulFkJpN4JJLUUrFDIJ1uZidMX2ZMDzwOEgh26q791E=; b=csgAyA947I7Hek8AbKzETrouaR
	jXnL/3/GGumOrnVFeD+BJYTZhH7hEFv4z9CFKgpka6tAX29J0S6jMIiR7WYAyJgKE0A2boaJ36Jdi
	zOAo5w3EwQgtGs6gPXVJIzI42Upimekp6sbZ8iG70k1LAMP59gDzUdjMZUC3zkZbxPTM5ljO32+QQ
	gP20K/mN5fkscnOV0CLcWAjQyZ9ZxZyJk3HS0K3JzGURqbxUctZvT77o4+/iXLVOd+WUwP2/XsG9q
	ncyIOaU/gr3Ns7sSi+JOBOoKRlYLXwuvlvKBPgWwHkoH5xaBBYQbzmrfTEJbRyfIY2WFZR4AgWmap
	W/iWnt6Q==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: broonie@kernel.org, linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 quentin.schulz@cherry.de, Lee Jones <lee@kernel.org>,
 Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: Re: [PATCH v3 6/7] spi: rockchip: Move to pm_runtime_resume_and_get
Date: Wed, 18 Nov 2026 11:59:50 +0100
Message-ID: <_LGRfnuzREyWei8rJ7BZTA@sntech.de>
In-Reply-To: <ldw_Vn7fRw2QdWAMZ2npBw@sntech.de>
References:
 <20261117235021.2013719-1-heiko@sntech.de> <av0CaMF_jOyqMYA0@venus>
 <ldw_Vn7fRw2QdWAMZ2npBw@sntech.de>
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

Am Mittwoch, 18. November 2026, 11:54:02 Mitteleurop=C3=A4ische Normalzeit =
schrieb Heiko St=C3=BCbner:
> Am Mittwoch, 18. November 2026, 02:53:32 Mitteleurop=C3=A4ische Normalzei=
t schrieb Sebastian Reichel:
> > Hi,
> >=20
> > On Wed, Nov 18, 2026 at 12:50:20AM +0100, Heiko Stuebner wrote:
> > > From: Heiko Stuebner <heiko.stuebner@cherry.de>
> > >=20
> > > Currently pm_runtime_get_sync() is used, which increments the usage
> > > count even if the resume was not successful.
> > >=20
> > > Move to the more modern pm_runtime_resume_and_get() which handles the
> > > usage counter better.
> > >=20
> > > Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
> > > ---
> >=20
> > This only makes sense when combined with error handling. Keeping
> > the use count increased makes more sense for the current code:
> >=20
> > pm_runtime_get_sync(); // keep use count increased on failure
> > random_code();
> > pm_runtime_put(); // always decrease the RPM use count
> >=20
> > Meanwhile your new code would result in double decrease on error:
>=20
> darn, one should not go "eh, let's just use the same pm-runtime pattern,
> should be easy" ;-) .
>=20
> But I guess real error handling in those cases might actually desireable.

at least in setup ... the others don't have suitable return values at all


