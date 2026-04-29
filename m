Received: from mail-pf1-f226.google.com (mail-pf1-f226.google.com [209.85.210.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF5E3BA25B
	for <linux-spi@vger.kernel.org>; Wed, 29 Apr 2026 18:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777486446; cv=none; b=lcQmHwaH1lnEiQhiuvavu4Byg8R8baSeIqyoRbMm04E0666h4aUcChql1axlmcCrbjHo5jVFMJAZGN6suimweR13drMAgt2sOsxDgWCMA6YeRR7v1D91X5y/lPqCkn20pr8e0GBd4/nPNH7EFP+ikqFrfbnu2fKMrvSkRnoBARg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777486446; c=relaxed/simple;
	bh=gzB/Jhz5b+M/UG2L7g2gBVe4SfaDS7RJJnBJGkyzRfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EZ7FjgoXrTOt23fM3HasEy1FRKwZOpEA/vk6hmlHcwBZyyIWm9w6v7SJdjjy414Vy5QUlUBd419uBsrfeV2dKjTlH7Dc8baWVcYpdlV454EQZ1evZHDVSdoWi4ilyWwNeU/wmwkHtz+j4mtuIAWx4NcbaatyDzT7kPG/4PmxY/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NVuklXKY; arc=none smtp.client-ip=209.85.210.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NVuklXKY"
Received: by mail-pf1-f226.google.com with SMTP id d2e1a72fcca58-824c9da9928so50272b3a.3
        for <linux-spi@vger.kernel.org>; Wed, 29 Apr 2026 11:14:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777486444; x=1778091244;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Youf5+hYaQ0yXUyf2Bm+Y5bBbZvi4Jrb+QiZ8M2HVI=;
        b=W2maCrgO82RBtetl5/zc65sYjZ4W+7TrnoFiKsV6kLYzhthc+n9Wf7oJuzIO9nPpnr
         p3thXPotlnf7NgmvcSLtxABOH4w5D/IQvxVYyvr2XoLOxOl5+sPs3yhHCRpSxUeT2gPy
         O+5tMKmNEw2X1g48OHNUIuUgv11vj3ojiG7esKG+ttLqVi8gp1X+c9cnAC5iKSgGZO4u
         ZcS0kL1DGDhqx/H6x+Ps/2d/AD2eEW7CWqw9YkvcTMryFiw51ceSkywWe2C6u9iYTZ4Y
         f61BHsgQyYXVT/GverfC27BTF/42IvXxL7Huuuz4Bz/NoF6oTTL8bipNltk+uaX/s74z
         pHsA==
X-Forwarded-Encrypted: i=1; AFNElJ83RyvsMunt5Zm4TPPJosPO2YgyvW9Tqg/X/k0RRITwdZL/hHt+9jake4L7l3gBFqPMSJEGYismw8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvE/QVfS398IuvP5wDjeezRLSV85rjaoj6mpLCtYe/YkAk3AuF
	29Md++KP85z/ko6bWWSg0heC+9Ex3leJXGZgKzMYq5lMkCsQoSbSZ/vsPYs78nCharF+gdHQwAI
	XOTuXIgTPMMlzcB2ldlEgjGxVXwhYLU5a7Ylt9lrcgs7Ja5u8Gn/js/IUvfPpP75341RbNdS2AL
	r9cg2M7bEK2VWAphdfQG60kFYHWz8Moz0K9SogVMLAFF+bwouxIw7LENHePW4a1FLWL+MT+Fe/X
	X7MuwI2yuuIM52z
X-Gm-Gg: AeBDieshYaV/ydbK4qUgzlUFwQxwRCOSiRH03zdz428uZln6cRwOFOLdB9EnWA/lu/U
	DohjCruAwtktAXncd41i+LqzW+sSPbwOsDXVQ/czQStCw6Nn/yIs1A0c3fPbtQFsxNrOpUtObdu
	UBJcLeDQAIACx39COF4+e2+6Qf79vDQ/qKf1797UMcH5yJZuRMrZ5wpy5uIMbZRF2AKjAy0m7ce
	08nghypUanG9JfLQMzdZmEghqWsitdvn/xAefij2ZABLOwbq4FWaHWcqSMdeuZM6mjycxuV0HPr
	oTmtu154Wx/FXEXnTl23PjJlVJfUagcas/iDeeJ4Us2coIj71yNq3hGyOd/0RIKnhIyj9Tmxla+
	9h8AHNuZ035OT4dWIbDuQQF37llgVnRH1dbEdE4Uc0b1dMsXTP9Swb+xUKIHMPI9gLSioGioqOS
	ngD50iEUvCywgURsZng4mBwMWuSuTI9CzhE4hjWeXGIPOHRqKfNmlWWV/LtMaMR++V2Q1dwtU=
X-Received: by 2002:a05:6a00:4147:b0:82f:2070:2683 with SMTP id d2e1a72fcca58-834ddb3d5e2mr8259433b3a.21.1777486443407;
        Wed, 29 Apr 2026 11:14:03 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-834ed2f453fsm211677b3a.0.2026.04.29.11.14.03
        for <linux-spi@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Apr 2026 11:14:03 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-657e42cee12so47739d50.0
        for <linux-spi@vger.kernel.org>; Wed, 29 Apr 2026 11:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1777486442; x=1778091242; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4Youf5+hYaQ0yXUyf2Bm+Y5bBbZvi4Jrb+QiZ8M2HVI=;
        b=NVuklXKYsLTCLDQu2YWKb8s6bh3kI4OMBO2+LnbeOFVeXICYPcAtkMXCmWCOqPXprC
         oJjNQIwxx1IRw2qCi0DqLZPr9yAZdKxK3h4HJsfh8m/OyVs2riCVYyrEWj1rhyey9Cd3
         rHd57HET362j14LGyN4yzg0WWk6cKIOz/vdEs=
X-Forwarded-Encrypted: i=1; AFNElJ/6+yqKV+/q+dJQF/DZlJJcDtmoznnKsdHbrXBMdgSdX3ab5GWMwFZ/9pTE7WDFi0jWX/riOcyitv8=@vger.kernel.org
X-Received: by 2002:a05:690e:1697:b0:650:4aec:29fa with SMTP id 956f58d0204a3-65beee5553dmr8104798d50.38.1777486441962;
        Wed, 29 Apr 2026 11:14:01 -0700 (PDT)
X-Received: by 2002:a05:690e:1697:b0:650:4aec:29fa with SMTP id
 956f58d0204a3-65beee5553dmr8104775d50.38.1777486441522; Wed, 29 Apr 2026
 11:14:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429091333.165363-1-johan@kernel.org> <20260429091333.165363-5-johan@kernel.org>
In-Reply-To: <20260429091333.165363-5-johan@kernel.org>
From: William Zhang <william.zhang@broadcom.com>
Date: Wed, 29 Apr 2026 11:13:49 -0700
X-Gm-Features: AVHnY4JQzw3bS-g6eP6cCb8AQYF5UU6B73tVUsKc2EKRgP6aF0pGrqd4bhv8k5U
Message-ID: <CAHi4H7G0nkyDww8eok=UUpcAq=MwirU06frnKHfsLmdaRLRbEA@mail.gmail.com>
Subject: Re: [PATCH 04/19] spi: bcm63xx-hsspi: switch to managed controller allocation
To: Johan Hovold <johan@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Radu Pirea <radu_nicolae.pirea@upb.ro>, 
	Ryan Wanner <ryan.wanner@microchip.com>, Kursad Oney <kursad.oney@broadcom.com>, 
	Jonas Gorski <jonas.gorski@gmail.com>, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000fcf65906509d4ffc"

--000000000000fcf65906509d4ffc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2026 at 2:14=E2=80=AFAM Johan Hovold <johan@kernel.org> wro=
te:
>
> Switch to device managed controller allocation to simplify error
> handling and to avoid having to take another reference during
> deregistration.
>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/spi/spi-bcm63xx-hsspi.c | 17 +++++------------
>  1 file changed, 5 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hs=
spi.c
> index e935e8ab9cfd..58012e1b5ae7 100644
> --- a/drivers/spi/spi-bcm63xx-hsspi.c
> +++ b/drivers/spi/spi-bcm63xx-hsspi.c
> @@ -783,7 +783,7 @@ static int bcm63xx_hsspi_probe(struct platform_device=
 *pdev)
>                                              "failed get pll clk rate\n")=
;
>         }
>
> -       host =3D spi_alloc_host(&pdev->dev, sizeof(*bs));
> +       host =3D devm_spi_alloc_host(&pdev->dev, sizeof(*bs));
>         if (!host)
>                 return dev_err_probe(dev, -ENOMEM, "alloc host no mem\n")=
;
>
> @@ -796,10 +796,8 @@ static int bcm63xx_hsspi_probe(struct platform_devic=
e *pdev)
>         bs->fifo =3D (u8 __iomem *)(bs->regs + HSSPI_FIFO_REG(0));
>         bs->wait_mode =3D HSSPI_WAIT_MODE_POLLING;
>         bs->prepend_buf =3D devm_kzalloc(dev, HSSPI_BUFFER_LEN, GFP_KERNE=
L);
> -       if (!bs->prepend_buf) {
> -               ret =3D -ENOMEM;
> -               goto out_put_host;
> -       }
> +       if (!bs->prepend_buf)
> +               return -ENOMEM;
>
>         mutex_init(&bs->bus_mutex);
>         mutex_init(&bs->msg_mutex);
> @@ -845,7 +843,7 @@ static int bcm63xx_hsspi_probe(struct platform_device=
 *pdev)
>                                        pdev->name, bs);
>
>                 if (ret)
> -                       goto out_put_host;
> +                       return ret;
>         }
>
>         pm_runtime_enable(&pdev->dev);
> @@ -869,8 +867,7 @@ static int bcm63xx_hsspi_probe(struct platform_device=
 *pdev)
>         sysfs_remove_group(&pdev->dev.kobj, &bcm63xx_hsspi_group);
>  out_pm_disable:
>         pm_runtime_disable(&pdev->dev);
> -out_put_host:
> -       spi_controller_put(host);
> +
>         return ret;
>  }
>
> @@ -880,15 +877,11 @@ static void bcm63xx_hsspi_remove(struct platform_de=
vice *pdev)
>         struct spi_controller *host =3D platform_get_drvdata(pdev);
>         struct bcm63xx_hsspi *bs =3D spi_controller_get_devdata(host);
>
> -       spi_controller_get(host);
> -
>         spi_unregister_controller(host);
>
>         /* reset the hardware and block queue progress */
>         __raw_writel(0, bs->regs + HSSPI_INT_MASK_REG);
>         sysfs_remove_group(&pdev->dev.kobj, &bcm63xx_hsspi_group);
> -
> -       spi_controller_put(host);
>  }
>
>  #ifdef CONFIG_PM_SLEEP
> --
> 2.53.0
>

Acked-by: William Zhang <william.zhang@broadcom.com>

--000000000000fcf65906509d4ffc
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
UaosAHBUci9qdfhVkqzF5kX28I7ZW8OZAeXHOlP3sU0wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEH
ATAcBgkqhkiG9w0BCQUxDxcNMjYwNDI5MTgxNDAyWjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFl
AwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAbaggetD3d2zngkM+aRbZN7NsN5MfhbaYvBEq
bqpcTlN1Ish0I1sDFAdTwDr05KiBOeddW5eofzFxIIdNMe3bOduEC9iMuEFH8X1H08FNzKxdqgS5
4MUVqIvRByhQw08MqGMnHAsYkciJN57fMVfvNM2xM7k5o4kn+ZMd9hovfEMzDJD5j7PTAivb1FVK
GqJObVEg69MHfb+QtuM0662GRhJdLPpIlUyxnlvnBMjJjuN+a44bFg50BrGHYizGkK9QAEWFq1DP
fj/i9OpyFrQQkLMqvAIRPJg22nLQvwxn0HJI9nRV/wnFCxEFjDZfnVvr8PF3O4o7lHV6EGxlb/hM
/A==
--000000000000fcf65906509d4ffc--
