Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A213BCD34
	for <linux-spi@vger.kernel.org>; Tue, 19 May 2026 10:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779186378; cv=pass; b=DRdZFwFc0xAE10v0WVhhm/SYWEcBKm1aOtqMtujKsi0m9/ECzmzuHl6oFhDmGJRfWJGWcsxcTENflw1yym8EY9B9S48MG9EW9RaK3KhiR0oy5wHZUX+QT72o6zoSmfqQRXbhzGhUObkdq3PhP7Y88oCyC+SMQeNMQNwCdSMt2p8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779186378; c=relaxed/simple;
	bh=Or7yG2HZWEiwlYiH/nOcJaoOGUYtAU1mLP4JGPvb4Ec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=md/vnBXlK6C8VGkZBFnfS3Cpgs0QapnL9PcBeKKnsfIq479VnkHZbfS+dTtDGtsmoSJQaENHyol7L/6fqJ+w11upjkz6L6lXmCZtWKa4GD5E/N8bI0nHTBHZdeyJIK08ohxmAIJUvUXwcfn2yUd9Zf9Ikun8pqcZoqKHr2sRiJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pcc.me.uk; spf=pass smtp.mailfrom=pcc.me.uk; dkim=pass (2048-bit key) header.d=pcc-me-uk.20251104.gappssmtp.com header.i=@pcc-me-uk.20251104.gappssmtp.com header.b=Dl1b2MU9; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pcc.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pcc.me.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pcc-me-uk.20251104.gappssmtp.com header.i=@pcc-me-uk.20251104.gappssmtp.com header.b="Dl1b2MU9"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-67bc6098640so6681149a12.0
        for <linux-spi@vger.kernel.org>; Tue, 19 May 2026 03:26:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779186376; cv=none;
        d=google.com; s=arc-20240605;
        b=LYzy0479fk8E3WZKqsX2kMC/Dt2XBR1C/0taZhTN7QElRPVoWBirqmWlWN2MbJ7yra
         9Uk/2owcQ0CEK3EG959eMZqts7/EV2QLlGSZIYhGQvOEDdXtf5TR3/i2/aB+U8SGtnhK
         XgEqBJXEAdgEUKGpLFKbiyrGWFAIu5umVf1o0XGrIzFjP7BrEMqkzTYEs6OGHY672hJU
         Ho+R+Vw6hK+XkUu/dlvs7JyMrYgjgtdqowfQFzqQHQUDchV0cXzgAjOgq7QfQ0ukFjZM
         PruQFRlGl/RjyeqwkPX3xB7yIdeekSMQaQu9QgK48Ti8NQEpdyjHAzyYppR8B5YGobxN
         gTlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5xuoacZ/gwTRBSog7v9RF9gHmEwj7oFhrNhlfJ7d4Rs=;
        fh=YURvhV4V3wXwr9bJMYuTcasEKNRrWaVhRwbGjptSFpM=;
        b=a3tO+bo6wfUOhCOvSDCi4UgoAMRUZyA3ixNIs5vnNL8oQGmOJKbe5pUk9zPHL7/TVI
         cVzdrwLNVQwHuzgluZrY3HPbVNJkdy3IngqIc1Z6oscK1i6yEbltDeIsag1pGYToeO5O
         h4iLbWdWe5XZ7FlVsG8e+Mcn04V56Pd3YK1R0euD+uah58IjeN6iCcla1BUBn9HbY+yC
         o4wyUpXGvG5B0F8hjUa40oC2LybBYVMNvPZVJ8BTnZ4NxkAtj2mLLw++XyWiEaWaRcNt
         Gb/4FdTEajiC12EOeIFfbPvpEv+VeRQv2SEWbwLQHYcZT6eAx+AeAaf268Uq0Jjab7tq
         XghQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pcc-me-uk.20251104.gappssmtp.com; s=20251104; t=1779186376; x=1779791176; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5xuoacZ/gwTRBSog7v9RF9gHmEwj7oFhrNhlfJ7d4Rs=;
        b=Dl1b2MU9vk3my7fZ9yh00tgVpLbSlYbwfC0GRd6w2W3+Jt2UisbwAdcAbyHO2Uskob
         KUgEsEULcck6wQEEPq69Gt5HVNZdnzpgCbZB7xqKNdTXdGUMTXnkSb2ppckGi6olFpNS
         kW4f+pnagCHLgyOWW/CyVm3D1nlnrrSYly89PJ2MJQ4TCf+EliNb5mYByv+EKmxOposP
         OrKRFX62G/57HWvcFbbTx08jtZcmssBfv4LH56qd9SIvbsNe3vkchgUDsg4v/dj2nlzq
         joPWV1VEe3qTny1MSH2VPhW0QYHoKKj9k2LTQvxBYW61H9YpQMh6ymYYJ4ts3RvGrZwm
         gSvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779186376; x=1779791176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5xuoacZ/gwTRBSog7v9RF9gHmEwj7oFhrNhlfJ7d4Rs=;
        b=NWXiWB7qFqafmw9S12e1jhLRJlXV+s7H5ADjHfAXxPfDZMcfKkHRJSu6X/w+o0W/1X
         39aCxUO+0z2V4ZlMzWA/3eQu6St8o9sM18u00/dvvwrZQGKs4Z9WTW4wZTDUWrlHNKJU
         jNgsq+5JyLzqpKkO+swdPk8jrjHCv0RoLTjdLXDizMDtAZDldJIUhf6B4424ci+pPCf8
         XMRaZEAXWMZqkxKcPNQ1Lx0jXx7DDg91WBCK0jOiKUH++eDuMCcgexWhJ6Mr3DX96N2+
         buHqSGdsXw2GqH1bwV5w3j2rUnfGPyQGbDyoS3/axRxkyyNuSIQjDYtaeWYTm47MPvZt
         RSNQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Hv9aTW14bFpCXapitdCLo0uQPR4OwDdOup05VI9/cz3SW2yHrCaIfGah773IPBYDa0lmXcnFu8AI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0neFFtBpmgD/nCtJc2zlaTRxJhWmvnCIAIYsArRApURO2ZUym
	Jawo1EMr4SRfEVpaDEc0TpNKSMZGRaaxhEMjm8FwTz+03AWledQmkCj83KzikHeXhrsJC/5Dz9P
	wvXh65pGcRYq+L6Q6mYhG/TcHQE79mOZ8q8o3dgGMTg==
X-Gm-Gg: Acq92OGglNOSceWZS2Af3Da9U+RsbLb81mIEL7OhWaxH3gwHaUxQyGcCuiFUMYJ4XZ5
	QPGiE2Nnra4uvGIfJ1zP8KrnuMkLMZp7clvn0GJN8m13o5cX/i+LaDwWzUtWBNzA/3Tu9dcGIM/
	o38YuxNudqAQkTJydBw/tHPRJIGv38Kq0krKi2qNVmy2u8qrf35xbviLhTN3elVuhXL/cGCuFUH
	dF13+CaHdBZJkMxrqbJAb19GzFm0CZ1TirlTQlJhBxtssT49xQwRXfSWPisawVrtvxEsTgEGDHT
	0kJ94Qv+8ZYMCqgJjZY=
X-Received: by 2002:a05:6402:a58a:20b0:670:8add:2b8d with SMTP id
 4fb4d7f45d1cf-683bda948demr7337590a12.24.1779186375700; Tue, 19 May 2026
 03:26:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260517062554.117448-1-peter@pcc.me.uk> <8e7c7d5f-376e-4ab5-9ea9-a19a32d4ff67@sirena.org.uk>
In-Reply-To: <8e7c7d5f-376e-4ab5-9ea9-a19a32d4ff67@sirena.org.uk>
From: Peter Collingbourne <peter@pcc.me.uk>
Date: Tue, 19 May 2026 03:26:04 -0700
X-Gm-Features: AVHnY4I0YwvzFfBXTMVn5yNzK0m82DM8ReeNm_apVnVHplWZAIJ0RHQfs9vKq60
Message-ID: <CAPQLkRii7J0-7Ai3QeTNZ_9kYkAB_=rsLVh04mhDGzn+YvHDQg@mail.gmail.com>
Subject: Re: [PATCH] spi: use udelay() for short polling delays
To: Mark Brown <broonie@kernel.org>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>, 
	Boris Brezillon <boris.brezillon@collabora.com>, 
	Christophe Kerello <christophe.kerello@foss.st.com>, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, David Laight <david.laight.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 3:46=E2=80=AFAM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Sat, May 16, 2026 at 11:25:54PM -0700, Peter Collingbourne wrote:
>
> > +             if (polling_delay_us < 10)
> > +                     ret =3D read_poll_timeout_atomic(
> > +                             spi_mem_read_status, read_status_ret,
> > +                             (read_status_ret || ((status)&mask) =3D=
=3D match),
> > +                             polling_delay_us, timeout_ms * 1000, fals=
e, mem,
> > +                             op, &status);
> > +             else
> > +                     ret =3D read_poll_timeout(
> > +                             spi_mem_read_status, read_status_ret,
> > +                             (read_status_ret || ((status)&mask) =3D=
=3D match),
> > +                             polling_delay_us, timeout_ms * 1000, fals=
e, mem,
> > +                             op, &status);
>
> This seems like something that should be fixed in read_poll_timeout()
> rather than open coded in a user, similarly to how fsleep() is there for
> sleep functions.

Sounds reasonable, sent v2 with the fix moved to read_poll_timeout().

Peter
