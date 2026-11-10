Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794342621;
	b=RC1NSpVBYRPtYtcorOH+fPxrFyeYmNjuTTGVuXYza2VbIpxZHppat4UWCS7Qxg+SGHuL
	 Wa5u2lefV+WBRlsMABK0tcC2Em1Q11O77PRz5G4Kdf0HDasQnoyCEJ8pF0Abz3fEKraq8
	 6tdHKHJHjoba5tQ/OnvF4DB4gK374PAnTb62HUKLg4YSEX7HCBK1Muipr+7sdiDHCb5sb
	 Zwkky+l4c/vHOqx0LhMo4Z1/x7xvfH1HdEDLDcK+gwt4l/PUo4OXmirE6u+FtrPOdYsOQ
	 nlt+M4HfMwAsSN//j9r3q7Bcl3HdoTqf/zGODGpJr8VgUDGcxSXIhaZvvQL8jBcOy2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794342621;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-DetectorID-Processed:
	 Content-Type;
	bh=Acko2u8EVM81tvP2FXdKU6AgMOuesk61mLuqsyDFlq8=;
	b=gkORNSG0H4w+7TIf4GwyXH2CkbAlcqNb+8OY7oC62/em6beEwuxWGdrupmZPTB6dETgJ
	 EPmZKQbwpKOrv7oW5QwD9felGdDmgOxPQNx/d4DMEYaZN0ggg0X0c3y9TBEG51CX/YE5e
	 QRYST8l04o8xf//u1WACoiEFBsFmYfHBWOydr0BlzU2/SHfUMfDRDMfY72USYh1aUKkg6
	 I6pqiXCRsXo7RtIem9pzjsERiPfJ/K5k6Xcz88vofcGCfSRA+YhAzdQMtgHH/gxuZ6fE0
	 RHOrAaDncYErBZ5hqtiDC/w6u9eb0VjaBf8WvNCujihJcqLV6axXnfNy/6tQyCwYY/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b="GKrRk67/";
	arc=none smtp.remote-ip=209.85.216.100
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB1F606BA7F
	for <linux-spi@vger.kernel.org>; Tue, 10 Nov 2026 20:30:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DB1F606BA7F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=GKrRk67/
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-3ae1b34e0d2so1370476a91.1
        for <linux-spi@vger.kernel.org>; Tue, 10 Nov 2026 12:30:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794342620; x=1794947420;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Acko2u8EVM81tvP2FXdKU6AgMOuesk61mLuqsyDFlq8=;
        b=jtbkZuQkM1gRgcIvmrOnRdUPin+XEIhVgyyWmZEtTBKTaMkLWVIdLj8ochfzv/vtqZ
         qN5vNfpTj229SIvZauOUxUArTKI2KLUiJUaIWd5W09WuFue9evHm8h3l38Dt3HU0Zi4z
         X3k9fzcCRC7aoFFpOZL7mmQbDZQG38zFkZIvPRGM+uaaF16v55owkuwjDUKa0fYi7xl/
         CfgCPNoy3DziKN5WzQtCCqEIh3KSSjemZDXJmtxSOefvmt220uvFuqeFHKJeJmbYLIHh
         AY47qpNrh1r4pOZ86dqEzyPGTzurka9qq3e5z7ZSHZfdhRewKTa6dWBPNZgrHMZn2hpN
         tG1Q==
X-Forwarded-Encrypted: i=1; AL+hErFHWPU99CS81rTQpsePo5oqUImW+iKypygDb9x+IIg1eDk1EABoEHErzIIf6ePdyyWuHbikhmRFcOY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/WLOIiFURz8VM1iPAQRmetTvDm8zp/pg4xDDE6kwz7/D/N4Beh
	7LdKDWoDFlgoMcw15r8DLbYco7VNcsoU8HuHX+jZK7S23+Y9astD45PGY4J0y+ae4fGJQ6VTA3Q
	99yEervidQurewmyE8Kxf0jPWKqfsdb4/9o0QQZJX3gg8kIsT+wDkslI0sj0Di9aCYvf7biCbdv
	3uFcI9wLqbs91wfOQLdpCiQ42AIOMUcm5lfu8PkfOfsEhAT8/sVdgYHUC4s2i/xOvuaV1kA+VHL
	yggCNcK2ujB9hDU
X-Gm-Gg: AYBFou1+e9VG0wtFIY4GUtw5kpKJ40DzC5jMQiD05H2MifnN+/yI0YBUh0EsSm6vDIg
	nGb9Z2FWBcA6UO3Rh/8sDOI1OBsPLq6CnVivf+Dds5/6zfthof2TAu2D/7hrmYd53fy5G/EJG4d
	HXQ640DTl/fy0EBrS7UcBeYWLq3OYvF95xKhfSWkLFaz2V67SA0Nny2zM+EYJz+V3bKxWRgsjqY
	p8Dc90hPrG0HmlwZbtjW8bVB6Cz1ongkv2v0iQoVQiXWkdpHDMAvc3ZiWbfsNIV4A5gqsyCJnKv
	hIA/n+ZAexUMFM1dn4rShqBqhiCGGkNKVBaLSEasj4om+EsJnuuTRda5RLWje7WSRNSq9abJKCe
	D6D6vtwFXR6xVn+zk3Ha7P/QlEtBKirFoVhaN+TuXGCfDcxvjrP+LckTVgZaLr1LbE+TdF3X+w2
	gfArxCi1vbCmcknBxhZBRI3qBB/5Do36Hsdv6v
X-Received: by 2002:a17:90a:e18c:b0:3a7:9ec3:ea0e with SMTP id 98e67ed59e1d1-3b182efef73mr80773a91.22.1794342619750;
        Tue, 10 Nov 2026 12:30:19 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b181f80204sm144558a91.1.2026.11.10.12.30.19
        for <linux-spi@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Nov 2026 12:30:19 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4f4612a1a5cso2689143b6e.0
        for <linux-spi@vger.kernel.org>; Tue, 10 Nov 2026 12:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794342618; x=1794947418; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Acko2u8EVM81tvP2FXdKU6AgMOuesk61mLuqsyDFlq8=;
        b=GKrRk67/v5tiYY2ON67kunaGTTf3f2q4DeIbKop9WdSAD69TVID8ZCJEIBpbQUquhL
         dUzy5/spmObiGeB5ljktVlnBMOlGv+1NzffblpyVjKLtmDjlIqYW5JjAv4HrmPh8U+ur
         Om1ifyhX1Edt/XYApirvtTSZ7hkjOwcDMnUs8=
X-Forwarded-Encrypted: i=1; AL+hErGyOxf1UeWh0JghTz6QtJfyOu0j4U/9NBlHMw9kwtoiQCyTpTr4j7jvcsyMlx8+ZpIx3cc2qRJPXOU=@vger.kernel.org
X-Received: by 2002:a05:6808:1b25:b0:495:f8a5:8797 with SMTP id 5614622812f47-56866c26ee0mr1910146b6e.0.1794342618087;
        Tue, 10 Nov 2026 12:30:18 -0800 (PST)
X-Received: by 2002:a05:6808:1b25:b0:495:f8a5:8797 with SMTP id
 5614622812f47-56866c26ee0mr1910115b6e.0.1794342617599; Tue, 10 Nov 2026
 12:30:17 -0800 (PST)
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110233450305Smji446Uhvoxa7r8SHEgl@zte.com.cn> <20261110233459277eFsXn1VXUPZl1EA9CCa5Q@zte.com.cn>
In-Reply-To: <20261110233459277eFsXn1VXUPZl1EA9CCa5Q@zte.com.cn>
From: William Zhang <william.zhang@broadcom.com>
Date: Tue, 10 Nov 2026 12:30:05 -0800
X-Gm-Features: AclHuK_JleX22zVRIqA91EWx7AC2g9xfD0FqItQwFTVyAjuP5RyQh16KDzAl-TY
Message-ID: <CAHi4H7GHGO27Q=O8Upfds8jk-ujSHU5h91hCZw6qjftNX7a2Ng@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] spi: bcmbca-hsspi: fix division by zero for
 devices without a max speed
To: shao.mingyin@zte.com.cn
Cc: broonie@kernel.org, linux-spi@vger.kernel.org, 
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
	boundary="00000000000060b93a065ff1f280"

--00000000000060b93a065ff1f280
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mingyin,

On Tue, Nov 10, 2026 at 7:35=E2=80=AFAM <shao.mingyin@zte.com.cn> wrote:
>
> From: Shao Mingyin <shao.mingyin@zte.com.cn>
>
> A SPI device whose max_speed_hz is zero (no spi-max-frequency property,
> or created through the spidev sysfs new_device interface without a
> speed) leaves the transfer speed at zero.  spi_setup() would only clamp
> it if host->max_speed_hz was set, which this driver does not do, so
> bcmbca_hsspi_set_clk() divides by zero in DIV_ROUND_UP().
>
> On arm64 the division returns zero instead of trapping: the inner
> DIV_ROUND_UP() yields zero, which is then used as the divisor of the
> outer one, so the clock control register is programmed with a
> meaningless value.
>
> Clamp the requested rate to 1 Hz before computing the divider.
>
> Fixes: a38a2233f23b ("spi: bcmbca-hsspi: Add driver for newer HSSPI contr=
oller")
> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
>
> ---
>
> diff --git a/drivers/spi/spi-bcmbca-hsspi.c b/drivers/spi/spi-bcmbca-hssp=
i.c
> index 8c01475886e8..84015110557a 100644
> --- a/drivers/spi/spi-bcmbca-hsspi.c
> +++ b/drivers/spi/spi-bcmbca-hsspi.c
> @@ -196,6 +196,9 @@ static void bcmbca_hsspi_set_clk(struct bcmbca_hsspi =
*bs,
>         unsigned int profile =3D spi_get_chipselect(spi, 0);
>         u32 reg;
>
> +       /* A device with max_speed_hz =3D=3D 0 must not divide by zero */
> +       hz =3D max_t(int, hz, 1);
> +
>         reg =3D DIV_ROUND_UP(2048, DIV_ROUND_UP(bs->speed_hz, hz));
The bs->speed_hz is typcially 200MHz,  reg(Frequency Control Word)
will be zero when hz clamp to 1.  It is not a valid reg setting.  FCW
must be 1 or larger.
The same applies to bcm63xx-hsspi driver.

However IMHO the upper layer should fail the new SPI device request
when its max_speed_hz is set to zero or maybe the spi core should set
it the max clock that the spi conroller can support rather than having
the controller driver to override with a risky 1Hz clock.

>         __raw_writel(CLK_CTRL_ACCUM_RST_ON_LOOP | reg,
>                      bs->regs + HSSPI_PROFILE_CLK_CTRL_REG(profile));

--00000000000060b93a065ff1f280
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
tXjb5BYFZKNuMImlxmOlyD3AkKTSJRueJMdv5b3HJxswGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEH
ATAcBgkqhkiG9w0BCQUxDxcNMjYxMTEwMjAzMDE4WjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFl
AwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAUp5BS0Y7+m5dxAIkx44eESSHl2P1Upqj4zQM
lL3kE1eq+Cx0SmOPOxyUI4pyyXj92mqsA044dI/StZU6lfdIiwiD6KYLWkFthPxKO0Trmq4FVImK
o58QitCfUyyIDDIUdbJqxaNR6IuCRar+qAZNwh/5ghFmYYDInEW40aMWQULfCkA8djWsljbJWq/c
No3X+E9NTO2wMKtsJrLHLwljZsVPz6nCBKj12Hr2EhKWK2y/QVWNvrsXY8HWMKcdJvxhLcYFsg+H
gNpMu2LHh/vzwy9+xjI/QvuE6iPAhT6KqmWYa0Vjtt8RL+5/9w17ZQudpuuHySyNWC8p0MxpVnmV
ug==
--00000000000060b93a065ff1f280--
