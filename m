Received: from mail-pf1-f226.google.com (mail-pf1-f226.google.com [209.85.210.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B5C3AAF41
	for <linux-spi@vger.kernel.org>; Tue,  4 Aug 2026 21:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785878413; cv=none; b=aqxv88bIUZSFRc3325aho6DlME5M2ioAfRP3KFKOg/7+eU4Krf1YevfHjqhPjrejoRSqAeAmjoS02FznLc3MIO43QybTCpCO0T/JDanp6UKRmfShbe6JgYzEYiO0R80oUEvvGqnt7BpUjj03sd0x6Adpjewy9RJZLc2u5HN0glE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785878413; c=relaxed/simple;
	bh=iF+D+GhOhRJvQSxK17BttE7qoiKQsYpyv/rZAY00j00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DFevxM+rEmJd0I7sCVrqrvttVY2mrR9i3KYEZooeEGZu5O4wsuo4mUFIkQ3UBq5aJrTTyH59n+bY0nOd4d9XNUCwMqX6hOarncM4hPg4i1fHBcBHd/xKwk9k72JuMPb63Opok9G9kuBSmNhn7Ow4HRzaqz0wpM+E5fZRJGFne44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=TWqiDJjR; arc=none smtp.client-ip=209.85.210.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TWqiDJjR"
Received: by mail-pf1-f226.google.com with SMTP id d2e1a72fcca58-848479c9bd5so240821b3a.3
        for <linux-spi@vger.kernel.org>; Tue, 04 Aug 2026 14:20:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785878411; x=1786483211;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KNTA6tklrqMEPv4ZdWQdGT/0UaqSpJxq4g490yqRkL0=;
        b=mfS9cEwZ1u5zFKT1pXbtvAemwQg2s+lrr0qnzo/FH/o+yrFKvWj4WPnzD2SBUAhIyT
         cBXyh4wE2FF+VngbFLXfya0k2iooXNfniKnHJQHgIPiYZ0BQ2djdTZjpUyKK2auetE4+
         E+HNR1rjvRzQHlGErDSvnyNnNdO5EmqtDpm7JvxTB0VpQz8TGj3rfRS6x2hxLED8pEry
         fVY26d0jMwxG6jnDqtfuKL02C/3mirqGJeE++htz4nQdVbuf2EMy6XvA7JOILQQMcLGi
         n9bVRD2yccV00Aq+6i5JUzdUIbDzVb7CqJ4Hsj5FqeIEdTw51eQqtP7nBA+LrLGiJfM6
         KCNQ==
X-Forwarded-Encrypted: i=1; AHgh+RoMtndAKtsNSRmQpAGeJP2VRbpLJfTEWn/MMV9OfnBP1J/o4EeTMpJv3m3Gign+Rrzchp94wgTg4+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzstDk77nVTEhAkgZryvkcyKQ5Ux+ypfKbbSE5l8yKfKKujLq5G
	M3UmzV+JpyIIKVF56vU/D++AMktmj0BDaFH3mbsJk4GBvO7noVmzYnR91kO9DCTxENoEEhoyTGN
	fMTjV1oSW1R6JSC8VJO7Ha49pzYgZINAbQRUPpZ0EC2g2B0fMXIJDHXKRgwThjsT3KF+OmARi9B
	4LWDQXbryj4Ee8JjTYizLH8roxsGvbTbHO/WW4UDygPvaZ0IRHIk9IrIYHlGh7R/Y9dqM1xWoEa
	VDtKHvVaQ+3bJbp
X-Gm-Gg: AR+sD11NcwTif8S3gHUYhhQiIJbxJqLToGQm09dj3zH1b6Y+qHO6OgJ/KenaUFN5+ll
	SmdskILUo/fqXSiCVYiYgrWJFDo+cyvK/EU5W4UEQVZ9HNHMJpz5kmYxsID/7xLwD2KnRPjn6eW
	K3IwRBfDkVPJms+PrrchLhsdn7CDN+lw4Hl09Cn+iEOCYxYWJe9KGt95Gi09Z+6cdxFW66Ehe5V
	VFttPbACwEwC5EvwVeKTkmveEnqE2mr7uy/NwuDk8NwBRp97vVQ0UAQzVpJjb7x3EQTB/NWQ+iC
	u6fGpG1BZwAYvCtxN/MYFiK99XFvMBOpTVgQGiN5DOBMuutTukI+I1/pLyVPuS8tmfQ1dJcmp7p
	EUP1BvjP0Hu4cdrBdMe8ibkCAeo0A+GeFPf9yVrAQlpgU5aUYOnII8rbEuXTfysDj+8RuQwVtpB
	rfNjY1JPlisq285NsTrR15sXe8OypDJ0qGoxoq
X-Received: by 2002:a05:6a21:329a:b0:3c3:9fc4:3ff5 with SMTP id adf61e73a8af0-3cb85ef7f1dmr1594811637.29.1785878411035;
        Tue, 04 Aug 2026 14:20:11 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-26.dlp.protect.broadcom.com. [144.49.247.26])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-cbe708df03esm81614a12.7.2026.08.04.14.20.10
        for <linux-spi@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Aug 2026 14:20:11 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-669260a87f3so859946d50.0
        for <linux-spi@vger.kernel.org>; Tue, 04 Aug 2026 14:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1785878409; x=1786483209; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KNTA6tklrqMEPv4ZdWQdGT/0UaqSpJxq4g490yqRkL0=;
        b=TWqiDJjRns1mQFfYaOTd/ViEzhGMigokC061u1e03G5nT9E6hswxSuVPBmNMow/aFR
         fGTPMh6+xqMIvR2YjkxP2Ns4bFWQQkKG7WkuULgyLQa4aGYHZhwFWRU/z6lvoBo3JwLu
         ct6KL0VsMHUYV3+qgfFS7fx0sc0n0IZTjF6wE=
X-Forwarded-Encrypted: i=1; AHgh+Rp013d94fHRrs/nzFWuO8BaLx8xUxmeqQ1TUIdVs9sl8FUKb/1yZbooRGcfyC5zi1oOV5WPjBiNFzE=@vger.kernel.org
X-Received: by 2002:a05:690e:450a:20b0:668:2c6d:92ca with SMTP id 956f58d0204a3-6699a8b6352mr1037806d50.16.1785878409511;
        Tue, 04 Aug 2026 14:20:09 -0700 (PDT)
X-Received: by 2002:a05:690e:450a:20b0:668:2c6d:92ca with SMTP id
 956f58d0204a3-6699a8b6352mr1037747d50.16.1785878408977; Tue, 04 Aug 2026
 14:20:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803142003.12857-1-jszhang@kernel.org> <20260803142003.12857-7-jszhang@kernel.org>
In-Reply-To: <20260803142003.12857-7-jszhang@kernel.org>
From: William Zhang <william.zhang@broadcom.com>
Date: Tue, 4 Aug 2026 14:19:57 -0700
X-Gm-Features: AUfX_mw9PxoYekOKTemFrUP62uZ4x44E3xbsoW8V5Ml0K3T58L77kpnvbiOt4zA
Message-ID: <CAHi4H7F4gjZc+ygR7oJgn1j6oLwmUyj0pB6pjn=jdPse3A7C8g@mail.gmail.com>
Subject: Re: [PATCH 06/39] spi: bcm63xx-hsspi: use modern PM macros
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
	boundary="0000000000003bffd706583f388a"

--0000000000003bffd706583f388a
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
>  drivers/spi/spi-bcm63xx-hsspi.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hs=
spi.c
> index 58012e1b5ae7..ca6cf7c19835 100644
> --- a/drivers/spi/spi-bcm63xx-hsspi.c
> +++ b/drivers/spi/spi-bcm63xx-hsspi.c
> @@ -884,7 +884,6 @@ static void bcm63xx_hsspi_remove(struct platform_devi=
ce *pdev)
>         sysfs_remove_group(&pdev->dev.kobj, &bcm63xx_hsspi_group);
>  }
>
> -#ifdef CONFIG_PM_SLEEP
>  static int bcm63xx_hsspi_suspend(struct device *dev)
>  {
>         struct spi_controller *host =3D dev_get_drvdata(dev);
> @@ -919,10 +918,9 @@ static int bcm63xx_hsspi_resume(struct device *dev)
>
>         return 0;
>  }
> -#endif
>
> -static SIMPLE_DEV_PM_OPS(bcm63xx_hsspi_pm_ops, bcm63xx_hsspi_suspend,
> -                        bcm63xx_hsspi_resume);
> +static DEFINE_SIMPLE_DEV_PM_OPS(bcm63xx_hsspi_pm_ops, bcm63xx_hsspi_susp=
end,
> +                               bcm63xx_hsspi_resume);
>
>  static const struct of_device_id bcm63xx_hsspi_of_match[] =3D {
>         { .compatible =3D "brcm,bcm6328-hsspi", },
> @@ -934,7 +932,7 @@ MODULE_DEVICE_TABLE(of, bcm63xx_hsspi_of_match);
>  static struct platform_driver bcm63xx_hsspi_driver =3D {
>         .driver =3D {
>                 .name   =3D "bcm63xx-hsspi",
> -               .pm     =3D &bcm63xx_hsspi_pm_ops,
> +               .pm     =3D pm_sleep_ptr(&bcm63xx_hsspi_pm_ops),
>                 .of_match_table =3D bcm63xx_hsspi_of_match,
>         },
>         .probe          =3D bcm63xx_hsspi_probe,
> --
> 2.53.0
>

Acked-by: William Zhang <william.zhang@broadcom.com>

--0000000000003bffd706583f388a
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
e3Z8jNSlpmxkRuSY1CaAGL9j6/Vs5okp3VbSwkHYClwwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEH
ATAcBgkqhkiG9w0BCQUxDxcNMjYwODA0MjEyMDA5WjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFl
AwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAp3I6uEdPSywFZMvXKDXtymAGwrJeWmJWRI/I
35xZwTPWKvcKhI9u4E+OLNDpGarR72fNTx9mCE9f4PUeHFSLE3x0/ZKHDp2xTh4tZEz5wPbITZ9n
W3Bg1JCO6VpEf6qvPDSVWyumF3DWuIxlJHlWnDCrOyDm0URbteKnAFc94d6xK11atA0ZnvFbm937
Htd3tWcztjPzxvS3dI/6GxUNDqPBtZfmGyumwURAcba9oi8GQ3eu3jlPw7bwrR4yu36aVqEmuy/w
Xt27T+1ufitHOQaxT5db+zGyKsaEBVKVD/6XJh0F+72kUwcJKbuGfOGSrcJ5kSJb1pt3BVi1vBZu
gw==
--0000000000003bffd706583f388a--
