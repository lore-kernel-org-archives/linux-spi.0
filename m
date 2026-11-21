Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795293735;
	b=C/+5imsLbG8ihy4dOLEfpw51/UyTQPRHuZCwes+3U51D37ibjtL0y377jIOaOJjBYOsg
	 z6yFE8ZogxkoxtZfHgOH9gs/MnSjPIe+7FV7dx2f0LPj36zwurcvl5a0bQeoCmxna1GkH
	 DzxY2xJrUFcR9MJtDkOfBRFejq97hbrrm9FDBcscAEPh6ilHPrgdWsu1jPfSMtK+PTVVg
	 Zxm5XsmmpyXYfcU+Btc1VZ1vLpmXm3vzvJpMIGX0IcSs8mgDLzFvh7ju5qJmX+iKJXV+k
	 5NUBYfh/R3h8QRRu3aTiz4BoAJyewcP1aESdRKjxT8mva2m6JnGq/cySRgDJVTKDnUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795293735;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=huxgq6e9wHfksi/drVHaTC3DOif56VffXqVT2Ec+rYg=;
	b=FoBlfGkIHUgOQ+MBqOEBzfA/dmw2xRdToR4FmDoJptO/TUUjzpUkvBJJQMLuYVbhJKEJ
	 euCSlLcc6kySDX7PWjdgfx+a507Pxc2lIzU+eL5f/S4a3KdheW0tABUlf7dNO8MdcogoT
	 q4+jCIjyQj43XJi6BRFzPspWxkX9gs6R2RR0vbaAh3FUrKvqwLePh0guArao8RLPcMrOF
	 NAanm6G7cUa+/fvre08DIzzRLeaq99Mb6UW5IpJ19M9LO7MKjwcKBeIkdvopiei79aXue
	 nJf3qS2jwGBfxw4y30yrLL/yBqx4qqWKti7NUOtcswF+MKO1oj5t+JYKT5eQtaXS3wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a8pXa9Nj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CD6606A332
	for <linux-spi@vger.kernel.org>; Sat, 21 Nov 2026 20:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a8pXa9Nj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6D911F000C6
	for <linux-spi@vger.kernel.org>; Sat, 21 Nov 2026 20:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795293734;
	bh=huxgq6e9wHfksi/drVHaTC3DOif56VffXqVT2Ec+rYg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=a8pXa9NjEx9NQ/UAZAfVgt42LplORXaYyGyB/rJCfB0Lm4Psbmc1pcOUHjwOnRF7d
	 GEg5NlA5BGM/WsTZZdqoyg2a/wPQkspqE8g1fRMtGD9zbabrEHzFAv9Hwnelx1zYsl
	 hoxYWeYg5/x/whFzryOTt86Bz4uIyhJcArYfdaHg/AZuoFQvW5XBRbFdwSEKwG/igb
	 gmY1DjUP9V0DbMtMWS8YkKlOEvxukraKf+/7QxUSJfIWUQK/rYHtJWWe/eAcqGj8Ou
	 hvBcvD8MvGmVBFAA62UuwzZoyO9MBuUFmonrilpHq9DR10KWMn7pQmDId7LIGndM35
	 ryUMk34EJmVMA==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5bcdae234ecso2561649e87.3
        for <linux-spi@vger.kernel.org>; Sat, 21 Nov 2026 12:42:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEs6RmnedAQM93GMUuwwy4FaFkAWzwP2pf0Vq6uSwCDEwiBwUdCvnKnstXAwBZ5N70etRce6yDCzs0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8RBSxCWpkxl/XFXTffGwOTVtzTxEDMa526fRYpBa5DhmpBAO+Q
	gfbi/j7iLbHiUeze6D4iu8cawaciS6k2WzL1ex0Tl1JyzVXHHPC9dQHsfN8BvyUlwq1aTkaMvpw
	WIbBXOFPe0dTrIqYxA5wHbEMwuLYdYGg=
X-Received: by 2002:a05:6512:31c3:b0:5bf:dc95:3817 with SMTP id
 2adb3069b0e04-5c1bc7bcbe9mr2121267e87.15.1795293733675; Sat, 21 Nov 2026
 12:42:13 -0800 (PST)
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112064957.1796975-1-dmitry.torokhov@gmail.com> <20261112064957.1796975-6-dmitry.torokhov@gmail.com>
In-Reply-To: <20261112064957.1796975-6-dmitry.torokhov@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Sat, 21 Nov 2026 21:42:01 +0100
X-Gmail-Original-Message-ID: <CAD++jL=u2okiCU12RV+nC0NLJEMg49CkhtPKOguapwXBpN9OVA@mail.gmail.com>
X-Gm-Features: Aa3M54q5oFmXwdWSrTxDLECj9BANyp03LDdetIui07Q3S7mayCU0UCP9cIWP9Xk
Message-ID: <CAD++jL=u2okiCU12RV+nC0NLJEMg49CkhtPKOguapwXBpN9OVA@mail.gmail.com>
Subject: Re: [PATCH 5/5] Input: ads7846 - fix minor coding style issues
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Daniel Mack <daniel@zonque.org>, 
	Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, 
	Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>, 
	"H . Nikolaus Schaller" <hns@goldelico.com>, Kris Bahnsen <kris@embeddedts.com>, 
	Mark Featherston <mark@embeddedts.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, linux-input@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 7:50=E2=80=AFAM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> Fix minor checkpatch warnings and checks across the ads7846 driver,
> cleaning up types, spacing, permissions, and macro formatting.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
