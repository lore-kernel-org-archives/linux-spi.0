Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36D335C188
	for <linux-spi@vger.kernel.org>; Wed, 20 May 2026 07:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779262725; cv=pass; b=GNdc49AFGDMuh2YwWdsA3hvvzYi5pOwlSbNI+T9SIxSEDEWNORauKWimGzpLK4J+2VSGhW/ItQvhKz265Od9YkvYe/ccR6LSDTmRbI+9bia8VZVCDMfSe+NJGBOelufRbMGbM+39x3qMarRTMBa6kHJ9sAFjHaohbF42tjupwpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779262725; c=relaxed/simple;
	bh=OKY7T+5LTeaeyopk0O60ZK8VP2UbO+XNmLdJ6p+Uopc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m4ws0tYImabnQYX95Bb4WL2ZFCd4CLGu6Zz/mjn8uUHpIcZov0XBIqi12a9YXA+TmDP1zgrj+wi+BXSs5nbXRTqkuJwvT+WnoC7EbH6grXyushEjCbWt9xrh/EvknUxKSOIllYkFOstt/CjAdnRT97N8O3hA8DkIZ0H08RNTKBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pcc.me.uk; spf=pass smtp.mailfrom=pcc.me.uk; dkim=pass (2048-bit key) header.d=pcc-me-uk.20251104.gappssmtp.com header.i=@pcc-me-uk.20251104.gappssmtp.com header.b=YHGi4rhg; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pcc.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pcc.me.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pcc-me-uk.20251104.gappssmtp.com header.i=@pcc-me-uk.20251104.gappssmtp.com header.b="YHGi4rhg"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-67fd8befac7so10845169a12.2
        for <linux-spi@vger.kernel.org>; Wed, 20 May 2026 00:38:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779262722; cv=none;
        d=google.com; s=arc-20240605;
        b=lHaD2LWmSQF3/IRdJUsIZwqnVOV06BY/tDfTLNJjWFt/roUaploqniwbDsNCU2KPFF
         gggi0spmPag8+50EoqlvY5UTAuIJf4rnGGj+zgLGc0Ub5BsNpxfPqhjxACdzVZJHOQbA
         53f9NGCVS+BS1SYYF8NgsW0RCJtwYBOqKD5lMeMj2ZMKpefwo5mEhrx9HTHti2XiRsDI
         KCRG/qF3Z5Dcx/FipO2ujjnKJxE4PamrzNaZeYehEvS9V4jQ+caWi+cNnBBIzFkjYCgH
         iBVNCiLGXE+kzRqD2tCSn9LOeTvW/1I9/z3BDSoxNZylTARhBDNgGqkaFffdjVbM/+Ol
         HgoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4I6Fd8+pRen8W82hB7C4CZsxS6Jwx5SGpDo+U4Vgxzk=;
        fh=t7uGFOPUnOefWF2eIuC6oGFH4Yidlav8sVXWHxon0+E=;
        b=PzurbQwlX5sBzSdvvk8lDOTdHH1sitnTe0lfz03GQBRA6PsWALM28mLf6qMS4Z8gU1
         JBP5hbylRXk1U0CUaiG9BAV+DRZhan0Gf9+GoPZ08hMd45rLpO6enzLOsfjKgdCC8pqp
         ywWluLTPJfFALPynguT1UUQv3BmsvAbQ4pW56Y4pbXfY+Xf9p4xelGaJw6Kg6LLQkbq8
         sWcAKcEZjkl5RUvGoskyVK2EipdlbcxRCfLL6VxzL7ZpMN9eeyyP/FnXtK+vTjkTKwc5
         Mz4r1zKpzXabD9kxbHtrQeOANixAl3yPCa2UWPrWgzztQdDVx7cy/ZSumuWOTTmgXfJ6
         Ye5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pcc-me-uk.20251104.gappssmtp.com; s=20251104; t=1779262722; x=1779867522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4I6Fd8+pRen8W82hB7C4CZsxS6Jwx5SGpDo+U4Vgxzk=;
        b=YHGi4rhgodh1vWNHKMVBfIvHtayJ5YNmn2VvE0KbG7qaCHt70bLm5ec1TDkvK5dhKU
         +R7CAkLic4otHnu9MhHNwAZpSo6uIYBYFqP+A7myqdwdYSS+sLgp5kcDmw2ybAq2MFAi
         Z5jeL/a+63DLbCbAPmhXdQAFvZfyJYqWg9XTSyMvVnBceNpLCiaVsLDKRis8iUysQPsE
         Cjd1pFOngtUW8iWLvwR5YQQeBM9S6QSv86xLTvum0GQT/kuLw2M8jcySsg721Mf7fDAu
         iyCwa9FO1j/E8Rh3i0x/5WCmP/jh4sAzkH1u0ATm2mAUQ09JzgDsp1+znPsbGL9IwBO/
         ZRrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779262722; x=1779867522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4I6Fd8+pRen8W82hB7C4CZsxS6Jwx5SGpDo+U4Vgxzk=;
        b=ZqlvuQYFwlAC9DHmhTxWMzDlldN09NbC0KErqfojx++0tu0vGunJzyxQNvDu8AfHpm
         mtseAKvCNmFhd9rIofcFJh7eY3/hdT7BaKe6eteiXRnmtfwE4ozKblVABDRyvSuoIMo5
         VJtligUGZ+f9Fk/mLp9klnOUvW00XaVsniZPPFjhPeDQVsdzX/+1eVe2J1mwP7OfHG+y
         5gL7/E6CbbU8ihnbf2PFiMBaWvk44gT6u8gQ2sJp0CDFuIdWTIJ90E4kgu0MoX7FVtTQ
         b2O9FDB47m3dMGwOQy1FqEqFAmlYr+Rt4PYOcDn1TKIWppKfM6nybep16fvMceU/xey4
         dmwA==
X-Forwarded-Encrypted: i=1; AFNElJ8Fn5ubVbm8T/lwJnz4x9yIkGcy5nZmAX/lO5/yL8ol5YT1/4u7344UEmAmbKkzyOZ1hXTPyl76qC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBJ7dAKSH32q3jkCnpbfqJA+z+hKrF6A9Gxo19ZVAPEs1V0zTL
	M+Fb3MEWm54YIWyY5SoYVAN4FLLeeF0wio6PvyaaeGMF3nZ3c/GCq4kbMKTEYNLmylK/y7PW5Mb
	7nyotFwYs1aFJrkYqgfRVX7GFM01x1f8PQRrWMJrl2g==
X-Gm-Gg: Acq92OGws9P3l2gKPobgRWHBAzpl5nwasFTQQ0ubwk37JQFhTH8xFk1s7v/9pFV6jTe
	M7p7U8saJ6GxByztGsoq1LTWCO+18OXTgKqoLqmFs0fLn3z1ctE01pLIoudv6UbJF5ub9wuJfO9
	+sop2byUx0qTWYlm3GVIeNChEzTAnLDafv4StJJs69Kc6TLmkut3rcXLLSq0iXoCaDm5UtRD4KB
	pw9o/x9nTUvXoh8JQ7DECd6Q4ZSx3yma5FoC5rPv2abpG47Dn5kv7DsSb7WJ2rZUkaedjJFkMgc
	/NDHJuO1
X-Received: by 2002:a05:6402:21ce:b0:670:8b30:a8a7 with SMTP id
 4fb4d7f45d1cf-683bad2a9famr9776226a12.0.1779262722002; Wed, 20 May 2026
 00:38:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519102446.209723-1-peter@pcc.me.uk> <20260519193543.18f45af2@pumpkin>
In-Reply-To: <20260519193543.18f45af2@pumpkin>
From: Peter Collingbourne <peter@pcc.me.uk>
Date: Wed, 20 May 2026 00:38:29 -0700
X-Gm-Features: AVHnY4JRX6sDcfHDi2h4ue5zqHRFzubsqC5j0MBn2SayLmDmlskHFNehZd3Tx8U
Message-ID: <CAPQLkRit9bRH2gnSpvt60evu31T=1YNFdTFH2emS6RSsY=eDJQ@mail.gmail.com>
Subject: Re: [PATCH v2] iopoll: use udelay() for initial polling
To: David Laight <david.laight.linux@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Christophe Kerello <christophe.kerello@foss.st.com>, 
	Patrice Chotard <patrice.chotard@foss.st.com>, 
	Boris Brezillon <boris.brezillon@collabora.com>, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jani Nikula <jani.nikula@intel.com>, 
	=?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, 
	Simona Vetter <simona.vetter@ffwll.ch>, Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 11:35=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Tue, 19 May 2026 03:24:46 -0700
> Peter Collingbourne <peter@pcc.me.uk> wrote:
>
> > A short polling delay, such as the delay of 5us
> > (SPINAND_READ_POLL_DELAY_US) provided by the SPI NAND driver,
> > can become a 1/HZ (order of ms) delay caused by the usleep_range()
> > call in read_poll_timeout(), significantly reducing SPI NAND access
> > performance. Fix it by adjusting the read_poll_timeout() macro to use
> > udelay() to delay until 1/10 of a timer tick after it is called, and
> > only then sleep.
> >
> > Fixes: c955a0cc8a28 ("spi: spi-mem: add automatic poll status functions=
")
> > Signed-off-by: Peter Collingbourne <peter@pcc.me.uk>
> > ---
> >  include/linux/iopoll.h | 30 ++++++++++++++++++++++--------
> >  1 file changed, 22 insertions(+), 8 deletions(-)
> >
> > v2:
> > * Fix it in read_poll_timeout() instead
> >
> > diff --git a/include/linux/iopoll.h b/include/linux/iopoll.h
> > index 53edd69acb9b..2ee89b76f072 100644
> > --- a/include/linux/iopoll.h
> > +++ b/include/linux/iopoll.h
> > @@ -19,9 +19,11 @@
> >   *
> >   * @op: Operation
> >   * @cond: Break condition
> > - * @sleep_us: Maximum time to sleep between operations in us (0 tight-=
loops).
> > - *            Please read usleep_range() function description for deta=
ils and
> > - *            limitations.
> > + * @sleep_us: Maximum time to sleep or delay between operations in us
> > + *            (0 tight-loops). Please read usleep_range() and udelay()
> > + *            function descriptions for details and limitations.
> > + *            This macro will delay until 1/10 of a timer tick after
> > + *            it is called, and will then start sleeping.
> >   * @timeout_us: Timeout in us, 0 means never timeout
> >   * @sleep_before_op: if it is true, sleep @sleep_us before operation.
> >   *
> > @@ -35,11 +37,18 @@
> >  ({ \
> >       u64 __timeout_us =3D (timeout_us); \
> >       unsigned long __sleep_us =3D (sleep_us); \
> > -     ktime_t __timeout =3D ktime_add_us(ktime_get(), __timeout_us); \
> > +     ktime_t __start_time =3D ktime_get(); \
> > +     u64 __delay_timeout_us =3D 100000/HZ; \
> > +     ktime_t __delay_timeout =3D ktime_add_us(__start_time, __delay_ti=
meout_us); \
> > +     ktime_t __timeout =3D ktime_add_us(__start_time, __timeout_us); \
> >       int ___ret; \
> >       might_sleep_if((__sleep_us) !=3D 0); \
> > -     if ((sleep_before_op) && __sleep_us) \
> > -             usleep_range((__sleep_us >> 2) + 1, __sleep_us); \
> > +     if ((sleep_before_op) && __sleep_us) { \
> > +             if (__sleep_us <=3D __delay_timeout_us) \
> > +                     udelay(__sleep_us); \
> > +             else \
> > +                     usleep_range((__sleep_us >> 2) + 1, __sleep_us); =
\
> > +     } \
> >       for (;;) { \
> >               bool __expired =3D __timeout_us && \
> >                       ktime_compare(ktime_get(), __timeout) > 0; \
> > @@ -54,8 +63,13 @@
> >                       ___ret =3D -ETIMEDOUT; \
> >                       break; \
> >               } \
> > -             if (__sleep_us) \
> > -                     usleep_range((__sleep_us >> 2) + 1, __sleep_us); =
\
> > +             if (__sleep_us) { \
> > +                     if (__sleep_us <=3D __delay_timeout_us && \
> > +                         ktime_compare(ktime_get(), __delay_timeout) <=
 0) \
> > +                             udelay(__sleep_us); \
> > +                     else \
> > +                             usleep_range((__sleep_us >> 2) + 1, __sle=
ep_us); \
> > +             } \
> >               cpu_relax(); \
> >       } \
> >       ___ret; \
>
> How about:
> #define poll_timeout_us(op, cond, sleep_us, timeout_us, sleep_before_op) =
\
> ({ \
>         u64 __timeout_us =3D (timeout_us); \
>         unsigned long __sleep_us =3D (sleep_us); \
>         ktime_t __timeout =3D ktime_add_us(ktime_get(), __timeout_us); \
>         u64 __delay_timeout_us =3D 100000/HZ; \
>         int ___ret; \
>         bool __expired; \
>         might_sleep_if((__sleep_us) !=3D 0); \
> \
>         for (;; sleep_before_op =3D false) { \
>                 if (!sleep_before_op) { \
>                         __expired =3D __timeout_us && \
>                                 ktime_compare(ktime_get(), __timeout) > 0=
; \
>                         /* guarantee 'op' and 'cond' are evaluated after =
timeout expired */ \
>                         barrier(); \
>                         op; \
>                         if (cond) { \
>                                 ___ret =3D 0; \
>                                 break; \
>                         } \
>                         if (__expired) { \
>                                 ___ret =3D -ETIMEDOUT; \
>                                 break; \
>                         } \
>                 } \
>                 if (__sleep_us > __delay_timeout_us) { \
>                         usleep_range((__sleep_us >> 2) + 1, __sleep_us); =
\
>                         continue;
>                 } \
>                 if (__sleep_us) { \
>                         __delay_timeout_us -=3D __sleep_us; \
>                         udelay(__sleep_us); \
>                 } \
>                 cpu_relax(); \
>         } \
>         ___ret; \
> })
> Which I think is approximately equivalent.
> But I'm not at all sure the usleep/udelay test it right.
> 100000/HZ is a strange number of usecs; for HZ=3D100 it is 1ms, but for H=
Z=3D1000 0.1ms.

The idea here was that since the sleep time for usleep_range() is tied
to HZ (or so I thought, see below), the delay timeout should also be
tied to HZ.

> Maybe it should be more like:
>         u32 __delay_timeout_us =3D __sleep_us > 20 ? 0 : 100;
> so that you delay for (approx) max 100us if the interval is less than 20u=
s.

I think that makes sense.

> The is also a mismatch of long and u64.
> I don't think anything (except the time_t) needs to be 64bit (esp. on 32b=
it).

Ack.

> I'm not sure about all architectures, but I'm pretty sure than on x86
> usleep_range() is independent of HZ.

Right, after looking into it more I learned that the hrtimer should
usually allow usleep_range() to return before the next timer tick.

Which, as it turns out, was not happening on my target device because
the kernel was configured without CONFIG_HIGH_RES_TIMERS. After
turning it on, the performance issue is fixed, even without this
patch.

For me this raises the question of whether CONFIG_HIGH_RES_TIMERS=3Dn is
always a good default. On x86 (except for ancient microarchitectures)
and arm64, the architecture provides a guaranteed hrtimer, so to me it
makes sense for it to default to y on those architectures at least, so
that users who write their own config (not defconfig based) will avoid
issues like this difficult to debug performance issue by default.

If we do decide to turn it on everywhere by default, it may be worth
reconsidering whether we need to delay in poll_timeout_us() after all.

Peter
