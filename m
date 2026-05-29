Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BAE3D1714
	for <linux-spi@vger.kernel.org>; Fri, 29 May 2026 11:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780053621; cv=none; b=bYmbuEmzlwcUPY5IjgLWL/3zn3YX6nJ9zcv6Ch1CtuFLnwH1ZlCV8AJXCBfVtqsXeitn16MWn2As/heUWB/Tj5DYfnYBNYM0ygxRj0iC5aEoiGSeionxYeWLSPzQyHDVZ4E5yflsXm8mNQQmY5IEpUXXKosYon/eCSV3mC/CxYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780053621; c=relaxed/simple;
	bh=tvCVa+RHQaTHk8RQ2B+wipgigc8o3QF3rut6hEMmjVA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qn8KGfhlEQ/Q3PzVMoP2VZXhDoJPga0hq6aIvBFzRO6RKbb2BnYQrENprx5P5Sko2NVlqBNAtWUx80A2Uy3QrZKO7fCVKluiymf96wvKQtepqd8z6ZlSdGDMaQrAnBxC3yeU4XzJdi3YQyGjYcILwuFmuaORkYY6f0KrKJd5tQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AHJa38J/; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHJa38J/"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4891c00e7aeso93710495e9.2
        for <linux-spi@vger.kernel.org>; Fri, 29 May 2026 04:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780053618; x=1780658418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZMOmZjFhi1z8Z85NGFurl7GxPD7P41BDcFAWD9JFcwY=;
        b=AHJa38J/X1u0MtPEHZ6cJ9gW2Oo1uLUvqDKmuW3zODnk5+m6Q0YXYbNUPlYAFnIa9+
         8oSIMUYc/kPqBMrvBMGkUybTwJIBKyDi8Wfi1Q43C6linlf976ZTSUlItiWI6Ds8HQ9P
         i/d5pNEvayrR1xhf74XFqodOWGRzAwvWzp6TO5LOPhvcISuki7/6CzHyUqMcellY0kVY
         2a6VUeTFg6mjp9ijb2S7QA8bWRGofESNCfAAfStWoLWVVjTWZnHm0quE0i8lXZfJGj/P
         +ULRz5cv0/lDY2AJzvNTGLKiYeFcrGyjZnVuefECKPuCb+ZVmUIyXs6biHNamJDIVkBF
         B5Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780053618; x=1780658418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZMOmZjFhi1z8Z85NGFurl7GxPD7P41BDcFAWD9JFcwY=;
        b=gOy0SLOTyXC7mGfSiYZTAqnSFjA6HqfQDX7IBhgbbGI2eSD4aXx2Xgx4enH5f5oEfI
         tyVXbDdC6EJBHtjI1HRk389H7mWeu9gCe8Y21VcQMQ/8t6sqEasFcXRM0mJhaQWuXcay
         A6cHDYcOYH6SOVITsD75rei5Tgt332XV9cOc7NDb1YlJYfxYBfSHmwbljEY9KhecKLaT
         YEyyNPho7ct36N3+boExltbBCnUU1ykRX7ahISwuDRh6AQr+KrwgLzXUhi6xVs+SMVi3
         bITdGW1aBOIkPnzLJg+I2esOBOgndDfpopc4Skh2N0ToS2SqJoa9sIFaEqku3FSkoXva
         73TA==
X-Forwarded-Encrypted: i=1; AFNElJ8xnu2gqd0Hh59ne9xqkSydyN1Gt64OhZySIBEn17G8Oxm65+CgBDUK3+D6K2h4SV+303zsDwPtL4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZjSIzfKdvOn+cTKt9HBPF0LxulvYuS4LJ9yKuq2UKGXLokm8y
	HOgB6k6gZBPZH9ON4SzgNDhLTkKqYDu4lxnofJJxF2Nxx/M2UDUzCSwBuNXEqRLW
X-Gm-Gg: Acq92OE9auX1ne6PpjpGEGC+C7qAwmeHyAn7wrU/Zf9rgXHULC/Pm6QItAClBpWx9xE
	O30V/yHdSyraAk9iJgrqWItjygQNezfGEDOm/nemj3xl1uqB4furZOVAVBYLidfLk+B/olDI4PP
	CUq8LmUWpOQramNSWfKW3aH+O2q0syIlae+dPK9KAKRJB7Ad3/Pq650PfrOn5qUCV95MqDju0a6
	wK/JHJiiH6dd78bVIuduqeWZweLkQa6h6XkhnDyvdIJYNkIHTjgf8uvaAMlYfTBxx4iqGYNe8hh
	Fy3TlE3Bh5zgLlmtuF4/JEOQqKb+LAlikk8yOqVbTBMrun2w1p/swkZPidrZ1Y84hBc2rmHJrDs
	vROptRHheBm6b83OyOjJ9r4j5tbQy7j5BR/uhh0Irmk7ZRh+89jfs1xXked6DIE1zDcUkgrYBoC
	NmeDui+RoK9E3JoQr8B8GD41O1doOMXOz17mjwn70fCIUftrO4/n5PqncIRbXtSLu3rm4jpFo=
X-Received: by 2002:a05:600c:888c:b0:490:958f:2a5c with SMTP id 5b1f17b1804b1-4909c0aeef4mr34543485e9.17.1780053618120;
        Fri, 29 May 2026 04:20:18 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c0f74fasm16896945e9.4.2026.05.29.04.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 04:20:17 -0700 (PDT)
Date: Fri, 29 May 2026 12:20:16 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Peter Collingbourne <peter@pcc.me.uk>
Cc: Mark Brown <broonie@kernel.org>, Jani Nikula <jani.nikula@intel.com>,
 Ville =?UTF-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, Christophe
 Kerello <christophe.kerello@foss.st.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Boris Brezillon
 <boris.brezillon@collabora.com>, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, Simona Vetter <simona.vetter@ffwll.ch>, Randy
 Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2] iopoll: use udelay() for initial polling
Message-ID: <20260529122016.0059f55d@pumpkin>
In-Reply-To: <CAPQLkRi1aP3N2d7GzrRfXF0xDyamt_n9AKzFvV1WdpNk0ZymJg@mail.gmail.com>
References: <20260519102446.209723-1-peter@pcc.me.uk>
	<ag23HbvCqhmK0Ph1@intel.com>
	<CAPQLkRhtdV5Whv3ZNtZ8Xwq5V0chaQ8_tUbh7VnTexezid6EfQ@mail.gmail.com>
	<d602e4ec24533aa239f04901574b4f4826640455@intel.com>
	<4e8d842d-790a-44ad-8b80-a0a8df1fde2b@sirena.org.uk>
	<CAPQLkRi1aP3N2d7GzrRfXF0xDyamt_n9AKzFvV1WdpNk0ZymJg@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 28 May 2026 22:59:25 -0700
Peter Collingbourne <peter@pcc.me.uk> wrote:

> On Fri, May 22, 2026 at 7:51=E2=80=AFAM Mark Brown <broonie@kernel.org> w=
rote:
> >
> > On Thu, May 21, 2026 at 10:03:28AM +0300, Jani Nikula wrote: =20
> > > On Wed, 20 May 2026, Peter Collingbourne <peter@pcc.me.uk> wrote: =20
> > =20
> > > > That's what I had in v1; we decided this approach would better hand=
le
> > > > misbehaving devices.
> > > > https://lore.kernel.org/all/20260517150253.031dec09@pumpkin/ =20
> > =20
> > > I think the problem with trying to adapt to everything within
> > > read_poll_timeout() is that every step like this adapts to a *specifi=
c*
> > > use case, and once it gets specific enough, it's no longer usable to
> > > other scenarios. =20
> > =20
> > > Having to reimplement the whole thing in drivers is much worse than
> > > having to do two calls. =20
> > =20
> > > Could a staggered approach work? =20
> > =20
> > >       ret =3D read_poll_timeout_atomic("short delay/timeout")
> > >         if (ret)
> > >               ret =3D read_poll_timeout("longer delay/timeout") =20
> > =20
> > > Then you have better control of the behaviour in the driver, instead =
of
> > > adapting a generic function to a specific use case. =20
> >
> > If we're doing that it still seems like it'd be better to have a helper
> > than just takes the two timeouts and does the right thing with them.  My
> > original feedback here was that we should have helpers which encourage
> > good patterns, and TBH I expect there's probably a bunch of scenarios
> > where some fixed cutoff would be a worthwile improvement for very little
> > effort on the part of users. =20
>=20
> Thinking about it some more:
>=20
> Do we really want to udelay() for the initial busy wait? Assuming that
> we've decided to spend some time burning cycles, I think we may as
> well use those cycles to check the condition so that we have a chance
> of an early exit.
>=20
> As an experiment, I open coded it in the SPI NAND driver:
>=20
> diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
> index a09371a075d2..cce34ada7611 100644
> --- a/drivers/spi/spi-mem.c
> +++ b/drivers/spi/spi-mem.c
> @@ -1005,6 +1005,20 @@ int spi_mem_poll_status(struct spi_mem *mem,
>                         usleep_range((initial_delay_us >> 2) + 1,
>                                      initial_delay_us);
>=20
> +               {
> +                       ktime_t __start_time =3D ktime_get();
> +                       u64 __delay_timeout_us =3D 10;
> +                       ktime_t __delay_timeout =3D
> +                               ktime_add_us(__start_time, __delay_timeou=
t_us);
> +                       while (ktime_compare(ktime_get(), __delay_timeout=
) <
> +                              0) {
> +                               ret =3D spi_mem_read_status(mem, op, &sta=
tus);
> +                               if (ret < 0)
> +                                       return ret;
> +                               if ((status & mask) =3D=3D match)
> +                                       return 0;
> +                       }
> +               }
>                 ret =3D read_poll_timeout(spi_mem_read_status, read_statu=
s_ret,
>                                         (read_status_ret || ((status)
> & mask) =3D=3D match),
>                                         polling_delay_us, timeout_ms *
> 1000, false, mem,
>=20
> And it did in fact improve performance on my target compared to status
> quo and even v2.
>=20
> With hrtimers enabled, timing the UBI scan, 3 runs of each:
> - With no changes: 0.784s, 0.779s, 0.777s
> - With my v2: 0.687s, 0.686s, 0.687s
> - With the above patch: 0.665s, 0.665s, 0.665s
>=20
> So 3 options:
> 1. Take my v2 and change read_poll_timeout() to do the check during
> the busy wait.
> 2. Adjust read_poll_timeout_atomic() to busy wait using the check
> instead of udelay(), then change the SPI NAND driver to do the 2
> calls.
> 3. Introduce a new macro that does the 2 calls, and have the SPI NAND
> driver use it.

There is also the (difficult to measure) impact on overall system performan=
ce.
The versions that sleep let the cpu run other processes (or go to a low
power state).
Looping reading the status will load whatever bus handles the requests
between the cpu and spi interface logic (might be PCIe for example), that
could slow down accesses to other devices from other cpu.

I think I remember someone saying that the spi hardware interface normally
generates an interrupt when the request completes?
So for spi this is only fall-back code for a few systems.

Although I just looked at some code I have for doing bulk writes to an SPI
memory device (to write an fpga image).
That does about 35000 back to back writes.
The whole lot is in userspace - the driver just lets it mmap() the PCIe
registers. And the PCIe slave just converts 32bit accesses into 8 4-bit one=
s.
(I really should have supported read/write of AVX registers to reduce the
latency of reads - but reads are only really used for verify and I got the
CRC64 logic working in the end.)
The code has this comment:
    /* Wait for the write - typically 0.6ms (max 5ms).
     * In spite of the datasheet values, I'm seeing 200us writes. */
It waits 200us and then polls every 50us for 2 seconds.

-- David

>=20
> I don't have a strong opinion, but my preference would be either 1 or
> 3. I agree with Mark that it would make the preferred usage code
> easier to write (and to read), as there would be no need to duplicate
> the argument list or compute the timeouts correctly in every caller.
>=20
> Peter

