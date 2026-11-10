Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794327268;
	b=kJqtj9uzRIjxD30kcMO8f2W5r3iIKe9s3dFbWk6O3CPhcrd0TICUVaGyKf/u/QTSutfl
	 QjpaohulqsB8yyzvw+tK24PFXkVOvMPs3G2JjRGAf8aYeghmGhoZqU6bqT2wgDBdzjYw/
	 jNSwEfELCh+kcZ5vmk2lfZsxxeucQtC+gK3YLgjCkW4Nuo44NWXMelPFjUTUeEEUcrVsa
	 rMR+XCnHZahMPKie1ALJUlW5jLWs7xtGJ7rcBlle2NooNhLPAP8shf208ce7dnY8rocmk
	 B66oL6o4XzYPhPiZitmfhbbVhMMpStn+NiupXoRRYlJlV0PbLFtS1fWHjvK54wG9YQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794327268;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=VTwH4AZAnTqvqVIKDfDqEJbISyn1E7hgr1jsha5Pows=;
	b=09WfACwKoGw/B4y7hopIBtpTAP/nesLxzcFeMADhbps1UJ+KUsSOqvU5oBn8msVCKYTp
	 ugdOwL6Gst3rmTfhCXv2R5SsfatrugA6RIjD4kdyYDGg/uNERt2g+ULOSHdwGefXTPpTn
	 4Al6VMT7LN33MywHPiGOClZuCyPWAoW5UEL6NKuC0ZpkiphBVb0kq42QYZiOkX8CRflgg
	 WowZc5zRn9CfNleoDYvuTnJFI/Gf+wSZYUogeiOblsPlTuIlj0GU3O6Iw8UeJ7Xf7eMCq
	 VrTQhp5OVXpS8Z7y2akYejPXisNOjrxqdtfsiPuAzcxf1nxLACZwz6qfY9b1rW5+cpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cc341CzK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C294D606A323;
	Tue, 10 Nov 2026 16:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cc341CzK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A69301F0089F;
	Tue, 10 Nov 2026 16:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794327267;
	bh=VTwH4AZAnTqvqVIKDfDqEJbISyn1E7hgr1jsha5Pows=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cc341CzKf3+9oxvcpT7QttZs9OydXOP4Mod0tAIw/DHQljIirxUE+rTD2YpumnkaM
	 jJMGxPixCGODU590DVjqvZ72dFaySeRIVaZ3Micaj2z64YeRIWBkcZdu39xzcJA0QA
	 VVsLfZGsDZt8Ieey7XfftMD0YygqNkWuDNSCIhGC4XRWIPLu3LbQuQTR5XXL/pbIHS
	 qsp0s3OXm/yMxiBMzrTo/vUCbbWJiUFXcnARzEK5HuyVP1fO6rNEfrSI5FYhqRB0kU
	 pYx0vZY0o/K5k8H18HmVh1d+8IEA2KOe91IKoYba3GJ6FecaF6KU1RS4WT9+Dg422w
	 gPa/Xvea5ayJg==
Date: Tue, 10 Nov 2026 16:14:21 +0000
From: Mark Brown <broonie@kernel.org>
To: shao.mingyin@zte.com.cn
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, pjw@kernel.org,
	samuel.holland@sifive.com, william.zhang@broadcom.com,
	kursad.oney@broadcom.com, jonas.gorski@gmail.com,
	bcm-kernel-feedback-list@broadcom.com, anand.gore@broadcom.com,
	florian.fainelli@broadcom.com, rafal@milecki.pl,
	linux-arm-kernel@lists.infradead.org, sven@kernel.org, j@jannau.net,
	neal@gompa.dev, asahi@lists.linux.dev, ryan.wanner@microchip.com,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev
Subject: Re: [PATCH v2 0/5] spi: fix division by zero with a zero transfer
 speed
Message-ID: <b8b3dd8e-7d66-4d8f-87f8-c88148334ebf@sirena.org.uk>
References: <20261110233450305Smji446Uhvoxa7r8SHEgl@zte.com.cn>
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
	protocol="application/pgp-signature"; boundary="xGHggE/6XmtG49YC"
Content-Disposition: inline
In-Reply-To: <20261110233450305Smji446Uhvoxa7r8SHEgl@zte.com.cn>
X-Cookie: You can't take damsel here now.


--xGHggE/6XmtG49YC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 10, 2026 at 11:34:50PM +0800, shao.mingyin@zte.com.cn wrote:

>   1/5 spi: sifive: clamp the clock divider to the register range
>   2/5 spi: bcm63xx-hsspi: fix division by zero for devices without a max speed
>   3/5 spi: bcmbca-hsspi: fix division by zero for devices without a max speed
>   4/5 spi: apple: fix division by zero in clock divisor calculation
>   5/5 spi: atmel: use the maximum divider for an unspecified speed

Oh, I see you also sent those v2 patches as part of the series as
normal.

--xGHggE/6XmtG49YC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmrzQtwACgkQJNaLcl1U
h9DXEwf+Lv/vVmV6mzd36B8u7tH7Xnl2z3sklZVzt/pyPr3Z0ZfatrEJTwsQ7C2P
t+VNfEkdZCLOKALR84LZ0k+GmDZp99DRg4mrpiml1GgGZnpPL9czK5e8o7gacKOW
CTr4UVWZWB6P+C+LmAqpSRXYBzkFpJ1lMLJhTR4SLS6/xVybvmpjgoIJgrW2uSpp
5WRciPMlEsQx0QeFcwgjifHCLt+6S0NC4WZUYxZDTA4xDU5kP3LFGse2J9smh0eo
7tRfwP4T85kQcB48kihqz4Ujpawh0a5tX7tkESJyokEItNuEHoZ08eiMR8RiFx+5
lsljqDlb64q8lH7sAy6dJdBh1e5OIw==
=xMYN
-----END PGP SIGNATURE-----

--xGHggE/6XmtG49YC--
