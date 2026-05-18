Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DAD3E51D2
	for <linux-spi@vger.kernel.org>; Mon, 18 May 2026 09:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779095047; cv=none; b=tx+egDgD9xENwjJDXy90VAVMdbdBMgWsyuK50pbV+cj5hA+1uzkHWR6EgJL2/6ACyUC1UdAH+wFvJ7qDI8SOEq+WQ68ZiiTssWQ0344u252A5oyd1tjNvyYsXVx0vk80utowF6m1TLQf7fQI1suhyA2SxlFw0UkLnGAgrYegHZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779095047; c=relaxed/simple;
	bh=oA1Lu5bvhUDP97/5bGpjX/QJjh/8fGgII/+u1ebhvAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sAlyJubF+qIKJOXDtJQUmPGenbI28EZbYvepOYuuGf7xmkUPM765caattvVl1nsQBBq7Ru/nYqlUJlONDC47iFdJI6MBU24HnEP6hzx8jo/B/GC2rkzbxgCTKyDnhqNGTcFis8/ouXFaybqpfoD6mQoSTg5LTEx+D18QRODilFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ry0Cqm9b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ry0Cqm9b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FCCDC32786
	for <linux-spi@vger.kernel.org>; Mon, 18 May 2026 09:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779095047;
	bh=oA1Lu5bvhUDP97/5bGpjX/QJjh/8fGgII/+u1ebhvAU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ry0Cqm9br+ntG6gURjff6grfILaTOLv+FICW2Y8UPkmwBj9Hodus3Cq3Bw1OyZZoS
	 OzY4pgx7+rsrNCBJkWzt8JIxrIJHnM/E2+JgIaS+jr1W/674YYExoQYcFwS6ODx9XF
	 SH5WzSRKTOehf7e2K1dO9aFqiaf/giuvvfCXr9BiU3u6gM9WHIGA7n36XeKE4IlxFl
	 Q4XNFyxfHUdYeEnZ8JpYgZTZOnp71tq3obxpu1WFUJ8H15m+EZ1OXUDVy4665Xbjzl
	 v/QKbPxNAK7lSx2XsgiHEGUt3Jt3sBFOgZC5DyAdz8i6gsaTdZpCXNWLAdjjS0z2CZ
	 RuKXv57NK1X7g==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5a8e33556c0so2638916e87.0
        for <linux-spi@vger.kernel.org>; Mon, 18 May 2026 02:04:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ82KXRhPMBvaeo3TTHLr3QJp01FW0D3+d2KKNQg9DK1y9rL794Zf2bqQzucgFIX/xyC3T9ztVFkQw4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3uT5IDoUyx0DK0bocTgP+uuUCLmJJaBtDsosPxeq4fNYYd7Ik
	WjWvgZtUkySiCqwJNjA1zuiz20xcZB/u2wdChBVFpi78z06XRIGbK/EU0AYMTzxL7RCcWq6oJkT
	5/Tvp5SZlAMc9eYL6TzUUef3aQneZaM3NTQNK2Vi7TQ==
X-Received: by 2002:a05:6512:138a:b0:5a8:73c2:c90b with SMTP id
 2adb3069b0e04-5aa0e09fb0dmr3501664e87.20.1779095045745; Mon, 18 May 2026
 02:04:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514034319.3507315-1-thomas_lin@lecomputing.com>
 <20260518024937.453714-1-thomas_lin@lecomputing.com> <20260518024937.453714-2-thomas_lin@lecomputing.com>
In-Reply-To: <20260518024937.453714-2-thomas_lin@lecomputing.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Mon, 18 May 2026 11:03:52 +0200
X-Gmail-Original-Message-ID: <CAMRc=Mf9YZJS4HyT=CfgXqoAZM=6CZLXc_M6xBHVGEUFbeey-g@mail.gmail.com>
X-Gm-Features: AVHnY4L99cuF1ZGuHXCO-ALnBTKrGIXkrITVhG5W_BkFB71OFXk93IVOayE1Inc
Message-ID: <CAMRc=Mf9YZJS4HyT=CfgXqoAZM=6CZLXc_M6xBHVGEUFbeey-g@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] gpio: dwapb: Add ACPI ID LECA0001 for LECARC SoCs
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

On Mon, May 18, 2026 at 4:50=E2=80=AFAM Thomas Lin <thomas_lin@lecomputing.=
com> wrote:
>
> Add ACPI ID "LECA0001" for LECARC SoCs that use the DesignWare
> GPIO controller with V1 register offsets.
>
> Signed-off-by: Thomas Lin <thomas_lin@lecomputing.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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

Don't send patches in response to other patches or sub-messages in a
patch thread, b4 can't deal with this. Please start a new thread for
each revision.

Preferably use b4[1] for managing series and it'll avoid you all these prob=
lems.

Bart

[1] https://b4.docs.kernel.org/en/latest/
