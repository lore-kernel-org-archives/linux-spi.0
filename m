Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13B73E559B
	for <linux-spi@vger.kernel.org>; Mon, 18 May 2026 09:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779095095; cv=none; b=HWWp2S+zdWYoUK4ZX16olm9xeY9Zt01WFNHUglFrNqJQDJ5WGtQ4NFMeEN9HjUOiX+0m2rFtCqFEt991THVr39hhSqUVDeWYPZ+c2oMTSmCvKIEkY2X7iOtlmOkApSsawnOyYcnXskEZPEnnUmIULD6YTRvTUKMTa24j3mW1BYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779095095; c=relaxed/simple;
	bh=uakw6O/aSxeiq7FiH6COxnqTbF2HQ/jSmQP7xiHYsq0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ohk9+mjHrJuvOZ2SSggeWQ9aqxwTX3NCSUBBARsxOEBxMCPrZfZ4IIWG6J10JphqGkJYQbeMCdkVRwXXPcvs4HmnAOxSZvUTxJ1B0XhZcjXH92wVsmJ0dhqdTNypAMHWcBnE4tQo6hl/7ySw/PGEmduHEI0dySqyl0OwrF27EnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MBj6heJd; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBj6heJd"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-45ae6a0e523so904705f8f.1
        for <linux-spi@vger.kernel.org>; Mon, 18 May 2026 02:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779095092; x=1779699892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gw/wuvCTs9a0Y5MJYOGwOreCV9s8UlS12seGF2T/0X0=;
        b=MBj6heJd1S6iZWzcrb4f1OoZuqGnFWRUNc0B+w3ZYVCmu1848XRrELNEXwfN8VE99f
         3pqbUot4ky/AjSf/nykFKYeIz8kt8So1MeixNAbQCqYDZfVy7hYVM0gFPlOw/O8SbXWV
         IlRNSOjGP0ehsqYeFO2UeZz+r4G45iO9tvOlNM6ZQbnfQH0VWTbEIAPyWaYTBgqbDiYX
         yKPgPDVWLd80FpOGbGj06oHFYwig+Rd4ZiqSIY6zYt3DioekkFD8uuUcBQoPtLsUZz8a
         C+/ckFlFZEWLIPwioPs6CM+GqN7PUJdPBVeePfi/T/U2VPC1yxb79u1z1gG/g6Ktfdgf
         Lsfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779095092; x=1779699892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gw/wuvCTs9a0Y5MJYOGwOreCV9s8UlS12seGF2T/0X0=;
        b=giPT8c3v/eV+69ngZTQMFQrqfPpN7PonTimMLXdG2gJw0tIYPXuoOwiA/Vb1zZdNgT
         seEWDQPIqC9RWT40lGoZhBKpC70KN8W0QKDdiA4NHnXvbBdj76pxxevanHUrB80eTyrZ
         5A+owzvCo6gwN0o2GEJG6bhX94WDjOBHGN735UxdhysolTf1eOLoVuS25mRcX0R5HzcA
         orlyxJOKHVkF158sXN5upRZ3/3mbFuq74Bo3SkHwR7l3ssE2Wr/0nsvleq3aFJ3A5f1i
         FVLTMQ8nW0WzPbN0jJdtWN7DVamXrbYuMVQQnvBsLCbHI2zZ1gaufEidk0zT4GiQpGCE
         YhVA==
X-Forwarded-Encrypted: i=1; AFNElJ8MnMb+TJhk/b0X1yvSbEjCsh88fXQYcOvVeV1+UhzJc2UtoqhpMpkxdcxZ0K/tWLritxPHUOChR7s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2WSVCuv6Rl745DJL8o//ocpAbf0VhkPCN0K7V5tpd6gJogR8q
	Y+L5TN/108r4SGGK93+b0ZXyOmaeWwqciMTsr5kKqEnUtzX0C7reFfjCZ/luClvS
X-Gm-Gg: Acq92OFjz221aysSAwlJTZIFZ2m+WDTKkCVa16c5CatFU3ouGTXfAUdqUxZlOAixd9B
	RXFJzoDkQkNgUNB9ubjH0mSxu7on7hdEtXfWwiaiNsvdKJolflcdUqR5f3Ojggw710LqSdr8urG
	EOvOVWY2PM9v8UA3VmH4Vn1VuKKjNjieZtvPXxCh71ZzUeA8VRkEQNJ/R2LDPYxb2uJKH7Af1z2
	jgGShjt3/avg2dVCgsbc6Exhpff3973vFLpWEqjhuHTSZFmzNPsVVMDx9bkYVkjwlgNgLnC1CAI
	KSzvSPlBD9APQnGH8VAFtlc103wv8LKiadeqiisYw9JRcRnwRVsJCaDz7ge0I4sRad4cplbr+v6
	GlbZ1PvjjmK0SmA0llhaUciqZ2EcomoKrBo186iGvdb2da7HBx13HonkTqtyA1wYmxIUpAteSKL
	G8xYQJVtaMFXoWypEOVy6+c+C0ULJJAh56mQO3jtAk4tw/68LG0EuEGmE8S8OPZjD0
X-Received: by 2002:a05:600c:8210:b0:48a:5c23:cab with SMTP id 5b1f17b1804b1-48fe6322447mr202576835e9.19.1779095091999;
        Mon, 18 May 2026 02:04:51 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe5ab527asm266838295e9.11.2026.05.18.02.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 02:04:51 -0700 (PDT)
Date: Mon, 18 May 2026 10:04:49 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Peter Collingbourne <peter@pcc.me.uk>
Cc: Mark Brown <broonie@kernel.org>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Boris Brezillon
 <boris.brezillon@collabora.com>, Christophe Kerello
 <christophe.kerello@foss.st.com>, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: use udelay() for short polling delays
Message-ID: <20260518100449.0595079d@pumpkin>
In-Reply-To: <CAPQLkRiw1LW6oW2SspQtRZt7O44e+y-WA1+2SNQ2t-1BFHJb=w@mail.gmail.com>
References: <20260517062554.117448-1-peter@pcc.me.uk>
	<20260517150253.031dec09@pumpkin>
	<CAPQLkRiw1LW6oW2SspQtRZt7O44e+y-WA1+2SNQ2t-1BFHJb=w@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 17 May 2026 16:15:01 -0700
Peter Collingbourne <peter@pcc.me.uk> wrote:

> On Sun, May 17, 2026 at 7:02=E2=80=AFAM David Laight
> <david.laight.linux@gmail.com> wrote:
> >
> > On Sat, 16 May 2026 23:25:54 -0700
> > Peter Collingbourne <peter@pcc.me.uk> wrote:
> > =20
> > > A short polling delay, such as the delay of 5us
> > > (SPINAND_READ_POLL_DELAY_US) provided by the SPI NAND driver,
> > > can become a 1/HZ (order of ms) delay caused by the usleep_range()
> > > call in read_poll_timeout(), significantly reducing SPI NAND access
> > > performance. Fix it by implementing the polling delay with udelay()
> > > (via read_poll_timeout_atomic()) if it is short enough, matching how
> > > the initial delay is handled.
> > >
> > > Fixes: c955a0cc8a28 ("spi: spi-mem: add automatic poll status functio=
ns")
> > > Signed-off-by: Peter Collingbourne <peter@pcc.me.uk>
> > > ---
> > >  drivers/spi/spi-mem.c | 17 +++++++++++++----
> > >  1 file changed, 13 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
> > > index a09371a075d2..914e35e51cea 100644
> > > --- a/drivers/spi/spi-mem.c
> > > +++ b/drivers/spi/spi-mem.c
> > > @@ -1005,10 +1005,19 @@ int spi_mem_poll_status(struct spi_mem *mem,
> > >                       usleep_range((initial_delay_us >> 2) + 1,
> > >                                    initial_delay_us);
> > >
> > > -             ret =3D read_poll_timeout(spi_mem_read_status, read_sta=
tus_ret,
> > > -                                     (read_status_ret || ((status) &=
 mask) =3D=3D match),
> > > -                                     polling_delay_us, timeout_ms * =
1000, false, mem,
> > > -                                     op, &status);
> > > +             if (polling_delay_us < 10)
> > > +                     ret =3D read_poll_timeout_atomic(
> > > +                             spi_mem_read_status, read_status_ret,
> > > +                             (read_status_ret || ((status)&mask) =3D=
=3D match),
> > > +                             polling_delay_us, timeout_ms * 1000, fa=
lse, mem,
> > > +                             op, &status);
> > > +             else
> > > +                     ret =3D read_poll_timeout(
> > > +                             spi_mem_read_status, read_status_ret,
> > > +                             (read_status_ret || ((status)&mask) =3D=
=3D match),
> > > +                             polling_delay_us, timeout_ms * 1000, fa=
lse, mem,
> > > +                             op, &status);
> > > + =20
> >
> > That looks rather sub-optional.
> > Even if the interval is short you want to drop to sleeps if the device =
isn't
> > responding.
> > (Or this code is used for erases and you are doing a full device erase.)
> >
> > I doubt you want to spin for more than 1ms.
> >
> > -David =20
>=20
> In include/linux/mtd/spinand.h we have:
>=20
> #define SPINAND_READ_POLL_DELAY_US 5
> #define SPINAND_RESET_POLL_DELAY_US 5
> #define SPINAND_WRITE_POLL_DELAY_US 15
> #define SPINAND_ERASE_POLL_DELAY_US 50
>=20
> So we will only delay here for reads and resets.

The timeout_ms values are equally relevant.
If anything goes wrong you don't want to be spinning for a long time
(and the timeout in the polling/atomic case is likely to be significantly
longer than you might expect - it only counts time in delay_us()).

So sort of want something like the following - but it is too hacky!
	int spins =3D polling_delay_us < 10 ? 10 : 0;
#define usleep_range(min, max) (--spins < 0 ? usleep_range(min, max) : udel=
ay(max))
	ret =3D read_poll_timeout(....);
#undef usleep_range

-- David

>=20
> I would generally expect drivers to arrange for spi_mem_read_status()
> to sleep using wait_for_completion*() where possible, so we shouldn't
> normally be actually spinning here.
>=20
> For example, the generic driver:
>=20
> spi_mem_read_status()
> -> spi_mem_exec_op()
>   -> spi_sync()
>     -> __spi_sync()
>       -> __spi_transfer_message_noqueue()
>         -> __spi_pump_transfer_message()
>           -> spi_transfer_one_message() [via ctlr->transfer_one_message]
>             -> spi_transfer_wait()
>               -> wait_for_completion_timeout() =20
>=20
> For spi-mt65xx:
>=20
> spi_mem_read_status()
> -> spi_mem_exec_op()
>   -> mtk_spi_mem_exec_op() [via ctlr->mem_ops->exec_op]
>     -> wait_for_completion_timeout() =20
>=20
> Peter
>=20

