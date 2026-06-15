Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EB92F745E
	for <linux-spi@vger.kernel.org>; Mon, 15 Jun 2026 04:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781497616; cv=pass; b=NFzuNJSqEXEsETTrvheSiHB7VnLzfYXw8sRMwWoBNKR/0rnz+X6BWf6ORpJiWwZOcgssgesknkOVDnhK+vtfVS1Q8TVVCujsmOj0gxIWaTjms09NP36SJ+9WkB539/cGNU2IPFvg7Drg5YcVZN/u53QwpEbbES3lUSQ5zL5H2Aw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781497616; c=relaxed/simple;
	bh=Vl7IPQ+oCx/xUtiuiJtRzdKDCC/Kdl8GVNHYD3aF2bI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VDIdVVwCw4wp5Lw2LXMDLoHOwRUZTLZ4x53Kt/5e14f8b5ZnvHw8y8RFEEeNuq+AjF6IghiSyCptJBhOrPq0oJKZaoI1jvfnNlxpAwk9+UnGUDOox0RpZsS5xe9MHRpADp1mvRhi33oWFZXI6VGHyZBhXp4H7SXX0JkPUTNSlpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qC3ybLm5; arc=pass smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qC3ybLm5"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-6cec1485789so803556137.0
        for <linux-spi@vger.kernel.org>; Sun, 14 Jun 2026 21:26:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781497614; cv=none;
        d=google.com; s=arc-20240605;
        b=ffO//Vrl2ewYbgLvl+r7frU/1eqaHENjZ0yTETZjvdP0KVGBX5TOrWD1lZG2VylZA1
         vPtDhS4RN8jJQVRQ/1QDH1ramRkepqMiw65tCBeBkPVZrZEM0v/BA7/ThjynoInEXHKF
         SfvRtX72+2oc7Hw4SUHSy75sau0ob1Nr0gckquSxCWjvjvynmhTdhGqMS6HoSDoQRv8E
         z4q5VDLO/75O5jf47eoghD03A6nx5G9e0H2NpqUwsXDRaU3b3vgIEmZdEoejMwDtd6WH
         y13XqdbCrgHfu9HSIBMu5oVvKymPnF0MsO2QGmX2HYUQIxLp8s6fNuPyHcTZlAQ5OULZ
         173w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R4Sf4+BSkjB0x/G1yuxp+2PybN4TRsjxfdrHzeKxLys=;
        fh=VdN7jxSyQ9KCUE9TT8T/KdRU9ZEyeny2aUGx0k6/AMk=;
        b=iWc3A1n6Za27DuGgPNm0Rq/wAXUbW2+aPxg0KpZ479WtX5rx51rddWkvLbiQxndQwW
         HDiC7w0C/b1aU4kgAlEdNTsz2NH+ZHkRE7aZ+LYju1vn/DMcJJIFWUiaa5OLqZjQoK1y
         JVxNA1+XRjUAS8HYbqmjaZ+iscxgVTb8MJRyUWMBUB51/kjXxJvlfUVT6FoIZHDWZPCd
         Lz991lEDegX5jq5FOefODxODe4p0+cbTlaokjeEffBhup6/Qbdvt8pJbkbN4SIBP6vOV
         JvwGOsQX+IsV5sxdqkjb75TH+ZZBDm30x7SQXhP1YQBq79QVST0zYb7yQtJhMhosgxZq
         VjxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781497614; x=1782102414; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R4Sf4+BSkjB0x/G1yuxp+2PybN4TRsjxfdrHzeKxLys=;
        b=qC3ybLm5F9PrOi2nun2df7gsPh4hVQgUPEPCavKwEhWrlCeL7Fs8BscaqRwbT5EkU5
         MWpX9zxgKKMlDqXSpCoOoMcfdtOlM2/5olkBy4/SY9ksxZK+pJFygMAlDH5rcjKZUzgu
         js724BmjARXi3QayLC+4gqvwv7tFrsTcDQZFGqfyh0F3sb32TmE0abJJHa8/RGrPrY/h
         ooGV/QwxiJahi8luqhWot/2aNIolx2IlWQ7iIr0IjRdd96OLnygAXF1TgzYAt7wmWYei
         rxjKNcmsKzXLggXO5CxKFIy762v7VloyuOKmLZrnHZNcGNRM53OzLg8wQQ3/dkAwE/hU
         BdGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781497614; x=1782102414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R4Sf4+BSkjB0x/G1yuxp+2PybN4TRsjxfdrHzeKxLys=;
        b=AahesdcjMl5FErwq3pYmtBrmnzEcYtz6xLMgxNn03SQ+epgoZ/QoO41YYbFwh3sFCF
         h7S3Xca0PqEfEXGcA4XY7l8UXlumLnq/iP0UOSRiNPAJRzHSUiChDFaGmK03ZSSx6ouQ
         9eklbT/YNtngui2ANqvT/0ORGP24yFzO+9QHVMXfEDhy43fT5Jjj9+KvNn5qnIYaS6z1
         Q99jvQh1jZyfgcL/j5a7khb95VBcGK0qQKFsNuOY0S5lGv+RAD2ZO6NuaV1mYzZiAI+I
         yYXNG6sVQ4HxA+cMdnTHm3hjWwblWF8uUDZ18YBTRDbRqxRZlnh2LaP3LyKQfpf/lwf8
         zwww==
X-Forwarded-Encrypted: i=1; AFNElJ9y7vWE1+ZvSb2ikABYhjhYDmf5XMkypDHjGu7qC7QBnZ2tghuteewEVfINaOEic7U/o7SGxTPYtbA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+vJfQCy1pNqI3t4/+etKBeQcmUs7SwUay8L3LRGRtrHbSWiAe
	01a599huy94c9xEJM+4zZLqcIrakEI5QIW2ImlTgkzuOba1B2bDhrvUvPlcDmjtBJkvYJHg5iEm
	AD92Uid/rQWgdgae3LnrrwGxM64IGznc=
X-Gm-Gg: Acq92OHdszXNF4Lj5sJ8lVkVlulB60ioy6VknW09kNpNj3207ZKMKbpZ+xD7wDjq16F
	AkG4mAzRlusYqpwMDXvTkNOJph6SAI1KLYGI/siP3zD7chb+QGp6t2147PCS3TcSzRb53siPB7m
	86WOwvPxKQgnNkBUUEqHYC45pIDJn/mWuFv35rQyRhZR8UL5GL4bVaae+PpUA/dQJRkCf7Dg9VC
	aWIDh4aDK/fSvPhONowBewxxGETswOLHfMSBUiztxqFQsavQ8o8dUJXY9Y+Z0djIoXrgJBSOuHj
	X8LRHOC0meBfSDxZAg5UkbsFpBHtS7jvj0ofNxg=
X-Received: by 2002:a05:6102:3ec2:b0:650:9174:f3 with SMTP id
 ada2fe7eead31-71e88b5d470mr7178683137.12.1781497613922; Sun, 14 Jun 2026
 21:26:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260614083424.464132-1-mitltlatltl@gmail.com>
 <20260614083424.464132-2-mitltlatltl@gmail.com> <qwbda435on6rhsbf5o4jqijakanjmnmswnc6g6qsubuqbyvbok@fuoclv6u7tq5>
In-Reply-To: <qwbda435on6rhsbf5o4jqijakanjmnmswnc6g6qsubuqbyvbok@fuoclv6u7tq5>
From: Pengyu Luo <mitltlatltl@gmail.com>
Date: Mon, 15 Jun 2026 12:25:32 +0800
X-Gm-Features: AVVi8CeDmjxY205ZovrS3y0Uc7ZTFkv5R1e4COHN-snpVF8Qqejv_b1FwKnYlgU
Message-ID: <CAH2e8h5Swn2mWoz+t_nrSw1=hQttwi1Hx=dg=cd9S3QRnHjpSQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] spi: qcom-geni: Add property to force GSI mode
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 5:18=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> On Sun, Jun 14, 2026 at 04:34:24PM +0800, Pengyu Luo wrote:
> > Some devices (such as gaokun3) do not disable FIFO mode, causing the
> > driver to fallback to FIFO mode by default. However, these platforms
> > also support GSI mode, which is highly preferred for certain
> > peripherals like SPI touchscreens to improve performance.
> >
> > Introduce the "qcom,force-gsi-mode" device property to hint and force
> > the controller into GSI mode during initialization.
>
> Ideally, this should be decided by the SPI controller based on the
> requirements. Another option would be to prefer GSI for all transfers if
> it is available, ignoring the FIFO even if it is not disabled.
>

I have read reviews. Can we check if the compatible
"qcom,sm6350-gpi-dma" is in DT? If the gpi dma controller is
presented, then we enable GSI mode.

Best wishes,
Pengyu

> >
> > Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
> > ---
> >  drivers/spi/spi-geni-qcom.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
>
> --
> With best wishes
> Dmitry
