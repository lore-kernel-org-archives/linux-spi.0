Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04CD2F3C26;
	Thu, 28 May 2026 08:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779957460; cv=none; b=MNilIqPDr87nhC6jlfG5Jad5m8A4cnM1WVL6XoU8qO64iAOf0N+SOC+1Kqn5TYJf32I+L0+l9qyf4KOFXA/emM32wIw/YVunP4tbGHzy8qgBBO4Ljn7kYjgUwYbd+Ixpy6E0zJTzTJpFLh+dCM+s+C7wBReSYT5+zKR6nvCQaAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779957460; c=relaxed/simple;
	bh=rd1NGYuTcUwvnpMdeb4fhOZspzWeoh7On5SbZVg1PVg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oKUusT2C3CTJdgdacWHZ1Y/dBpS4+5TudiENX+VX8vjIeeiIt+/JoqrixhWE2uYEdSinSR9zCcF/e9GVzr+4SMiAASwCOIcbGeH6xwwAaiBopRg5i3DNfVzu2Jlz6BUxK18L43Cr351ahZ8Ysk/0lMjY5JPLOUNyR7R7FCCMmK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=imtaRvqU; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="imtaRvqU"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 7172B4E42D73;
	Thu, 28 May 2026 08:37:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 42FCF60495;
	Thu, 28 May 2026 08:37:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0822D10888C7A;
	Thu, 28 May 2026 10:37:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779957456; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=XyhoOym185U8bM/2Sx/vYzZsdNn1dtBmX/QSmGBwvOM=;
	b=imtaRvqUKSRHQqYxUDFnvE0kGpIE8Kf9OzH/VWkVTDXaJwzC2vDmBdZQbLTq/iDibYFFYE
	G46ALjTa8MwyofgWN6heunt5UMx2M4aMFLSymBhKKH3dapjJ6oV2t19BkFPoyzcfWBRxW3
	IuI154IPDugGsngr0+tpZJMXAKG7inxtGh5gye6xhxXs7x2Q2BpcCY/tEE2C3LQmadgGwr
	48zyD6oPpaUaCsY1D7X/ji1OhrJhKJ99ZaKeFjgo/cRf3dPZgAPH6EtbNK7bGan+wlNGDQ
	Ss6TWhWGenjKPQsoVZYb8Xhl9lIeGIwat/ON0RMa8Eu/ZOr5h+j2uNL9fhBvAQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Santhosh Kumar K <s-k6@ti.com>
Cc: <broonie@kernel.org>,  <robh@kernel.org>,  <krzk+dt@kernel.org>,
  <conor+dt@kernel.org>,  <richard@nod.at>,  <vigneshr@ti.com>,
  <pratyush@kernel.org>,  <mwalle@kernel.org>,
  <takahiro.kuwano@infineon.com>,  <linux-spi@vger.kernel.org>,
  <devicetree@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  <linux-mtd@lists.infradead.org>,  <praneeth@ti.com>,  <u-kumar1@ti.com>,
  <a-dutta@ti.com>
Subject: Re: [PATCH v3 03/13] spi: parse two-element spi-max-frequency property
In-Reply-To: <20260527175527.2247679-4-s-k6@ti.com> (Santhosh Kumar K.'s
	message of "Wed, 27 May 2026 23:25:17 +0530")
References: <20260527175527.2247679-1-s-k6@ti.com>
	<20260527175527.2247679-4-s-k6@ti.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Thu, 28 May 2026 10:37:33 +0200
Message-ID: <87ldd4gcaa.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3


>=20=20
> -	/* Device speed */
> -	if (!of_property_read_u32(nc, "spi-max-frequency", &value))
> +	/*
> +	 * Device speed: a single value sets max_speed_hz; two values set
> +	 * base_speed_hz (conservative) and max_speed_hz (maximum after
> +	 * controller-side configuration).
> +	 */
> +	nfreq =3D of_property_count_u32_elems(nc, "spi-max-frequency");
> +	if (nfreq =3D=3D 2) {
> +		of_property_read_u32_index(nc, "spi-max-frequency", 0,
> +					   &spi->base_speed_hz);
> +		of_property_read_u32_index(nc, "spi-max-frequency", 1,
> +					   &spi->max_speed_hz);

I don't know how useful that is, but I would use an intermediate
variable and check the return value of the of_property_* helper before
filling spi->max|base_speed_hz.

With this fixed,

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
