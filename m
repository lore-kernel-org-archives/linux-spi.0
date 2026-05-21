Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD6427A907;
	Thu, 21 May 2026 07:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779347016; cv=none; b=dpCIwuPZU4/mBJSwP8by5dzsC1jShIjv4X0W7EFcf+kz9Auu72J8bigwNaKMpG5QBeBouH3oo0ROeFmjCH8UgqQDEeC0tLbDkeXvXAAXv9ACKUmH31t7LVV4j1cXyROTQcakmnLGNJ1crybx1z9HaD+YDqkc2qklzWORHib/jas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779347016; c=relaxed/simple;
	bh=WgErnIgDTOS4zKiZ9bN8jnkBqlXOj4MrC1VJg8U6i38=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sN6qKkS+zDHhe3nWziExQlRvRYHYJ2l7ZrrDgeJCALzVw9U8qrh/YcKksRYEfRpn2IzwFT3Qeag8NevBco9s+9eg5NATID3tHcbKTlOMi941W+bqE8uOcniKvgcMYeBWM+kPoGdvKnUWZdY/MRDHCRZw3VA3++jH8DmbM7LR5So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZfHxDM1t; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZfHxDM1t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779347015; x=1810883015;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=WgErnIgDTOS4zKiZ9bN8jnkBqlXOj4MrC1VJg8U6i38=;
  b=ZfHxDM1twhzrxPlDkh+T1D/2JkDpJ6BVVuRrh6wATOi9BpyLC7EaIMl1
   E3ovTpgupFyoPIU/5zf2uSYY0EG4s2piPGNrFS47Eo3djsVkW82IUMfqi
   9tDXEQpVXqhFxHu25XfJipD3voVvL3jwMQ+1xD5WbEVjZA0zV8iYzsqWk
   EDQvoNigIJhUCImnuJLDPOsNTqCl/V/jdtYawIJoL0kA31DABc+dilE6I
   Cj5wsJFOJD9wmXwq2kHFPPlhtARhRW17fqa8v55Q0E7+9N9stUneRq54e
   +PGWEMj9arP3s7bAa4H6CkTTVitb0yO0aHkzh6s4J/jx8vsZkhY/WS/db
   w==;
X-CSE-ConnectionGUID: +h5IZ/SDRJutG92L/VeJQQ==
X-CSE-MsgGUID: adFcZ8wAROC7rn//ORW6Tw==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="80160463"
X-IronPort-AV: E=Sophos;i="6.23,245,1770624000"; 
   d="scan'208";a="80160463"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 00:03:34 -0700
X-CSE-ConnectionGUID: eeIAOtEmRouOL/H++VxZPA==
X-CSE-MsgGUID: tg4jj+CIQoyR3ZnQQ+0P1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,245,1770624000"; 
   d="scan'208";a="263966012"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.34])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 00:03:31 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Peter Collingbourne <peter@pcc.me.uk>, Ville =?utf-8?B?U3lyasOkbMOk?=
 <ville.syrjala@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>, David Laight
 <david.laight.linux@gmail.com>, Christophe Kerello
 <christophe.kerello@foss.st.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Boris Brezillon
 <boris.brezillon@collabora.com>, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, Simona Vetter <simona.vetter@ffwll.ch>,
 Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2] iopoll: use udelay() for initial polling
In-Reply-To: <CAPQLkRhtdV5Whv3ZNtZ8Xwq5V0chaQ8_tUbh7VnTexezid6EfQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260519102446.209723-1-peter@pcc.me.uk>
 <ag23HbvCqhmK0Ph1@intel.com>
 <CAPQLkRhtdV5Whv3ZNtZ8Xwq5V0chaQ8_tUbh7VnTexezid6EfQ@mail.gmail.com>
Date: Thu, 21 May 2026 10:03:28 +0300
Message-ID: <d602e4ec24533aa239f04901574b4f4826640455@intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, 20 May 2026, Peter Collingbourne <peter@pcc.me.uk> wrote:
> On Wed, May 20, 2026 at 6:29=E2=80=AFAM Ville Syrj=C3=A4l=C3=A4
> <ville.syrjala@linux.intel.com> wrote:
>>
>> On Tue, May 19, 2026 at 03:24:46AM -0700, Peter Collingbourne wrote:
>> > A short polling delay, such as the delay of 5us
>> > (SPINAND_READ_POLL_DELAY_US) provided by the SPI NAND driver,
>> > can become a 1/HZ (order of ms) delay caused by the usleep_range()
>> > call in read_poll_timeout(), significantly reducing SPI NAND access
>> > performance. Fix it by adjusting the read_poll_timeout() macro to use
>> > udelay() to delay until 1/10 of a timer tick after it is called, and
>> > only then sleep.

What's "1/10 of a timer tick" based on?

fsleep() has simply 10 us as the threshold.

>> >
>> > Fixes: c955a0cc8a28 ("spi: spi-mem: add automatic poll status function=
s")
>> > Signed-off-by: Peter Collingbourne <peter@pcc.me.uk>
>> > ---
>> >  include/linux/iopoll.h | 30 ++++++++++++++++++++++--------
>> >  1 file changed, 22 insertions(+), 8 deletions(-)
>> >
>> > v2:
>> > * Fix it in read_poll_timeout() instead
>> >
>> > diff --git a/include/linux/iopoll.h b/include/linux/iopoll.h
>> > index 53edd69acb9b..2ee89b76f072 100644
>> > --- a/include/linux/iopoll.h
>> > +++ b/include/linux/iopoll.h
>> > @@ -19,9 +19,11 @@
>> >   *
>> >   * @op: Operation
>> >   * @cond: Break condition
>> > - * @sleep_us: Maximum time to sleep between operations in us (0 tight=
-loops).
>> > - *            Please read usleep_range() function description for det=
ails and
>> > - *            limitations.
>> > + * @sleep_us: Maximum time to sleep or delay between operations in us
>> > + *            (0 tight-loops). Please read usleep_range() and udelay()
>> > + *            function descriptions for details and limitations.
>> > + *            This macro will delay until 1/10 of a timer tick after
>> > + *            it is called, and will then start sleeping.
>> >   * @timeout_us: Timeout in us, 0 means never timeout
>> >   * @sleep_before_op: if it is true, sleep @sleep_us before operation.
>> >   *
>> > @@ -35,11 +37,18 @@
>> >  ({ \
>> >       u64 __timeout_us =3D (timeout_us); \
>> >       unsigned long __sleep_us =3D (sleep_us); \
>> > -     ktime_t __timeout =3D ktime_add_us(ktime_get(), __timeout_us); \
>> > +     ktime_t __start_time =3D ktime_get(); \
>> > +     u64 __delay_timeout_us =3D 100000/HZ; \
>> > +     ktime_t __delay_timeout =3D ktime_add_us(__start_time, __delay_t=
imeout_us); \
>> > +     ktime_t __timeout =3D ktime_add_us(__start_time, __timeout_us); \
>> >       int ___ret; \
>> >       might_sleep_if((__sleep_us) !=3D 0); \
>> > -     if ((sleep_before_op) && __sleep_us) \
>> > -             usleep_range((__sleep_us >> 2) + 1, __sleep_us); \
>> > +     if ((sleep_before_op) && __sleep_us) { \
>> > +             if (__sleep_us <=3D __delay_timeout_us) \
>> > +                     udelay(__sleep_us); \
>>
>> If you want udelay() why not just use the atomic variant of the macro?
>
> That's what I had in v1; we decided this approach would better handle
> misbehaving devices.
> https://lore.kernel.org/all/20260517150253.031dec09@pumpkin/

I think the problem with trying to adapt to everything within
read_poll_timeout() is that every step like this adapts to a *specific*
use case, and once it gets specific enough, it's no longer usable to
other scenarios.

Having to reimplement the whole thing in drivers is much worse than
having to do two calls.

Could a staggered approach work?

	ret =3D read_poll_timeout_atomic("short delay/timeout")
        if (ret)
        	ret =3D read_poll_timeout("longer delay/timeout")

Then you have better control of the behaviour in the driver, instead of
adapting a generic function to a specific use case.

BR,
Jani.

--=20
Jani Nikula, Intel
