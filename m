Received: from mail-ua1-f100.google.com (mail-ua1-f100.google.com [209.85.222.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AD748094C
	for <linux-spi@vger.kernel.org>; Tue,  4 Aug 2026 17:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785864344; cv=none; b=PoqZDGLVn+50CePNoQoy8NrFxJjrYcc2JCF083Fa2HZFvmCvXQppV+g4kBCUDmEixrrLE1Y3C3/aWZtO60mqOOClAQrWqBsExO2FqR7ALv2I8e+JGjx2J0o1T5t92wdI6AaAVTRzCjbR+IVm7TyTdjTlYkYfehQF2Tr5vSX+Ivo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785864344; c=relaxed/simple;
	bh=nXv26jmz+wTKZi/4NPrWeQ8hyUNUHrqI3fES2xlSjkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p9YnuyiiqW1RgEyIJaXhs95DAQ3QwEJnsJ3Wz86Z9wxnA1ytBOquKml3XyUDq9jxO4ufKjIoYUrYh80LCQXRVHRWOKP9FkyvhNeTIxemzZQ3aKeNE4klI9XAnqkDrOlcKqIo6X+9VXXDuQa2VqG1oNl12y5n+lEG13wu99MvHbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=L3kVtuEh; arc=none smtp.client-ip=209.85.222.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="L3kVtuEh"
Received: by mail-ua1-f100.google.com with SMTP id a1e0cc1a2514c-9618b8bdc51so37599241.1
        for <linux-spi@vger.kernel.org>; Tue, 04 Aug 2026 10:25:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785864340; x=1786469140;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/awt38VrZHZAZ0eIXWi1TQ6reUz0p/xIxVAgBOXV1B0=;
        b=aloh7JwzhGz+I/jW86z73jrtGvAqihbMHYlX5TjHtr6PcmjqHExb2nN635e2nNzQT3
         KX1Ca5rKqX2lXUALTTyeuOTAmIFQW7y1qqy5BfZZ2HHiYNZk8geuUwobb2uaOzR/jh9W
         jAR1H3+YufvVf/zLnBqAO62QwYoetfkf1xYaRbj0RiAu2xi2pPfKzIv36p1vHKpZaoS6
         hkdujiv+CvFZ+OuA4Z5Ku3OMV4Kf/x76roDs8HO1HlOzjwT3WQ1E84xTzeRqMg2CDlXj
         TEs40EeifaUZBx7mAyxm+u2OzYml57GlHFqlyEnxWuZWqK/inIOgVM1qL1iHrQt2pzBt
         iMaQ==
X-Forwarded-Encrypted: i=1; AHgh+RqjJwRAx9xo9yC3aJagQTQAMqKvEGO/pDBqXiMG0zxeur9OP+DFZXHvx2rRDYp2jorazngWVACmgF4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu5mpQ2HY3jtwG7vt0TB/tILGcbk+bBvltFFkJYvZGBcN0zOli
	g08jvsE0v5EVJO9cFJzOePtzZPhFAOb/ui6Bj3xzonCqTA/VxRuiRvU3zjqQKFumvwqmmjSgy5U
	8g0k9734O95V87UgIVSOBfUnXIVkQtnfSnfZqM/NgpKq3C5StL+PFKgyBbTYdcbB52R2gYNSeu/
	4Av11AZA49H6bXyu3kDaqdPeYFgeALD9EQfEix5QK//WW6wuGcyMqIYXdXOpx+Cnit0cJY137xk
	ZEwX/hqjES0rg==
X-Gm-Gg: AR+sD12gnulrW3fh8zE+AMu5f83XNWZC/pTidr7QddMW6EqkKT90ZKvKLLemIs1h3zD
	q1nBz7RGgUowept9dYNF9DwU/GDeQ7CzWnsAMU+M0jlNuoTsTjvQd27Em4JmouLb8xkzc9B1OGk
	pZrLNm4oNpWSSipWsnjENx3Fd/kuGMSnfTrVbqIp0EAxKf5SoQiOnCNGHnQrzqQtoqL+ZiJ6hHG
	AWX1Fxbp7N6YlrFu3LAuLqlr5yV71axjHxT3MdXTTeI3eAR9EgCZPEkl0aE+KlWE18Ac2AMbpI1
	HRQn5k9JsdYq3Dqf0rkOZwrQu/h62l02aLmdkxGNiOkEWSdblH2n30nH8z5lpWKyHE7VWkpPiLs
	isl9Q8L3pGOao3GsyMR32OIIyq2ykgldau85AVJXpUheqXiZ85ErPfxgkMPdqR6lKo4ATFL+OhE
	gVRJsn/9r2+nK05GVBO/uEScPUNEbXeg2sbQ==
X-Received: by 2002:a05:6102:6a85:b0:739:5f55:3c3c with SMTP id ada2fe7eead31-760ed284196mr73586137.13.1785864339649;
        Tue, 04 Aug 2026 10:25:39 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-27.dlp.protect.broadcom.com. [144.49.247.27])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-7604512a24csm119769137.3.2026.08.04.10.25.38
        for <linux-spi@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Aug 2026 10:25:39 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-5b109e0a1d8so60307e87.3
        for <linux-spi@vger.kernel.org>; Tue, 04 Aug 2026 10:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1785864337; x=1786469137; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/awt38VrZHZAZ0eIXWi1TQ6reUz0p/xIxVAgBOXV1B0=;
        b=L3kVtuEhNFPswKBIrZLkyHADCsjxFjO3yzqz7TwQ3Iawj0sUtyAqQ53Q2taelHt93t
         MCnl08Oz4oWjda4KafjKNZBWRteieWfeOxn1k4fCtbSly/pcZ68GZvPaOyGoPnfB2hKC
         YSTCmfBa9K03KdVTEHVUhB7G6RNROUub1izxo=
X-Forwarded-Encrypted: i=1; AHgh+RoNp4WvdOiWv6VgZ2vXhc2j7oFb/gGZA1omehDbc1Byk5dZ1WyxAiCjx06ZdV09D9H2kBu0OGS1aD4=@vger.kernel.org
X-Received: by 2002:a05:6512:158e:b0:5b1:5d66:6393 with SMTP id 2adb3069b0e04-5b2f4cc8dc5mr39957e87.33.1785864337182;
        Tue, 04 Aug 2026 10:25:37 -0700 (PDT)
X-Received: by 2002:a05:6512:158e:b0:5b1:5d66:6393 with SMTP id
 2adb3069b0e04-5b2f4cc8dc5mr39952e87.33.1785864336811; Tue, 04 Aug 2026
 10:25:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804072017.860974-1-pengcan@kylinos.cn>
In-Reply-To: <20260804072017.860974-1-pengcan@kylinos.cn>
From: Kursad Oney <kursad.oney@broadcom.com>
Date: Tue, 4 Aug 2026 13:25:23 -0400
X-Gm-Features: AUfX_mymajaZbmXEkV1rOvoJiv8sIHMZR0uRo_nLm7XK_f1uYzdmF5xggPZiRro
Message-ID: <CAMm8Nh1RMWN23xf_DOtK1rm2LMJxwLJGGxnonCBioC1sSR2m7g@mail.gmail.com>
Subject: Re: [PATCH] spi: bcm63xx-hsspi: disable clocks on resume failure
To: Can Peng <pengcan@kylinos.cn>
Cc: jonas.gorski@gmail.com, william.zhang@broadcom.com, broonie@kernel.org, 
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000074b4af06583bf1e1"

--00000000000074b4af06583bf1e1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 3:21=E2=80=AFAM Can Peng <pengcan@kylinos.cn> wrote:
>
> bcm63xx_hsspi_resume() enables the HSSPI clock, and optionally the PLL
> clock, before restarting the SPI controller queue.
>
> If spi_controller_resume() fails, the function currently reports success
> and leaves those clocks enabled. Propagate the error and disable the
> clocks before returning.
>
> Fixes: 142168eba9dc ("spi: bcm63xx-hsspi: add bcm63xx HSSPI driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Can Peng <pengcan@kylinos.cn>
> ---
>  drivers/spi/spi-bcm63xx-hsspi.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hs=
spi.c
> index 37b3534d0b0a..633164e5a856 100644
> --- a/drivers/spi/spi-bcm63xx-hsspi.c
> +++ b/drivers/spi/spi-bcm63xx-hsspi.c
> @@ -919,7 +919,13 @@ static int bcm63xx_hsspi_resume(struct device *dev)
>                 }
>         }
>
> -       spi_controller_resume(host);
> +       ret =3D spi_controller_resume(host);
> +       if (ret) {
> +               if (bs->pll_clk)
> +                       clk_disable_unprepare(bs->pll_clk);
> +               clk_disable_unprepare(bs->clk);
> +               return ret;
> +       }
>
>         return 0;
>  }
> --
> 2.53.0
>

Reviewed-by: Kursad Oney <kursad.oney@broadcom.com>

--00000000000074b4af06583bf1e1
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
WLjT+gks0Kd/cbP0dcNN3CUcYMYtVlHhJc0alhNIUhEYGBn5FXwIovRjv4w8vYdAGu3Mn4GwoqgH
BnSQFD3St8aq6hgohc9jxXxTR/9DDqSSq64xM/ugqaLZXv5xuQK1zCt8lK07JWIJ1rXkqKtennWP
nt58zpNGlmYBHojF6BbjYTd6vpd1pHQISwi8DrWMAUDa7iWHpBocw6gSZm8SvaRJFodIma4Ev9kW
ekRCoHi74o5vbrDz/aqNlFa0iAIHoDNw11sCAwEAAaOCAdwwggHYMA4GA1UdDwEB/wQEAwIFoDAM
BgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3NlY3Vy
ZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEFBQcw
AYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1UdIARe
MFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIBFiZo
dHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAyhjBo
dHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwIwYDVR0RBBww
GoEYa3Vyc2FkLm9uZXlAYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8GA1UdIwQY
MBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBRaQVTN1g3mGepKgQklJr3uMbCS9DAN
BgkqhkiG9w0BAQsFAAOCAgEAE2m7WsjjPj3wmw0t3GJ0XtNFKqFHZfT6zb3d4heSwp+Tq1fHkjpF
xUhIzJnD2MXCryCAuX73pAQmLEf8UDdEPZegH6g4poXTtCd2WBv3B2NU0TIMjCEhk5u+XIroo7Sz
p9g+wuVY0yUcl5QBswTk3kT3jkd6jx7k59ihAYsTMMUNK6RPOQHJazd+CY+A48ptKEzcauFBVUwg
l/ZEcN6oWAP9DY5J8aQCLH73UFn7mo2Qkmvx2wzEGlq8ilowQtOwpPHdKjxaMaR9x7NZMU5IE/cX
hClA1WVIp0Cp6CUUJh8Z3RPss8624Ct2QfedUjKjK2TtaiIAv4dcJF0NXoBWx9J0r8Z5IGDGCC0t
xiRAyerE6s5S90gIvKSKA4kz1kGjoFD0g0Mu88Wklna1FxyX72YwJY6XGqUpxfUSJpj/6+hEqpLe
Lucnxpvr0aqEZrjnm3at4dwAMd3bpddoSDkGIzXgB/EDinMopHueiwlvK0vIbrX5eHue7yFCJhpr
s24mwnppy3Oy++8ql2+ifJ7VbVqYdYAKzjVrx0E7KqHH2/QqgW4fv9fQwQjHaslT/r0Qv0XVyNtR
wRPbY6ZzeUcVxB6a5vC8XrXD/+k+ujXBjRIg/yKZk7OB2sFC8cv9Up8rPQDaguQMJ0BRG53ggwcO
ikPna8ZaE9vI/f7PcdSt3v0xggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBH
bG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAyMDIz
Agw5Ja1W5pJarmzi09UwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIKz+EbUDO0em
xC3twRQNGZiXIh7a57sfZbTtcj2WSGjAMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTI2MDgwNDE3MjUzN1owXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBAIepfOCVk3+4cVEs+pVZwA0bnE7JNP/SnOJNvJXfrS6wf94W
i5JmxZJudoUZe0Tu3FWLJzNCIJSO+qv/3JTOXrvXRqMriedW9sGfEq+P2mmRZT/G+Sj8+iEjGhfK
uhsWFRnB4fKDDlhW3z1Amt94FIwp3QPZB4H6HevmET6ROg4szcw73Vb4eP1QFVSxUD4nB9S+tYXB
QKp3RyAKLMroOYEyBrfwaAHFiJdUHu4FmHSAyJ0HL0afR4Ns1PBsKc1EmZmJaRFYQmkPkIeVVM+b
Fj9WfwTSqE12Hnm1/RZCkZU+P6ms8nJO8dsB4UYE3N+/Ut6KabXoGlUO/Lt0SY0N8w8=
--00000000000074b4af06583bf1e1--
