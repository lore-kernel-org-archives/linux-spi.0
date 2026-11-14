Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794665699;
	b=oOYsmuBWGAtTdsTbbmIuLf3riK1rPz80mq5X8LWHFmUkRaWM/2IjIfJ1k3hVKn5nXzvF
	 M7Rlo/9K0k899O03iI00KDUdwTOIasl1Y46zeOOSLwPIj0/cFPI087l16hm9fDyGbZB84
	 coPXtqtcvVwB6UTNNQ5HcVGnDk/thOUmQSgA0DefLr72WhNvdwlUss2PKHcdrugpV2Oqu
	 eGnbVry+E27pfezXhuhXkhzpLNQP77Q4bDlvBMKZks9iDmgyOXatwQP/a7tnMqb3m2+Fw
	 CedQE2VRq08exfamF0oAfB+LHWuDtGn0xzY+JYHgDNJrlRSz2/IWW6Ds0yxqhmZWtTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794665699;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=72U7+AqtHKP0x8muIDrhMnmzZwnSsUdy39CDbj4j1GM=;
	b=ogvGaKQkHAxqHysvyD1vRUwl+uhIcGMmHrwh8gM0FCir5fc2ItRLrJ/yXKHIYPTg7XKk
	 aiKgeUN9y2U4aifZla2TiUzhZuWMlVl2HQ4zSpQRXRcTIT76rP1OqjQMeqSOA5s999KDV
	 IlDyw+sJbCPcPSLGJzt6SQM5UkgAEsB9mxKUja/p9vzVOSXd1CoGhJNNKktX7MEByJaEu
	 QMiHufji4LqFKfesZ4Q3p29r2A+I3fpdOHTzYQ7daNYYZRqqRoENiYjuSbq5tokQAV1kF
	 ZDoDrmATa0etAic/BDBJxt0w4bYwmdGiPC1UKn3m3odmYq7Bcy3zLP3kBwl6p9lqCBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hrBTatZ9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193C7606A323;
	Sat, 14 Nov 2026 14:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hrBTatZ9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F8881F000C5;
	Sat, 14 Nov 2026 14:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794665698;
	bh=72U7+AqtHKP0x8muIDrhMnmzZwnSsUdy39CDbj4j1GM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hrBTatZ95dSn+bxZPrsTL4b7q7ny265GJboFq0ZXfdCCznkhSrXwtbCSzvaI5lo34
	 iJpLT/GdrqKXmbGC0pVKNVuyhPnp6xyufy8v0hQ+7/fMtqrbKZe2FQCSZe+dA95ysK
	 +goXp1loNQ4dmKmiw6qHIKuJvyWYFzEDc1tLN8IBbsC2Ui0URBJVu5VrHnaEhJLovr
	 JeIeSxe8IhMNxpzEF7RVpzoUgVsEoPXByn0S1C8G3WzBL2V8npovVd/cpas0H04BM0
	 S/tErP7EQPQSCn0Ra8kV8GNaj0KUaawDZhBroLf5Jt1Ps54d4au8PIdtb4MBypyxxC
	 /zWGeifgJ5L7A==
Received: by traversing.sirena.org.uk (Postfix, from userid 1000)
	id F3EFF32DAFF3; Sat, 14 Nov 2026 14:14:55 +0000 (GMT)
Date: Sat, 14 Nov 2026 14:14:55 +0000
From: Mark Brown <broonie@kernel.org>
To: shao.mingyin@zte.com.cn
Cc: william.zhang@broadcom.com, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	pjw@kernel.org, samuel.holland@sifive.com, kursad.oney@broadcom.com,
	jonas.gorski@gmail.com, bcm-kernel-feedback-list@broadcom.com,
	anand.gore@broadcom.com, florian.fainelli@broadcom.com,
	rafal@milecki.pl, linux-arm-kernel@lists.infradead.org,
	sven@kernel.org, j@jannau.net, neal@gompa.dev,
	asahi@lists.linux.dev, ryan.wanner@microchip.com,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev
Subject: Re: [PATCH v2 3/5] spi: bcmbca-hsspi: fix division by zero for
 devices without a max speed
Message-ID: <6a977239-f9fa-4eee-b2b4-944e77026b30@sirena.org.uk>
References: <CAHi4H7FCOxcXnYkNfXNa_iO9KFZRSC96urJthPkgoem7C52ppg@mail.gmail.com>
 <20261114140757347tqYOa2IkTGVulSwLrw2Mf@zte.com.cn>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZNqZEe0eKx9dEgrH"
Content-Disposition: inline
In-Reply-To: <20261114140757347tqYOa2IkTGVulSwLrw2Mf@zte.com.cn>
X-Cookie: A watched clock never boils.


--ZNqZEe0eKx9dEgrH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Nov 14, 2026 at 02:07:57PM +0800, shao.mingyin@zte.com.cn wrote:

> If you would still like an explicit FCW lower bound in both drivers,
> I can prepare an incremental patch on top of the applied commits.

It might make it clearer that everything is OK.

--ZNqZEe0eKx9dEgrH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQReagvpf3TrrA7BoYYv73Ows9A4iQUCavhs2wAKCRAv73Ows9A4
iXsrAQCU0JQox4pMECKuQI7VngVhCYweIy1XfePH/c1L1CUWtgEAjUGgmB2MHEDZ
5uNQOCvE/OVvVSAqED8H7eMtyw8n5Q4=
=eBce
-----END PGP SIGNATURE-----

--ZNqZEe0eKx9dEgrH--
