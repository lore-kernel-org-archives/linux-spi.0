Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA42223DC6
	for <linux-spi@vger.kernel.org>; Fri, 29 May 2026 05:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780034380; cv=pass; b=DEMjRGJ7+3wIDejq+tKVRB09eaPlTiNrfkJw3okDezPSecy6STt/KlBNBCUSn68HjPtoTPsSap9Uop56QyFpvQyDNR1d/49CEYTJ13OFu7wnYPgKte9M9hZPjLxcdgp5SoQwA84wDi0IKutvfTWqcxVOnwgMd91J169bLQxubqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780034380; c=relaxed/simple;
	bh=XbEbCoUKFkv/QlOAe3EIQzSY3d0VX4qC8kYQIfkZAl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BJHD7Rx64Yx6GhheiHFBXih0p0jxz6TAdMQjTkp+2aVYrLVEazp+918taUuUNGos8nkXd79GfNKKLrNWP/rXOsohXSkQ23hXRSIi9+ZxO0tvS+FK7qqFinYx2k2JIGyub1wj3s7OkjSLzqyYeS25yeDhtO+NpfcelGdksXHWP6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pcc.me.uk; spf=pass smtp.mailfrom=pcc.me.uk; dkim=pass (2048-bit key) header.d=pcc-me-uk.20251104.gappssmtp.com header.i=@pcc-me-uk.20251104.gappssmtp.com header.b=Wm3vip9D; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pcc.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pcc.me.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pcc-me-uk.20251104.gappssmtp.com header.i=@pcc-me-uk.20251104.gappssmtp.com header.b="Wm3vip9D"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-67fd8befac7so6880138a12.2
        for <linux-spi@vger.kernel.org>; Thu, 28 May 2026 22:59:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780034377; cv=none;
        d=google.com; s=arc-20240605;
        b=JGR3Lz3EAF5ppqJ4QfaBOgh5jNkydZBCKy9s00wsetc8Pb0R1vrFfpM6Ia4w18brSP
         K+ZE2tQNnhIW+rgIbzoUryBNqO/fo3gLXwupKI3HoD/b/FOh4xmzEIzr6YSCU3dQpWXt
         Ap9AVjWVXMht9Pom3Ohg+Ff57hGfnmrDbWkxWANOGkO2wqiogQ1Ax9HzJrabUr/awTDa
         0xLpr9u4EyiRJqxOOlBhsF5kGgmKQXY+cBijp2eAu4tQXZaP7mgEk9qWD207yjRWF6bp
         K6N+RWvz8nckOV8zTJrkW1PhH/kAfO6s5NGgZxmlkaG2dNx8+xCp/duagcuk0xPjPOw7
         yAXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wK0Wr1IgTW5fyZ0hwRe/Lnnz0onEU2uOHWtezquju2w=;
        fh=XlTeyLswuKXN+AWNqaQtPlVQT98ZosyCInQIZlpwb1A=;
        b=RD27Yd4/1QHimHYkgzg4UQs4lEbGcFtcFRqxNVJKJDwcLyetqr+9SEn03r7rm1N0jX
         v2PkSQjZCf9kYCjwT76HMBo0Ai6HUijxDXvzuDX4wZfRdgmf6h3QUvt0L8VVjkjtAOf5
         KvgddLiqawDy8eqJcK1F67I9WvmWQEW7JEx2eHeNWtaxYaiaUWdq5EUTUi8oXBxgwI8/
         I3dNv6uxeqLg9JMtcExMLhya9UzivhpIbpo+5D6uoPfuTtPvdWDxOK+M+BwPv4oBQl9H
         62OQs9molBGdLTU2eaoDIM3s0AraqorWSHvu3TaGnqqs6Q15NhoK/1miasI70qjXiPhv
         P7bQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pcc-me-uk.20251104.gappssmtp.com; s=20251104; t=1780034377; x=1780639177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wK0Wr1IgTW5fyZ0hwRe/Lnnz0onEU2uOHWtezquju2w=;
        b=Wm3vip9DBsFJ1dsVSBarO27zqzmFZSA7B2MIfLl46O2GOY7OM4kT1P6Ga5Qo8sH2WG
         jh5MS7FYd+tTO1/+V5XJpTXwbgt7opKCnqV5Jr6lxZrHFSVqAsxWQkT3gyMhE0lbgOd3
         GVizxgyhmKlKdXeIlx0yKWKtM1LsKYLNR25LTwGWsbNU8ePOayooOWWDVKnhziVBorxv
         3lFHrMuzDe/e7PmRVR+hE+y3ptH0mZORiy2h0vivtBn75rzt6ntakkIDPps6AXhgZZ0A
         6mSRC6oVziKuZnSMuGys7vYtyJ3c5JxvIEVU713VUiVRar1HmurgRRcKMV0f8IgiODoF
         bREw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780034377; x=1780639177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wK0Wr1IgTW5fyZ0hwRe/Lnnz0onEU2uOHWtezquju2w=;
        b=AU9S0Q1FbQsSeElrTrqjoRZFYjgkoNrcAcx7U37qGpdroSKpYLE/zymXU8rLT5jYGO
         W1bp5JBf6v+UuMZ0I1S9z/2tjciS2WaFqmD2JrjRjIY+CULLhLhZPewcUDmAZec5NTlV
         Nv/eh8W9U+3zvBtIc/wRbEiQgoQOwhtHwRcZdX4tqqHmuRzBOIfNpK5+mhLJ6b62uILK
         ja5GU3Y03gAlJ7b0XUAgiqtA3svx2JZqcodZABMfPa3QoXCPpaVxbTy2M+m7DrNfEHCA
         E2t3glCRSlzMGllEsocpaQXj3U9Rh7Bz8DZj70dbk8e7cnv/wYWvJgb921rB5qP097dl
         pKxw==
X-Forwarded-Encrypted: i=1; AFNElJ9Rn26ADwhvsQLOLIWskzH2+TUZTwlGMvaNY+ODfcSfffUdAx0qnvoYAqkYuY3SqgsOeEF9zZHKt0A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6yENxxghe+gvLDQ7a2QqsWWAjEY6oQnj4tZDAAmtvSWdUByPy
	YAGfIzBEjvTtif/bWnN4rr8ChXZDYk2uFoNZoWmThQjAhGHVpbQ6csKxepG+2gT7ygQiS37PyUS
	2aztSydZILPoQ6rz2bkHzg+xXTAy13BbwA+GGcj+3vA==
X-Gm-Gg: Acq92OFHU+D4G+b3CVSJfZB08t4hPaWr/X2+B8CvlzvgBbNKn8sjx+8a2nXJvtiWH9I
	ml2ETpWusHff8yIFNlvYqEMeBF4zKQLA1GFfcy4UnHjxNl0c/QDGNfbTwTQGBU3gEGw5kZHkNQj
	cx3dYT3cb1jTFVozuIoW+lRkLQ/S5qwI4W5UENLQMv8bAD77blUZocwNUJQTtxscla7UYsL4LG/
	EJ8R5mM6zQChTbm9ZpUM7Fr9DTjN0zMZFSAXGMsgrsazgSHxziM+qF7z5Ai4x/PPnHgTrTNOdG0
	sHfTMnP7orkNvKAxrH5WcNQXwGtqRQ==
X-Received: by 2002:a17:907:db03:b0:bd5:156d:835a with SMTP id
 a640c23a62f3a-be9cdc3637fmr57505266b.41.1780034377275; Thu, 28 May 2026
 22:59:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519102446.209723-1-peter@pcc.me.uk> <ag23HbvCqhmK0Ph1@intel.com>
 <CAPQLkRhtdV5Whv3ZNtZ8Xwq5V0chaQ8_tUbh7VnTexezid6EfQ@mail.gmail.com>
 <d602e4ec24533aa239f04901574b4f4826640455@intel.com> <4e8d842d-790a-44ad-8b80-a0a8df1fde2b@sirena.org.uk>
In-Reply-To: <4e8d842d-790a-44ad-8b80-a0a8df1fde2b@sirena.org.uk>
From: Peter Collingbourne <peter@pcc.me.uk>
Date: Thu, 28 May 2026 22:59:25 -0700
X-Gm-Features: AVHnY4LMm6HvK-rZ_3YAPzqZS5rk0D059Dq0b3cTMRh5q00fppEXU6GEtUwdWiw
Message-ID: <CAPQLkRi1aP3N2d7GzrRfXF0xDyamt_n9AKzFvV1WdpNk0ZymJg@mail.gmail.com>
Subject: Re: [PATCH v2] iopoll: use udelay() for initial polling
To: Mark Brown <broonie@kernel.org>
Cc: Jani Nikula <jani.nikula@intel.com>, 
	=?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, 
	David Laight <david.laight.linux@gmail.com>, 
	Christophe Kerello <christophe.kerello@foss.st.com>, 
	Patrice Chotard <patrice.chotard@foss.st.com>, 
	Boris Brezillon <boris.brezillon@collabora.com>, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Simona Vetter <simona.vetter@ffwll.ch>, 
	Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 7:51=E2=80=AFAM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Thu, May 21, 2026 at 10:03:28AM +0300, Jani Nikula wrote:
> > On Wed, 20 May 2026, Peter Collingbourne <peter@pcc.me.uk> wrote:
>
> > > That's what I had in v1; we decided this approach would better handle
> > > misbehaving devices.
> > > https://lore.kernel.org/all/20260517150253.031dec09@pumpkin/
>
> > I think the problem with trying to adapt to everything within
> > read_poll_timeout() is that every step like this adapts to a *specific*
> > use case, and once it gets specific enough, it's no longer usable to
> > other scenarios.
>
> > Having to reimplement the whole thing in drivers is much worse than
> > having to do two calls.
>
> > Could a staggered approach work?
>
> >       ret =3D read_poll_timeout_atomic("short delay/timeout")
> >         if (ret)
> >               ret =3D read_poll_timeout("longer delay/timeout")
>
> > Then you have better control of the behaviour in the driver, instead of
> > adapting a generic function to a specific use case.
>
> If we're doing that it still seems like it'd be better to have a helper
> than just takes the two timeouts and does the right thing with them.  My
> original feedback here was that we should have helpers which encourage
> good patterns, and TBH I expect there's probably a bunch of scenarios
> where some fixed cutoff would be a worthwile improvement for very little
> effort on the part of users.

Thinking about it some more:

Do we really want to udelay() for the initial busy wait? Assuming that
we've decided to spend some time burning cycles, I think we may as
well use those cycles to check the condition so that we have a chance
of an early exit.

As an experiment, I open coded it in the SPI NAND driver:

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index a09371a075d2..cce34ada7611 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -1005,6 +1005,20 @@ int spi_mem_poll_status(struct spi_mem *mem,
                        usleep_range((initial_delay_us >> 2) + 1,
                                     initial_delay_us);

+               {
+                       ktime_t __start_time =3D ktime_get();
+                       u64 __delay_timeout_us =3D 10;
+                       ktime_t __delay_timeout =3D
+                               ktime_add_us(__start_time, __delay_timeout_=
us);
+                       while (ktime_compare(ktime_get(), __delay_timeout) =
<
+                              0) {
+                               ret =3D spi_mem_read_status(mem, op, &statu=
s);
+                               if (ret < 0)
+                                       return ret;
+                               if ((status & mask) =3D=3D match)
+                                       return 0;
+                       }
+               }
                ret =3D read_poll_timeout(spi_mem_read_status, read_status_=
ret,
                                        (read_status_ret || ((status)
& mask) =3D=3D match),
                                        polling_delay_us, timeout_ms *
1000, false, mem,

And it did in fact improve performance on my target compared to status
quo and even v2.

With hrtimers enabled, timing the UBI scan, 3 runs of each:
- With no changes: 0.784s, 0.779s, 0.777s
- With my v2: 0.687s, 0.686s, 0.687s
- With the above patch: 0.665s, 0.665s, 0.665s

So 3 options:
1. Take my v2 and change read_poll_timeout() to do the check during
the busy wait.
2. Adjust read_poll_timeout_atomic() to busy wait using the check
instead of udelay(), then change the SPI NAND driver to do the 2
calls.
3. Introduce a new macro that does the 2 calls, and have the SPI NAND
driver use it.

I don't have a strong opinion, but my preference would be either 1 or
3. I agree with Mark that it would make the preferred usage code
easier to write (and to read), as there would be no need to duplicate
the argument list or compute the timeouts correctly in every caller.

Peter
