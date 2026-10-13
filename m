Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C769379EF7
	for <linux-spi@vger.kernel.org>; Tue, 13 Oct 2026 20:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791924564; cv=pass; b=ox13x2nnQT0UOmf7SxZEXgaqf9BWPzSuNfDERIdSXhQAqhdMyClXdak4v7D0httdqhRftbf9OisskPpUFicxN1EawyhrVdAeKCeXvL7quWsts2vIn0Ge31sFaWeG+YncFlY4jwJEV/s6wUIwYXV6WM1bJrbkxgswP9rGN4cdROA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791924564; c=relaxed/simple;
	bh=VCb03VA6LjpMHOfUp8pvf/EGXGe3r0X2vnJKPUWICB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eVOPgPlKofGes9MCFnfsAl9PcfLRZ1M9BVocBcZkY5B5iCukkCVh3dFmRZIojEgFFZnVCKzsHuIRMemq9TvkjFSJwDOk7lJf2hALuofxQo2pAeYIbNklFKIhGnYLmilPNi9d+33E5MZXDCRWoY/r1/Qq5AeuMfPFSKWzoY9BLgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hq0WLQJE; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hq0WLQJE"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8b09e07e149so3790417b3.1
        for <linux-spi@vger.kernel.org>; Tue, 13 Oct 2026 13:49:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791924562; cv=none;
        d=google.com; s=arc-20260327;
        b=WBDFXKhi9F5yVHVsh99q1G7lPnw4rhU8xbeGuWrpQojx2+FxGrnrMXlm8MDD8sF/Z8
         OCJL4tYCebQrt/a3QEp7zPBgiODoendIB2hQQ7llHegYregLe8UUsAFrVumPL6mnivwQ
         Fzcn6LOzNH+pnGykwQbn8/OUzW8TitqDH9cIbkmGt0AhqoyT3ulmk8ijBmWDqJivurjk
         CwY+wzG4oBaza1/RjDlLQEcODqOfreH1vxRZuF+D9sbWu1Fw0JnhFPI8/scB471/vNI7
         k6IBnTaYuINRdGpGTHXTiKNQ2C443u3UPKUECvrGOGVOz5h/nfHAI2FNOTsA3tc9lO+1
         ptqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VCb03VA6LjpMHOfUp8pvf/EGXGe3r0X2vnJKPUWICB0=;
        fh=j/H2I+Va8zbZSwFlhPmBTbl9fyOPhwXt3iVBL8H7D+0=;
        b=hEcy1deFKZyJ0/TtKoYkVpVTAZSMOs+PGqV5ZyogFxio94UkJ0y+Nu4K8RXy60r09F
         uHnUyBYplx0wrFPgV4H/r8JJu7MgyZLu961PKtkVWnQjk/FDQiizVtD7x8hLcmO8SJX0
         6S1OwilXVxP6P5ywY8wNdw4Un2dRFgKg9EieGixutD36rZvpFGd2UvHWwrWOXOCWHs6f
         F/AvuLB6e23fg9K00iriNbSRCEuqhAWY9HiLeE48iXhEMtQm9kz89xOa7+0icsGFor41
         qAA6lPHZiaWW4h5cxKLM/Q1TS4bGwQOoIKp4HIbSIQATXfFoHpEFx/KGFPV9j1tZkLrR
         LTQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1791924562; x=1792529362; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VCb03VA6LjpMHOfUp8pvf/EGXGe3r0X2vnJKPUWICB0=;
        b=hq0WLQJEF6QP73pmJ6c8FJeMVwrlj6kQptWIXaj1nw7k4uKBOCtdqhFa4ZEx1U9iI5
         2noQBoKQenrv5zmZJK06HyjM7oJBoTx6T6GOFZDkIBKYzCTH4eq2ThweRjcfkv9OdK9g
         gmGNRBbxuOwIzL99EqhlmFKi50HlDL2A7kFw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791924562; x=1792529362;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VCb03VA6LjpMHOfUp8pvf/EGXGe3r0X2vnJKPUWICB0=;
        b=S4lzivy4pIv7aB0mWA31wnczgZBm6s1lBckzWtoK9CcB8vo+J2pAEi23HTMWIkNQ2G
         Fza8aBRt+jIE0DZ5tbbYYw8WiYrPcLGNINljFKwvYkGFwWoEyaOZu8RKodwMyLRqx/Vs
         v93n1GeQrrbeJSSGou1Y2A+Q8DFZMMG75t1eOIDGFdiR0MeXGlsddaY8Oz4E+kfVfEvn
         XMourvc/YcGNXgMU72ead7wpknvtZ5WjXZLPtkt9O8z9jYa62iJIFsig148Y6m5iyJcU
         Fxfp+faLu2jmCiU313qDGBq4sPlGqzu3T7oD+VAM3L58X/mnAT1i1Qpq6RSw2baRqQjA
         Vp9w==
X-Forwarded-Encrypted: i=1; AKwUvBxWgLkITdpsLufr0zJfHueCEPQSkUwudFFPTO7i+F2LmH7Xe2v2SGBDlttyrtbJwuIzY321NdOfx4k=@vger.kernel.org
X-Gm-Message-State: AFq9FYJdiVA6L93VIK/+431BGo1Ly3H02KLq8yNxdfYERJOa4GohXCop
	6qzptHOu63B67ZNz6SfwgaUonpMpUpPDMecy7mApjWV6H8vj51jd2MmZNXV0ekt/X8JjKjJSGGZ
	vRhINjVYGAw1Whu06IfjflKsefI+01Ks4Qlvjv5vc
X-Gm-Gg: AYBFou0QIsTd05NaueTM7SsWuggDXReneqRtc5FKA4YoBTL3bBbBZo5U/n6jlr708DI
	94K5G0h4OHqUlMec3RP+SdbvuUDdtEduGyC5cEE5hjQE5sXotC/66a8knSFTn8dORvYuSNnJJO/
	eBf5dpTm1cx6pI62RkY4epG17IkC2eReRleem4/ks3OxJzNdfIv3tzpfmkzTQK4hOpsyKhWA5Ha
	50yA0vIlzlf6Bnjx2LJYJhILAfdsLl2o3fegn0PTJZaYv8RzhMgP/zJGnB3InRxKAg9ePEmWM7N
	2TwKOk3nJ0xUKJPBs43hy+xZ4tgP8VNtb93CJELVqcbuPgnwH8G4XUI3OskHzdKcT0El4ot1RBb
	eB16i4eRFRw==
X-Received: by 2002:a05:690c:3346:b0:89a:63da:fab2 with SMTP id
 00721157ae682-8b07ee2c80emr43041947b3.109.1791924561531; Tue, 13 Oct 2026
 13:49:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009-send-upstream-v5-0-384af01da3ee@chromium.org>
 <20261009-send-upstream-v5-1-384af01da3ee@chromium.org> <be3f853e-8b37-4b41-a998-94de1cb552f3@kernel.org>
In-Reply-To: <be3f853e-8b37-4b41-a998-94de1cb552f3@kernel.org>
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Tue, 13 Oct 2026 13:49:10 -0700
X-Gm-Features: AclHuK9ox7K2COGXrl-FRR9cM2pKj2PME_s-ad7oALLfV1KkNB6t3-cZk6Vgeos
Message-ID: <CAEe3GZE-3rCTw-2L-dzXqim5qHxLs1BKjpbmo9aT85ZBLWm5_A@mail.gmail.com>
Subject: Re: [PATCH v5 01/11] Documentation: Correction in HID output_report
 callback description.
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Mark Brown <broonie@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-input@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, hbarnor@chromium.org, tfiga@chromium.org, 
	fqwqf@fqwqf.xyz, daleyo@gmail.com, Jarrett Schultz <jaschultz@microsoft.com>, 
	Dmitry Antipov <dmanti@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 11, 2026 at 11:04=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:
>
> On 10/10/2026 00:25, Jingyuan Liang wrote:
> > From: Jarrett Schultz <jaschultz@microsoft.com>
> >
> > Originally output_report callback was described as must-be asynchronous=
,
> > but that is not the case in some implementations, namely i2c-hid.
> > Correct the documentation to say that it may be asynchronous.
> >
> > Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
> > Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > Tested-by: Dale Whinham <daleyo@gmail.com>
>
> No, you cannot test documentation. Do not add fake tags when they simply
> do not apply.
>
>
>
> Best regards,
> Krzysztof

Thank you. I will drop the tested-by tag in v6.
