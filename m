Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794616794;
	b=hKVpZjq9C9PMuIXqkXK1DkIPscohQMT3fazYPvZzQ8ercsUZvjOLq9SsyNQWjDenc8vM
	 j9G8YvFTq8LuzNZdAbYXGPI3Qb2QOIi43p2SsnhC0q3AMtBf+tr8hEMFG5JTHlBLl76+L
	 72nBJjArNYuSjJtYp8UerO8JGrGOimYl2jF0gK/GbpIOTU+S9A+cbghwVfE7ruC+UC+9u
	 54d26l0Ws3SeKg9bPvq4mQkhrPEKdUlB+rCwZz7J3iS3m3qfNze2Pz2cLNgNaxNTEQv2l
	 M4gL8J5KmsA/ebpmDYwlS4vMzV+2YUD+4zyFGeVG6Vp19WJxqGkto5iynL/AgnU5q7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794616794;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 X-DetectorID-Processed:Content-Type;
	bh=I3EepQWnMwqQzMCUMGpKYZous26LC8k4YvZu1hZ0ebQ=;
	b=sAW4sWqaADA9JW52RHovaavIf+oKmI+kNEbADnuJSSG4WYr9AiXllW5LgFhovN/x7Gc4
	 4VnVqkM4uZKHgrCObi7626mc9wIl8t2c4ytBlzDx9GyRZDSE5J3IN5X2FDSS8ZS9YVj5s
	 BwYZTIffTeIieLPzPugBqzkTfZBrvhZ+uQR0qiNvF5myqo89Ok82ctBQfVIZ4dUNfyjAm
	 s4s8DCwtatLpI6HgdwByFHuPehWwDf4KdVO5zl4zNE92cNNNW4umd28GoXZQ+3o9J8RFv
	 mOwQnmV4TRh6tO98bT8OJUTTY0TECmES8RNQJHfZPGg94BhDt9YJxNKldb+pMFRYKAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=RmaIkwJi;
	arc=none smtp.remote-ip=209.85.210.98
Received: from mail-ot1-f98.google.com (mail-ot1-f98.google.com [209.85.210.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F3E606A332
	for <linux-spi@vger.kernel.org>; Sat, 14 Nov 2026 00:39:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38F3E606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=RmaIkwJi
Received: by mail-ot1-f98.google.com with SMTP id 46e09a7af769-85ac281604dso1621202a34.0
        for <linux-spi@vger.kernel.org>; Fri, 13 Nov 2026 16:39:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794616791; x=1795221591;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=I3EepQWnMwqQzMCUMGpKYZous26LC8k4YvZu1hZ0ebQ=;
        b=wh5kYFm48ZEGHZ9ryDlR48zwLU9SF2hA+UtwD2FJnElKZI12PUkX3VfT45jDIrMpqZ
         8ElOfnole4N7Fj3VRjguMS+o6M6uGwGuudrIGfKIPPeCc92asU7Ats93upZjDn1xZwh+
         ZTrfhFKI2MLu+tpcEPqPK5OPxRNfH0OSgow/k/QCbfB8iLjvddmXApBXcPa1SIlvgyhn
         vaXHZxl6ziG44PCfYcto9CSbrqVIOktpcm+2Of60wcJ6oYhksVA5G7tjIimuLG49D0r1
         0sPE7h9XQsRGDhyiaZ1tNNU4jWBvDFF6igScttX2NOh52OqgQoyQPgwtn0GvWqzqdnmA
         5oLw==
X-Gm-Message-State: APuU4Z/QqxnXA2Fh0L/0oFUpJkTSvPXdKviNOEiWP37fDcRYl1MgNuqO
	wFmb9JvqiBppC/zvgDIrA9QKCoj3nVMvSCGQv8U7UmX747Ws0kzH0OHAP03pwlwtJPP4+RHn1Pz
	oj8RsfkBbDZF6xWN64ISlYzZ1azMyhvr53Kx+sCt5hG6UzaczW6q4cejbDlDZOFE8uJlFDwjBuh
	l6THOW3xOmfcm+LRcea+nuFeCL2fVXfZD66KKZshX6opTnXibJjZ0o51FCksPQ/JmOL2k9Q8423
	InQGaHuPT1UUqI3
X-Gm-Gg: AYBFou1Oqa3IfIZ7FmmIWK1MzfaaaG+jS8oSiD/u1Spo1jT3jT0LPgShwT+PHIBF8H+
	29jXvXYEBfwqy67pxdMI8iMIv880T0MKsD2TumSnwVz/4vBihAsRQn3wjr1BNJJnaOo8YsWxvaR
	xMBT05/kXsu5qG92RHR6J4UjzPSKqn2FA/jF2MqGH6Bv1vWQKSTyprGWRscjPePBU+I2FQ6vG1P
	cCJGS0ZvSEeaUgWxvLeVOnB7RU+S9V1wWzCc/ESxhnwpkfyQjMTwfOKllsrfrVtGBxSKHxN4e4O
	lVqzv1ScWePogVhvs+58Z9ASC+/kb9u4oOc8/IaipuobPeuMKyLr5P6C3nk8WgUK0mFWBtJz0/4
	LE9CKow1eItq8eC9fdG8ISExFKsK7GdlBoXosanKw9rsTVI/teMv2yzZV6DvSO4Yb5c3GGOmJFs
	9SMjR6gdxuaYz6A+d7Q+DTro5Hk8pEwCeoRPkrn1U=
X-Received: by 2002:a05:6830:2683:b0:861:5924:c315 with SMTP id 46e09a7af769-8628981b64cmr4173553a34.5.1794616791117;
        Fri, 13 Nov 2026 16:39:51 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-123.dlp.protect.broadcom.com. [144.49.247.123])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-8629bdf5ce7sm61995a34.13.2026.11.13.16.39.50
        for <linux-spi@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2026 16:39:51 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-677c4ca2265so2286886d50.2
        for <linux-spi@vger.kernel.org>; Fri, 13 Nov 2026 16:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794616790; x=1795221590; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I3EepQWnMwqQzMCUMGpKYZous26LC8k4YvZu1hZ0ebQ=;
        b=RmaIkwJiOf96QPJbocEHtzI7hYeVQa+Kyx1XPiBynarZGoroUUDeebQ/7UfbiKtQ5R
         rR+DzGjA8hCBAeJsNXKryPVN5Z0mXxD1BzLh3OONQV7lxjJcyVRBetAgPOz5en4ShaVL
         HXz48V5366dXfzVvVJWtWBlzOQBTH7o6th54A=
X-Received: by 2002:a05:690e:11ca:b0:67d:927b:5cc7 with SMTP id 956f58d0204a3-67d927b62b6mr1064882d50.63.1794616789939;
        Fri, 13 Nov 2026 16:39:49 -0800 (PST)
X-Received: by 2002:a05:690e:11ca:b0:67d:927b:5cc7 with SMTP id
 956f58d0204a3-67d927b62b6mr1064860d50.63.1794616789554; Fri, 13 Nov 2026
 16:39:49 -0800 (PST)
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110233450305Smji446Uhvoxa7r8SHEgl@zte.com.cn> <179460764342.448985.18219249061160291658.b4-ty@b4>
In-Reply-To: <179460764342.448985.18219249061160291658.b4-ty@b4>
From: William Zhang <william.zhang@broadcom.com>
Date: Fri, 13 Nov 2026 16:39:38 -0800
X-Gm-Features: AclHuK_R93zMx5JdIqA9R4YFk19f5vFBEjNV1ogvvEgejiFz1GRdDNuBkvJS7CI
Message-ID: <CAHi4H7GnDJPcJ2_DD8GGuFjN8mZsGPVWRCYzfCwywQeh26-=Fw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] spi: fix division by zero with a zero transfer speed
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, shao.mingyin@zte.com.cn, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, pjw@kernel.org, 
	samuel.holland@sifive.com, kursad.oney@broadcom.com, jonas.gorski@gmail.com, 
	bcm-kernel-feedback-list@broadcom.com, anand.gore@broadcom.com, 
	florian.fainelli@broadcom.com, rafal@milecki.pl, 
	linux-arm-kernel@lists.infradead.org, sven@kernel.org, j@jannau.net, 
	neal@gompa.dev, asahi@lists.linux.dev, ryan.wanner@microchip.com, 
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, 
	claudiu.beznea@tuxon.dev
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000049f303066031c865"

--00000000000049f303066031c865
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Fri, Nov 13, 2026 at 4:27=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Tue, 10 Nov 2026 23:34:50 +0800, shao.mingyin@zte.com.cn wrote:
> > spi: fix division by zero with a zero transfer speed
> >
> > Five SPI controller drivers compute a clock divider from the transfer
> > speed without checking that it is non-zero.  A SPI device whose
> > max_speed_hz is zero (a DT node without spi-max-frequency, or a device
> > created through the spidev sysfs new_device interface without a speed)
> > therefore reaches the division with speed_hz =3D=3D 0.  The SPI core cl=
amps
> > such a device to the controller limit only when host->max_speed_hz is
> > set, and none of these five drivers sets it.
> >
> > [...]
>
> Applied to
>
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.=
5
>
> Thanks!
>
> [1/5] spi: sifive: clamp the clock divider to the register range
>       https://git.kernel.org/broonie/spi/c/49071cdbecd3
> [2/5] spi: bcm63xx-hsspi: fix division by zero for devices without a max =
speed
>       https://git.kernel.org/broonie/spi/c/82ff536b6049
> [3/5] spi: bcmbca-hsspi: fix division by zero for devices without a max s=
peed
>       https://git.kernel.org/broonie/spi/c/167fe08d3ba5
There are still open disucssion in [PATCH v2 3/5].   If we want to add
a clamp in the controller driver,  patch 2 and 3 require extra fix as
discussed in that thread.

> [4/5] spi: apple: fix division by zero in clock divisor calculation
>       https://git.kernel.org/broonie/spi/c/ee22df21fdf4
> [5/5] spi: atmel: use the maximum divider for an unspecified speed
>       https://git.kernel.org/broonie/spi/c/51953948d6a8
>
> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.
>
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
>
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
>
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.
>
> Thanks,
> Mark
>

--00000000000049f303066031c865
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
PRi27wH/XHTDMdyL0Org+kxniXue6MSNJvcQwaLO/UQrmgTygBlVGa+Qg9ZFfS00xvuqeYH7tImO
48WiXeu9rgn5KTH0IWP1+R74KIgxJQ+65la+caZvxwC9V3ik5p/LOGA2qS4GEjGuaYF8QKhRTR4h
/QBSktqZLbzVxpjJXrqFTA2BLlYRp9hPhqNxbn46WuLufpMWhFtjUoQi/8fRRWRsMAY0o1J0f+kB
6EI8FoxPTOpvuLRonqHIWMHk5YRnDdqJ3G5Oc8zmV+UCAwEAAaOCAd4wggHaMA4GA1UdDwEB/wQE
AwIFoDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDov
L3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5Bggr
BgEFBQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUG
A1UdIAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUF
BwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDag
NKAyhjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwJQYD
VR0RBB4wHIEad2lsbGlhbS56aGFuZ0Bicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYBBQUHAwQw
HwYDVR0jBBgwFoAUACk2nlx6ug+vLVAt26AjhRiwoJIwHQYDVR0OBBYEFHjI7pbQZurVKsSRE/a9
7gUEyVCkMA0GCSqGSIb3DQEBCwUAA4ICAQCFA4fU1GnG8sY7kyUXp5tle+VeWveoWb272jPauU5R
w+udkhVXmnR0Kg7RgkCD00PLTKHNRyegXXDMArs3N9NhO3s9eSp9KjDh+h3WuQWCJH3QBHLGW0qE
fyV87wUtBIy/QsHwO4S8OlOZiXECR7V1EGIF6t3s0W+3UzgYeHL+Ttuhda+2wIVY0EbS0eNH9Vob
4YG17VTBBe7hyobXFpd9d1JGENFzIWncPUshOE0Wv7KlkrRc6aBOpL4p5xO1pHi9h9w8utyHkMoV
nefXixkn5YVHnuV/jbSF/IM4Mlqt0E+n/TRp2c0eR+1AauZKENV2syNBo4aMa0BkmikBjLSnDjt/
TYQdwHNWdV495n71idvueWwTFUhUsnudYcnh42eZENopBOYjVu2WhsffyrNz0hsuR85LriqSuBbf
drd9DMo3DgtfJ7hh4sEAhSw/x/Br86rfLBftZMU02htlnkOI9Tp1QuDsr9+MsqY6AjKeXAy67m7H
TVAZ9uyO9N20yU0p7igESOWKR1ccL1TPA1jrSHK18Y75ot5199FNWeE/UKoDKSML39iPZho9XPh/
/RlsfRFiVOPrI5Gwi4YfIfi0jjEWf310/CYEmA5jrp5gUQSdo/+FgfXLKDFiEHCf5b3B1l70r6bR
WkDCNNacYJWZtSp87i6jmw+l5xx7OkEJ9DGCAlcwggJTAgEBMGIwUjELMAkGA1UEBhMCQkUxGTAX
BgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKDAmBgNVBAMTH0dsb2JhbFNpZ24gR0NDIFI2IFNNSU1F
IENBIDIwMjMCDD2ooFIye/WiO3KgZTANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQg
LZFCjP7B4eWNV4p4bAsKClYp/L7CCgVfLE9Ck7WCWm0wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEH
ATAcBgkqhkiG9w0BCQUxDxcNMjYxMTE0MDAzOTUwWjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFl
AwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEANU+g59Ym8z2569oD0lWRL9hfRWZht20X85Kf
tUuDiX+aucfhpZ5VnDaUL01+DSy/fXvm/6hfxuRw3PpfcU4DAVeG8A8Up6zZfJDZDtvaMDMmFVOE
xabF5MaL1V+gADN6OpJFADJlwR6em1c1nRBRqf73efwSG6neWfq3174P4S2MOiaAQG8MmScd9nKZ
zX8Xu5y1yv5McxaTmAX1+1d3JZg/hn7xGpP3sv+zsgf7yRR4l4WwPe/WWzMB8pwpcXH+Iaoc+2Pw
4pGUfMCdl+FrKzFdGh+Y4nI6D5Tip6+59Ir+PQYvrGLy2EsiAr5tase6zEkWd0+H7ekGD8UXzeVV
eA==
--00000000000049f303066031c865--
