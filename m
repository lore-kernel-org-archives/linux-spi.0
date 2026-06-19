Received: from mail-qt1-f225.google.com (mail-qt1-f225.google.com [209.85.160.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30FD3B38B4
	for <linux-spi@vger.kernel.org>; Fri, 19 Jun 2026 16:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781886264; cv=none; b=Nwwtc4GVY37y/vQaj1AumKTP+bFtzi5lIRQEdyuHGs+eznJu1ebi/JvaxY0jQO70LFxa9D84WaifK885s0YlP/UxhIOSk+LklAqIQ1COcuMKl3ethfT22Nm2mrRIGZ8O2WSFVph3qXosMjWiKeIUUgbXV8Vv+AdRe4Y6wjWcmZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781886264; c=relaxed/simple;
	bh=W9RhsVhsR9YttUsrWJ8ptOMgNsEuuA4QpB8xlbg06Ts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dmUrD23v0D/ljgudo4s9pnmm5ueDtJ23hQbC7saVh3QBGRtzlkMBy1tHPssZnTCzyHQ/us8qWNZsvaKFRGFDyghgfCwYMftJH2Xd133Rjch6OtlUWWZzJocOAmHxbX7QdK37J/6orMiKri14DFf6m+QgLh/wC4Kh4TVdGCL7wAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bMQ/am6a; arc=none smtp.client-ip=209.85.160.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bMQ/am6a"
Received: by mail-qt1-f225.google.com with SMTP id d75a77b69052e-51790c0a692so24516991cf.2
        for <linux-spi@vger.kernel.org>; Fri, 19 Jun 2026 09:24:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781886262; x=1782491062;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cIcD1845FQqom2XYv2cQaLCPB487PUPmeFBHf1jAGUU=;
        b=lp6CLSGEaTMJ/0dYWSzhtNjpatG4QxXtAsKPzgJUMiItcrVxlw3u6eLXV9rzJZL6d9
         LrvVcPG6Agh8/CdfXU01gIQ8OjTOgmjyyapS81vtuAOKCsPaPzWmS9szvNMGiWkwLvLJ
         zJuJD5xcMj68cXypT2vPZ3AAnzRdgCaLfB6HdJpk1VuPm4rbz4lW79+Q7SVT+geXKELL
         pmW5SGIh2uTB2+msYLQW0hd7m/93RIpoCp+eOjC2OIdW9ziZXL0ZbhEPsNcaLPkZVfv0
         /GHLyy0+KLtXOj7sKmoWxZzpbZRaOomLbUpud3bnJlHnzUu4YyMJ1qmWQcoLlm4Fmh4v
         p1TQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Gaeo4zbiCT30ri2wiNCsiQI2WGkZ9Hm3ZpPancl9xHuGBm6iLC7B8YeMQ6t2rb/eD3aDCAA3Pg/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/LMf/gCHbVodURog68GsVh5SZjfYZko1LaAmVAdMoFrRCd1T+
	uxEKsh+7S6Fha+FYIpd3kaieSQUDRAQm9CLX1tENTNlw6RVL1OGmzd9IMyLYWny7sTMg27iqhjq
	7jJ33Lbr6siKyyrgyKfa53HsTGZi85QEiy7w8nxrRZmkBxKDvelK+3dsuXOlUqHn0oH14CqadOL
	tRayzo5Wb8iQO5cIZmmi6xypsAMC/oH3a/fGTc/RzMzfZDVayCxCJhHDHlCHnTsDxYvaISsQees
	oRCG337b7Xp6Bx3
X-Gm-Gg: AfdE7clcR42lZRYe4tfuvmLBdTbw4IksPYEIn3WszyFXvNbiSVUjsIHpFN7qUmZHJPB
	MokXxbI73gpL7iGYn0kNsoaEQLPro/eqkK7yUdd4uEktRrIIvvjFdJGxiGGClqHJmO4m0Gd2O90
	kWYgxCwPXBCpj9iSS7o3HDw1ExhDct8MIcYKBzQ4lO45gAApPsLJN0HqWjjOXrbSCBFaxZWhq6C
	RTtkiLlgmxcp4U49yWm3rg8CMLXw3XYAISCz4dWe1KWI3lJ42WqMSYsq5U1O8z//7Sclop0sdct
	awPTV14H4FBGnpfW5ijJFIeRlSlAAHViJ6EO1gqimQqYD7SU/8zU+442lp1heoVcfLpGmnMsYdy
	p2O4JOTyGvw8mTcdNfjr89xLWzSrGVFxZS7JCWhqlko8jhrtWSboO2vv74y05G6JOnUzsP31E7m
	ghnwIe/hDQxOjVaLMbP6O+KiC7pdEUZg04GDL/6MkHYzCf7ig=
X-Received: by 2002:a05:622a:98c:b0:517:9648:f725 with SMTP id d75a77b69052e-519f0511efemr48731771cf.50.1781886261342;
        Fri, 19 Jun 2026 09:24:21 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-29.dlp.protect.broadcom.com. [144.49.247.29])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-519e4dc7139sm943291cf.5.2026.06.19.09.24.21
        for <linux-spi@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jun 2026 09:24:21 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-662b875c154so3518087d50.2
        for <linux-spi@vger.kernel.org>; Fri, 19 Jun 2026 09:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1781886261; x=1782491061; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cIcD1845FQqom2XYv2cQaLCPB487PUPmeFBHf1jAGUU=;
        b=bMQ/am6aF5y8Jo62JQsczaGGW/28ubBeGcbU8zH2f/r5tJz16EGdn6Vv6FUDc1racr
         VifIvpK/btq2/1ussUxP2ircUZ03GyBdzhbQUU9jdNr8IEIjJHhqBQCTFF64zkT071K2
         jI32MifhFeoSCW5714aRm4L/PisC3717lOySg=
X-Forwarded-Encrypted: i=1; AFNElJ/henJ5/q/LTTlVw6RQuUeDk2RHqqA+C5nEu2rdq2FTgacU6Tg5X5n1m41BgQ1JPpBlRWZmFBzNUHk=@vger.kernel.org
X-Received: by 2002:a05:690e:b4f:b0:65c:4b71:e69b with SMTP id 956f58d0204a3-66303066732mr2836440d50.19.1781886260564;
        Fri, 19 Jun 2026 09:24:20 -0700 (PDT)
X-Received: by 2002:a05:690e:b4f:b0:65c:4b71:e69b with SMTP id
 956f58d0204a3-66303066732mr2836403d50.19.1781886260081; Fri, 19 Jun 2026
 09:24:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618164518.3885130-1-1298662399@qq.com> <tencent_B5A06807924A77C8690730EBF7A052AABE05@qq.com>
In-Reply-To: <tencent_B5A06807924A77C8690730EBF7A052AABE05@qq.com>
From: William Zhang <william.zhang@broadcom.com>
Date: Fri, 19 Jun 2026 09:24:08 -0700
X-Gm-Features: AVVi8CcrAp7_LPjKd2oZHON9jICVEOshgJgs2ohAdvn0CgxDWRay6pIV09goUsw
Message-ID: <CAHi4H7E986J_x10puJSxxn3kATrGvmYMJENCV7=jHor+=Meo3A@mail.gmail.com>
Subject: Re: [PATCH 2/3] spi: bcm63xx-hsspi: return error from failed
 controller suspend
To: Jiawen Liu <1298662399@qq.com>
Cc: broonie@kernel.org, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kamal.dasu@broadcom.com, 
	bcm-kernel-feedback-list@broadcom.com, jonas.gorski@gmail.com, 
	kursad.oney@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000009e4a0e06549db9a6"

--0000000000009e4a0e06549db9a6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2026 at 9:45=E2=80=AFAM Jiawen Liu <1298662399@qq.com> wrot=
e:
>
> spi_controller_suspend() can fail if the SPI core cannot stop the
> controller. bcm63xx_hsspi_suspend() ignored that error, disabled the
> PLL and core clocks, and returned success.
>
> Return the suspend error before disabling the clocks.
>
> Signed-off-by: Jiawen Liu <1298662399@qq.com>
> ---
>  drivers/spi/spi-bcm63xx-hsspi.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hs=
spi.c
> index 58012e1b5ae7..37b3534d0b0a 100644
> --- a/drivers/spi/spi-bcm63xx-hsspi.c
> +++ b/drivers/spi/spi-bcm63xx-hsspi.c
> @@ -889,8 +889,12 @@ static int bcm63xx_hsspi_suspend(struct device *dev)
>  {
>         struct spi_controller *host =3D dev_get_drvdata(dev);
>         struct bcm63xx_hsspi *bs =3D spi_controller_get_devdata(host);
> +       int ret;
> +
> +       ret =3D spi_controller_suspend(host);
> +       if (ret)
> +               return ret;
>
> -       spi_controller_suspend(host);
>         clk_disable_unprepare(bs->pll_clk);
>         clk_disable_unprepare(bs->clk);
>
> --
> 2.34.1
>

Acked-by: William Zhang <william.zhang@broadcom.com>

--0000000000009e4a0e06549db9a6
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
8IBeDinZ7kEsbzPvW6wf45blfpCkI41G98F96ey4NuUwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEH
ATAcBgkqhkiG9w0BCQUxDxcNMjYwNjE5MTYyNDIxWjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFl
AwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAkuxoq6CRYpmVR+NnnZdD8/xP1A4fG2OgycAE
RsgcCTf6xNx14x2RW/sofvnnOH5ts+AgnQltghmfZKvoTUCOaFKsv4tp6POTRHy97NBjq8sGZjF9
YwgHStfN3jIXV0/DMZ07omFA7qgpTDCg4CBGs55qAeoVtxCG5KDWy43OO+N6Ltot1h9Sz51+Ztg1
IqCcUSEt0JNWt0nmQv8g4sl1K31c4yeNTgLIIo7JbRg10eSYaimPYkKgyfuOzveyTCDHCvHyupdW
gGy9fV0oJbAe/yp9DpZ46JtRqRNf8cXV4S84poKhkwWRPhDh3GeefFqlkreGg2JhEFueo4mCBpKy
oQ==
--0000000000009e4a0e06549db9a6--
