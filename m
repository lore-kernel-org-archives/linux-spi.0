Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.11.138.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794999246;
	b=vhaYZeY0aDaJjOO45StPS1LMjULHuFs1fe9acidYDM4ij0yqVvqMTW/YqQli1yEFIksG
	 U0eK6e2y7Uo4NoCe8FO0e5vLsfAYZdcE7U9sKWIPq9TInQrPCqIcg6Mw0hcF7a8NbJYay
	 21YFNAwtW3GbhI8Oq6/IUF7a/gcXSghlA51QEGOhPBh3mJHGjJtDMv/76LZYy0XkSSojL
	 TPS2xCMHrV/7ziafqcH752m+DlBDbDDngls7MM3wTFkVfDIz7FWD//kPvm4BaPqGDX6xd
	 +8in5cYMXq3TU0KoKfBD22v9EgvYIGm6RIkIfn912QFobSSJn1cdtzj2u1J7IcJ5gZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794999246;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type;
	bh=2d12lWVGBsaoMn/Enc4uD3O8Aj7O2S/+EaVF50C+EQ4=;
	b=kxoXC4PkWNKAHbY1oQ2Q3Aix01TImXjYOHT2DpBgVIZHCj6p4tSmWh+C5GESycVhY2yi
	 Nm0nH/vaifnJEhLxPhVsGvWOdWL5oPwo36ouqyhWOK4Fc6NhPRwIZKCniMPL8LnfyH8ci
	 HA+vlVeXs+/5TQOa+ZQ1ryJdwbp+SdWBpkpKlU4dB+yGjWNZev17Zu7A0AUskNP+mmGpX
	 /L51LAwT+eKEUmI2XhU0ZU2km1URvByStZVQa7jwi2b5WdRYqySJAwhXrn5cM4uyO1uw5
	 b+KdJepD2Xn6XLObQPSjKqoy+1m1WU1L1oHPp28O97+3pkT3cYu2OCO2+OmVtH9S7nQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sntech.de;
	spf=pass smtp.mailfrom=sntech.de;
	dkim=pass header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=ASB9sl6E;
	arc=none smtp.remote-ip=185.11.138.130
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4EC606A31C
	for <linux-spi@vger.kernel.org>; Wed, 18 Nov 2026 10:54:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A4EC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=ASB9sl6E
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=2d12lWVGBsaoMn/Enc4uD3O8Aj7O2S/+EaVF50C+EQ4=; b=ASB9sl6EOSdJIB1EGdzGn/PsUI
	tjmO5szAeJdZlM3+Q+1IxHT6bEQz7NGbHeDeXN/VaxTVXWPcEGKc4AfeQfzAuyTuxCIVTt7MpD5t/
	XlSIvngr8SDDvOVk9p25Jn/Q/FYRGNish8CUgxxwlY5S/t2eXyRIV1e04CKzxeg55zOC/EKwYhBkO
	GGKPXSQczmZOV3gvlJe9BxKNc5Kdwfh74CEC8xAFFoZieOiti6wZ9MnWlrXi0cC/pRxJv6OdZvQ5k
	F+DEY3D2KFaFrIzZppTvcBQ5gdYd88NvoFprVbrXRsYK2qEsmfnrs9yIAcKEjRDQLi4S3L2LG/LU8
	ffa/brvQ==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: broonie@kernel.org, linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 quentin.schulz@cherry.de, Lee Jones <lee@kernel.org>,
 Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: Re: [PATCH v3 6/7] spi: rockchip: Move to pm_runtime_resume_and_get
Date: Wed, 18 Nov 2026 11:54:02 +0100
Message-ID: <ldw_Vn7fRw2QdWAMZ2npBw@sntech.de>
In-Reply-To: <av0CaMF_jOyqMYA0@venus>
References:
 <20261117235021.2013719-1-heiko@sntech.de>
 <20261117235021.2013719-7-heiko@sntech.de> <av0CaMF_jOyqMYA0@venus>
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

Am Mittwoch, 18. November 2026, 02:53:32 Mitteleurop=C3=A4ische Normalzeit =
schrieb Sebastian Reichel:
> Hi,
>=20
> On Wed, Nov 18, 2026 at 12:50:20AM +0100, Heiko Stuebner wrote:
> > From: Heiko Stuebner <heiko.stuebner@cherry.de>
> >=20
> > Currently pm_runtime_get_sync() is used, which increments the usage
> > count even if the resume was not successful.
> >=20
> > Move to the more modern pm_runtime_resume_and_get() which handles the
> > usage counter better.
> >=20
> > Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
> > ---
>=20
> This only makes sense when combined with error handling. Keeping
> the use count increased makes more sense for the current code:
>=20
> pm_runtime_get_sync(); // keep use count increased on failure
> random_code();
> pm_runtime_put(); // always decrease the RPM use count
>=20
> Meanwhile your new code would result in double decrease on error:

darn, one should not go "eh, let's just use the same pm-runtime pattern,
should be easy" ;-) .

But I guess real error handling in those cases might actually desireable.


Heiko



