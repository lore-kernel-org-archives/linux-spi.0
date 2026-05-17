Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD209341050
	for <linux-spi@vger.kernel.org>; Sun, 17 May 2026 23:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779059717; cv=pass; b=CUDCelP38C5DjGJRgB7VV2kSniNh1IrV9JBLJjhuB+wBcS9FG6foUH27hi0QunQ59MPdWnUC4PRiCTettgKPF7iI18T35ciNtJx6y+AbFmIeqGhvDih1D5OWJ2Ey4Mv1paSxX4BJT/ZNi2cJ6pXCdzT/4Sn3SkpNAguGkIG4/sI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779059717; c=relaxed/simple;
	bh=19XbO6lAHOzzfGM0tSsjsYRfi0h83riXZM2zaPYU0tQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OfjfEdn1ptGbAX9oXi2bn/Lmhso8CBOOsyqGKAuglV2GC4ORJSl6+Rrx6BBppAFciR9AMsRRfiB4lFrPM8WbcqTeZz92tM9DRaiPvMxM1vpOz4E4bi8D5tTdNiqv6sxjweVMn314Lu0WF1qHYZRi4lebhEDHhJ/v3f3GkRySozc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pcc.me.uk; spf=pass smtp.mailfrom=pcc.me.uk; dkim=pass (2048-bit key) header.d=pcc-me-uk.20251104.gappssmtp.com header.i=@pcc-me-uk.20251104.gappssmtp.com header.b=ojtHZhQf; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pcc.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pcc.me.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pcc-me-uk.20251104.gappssmtp.com header.i=@pcc-me-uk.20251104.gappssmtp.com header.b="ojtHZhQf"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-67c4aaf76ecso2921232a12.3
        for <linux-spi@vger.kernel.org>; Sun, 17 May 2026 16:15:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779059713; cv=none;
        d=google.com; s=arc-20240605;
        b=Wi7SkvNdX+OVWvYHKHanKFN1bhKTege97feU6Z+y7XILnh+dh7dhoXZ5MbP4Fgdlll
         ZF/3+9OFDBEyGUSpvUj5f4CbQYNX58RWI09NcEQ6LIVk/mP8t8xJ4BQ/qZj5n71BTE5x
         M6uIPDLAhBqdMIOTx9Sy7RIG60LCPMzGsIU8saiM/dIXM+ui5rS67VfZV4tS+agR+MwL
         TMlVbibJdBkvdK0lVU4L9TW6OTa4mLNuG2Jp2yeD5//Zmw4W/sWHyvRdCGtqT+EqNzi1
         mPJGCdcZwDdcxLS74DVfUONFwcJfmJYadOvpCdDamGuBP1nH2sEWdwShRe5j6lbRMSp8
         bgow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=S/zI79IEXrQXECU9rQWS+uCMyWD8MlLbFgtSm3gtaLc=;
        fh=O9cA3EHMbpoVXzY614ShNz+PgPePAmbXCvcC5iaodX4=;
        b=kFehOVg+NjZ8m/FbiOEcMDHxCyiRmzgXMHtqe5/ApmaKlW1vTKFqvU+slx3aS5j70a
         ndIJAFu9LjolX2+Kf6y3DFUS7rbqKpfAV+eCrl6fpRI/ECh77W26Fhm9hi98K84DTLo3
         8w9End0teCzBG2yZ5ZTVeIDaNCapJlM4v96HAytiyrFcnOWoUQFtkE/2sZQRMA5+BIIg
         EVw++3JGYeFH8JGFr5epDQ9ucwczCkrZGxEc2wJ5EXDRBZDVs3RTF78zgphiBAYaCiWh
         DgB+uBnya16KyFVAJvifLoxnFIi6+qCFJP6WPMgrSDHLVee8wladXVP//Dltr8pynyzq
         kSEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pcc-me-uk.20251104.gappssmtp.com; s=20251104; t=1779059713; x=1779664513; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S/zI79IEXrQXECU9rQWS+uCMyWD8MlLbFgtSm3gtaLc=;
        b=ojtHZhQfYRDeKw/iGryR5/Pw10awQW7BoCqNGPc4T5v40a67kx4IJj2ejSIdJEj6zW
         MDX+91HspEjf1n+MM3G8qViW1HWiqUovOQgYYa29HeJSLVIDDJ8zq/jDRNyZ5C14iB7c
         3ctCrTPB6eGAS/nZjSMPpzXpcFyVooInRO4yeuM5i6QjjKwH21DXD8Fg0DKsvFp2BISF
         B+8pcJ8TuPBY3XGvVdvBe3pNqtlWIgr8MylYey+mU3jXTFpi7kdaaBLCztYBYGzmwxYD
         YDZaFqBhkKpEhABP7tdN0QK34f9BGJzcV4kR5HH5h7y5uUggfVlI9iWvSqhdNfm+fnFM
         dAzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779059713; x=1779664513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S/zI79IEXrQXECU9rQWS+uCMyWD8MlLbFgtSm3gtaLc=;
        b=Y6gBj8572g8B7UoWtORZ0nACYuukHhEE8XdwyDBHxjp5z/0JI4hqG8czj0BxZeJ90m
         PdllJmuWLWq7DYSlXbqkgW5GCWJtYlatXqqlPzMXrVuA8pH0atMGcz8keipYgbUIVdoY
         FLngGpDjLR8B3qi9ssgd+qlJ8PYBigKhw49XshxT2a+SrwxSGjECg0irsrx748bH+uVc
         eMMSSr4nX6cqrBnN9PimnfUjXu5tY7Ly/2mVOY6ObEAK9kzxDQ4tcgWGYOjVjh7L5+MW
         ymg2R+lIPCg0batT83F46/zAdRh6d1LEkCfkHV0XJwnpHPUwHtZzosDs1tL8UYUoUl0w
         tz7w==
X-Forwarded-Encrypted: i=1; AFNElJ/S2H/tppmYGsM2NCjUDrfiG5XAC+YZZnEDZDnbU7xrZgja9/xXbLhcjvsxM4C6xWbVRLcT0AHlfbk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZhZDo050/jnqXSG23axTSNnu5vEd8Nw6UpQG79A1mIFCkNbRE
	DeUNbdPqzURMoKM8tBYr9kVLwfM9IZ+ByGPGlMduuKFkyVDqJx27+F2oloJPI6dX54V4WoiAYJo
	exZXjj05t6SuV4vm0F82CUOdRE5zHo2STTaCAWnQTzA==
X-Gm-Gg: Acq92OHREerW6kHwsYbLMgl+yQYr7xociubCadql2k+RVDCNmoKCynMtbObjP0/XIJ7
	i+nkfuEl67rDtVmJt0yAqwztOTNtkoO54AvqclN/S2M9y+G3trxH0DpKMU02VkV8QhTykfQmwWp
	W5zoKdABs5MndPHLpnngOidF/t50CYCRWMPTMO6F3Q4mSViO51auqkrcJ1HmIcY/dxaPJnwc2jD
	48QUAxfu/VKnVNjIuRzPLTE/MGkQ2CxrQjzwzjKyHgPudu6JAI92ysxrJdBV7kcRDWzW1lu1mc6
	Vyeowkcp
X-Received: by 2002:a05:6402:1f45:b0:67b:7d77:14da with SMTP id
 4fb4d7f45d1cf-683bc8a94b8mr5633816a12.8.1779059712987; Sun, 17 May 2026
 16:15:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260517062554.117448-1-peter@pcc.me.uk> <20260517150253.031dec09@pumpkin>
In-Reply-To: <20260517150253.031dec09@pumpkin>
From: Peter Collingbourne <peter@pcc.me.uk>
Date: Sun, 17 May 2026 16:15:01 -0700
X-Gm-Features: AVHnY4JRzfsftcM6T0MwaNQvY8ESCP1kizITldQonTVmfdvjPL3dAzjFzefglF4
Message-ID: <CAPQLkRiw1LW6oW2SspQtRZt7O44e+y-WA1+2SNQ2t-1BFHJb=w@mail.gmail.com>
Subject: Re: [PATCH] spi: use udelay() for short polling delays
To: David Laight <david.laight.linux@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Patrice Chotard <patrice.chotard@foss.st.com>, 
	Boris Brezillon <boris.brezillon@collabora.com>, 
	Christophe Kerello <christophe.kerello@foss.st.com>, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 17, 2026 at 7:02=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Sat, 16 May 2026 23:25:54 -0700
> Peter Collingbourne <peter@pcc.me.uk> wrote:
>
> > A short polling delay, such as the delay of 5us
> > (SPINAND_READ_POLL_DELAY_US) provided by the SPI NAND driver,
> > can become a 1/HZ (order of ms) delay caused by the usleep_range()
> > call in read_poll_timeout(), significantly reducing SPI NAND access
> > performance. Fix it by implementing the polling delay with udelay()
> > (via read_poll_timeout_atomic()) if it is short enough, matching how
> > the initial delay is handled.
> >
> > Fixes: c955a0cc8a28 ("spi: spi-mem: add automatic poll status functions=
")
> > Signed-off-by: Peter Collingbourne <peter@pcc.me.uk>
> > ---
> >  drivers/spi/spi-mem.c | 17 +++++++++++++----
> >  1 file changed, 13 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
> > index a09371a075d2..914e35e51cea 100644
> > --- a/drivers/spi/spi-mem.c
> > +++ b/drivers/spi/spi-mem.c
> > @@ -1005,10 +1005,19 @@ int spi_mem_poll_status(struct spi_mem *mem,
> >                       usleep_range((initial_delay_us >> 2) + 1,
> >                                    initial_delay_us);
> >
> > -             ret =3D read_poll_timeout(spi_mem_read_status, read_statu=
s_ret,
> > -                                     (read_status_ret || ((status) & m=
ask) =3D=3D match),
> > -                                     polling_delay_us, timeout_ms * 10=
00, false, mem,
> > -                                     op, &status);
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
> > +
>
> That looks rather sub-optional.
> Even if the interval is short you want to drop to sleeps if the device is=
n't
> responding.
> (Or this code is used for erases and you are doing a full device erase.)
>
> I doubt you want to spin for more than 1ms.
>
> -David

In include/linux/mtd/spinand.h we have:

#define SPINAND_READ_POLL_DELAY_US 5
#define SPINAND_RESET_POLL_DELAY_US 5
#define SPINAND_WRITE_POLL_DELAY_US 15
#define SPINAND_ERASE_POLL_DELAY_US 50

So we will only delay here for reads and resets.

I would generally expect drivers to arrange for spi_mem_read_status()
to sleep using wait_for_completion*() where possible, so we shouldn't
normally be actually spinning here.

For example, the generic driver:

spi_mem_read_status()
-> spi_mem_exec_op()
  -> spi_sync()
    -> __spi_sync()
      -> __spi_transfer_message_noqueue()
        -> __spi_pump_transfer_message()
          -> spi_transfer_one_message() [via ctlr->transfer_one_message]
            -> spi_transfer_wait()
              -> wait_for_completion_timeout()

For spi-mt65xx:

spi_mem_read_status()
-> spi_mem_exec_op()
  -> mtk_spi_mem_exec_op() [via ctlr->mem_ops->exec_op]
    -> wait_for_completion_timeout()

Peter
