Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282E73612ED
	for <linux-spi@vger.kernel.org>; Thu, 21 May 2026 05:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779343180; cv=pass; b=p6i0V9pU7D9FtxdX27R2Eyfmy733oXwTJbF6/srg3dfnP33If+i6lU1/2VRJB1lzv4YmE9Xvba7r7rvy69q0EJ3u88OcAAi6OnbsN9zXS4OHlQwmNSFsjFOBiOUKhqqb4GqLxXstokeeAjSyeNmkfjP/SV/ccxvfoLggLzwxmSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779343180; c=relaxed/simple;
	bh=iDeyeAnCkrhHLsxohTPEN3fbu4WEwrpJuYTnU5OauYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NSLr2uXOlM/9i0m0a3gRkGxWZJLVCt1NUwtFmcHPR9o9yHHmbxEdSPC5+8WMf7fZEXL9CmuVMvJKL9NJwotKDtoOPLzXaCgawCrjFwrSqBpgA0eUhOQTRzp4jnab0BL42kIMnUi4Fm7lTd1I8oqbyd0Uy2TNE2ITN3udelAG9mg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pcc.me.uk; spf=pass smtp.mailfrom=pcc.me.uk; dkim=pass (2048-bit key) header.d=pcc-me-uk.20251104.gappssmtp.com header.i=@pcc-me-uk.20251104.gappssmtp.com header.b=jQOKqHms; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pcc.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pcc.me.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pcc-me-uk.20251104.gappssmtp.com header.i=@pcc-me-uk.20251104.gappssmtp.com header.b="jQOKqHms"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-672645dbfeaso7390238a12.0
        for <linux-spi@vger.kernel.org>; Wed, 20 May 2026 22:59:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779343177; cv=none;
        d=google.com; s=arc-20240605;
        b=DnhcJH+jpvggQOXMzGw4I0EAcQ3rVFgqWXBAz/iSO7NQ2mtoT3yv4it3UVKy7Ae6TC
         TLOj6gXqCFy+jFNHTnLGQUpkl+rD1xaGWLKl3/uajpU7uPHO5Vbi0JP2ZW61kda3wf54
         ZShvD2YK/jDqSXBmB2Ri++2vfyyJwvKJDA7OQ3QCcJk7PwFHHKDM4XepdNqgDtWy8ZQ9
         1i8EkVpHoKM2SVwVEqiygUvcJIFYSPjUXWLqeB9FHb28xP5bRzbEqmEmZyO9/nTNqkRs
         GMdxy3BB9twIHmUKU2AQrCk1AXtNx6OUeTRbvPzkRYremT8WBGDVL9XApG7YfF2O5eFf
         QXBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gee1Cl4743J9F/Xz6Axq+3xld3PGF4H/7dC9K2uF3Lc=;
        fh=yKGqCgMsgCEHAAZvYMwojbt7XRits8BLbzHkIS7+G7k=;
        b=VE7eYSyaB53+CoMhd/QDZxCGuErloP6menHAvyZTOf5xqDiuyk9Xj7bSE35AH0moG/
         0kAxu4URf4mT/EN++PymroEkl4ijG00piHtLJoi6wjmRF8H2yhb6yAG+rwuyDFGIyCr1
         ne+XR4fn1jkJk6ChP8UGFypp/QA3xEtCTOW48e6jc1/TMEW+4L93p1yksVcB7gpeT3KD
         /X0GuYNcMlfMyG5d4H73+zND+Hk7D3VIqhD4BfsPSBC6qn0mexhg3x5Ti3ZP2NiMfGK0
         esPZa9BVBc6R/P0tGdONksqM57qh1OPKkLoWrTgwI6u59vDkv3XK/0MFg5SoudroBUir
         U31w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pcc-me-uk.20251104.gappssmtp.com; s=20251104; t=1779343177; x=1779947977; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gee1Cl4743J9F/Xz6Axq+3xld3PGF4H/7dC9K2uF3Lc=;
        b=jQOKqHmsFrXfKV+aGs7Ckheay7QBiQAhZKnoJyxFett881eQ4bvhRgkfZNTYEdmhp4
         dqjJXgTKvRQtqm+zc77G4Gr0j75+WIMJScYIggsk1o6dh3Sg7siZ7P9s84F5F0ZSsqY/
         jYM1/QBi1A61fd59WkAP8z6LtDkd7XpzoXCW+GzUnecp6/jJc72MKHb6bJP5y153c90I
         zL2I4vzlY2zbgyqZA3wEAF/8LYT4VoYQ/b089ENfaMbEpUIXO7vYZHu+9unrOA83WWxN
         kN6/lr7NUwb+Y2u8bdmRSfNjVu5/zT9KXfSoftnSul4+/+1xgDwqt1TlQNSuSq7Pii3R
         TGSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779343177; x=1779947977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gee1Cl4743J9F/Xz6Axq+3xld3PGF4H/7dC9K2uF3Lc=;
        b=aDjKFCFHlG3+18dL7OMAxfdffwCWoeT7a0mK/iBVubq7imn6cBwI1B/TJMsv0/GOPE
         4VgaXLU48k0J/Ws5o8NZfOL8Fs9a9fTO0WCRukuHBA7yyM4zGY9XKUxOyqxifNuft3RD
         9oo5B81MjSLSaglvny7fUIlVJo+jwfYb7Dh5ieA96ggFu95Dz+CuNNy1iS5frfN+Bedm
         F0Pbvxl/0mixJ3IFlU0x31aF9pbsJ0bCO93iTiNYRmjeq8h9nYyF+XJQ/88Mrh2uqaTC
         mtlsePmIBA4uy4hv+yrVMRabY/400p6ZgvCTzG76lwnB4d11Fx4fzVXY/n5oDRRlCjE5
         xlxA==
X-Forwarded-Encrypted: i=1; AFNElJ+Dnb6LmOpPK220ZbnvoUMOjFoG844gDL33fDEeaW82S8LAJuV/mxN5BVYEuHXsh/V2F4/SC338J5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFHhp5dk1RrUuGJAB5u2+YSeRvJ72HDeHweCk1+zmHxIG3M/pF
	188OT/Yii10B218tGlIEVEf5w25wzBJoRU6CIoUglRtJOi+nJXOwwPjmL15EYVNmHETVupVoV9L
	AQyFSbEEVDsZeg/kKTB/zs8fxVvS/ON2KkhTcyktK+w==
X-Gm-Gg: Acq92OGoDjLKcDs8FHuvdcUsgUIie/EZ1kflOycXaOtdA0J3KfM4HT4EPNj4r54uITG
	d+lAET4ocYKQAqzEzc7cydIxR+9Io5UzMPqdXY7HG2oX3JUAu4uaC0NOJPGIYRHH4c6F94+cmMq
	AqkjGto+fUMAoRKKeSvHgiSVLyZ9D85/QKRQ1gJ5mZn22YNTVZ3Wx75Fj61VBTgEPzqYL8JWZTt
	g5S6/foxk+1D+allwYajQlZ9UeXPJ1+Ekl4gCpbzMy7g7IOwACcHuKj52Bo8dulgJmgNRovNLUD
	gS7eqh1R
X-Received: by 2002:a17:906:ba84:b0:bba:3cf3:2ba6 with SMTP id
 a640c23a62f3a-bdc14a6a240mr66996066b.29.1779343177192; Wed, 20 May 2026
 22:59:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519102446.209723-1-peter@pcc.me.uk> <ag23HbvCqhmK0Ph1@intel.com>
In-Reply-To: <ag23HbvCqhmK0Ph1@intel.com>
From: Peter Collingbourne <peter@pcc.me.uk>
Date: Wed, 20 May 2026 22:59:25 -0700
X-Gm-Features: AVHnY4JFvlhTAWLx9MZGuHJIpRn7ff7w_eNj6N0T5Cn18EksfFjfgF_770QvJ8U
Message-ID: <CAPQLkRhtdV5Whv3ZNtZ8Xwq5V0chaQ8_tUbh7VnTexezid6EfQ@mail.gmail.com>
Subject: Re: [PATCH v2] iopoll: use udelay() for initial polling
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>, David Laight <david.laight.linux@gmail.com>, 
	Christophe Kerello <christophe.kerello@foss.st.com>, 
	Patrice Chotard <patrice.chotard@foss.st.com>, 
	Boris Brezillon <boris.brezillon@collabora.com>, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jani Nikula <jani.nikula@intel.com>, 
	Simona Vetter <simona.vetter@ffwll.ch>, Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 6:29=E2=80=AFAM Ville Syrj=C3=A4l=C3=A4
<ville.syrjala@linux.intel.com> wrote:
>
> On Tue, May 19, 2026 at 03:24:46AM -0700, Peter Collingbourne wrote:
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
>
> If you want udelay() why not just use the atomic variant of the macro?

That's what I had in v1; we decided this approach would better handle
misbehaving devices.
https://lore.kernel.org/all/20260517150253.031dec09@pumpkin/

Peter
