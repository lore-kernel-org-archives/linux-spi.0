Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF763E1D07
	for <linux-spi@vger.kernel.org>; Wed, 20 May 2026 15:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779290128; cv=none; b=N6UDW3dbfeyiYItRZEa8SBNY2afUkuHVxbeQjfYOvO+H72Mv4HNkAYnynhq9U9YibWptLkdlLXu8/RHg2lKTxgaZFkUajlXO1xKnzMmJSDvF1rDftNa3bV+hOSqV0Ie2+XiKazZN/gJrN+uW1RS6y4kD/LBqDmLYqAA4WVP5B5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779290128; c=relaxed/simple;
	bh=jhnTY12y5lotrhqZzCBsVpLdBkHhAK/d+l3qAwFgP2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gsD5JBjSbKId04/C9oR4t+tDCr1PY3P8o8dQIiIxS1nQVQUPavlt3Un3wOCI6+lnkoKp6wxUwtVupyxHjQBOMMdJkJgqg8nksrolkpZNDzjABXbo/MCL+/xb0mZREIaD2P/9jRHuHckIVj+iL+IpQaoiq4ECW69+AT/oKGengaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OfFhkMbh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OfFhkMbh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A22761F00893
	for <linux-spi@vger.kernel.org>; Wed, 20 May 2026 15:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779290126;
	bh=tXwW/SaZzGQelLcgmeBNnCNKn50znhPz58TEo5aKrCM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=OfFhkMbh6/iil3R8eySbuWkAkTr5EBxAg5mV9gmXGVdQ/QqrBdLk0aHbgalZFLd3S
	 PW9FHC9x2ozBEeHYJzloEusRL0VI1oCZ6/MZp1+wn6oAaLDGcZwSC/2Z7D3vV/8t50
	 BPAFRFqTBXn/LgDTLsS6Kmne6IEqroQCfxY98T2RKV0/uirmBW6kZHNDlxUikyt5tZ
	 Lq2NieEGmwqaUSVaKOFTaAy+PzE3MsEIyRz3nZQr9J8HkrGOUK+z04vd16MXTVlgVV
	 qFMjFkZJRDekxUf2n6HqQL7r+GKZtCx9e01OOSXuyNm16A+wRk3oFnBMYLfIms3TtA
	 3AS4+SH/EqB3g==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5a8721851e2so6070271e87.0
        for <linux-spi@vger.kernel.org>; Wed, 20 May 2026 08:15:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+w1L0VeiBHOfF/008FTuPqVcZN9Imh7eruk4D8VrQPEc0YIrd+ALTSAWIniiama1ktpWK5IM6QJf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YybGmVSCrBkPMfxSrFH+PP0PVSDiiMn0O1co5yD8cA2B/P5d9Ft
	/L/xnhZlkF5cchID/1/JIbB6piqV5ztXK+7qhcvKGxSN9VYtnvjXtw5O4j1hn5LzrofNgNrsyK/
	U4zhZ3b5ov9Z0hBXXue2YMscRKLvV1d4jkptJiFawkQ==
X-Received: by 2002:a05:6512:31d5:b0:5aa:b6a:7a8d with SMTP id
 2adb3069b0e04-5aa0e779e30mr9211550e87.44.1779290125200; Wed, 20 May 2026
 08:15:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520081140.637637-1-thomas_lin@lecomputing.com> <20260520081140.637637-2-thomas_lin@lecomputing.com>
In-Reply-To: <20260520081140.637637-2-thomas_lin@lecomputing.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Wed, 20 May 2026 17:15:12 +0200
X-Gmail-Original-Message-ID: <CAMRc=MfM38h=zJU5Uy7zu9pigjb-XBAteBhUmvMAKZRWHGZNKA@mail.gmail.com>
X-Gm-Features: AVHnY4JDu5NZZ0wIyz-eam2N1N-uPmkRu8vNP0BsaGtOg31C0_IaXbfTkCj7LWM
Message-ID: <CAMRc=MfM38h=zJU5Uy7zu9pigjb-XBAteBhUmvMAKZRWHGZNKA@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] gpio: dwapb: Add ACPI ID LECA0001 for LECARC SoCs
To: Thomas Lin <thomas_lin@lecomputing.com>
Cc: rafael@kernel.org, lenb@kernel.org, hoan@os.amperecomputing.com, 
	linusw@kernel.org, mika.westerberg@linux.intel.com, 
	andriy.shevchenko@linux.intel.com, jsd@semihalf.com, andi.shyti@kernel.org, 
	broonie@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-spi@vger.kernel.org, lucas_hao@lecomputing.com, 
	puntar_liu@lecomputing.com, jihua_tao@lecomputing.com, 
	stan_xu@lecomputing.com, lumin_liu@lecomputing.com, 
	notics_zhang@lecomputing.com, braden_zhang@lecomputing.com, 
	harold_wu@lecomputing.com, will_zhang@lecomputing.com, 
	aurora_jiang@lecomputing.com, ryen_lin@lecomputing.com, 
	andy_jiang@lecomputing.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 10:45=E2=80=AFAM Thomas Lin <thomas_lin@lecomputing=
.com> wrote:
>
> Add ACPI ID "LECA0001" for LECARC SoCs that use the DesignWare
> GPIO controller with V1 register offsets.
>
> Signed-off-by: Thomas Lin <thomas_lin@lecomputing.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Bartosz Golaszewski <brgl@kernel.org>
> ---
>  drivers/gpio/gpio-dwapb.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
> index 15cebc8b5d66..c1f3d83a67c1 100644
> --- a/drivers/gpio/gpio-dwapb.c
> +++ b/drivers/gpio/gpio-dwapb.c
> @@ -694,6 +694,7 @@ static const struct acpi_device_id dwapb_acpi_match[]=
 =3D {
>         {"APMC0D07", GPIO_REG_OFFSET_V1},
>         {"APMC0D81", GPIO_REG_OFFSET_V2},
>         {"FUJI200A", GPIO_REG_OFFSET_V1},
> +       {"LECA0001", GPIO_REG_OFFSET_V1},
>         { }
>  };
>  MODULE_DEVICE_TABLE(acpi, dwapb_acpi_match);
> --
> 2.43.0
>

I'm not sure about how to interpret the cover letter - is it fine to
take this independently through the GPIO tree for v7.2?

Bart
