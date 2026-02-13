Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF18364EAD
	for <linux-spi@vger.kernel.org>; Fri, 13 Feb 2026 16:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771000769; cv=none; b=Ibqq3zC+pgPOCW+wn/t1HwY4hcYIOnnOBbURUXODh+S+N80VNU6RLu70Ufgj8W82xTYegx/pphQu80Sl6jmgYmEtzuIPAQOQ5QY7pVjBlFS8AuzCCRuIbFGOVE2aGZHXjzNVC5ktetutiMIBbM3mOKA0roG86PJvKa2/5hPgI50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771000769; c=relaxed/simple;
	bh=I5t+AuxYw7p7Xyx85rveOZeK24TscG2Fhq1FrAYn1hw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Apakx4zouAmsSN5j+3vmIP16Ii3QCd6+lCr0WOfps7/5LjG+wOMJsy3N3H6LREj9rWj8uAK6xIs/yHrarIkXmR5xV03QLjXHj1WAjYDdPhECDBut065+yFPikAFDtubh4U0JUEDxeysOwmM1wSgO3r4FdadLNx/1plzzrVoLcVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OSb+eb6s; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OSb+eb6s"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4834826e555so11343395e9.2
        for <linux-spi@vger.kernel.org>; Fri, 13 Feb 2026 08:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771000764; x=1771605564; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IYpnXoF4mkHSRo0JO+Wo5zILS4TZKjxUVcEjwxhz2As=;
        b=OSb+eb6sGoq1Xz0rDLY7B3NG6KlKT5trRdjEdWC9lUP7GxFtHixEJ0YQz37IElpwWE
         wC8VvY8s/VbEvWJbiuMU5/TVSxLVV2JqsHEbUcei4oqytBwwOKxk/BwvR4c/bNi7tgUU
         skMpvj+k6BSgkgF5Bk8jAcQ9YamrUA/fAJmAchMc5uLQlqiNJnB4+3sE7CoORMsORJHH
         Z21hNQ0ACqYxLJVUjiVwnf+9oYHjqFefafJGosw1MlDa9X+nxgcgtLy+XZ5iQzYI49xx
         w62i7XOs/LYtH5UlGn8hkCi4I5woYyavprBn96QvhV63MlQMNrw3N1VdatcEOe+8vI/t
         ZJ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771000764; x=1771605564;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IYpnXoF4mkHSRo0JO+Wo5zILS4TZKjxUVcEjwxhz2As=;
        b=lGjr1olO8549eKaI1K/V755/6CM3Yr5wtK6iP/lDCBixLRk1VauXIPkS0GYRdORSse
         O2R4rcGnXqvVnpO/0B/LzpDtfLA7hg+KcD7dCRvZA1XRUiNUyErzO5gL1n55S00bTwND
         zQHtsKh37L/js+TcV22SE32wd08phBeBYNw09zPWclkGPrhG8biNyKLShbBk8Bp2s9NL
         OTLpj5DJdToTVALYDVeh8Ya2uh1AaeOBS4I9/5BvyOrasM681oGNWsMtRKbMCxd55CJt
         NnVDw+d7UfPosJ0ZeNS6DZQkSsUtvikMl0Cx9Xx6PQyb42lXWZOtdOeU8Xdhubi/6ZX3
         n1fg==
X-Forwarded-Encrypted: i=1; AJvYcCUjBaxNtDnRH8afP3S5UcJ9i03x53u6TZz6QdlChPlIiluqD2Z1kTomlLHCTM3na8vouHVif4fW8/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ6KG9Q7JuoXKWAfRFRcC17Z2PTf5XHRm/7DmNrrI9WnO55B3c
	2UavRAgnPUav7lpGNaYuovV8GdReTBPM3C0iJ7Rkex/3V3ldKhgCaWqk5FtvS4fI
X-Gm-Gg: AZuq6aL2edGN9pugBlI6IyFCELXED3Nlre8AHQg2Zznw+uMyMHUCBpZ9BvzS0f+uvWF
	mAfMrLrj/dq1WOMBaCvnlX4g5XhhL4cf8WB6o6kFoXLeuSu5dc7ktQxNeUFFa1Z5ToXw6TQnYtW
	xhRjeKqPmy5Gl07V/1IPl4aTj4zMLH4LyIr4d+FY6Iz+pE8DV4WCwx4RgVre7Lx1g8XZ3AKbYqq
	x8Rf193TZa4x4ox0LkM+C28lJbB5W/Or9sByF71NWjJ+0WhabbkXhb6V0su/8SLUv76X8tK/tEz
	hc2jujTFHPQb8GV581JiQkCjOx4CuLbE1hHKJmlxEYQVQOi+hWn1R37tFjsn2KgCFfgpafxZC0m
	1XEXi+FE1aJVfIRE5iixhZnnbq5JAASpx4RudUc0ofvSyKA6iJhtwRFNKu0ZEDCedBjOTfowYLA
	usBqbyZbL23Hq7+GoSg03HViC5XVjEcB4=
X-Received: by 2002:a05:600c:4e86:b0:47e:e20e:bbb2 with SMTP id 5b1f17b1804b1-48373a15ff4mr40626655e9.7.1771000763657;
        Fri, 13 Feb 2026 08:39:23 -0800 (PST)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d8334a8sm283255245e9.12.2026.02.13.08.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 08:39:23 -0800 (PST)
Message-ID: <c956f310b31e608520e203186ffdc753e55c045c.camel@gmail.com>
Subject: Re: [PATCH v3 2/5] spi: add devm_spi_new_ancillary_device()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, Lars-Peter Clausen	
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron	 <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=	 <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring	 <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley	
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>, Mark
 Brown	 <broonie@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org
Date: Fri, 13 Feb 2026 16:40:05 +0000
In-Reply-To: <20260213144742.16394-3-antoniu.miclaus@analog.com>
References: <20260213144742.16394-1-antoniu.miclaus@analog.com>
	 <20260213144742.16394-3-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-02-13 at 16:47 +0200, Antoniu Miclaus wrote:
> Add a devres-managed version of spi_new_ancillary_device() that
> automatically unregisters the ancillary SPI device when the parent
> device is removed.
>=20
> This follows the same devm_add_action_or_reset() pattern used by the
> other managed SPI functions (devm_spi_optimize_message,
> devm_spi_register_controller, etc.) and eliminates the need for drivers
> to open-code their own devm cleanup callbacks for ancillary devices.
>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---

Acked-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> Changes in v3:
> =C2=A0 - New patch
>=20
> =C2=A0drivers/spi/spi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 40 ++++++++=
++++++++++++++++++++++++++++++++
> =C2=A0include/linux/spi/spi.h |=C2=A0 1 +
> =C2=A02 files changed, 41 insertions(+)
>=20
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 693bdcc5a12a..1b48ec67b8e0 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -2612,6 +2612,46 @@ struct spi_device *spi_new_ancillary_device(struct=
 spi_device *spi,
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_GPL(spi_new_ancillary_device);
> =C2=A0
> +static void devm_spi_unregister_device(void *spi)
> +{
> +	spi_unregister_device(spi);
> +}
> +
> +/**
> + * devm_spi_new_ancillary_device() - Register managed ancillary SPI devi=
ce
> + * @spi:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Pointer to the =
main SPI device registering the ancillary device
> + * @chip_select: Chip Select of the ancillary device
> + *
> + * Register an ancillary SPI device; for example some chips have a chip-=
select
> + * for normal device usage and another one for setup/firmware upload.
> + *
> + * This is the managed version of spi_new_ancillary_device(). The ancill=
ary
> + * device will be unregistered automatically when the parent SPI device =
is
> + * unregistered.
> + *
> + * This may only be called from main SPI device's probe routine.
> + *
> + * Return: Pointer to new ancillary device on success; ERR_PTR on failur=
e
> + */
> +struct spi_device *devm_spi_new_ancillary_device(struct spi_device *spi,
> +						 u8 chip_select)
> +{
> +	struct spi_device *ancillary;
> +	int ret;
> +
> +	ancillary =3D spi_new_ancillary_device(spi, chip_select);
> +	if (IS_ERR(ancillary))
> +		return ancillary;
> +
> +	ret =3D devm_add_action_or_reset(&spi->dev, devm_spi_unregister_device,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ancillary);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	return ancillary;
> +}
> +EXPORT_SYMBOL_GPL(devm_spi_new_ancillary_device);
> +
> =C2=A0#ifdef CONFIG_ACPI
> =C2=A0struct acpi_spi_lookup {
> =C2=A0	struct spi_controller=C2=A0	*ctlr;
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index cb2c2df31089..9aef1987b12f 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -374,6 +374,7 @@ static inline void spi_unregister_driver(struct spi_d=
river *sdrv)
> =C2=A0}
> =C2=A0
> =C2=A0extern struct spi_device *spi_new_ancillary_device(struct spi_devic=
e *spi, u8 chip_select);
> +extern struct spi_device *devm_spi_new_ancillary_device(struct spi_devic=
e *spi, u8 chip_select);
> =C2=A0
> =C2=A0/* Use a define to avoid include chaining to get THIS_MODULE */
> =C2=A0#define spi_register_driver(driver) \
