Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.11.138.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794594638;
	b=BH2p2amBhlTRVPSo/QP9jgmgp/Y3lIL1xXPp2biTJPE+N2W51lwAESOrwMUqkMjf4TRF
	 sgRVhEuYggRsaL+WNnvJB8turMLU9IGROK6tVA4H0OhSG2pmmlqk5p3eE+KM7A1rL50G/
	 VblJ7FGi2RGM1cuS6V5oVrikcUnnXEdKfQBFrzafYyACklSo1IkcaabrDwhsdZySXYuVv
	 o+/y0yevZZoJZvY0E13QcyEAYuP3J2dm/2LUoiMXljM+MhHrMGZDVyBlLxgAgevByZbUH
	 ykV04x2LeOvXXuf41ct648a3kOV9/Kf4WCKbA5qIfY2b2FafKuyAeskMqRWPXltgeIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794594638;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type;
	bh=wM1IQoyS/kff0hQA3Z9PrPD6GnekMw+h/sWii7GLcYc=;
	b=si/Wa8awdTzdUzO80xsg/KKWsKGUocLF9DhGL5RcBoicVDjhyd2OKQQTq+ODKt1dAOPQ
	 MvBq+XYVtUw3Ru3B3fRDp5N/i0xj1EdQwKBYDcXTb+LWAesLFJ2r/ts3SvcMb6z/xLjCh
	 hYNw15r49hTBuwo2dcWtXpg+DrAb91/GdcCbGqJXAlmKQ+nngnYUqR2yJIdIRmU4uq3KT
	 dOS2fztGJKbgLITZlnFnq6dULbSV0jipfE87TxyC4azl1gEBOCaHKGi7gY6vr211c+ao4
	 jUlQpKuqD6phQN0D4KApRiFdHzTnb64fRzGdbh3InjaSIHmnshZv6cU0x4B7vTqTNzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sntech.de;
	spf=pass smtp.mailfrom=sntech.de;
	dkim=pass header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=cdJSjMcA;
	arc=none smtp.remote-ip=185.11.138.130
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3493606A32D
	for <linux-spi@vger.kernel.org>; Fri, 13 Nov 2026 18:30:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3493606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=cdJSjMcA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=wM1IQoyS/kff0hQA3Z9PrPD6GnekMw+h/sWii7GLcYc=; b=cdJSjMcA7tYehsdP/mIhTaa/V+
	+xCLtgQUJ2lX7T5NPZZM1uyX6sFUu6pT9LUQ3ePCv9OTxuAX/NOwx5FD0CRsAAm7N/EE3nZVlyzRq
	dZb796O3CQT5YuD+vv/h/CXo70cyvubmjkdWzMI86a9VDzCYExMSB0hxCUU3I+csq00wKYzDkhixA
	gOIBNWELLZx5Ahp8iNkNtGJpqjSjx6HJW7GKENmC9VrTGjJhgpynJPxs3jQt+vVKwS1RhqF4kDgdf
	+TzkqzS07OJ+9k7kf1gDt2NXOL/FmJALu70PXY2hhCCwioH9P160aExjmFZjTdn5gt0LXV1tXvFA2
	K4IPxDzw==;
From: Heiko Stuebner <heiko@sntech.de>
To: broonie@kernel.org
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, quentin.schulz@cherry.de,
 Lee Jones <lee@kernel.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: Re: [PATCH v2 2/6] spi: Export spi_set_cs() function
Date: Fri, 13 Nov 2026 19:30:33 +0100
Message-ID: <m57rhfeHSi6wilRDC92EGA@sntech.de>
In-Reply-To: <9kep3BO9ROGEepQWTWqwnA@sntech.de>
References:
 <20261113135017.1047959-1-heiko@sntech.de>
 <20261113135017.1047959-3-heiko@sntech.de> <9kep3BO9ROGEepQWTWqwnA@sntech.de>
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

Am Freitag, 13. November 2026, 14:56:33 Mitteleurop=C3=A4ische Normalzeit s=
chrieb Heiko St=C3=BCbner:
> Am Freitag, 13. November 2026, 14:50:13 Mitteleurop=C3=A4ische Normalzeit=
 schrieb Heiko Stuebner:
> > From: Heiko Stuebner <heiko.stuebner@cherry.de>
> >=20
> > While spi_set_cs is currently only used when the SPI framework manages
> > the core transfer function, it contains a lot of functionality that
> > can be used for the upcoming atomic transfers, where a driver implement=
ing
> > that atomic transfer could profit from not having to duplicate the
> > chip-select functionality.
> >=20
> > The only sleeping part was the spi_delay_exec function doing the
> > chip-select delays, which can now also run in atomic contexts.
> >=20
> > So export the function.
> >=20
> > Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
> > ---
>=20
> Dang, overlooked spi_toggle_csgpiod() called in spi_set_cs(), which does
> gpiod_set_value_cansleep().

spi_toggle_csgpiod() can of course also differentiate between using
_can_sleep normally and switching to the no-sleep variant in the atomic
mode.

So before this whole series a splat is already created if a gpio-cs at
the late stage, so after this, the splat would only occur, if someone
uses a sleeping gpio(-expander) for something wanting to poweroff a
system.


Anyway, I've created a patch for spi_toggle_csgpiod() but will wait
till monday to maybe get some more comments beforehand.


Heiko


