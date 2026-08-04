Received: from mail-yw1-f225.google.com (mail-yw1-f225.google.com [209.85.128.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203894457CB
	for <linux-spi@vger.kernel.org>; Tue,  4 Aug 2026 21:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785878462; cv=none; b=gcnmw1r3QqmhcdPYbeUKn2yDGQxrE+C/4lRZvHRB6vHuPESNDRPmgoOerrvlCmJeKDlAauGYykYe3uocJtv6UsYLSg3a5tX5Fjhyy5Z75+IpIUwwMguaJLJkwmjueMtJn+R9n36vMAQ6oaG1Wvzw34hNPpmQfeELyBux3mWndEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785878462; c=relaxed/simple;
	bh=71OghWNZrCrQvTpG0pdaqZaMfips/pvfXqu+nc1lE5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K3ISI5DQgdLQ2n+hg61i9WuwVavbRjKgLV8XioOMNZhnTCd1kUaVUZBoZGaL9JUUJoZYlncoZx4fmomwC46GBx1FfIE473liO9l1O3HVl973mEiMUmTlnnRZ2NecInbZZ/OkICpAQ/HYs0qQiU5WVgj5WGrbClDOFChAKslYTZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=DP6C/UzS; arc=none smtp.client-ip=209.85.128.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DP6C/UzS"
Received: by mail-yw1-f225.google.com with SMTP id 00721157ae682-81e69a2db34so4860137b3.0
        for <linux-spi@vger.kernel.org>; Tue, 04 Aug 2026 14:20:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785878458; x=1786483258;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dn2Ot+xTp2Jd42Ak7BvUBUKuZjqJaiYGKZVxpl2n9Ug=;
        b=Lg7MO5XPlCaSh0HfxJVAhK/TDyoON/SZkvMmy30ZWPyCJFi2Rh9Ny7KqQOup3Q/l3V
         64I1xGdXnqozNWDwM4zGZCseSZ6/vYTVx+4JjuomT4/SeE1TGmG1RsXOZcwAi5VKwJpX
         eO/R8pX+DUEsfj5Fd5d1sjZTO9AkrwXlb4nXS3aCZEfLWnMNGUqZOxQNEMBp3pwZ6ccc
         ujki/wq9HwUYdVOyJ5uumJUWt3KSwdAqd/vfgjAKVsmwcMuBUenvOI3TdshH1eQCiT/G
         Gdiuhoxj3VMZCq71rSTSzv4NYf+u0C0BWMXY8lMHdzkZ4KDEAgIWbyXxFU/hNASH0DCm
         wvbQ==
X-Forwarded-Encrypted: i=1; AHgh+RqE8f6f8wkX5fjJmC6xcwFy4i5aELnscLhchzx8kqiVmFff/sus0P3bszIVV1nX4rSAOoPCLpf+sTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yytr07V49Mzj6yBu5vWpiw5DpXC9PTrn0k1cN68by8UZH0JJHgB
	hMMYmAF08/iGTVCykW5pmk5CG+kFH5ABBd/tFysE8UOpqR7z37ZGEjxh+I/DiVfqwHeFIZWQXp6
	ypoOOeZF0pa5WOzmgsQo4jtVHc1zKs1AtUqA0SGyxPvHGZ75ydypYYqG57mKbW4YcQ7CNKRyURR
	5/5h/zTNIQM8vK2mMmootX2GIDbwkEIZIH0VQcI1d1fpKCpD4lvSv7xkLhQOVXNjDuoFkLyUufR
	b7DCP1Fg+Z43sjJ
X-Gm-Gg: AR+sD13EVswvxjsUli3mrENwZKpbcvm4m4HxVx1WPlicmINOAnpy7/3KBBt3uWeH6LV
	xwf4QxbF38XJDXBGbAo0Qa5GdOOgNlP8Kpo1mMD1sjOCgi2g4dQQqs0RSL+gqBlllyxB07MCXiJ
	mZIKlCt9Jp+YYPEoIpqy+pFt6NkHz1XBZ1qxIoI6QEuo1tLzKlb805xRS5d51JH9CPiW5NZvyPt
	sWhs1UbIKAkT5AOUsNgCzfwb44cCu1DUN2xqrSDTO992gkZfuM38pTlLxxbfTTOfvdq9PzDTxCb
	9NNpMIfwy6az2RqWjKkkycBL9nmBs8lJTugzrhI1m97lL1COgqHKwSZaAOuuXjBTBOMliA4goNJ
	vlWwMSy2uEWyVoVTh1g7j7U6jRB5UkGcRMpPnO5DrzuQhN0Xy8s3OQKM12arvhqZRxE1tKk16/Y
	TSFeHMbn+FuoQHWd2D43CbXu8o7HCLfHFj/q1G
X-Received: by 2002:a05:690c:6603:b0:80b:9114:3b7e with SMTP id 00721157ae682-820222c0250mr9365977b3.12.1785878458452;
        Tue, 04 Aug 2026 14:20:58 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-26.dlp.protect.broadcom.com. [144.49.247.26])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-82019557648sm462127b3.2.2026.08.04.14.20.58
        for <linux-spi@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Aug 2026 14:20:58 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-820180d89e3so9672917b3.0
        for <linux-spi@vger.kernel.org>; Tue, 04 Aug 2026 14:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1785878458; x=1786483258; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dn2Ot+xTp2Jd42Ak7BvUBUKuZjqJaiYGKZVxpl2n9Ug=;
        b=DP6C/UzSK5xO1D49xZlAVFSKCK7F0YhVCKdlf7OQpN/FGNqLod47k7W0SzK5xHdpax
         lQOXtfUIK+1wa3LtdfqYed9yDxHk9LKn73w/+wkHpMrBveKskqBAQ6j128UD0sNQFXzD
         04yPztqyYPfML0zjOUlxP9x8SaEj1+6/lJnmk=
X-Forwarded-Encrypted: i=1; AHgh+Ro3CwyMBZpLYTfnt/aGJruQkxj3+XJYrcKPY3Cq2ZRFKOpubiCw/89HYPld7lSe7tTVIsU3J5V7qMc=@vger.kernel.org
X-Received: by 2002:a05:690c:6188:b0:81e:a471:e8b2 with SMTP id 00721157ae682-8201f0c1830mr11482347b3.2.1785878457828;
        Tue, 04 Aug 2026 14:20:57 -0700 (PDT)
X-Received: by 2002:a05:690c:6188:b0:81e:a471:e8b2 with SMTP id
 00721157ae682-8201f0c1830mr11481827b3.2.1785878457307; Tue, 04 Aug 2026
 14:20:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803142003.12857-1-jszhang@kernel.org> <20260803142003.12857-8-jszhang@kernel.org>
In-Reply-To: <20260803142003.12857-8-jszhang@kernel.org>
From: William Zhang <william.zhang@broadcom.com>
Date: Tue, 4 Aug 2026 14:20:45 -0700
X-Gm-Features: AUfX_mxLqjlvSqm0vLEh4Ga4Mwnoj7v5kDoMyUUntEmAxgPT2CLJeLe8VF2hofU
Message-ID: <CAHi4H7GJ3CB-4s+92vMYmTDJn=rJa11OYivzdgrZnS1kpCSu1Q@mail.gmail.com>
Subject: Re: [PATCH 07/39] spi: bcmbca-hsspi: use modern PM macros
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Radu Pirea <radu_nicolae.pirea@upb.ro>, Vladimir Moravcevic <vmoravcevic@axiado.com>, 
	Tzu-Hao Wei <twei@axiado.com>, Swark Yang <syang@axiado.com>, 
	Prasad Bolisetty <pbolisetty@axiado.com>, Kamal Dasu <kamal.dasu@broadcom.com>, 
	Kursad Oney <kursad.oney@broadcom.com>, Jonas Gorski <jonas.gorski@gmail.com>, 
	Anand Gore <anand.gore@broadcom.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
	Vladimir Oltean <olteanv@gmail.com>, Frank Li <Frank.Li@nxp.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, Yinbo Zhu <zhuyinbo@loongson.cn>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Linus Walleij <linusw@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Andi Shyti <andi.shyti@kernel.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>, 
	Li-hao Kuo <lhjeff911@gmail.com>, Masahisa Kojima <kojima.masahisa@socionext.com>, 
	Jassi Brar <jassisinghbrar@gmail.com>, Laxman Dewangan <ldewangan@nvidia.com>, 
	Thierry Reding <thierry.reding@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Sowjanya Komatineni <skomatineni@nvidia.com>, Michal Simek <michal.simek@amd.com>, 
	bcm-kernel-feedback-list@broadcom.com, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000001b840206583f3bb3"

--0000000000001b840206583f3bb3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 7:41=E2=80=AFAM Jisheng Zhang <jszhang@kernel.org> w=
rote:
>
> Use the modern PM macros for the suspend and resume functions to be
> automatically dropped by the compiler when CONFIG_PM or
> CONFIG_PM_SLEEP are disabled, without having to use #ifdef guards.
>
> This has the advantage of always compiling these functions in,
> independently of any Kconfig option. Thanks to that, bugs and other
> regressions are subsequently easier to catch.
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  drivers/spi/spi-bcmbca-hsspi.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/spi/spi-bcmbca-hsspi.c b/drivers/spi/spi-bcmbca-hssp=
i.c
> index 09c1472ae4fa..570ea635ab0c 100644
> --- a/drivers/spi/spi-bcmbca-hsspi.c
> +++ b/drivers/spi/spi-bcmbca-hsspi.c
> @@ -563,7 +563,6 @@ static void bcmbca_hsspi_remove(struct platform_devic=
e *pdev)
>         sysfs_remove_group(&pdev->dev.kobj, &bcmbca_hsspi_group);
>  }
>
> -#ifdef CONFIG_PM_SLEEP
>  static int bcmbca_hsspi_suspend(struct device *dev)
>  {
>         struct spi_controller *host =3D dev_get_drvdata(dev);
> @@ -598,10 +597,9 @@ static int bcmbca_hsspi_resume(struct device *dev)
>
>         return 0;
>  }
> -#endif
>
> -static SIMPLE_DEV_PM_OPS(bcmbca_hsspi_pm_ops, bcmbca_hsspi_suspend,
> -                        bcmbca_hsspi_resume);
> +static DEFINE_SIMPLE_DEV_PM_OPS(bcmbca_hsspi_pm_ops, bcmbca_hsspi_suspen=
d,
> +                               bcmbca_hsspi_resume);
>
>  static const struct of_device_id bcmbca_hsspi_of_match[] =3D {
>         { .compatible =3D "brcm,bcmbca-hsspi-v1.1", },
> @@ -613,7 +611,7 @@ MODULE_DEVICE_TABLE(of, bcmbca_hsspi_of_match);
>  static struct platform_driver bcmbca_hsspi_driver =3D {
>         .driver =3D {
>                    .name =3D "bcmbca-hsspi",
> -                  .pm =3D &bcmbca_hsspi_pm_ops,
> +                  .pm =3D pm_sleep_ptr(&bcmbca_hsspi_pm_ops),
>                    .of_match_table =3D bcmbca_hsspi_of_match,
>                    },
>         .probe =3D bcmbca_hsspi_probe,
> --
> 2.53.0
>

Acked-by: William Zhang <william.zhang@broadcom.com>

--0000000000001b840206583f3bb3
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
dI96jFsAWyHCgV7GyLHpRxjLynesStgpEBc0hilWb9gwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEH
ATAcBgkqhkiG9w0BCQUxDxcNMjYwODA0MjEyMDU4WjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFl
AwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAq+KCbw/Pu37kZXE01b5/a3FkM2YZxduYVla1
C2rWo4ysSQ2LPZuRyb2f/K25/J8hO/H+AGcKle0TPa68YXuHlhxheYi4oBZ/37caxbT1FzRnZvcw
xplPLxtLeZBepQVKLEqCPazOV68VGI+V+sPQr4Z9LRJOuaesb6Z6/5BKl/iGUemDrnOD8o7bIvvW
emlwUnOiRZo4LTDy+twyixAAd/ykKFk72yZTwjrzVSmLrbwa9BYsJ5wGWbhQmxktKxLbXWcJKUCo
L+iFbxQXarazx1/Z2Fk69Wl2EjHibDLFHFPjeuhrwefJ5iDh0BRZ/WfKMBP1i+y17r+/+YI0xXJI
Zg==
--0000000000001b840206583f3bb3--
