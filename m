Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D8440149E
	for <linux-spi@vger.kernel.org>; Mon, 20 Jul 2026 11:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784548683; cv=pass; b=lZWAYxYEBmSw9RWx9la0q73TTJZ4B+IJuIt4CUfVD1d+YVjh9Wq8uM6k4jYCCu+PAow45cjFr5CswvCBs5acix8YuZdgyuJluyDf49JSNZtr0aO07CO7PAJhWznIqFou2TJtu+xqqLaGyBgvpWn48vsTTsHCen16QNlOInVVyvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784548683; c=relaxed/simple;
	bh=U3MDi5hJMY6ca1k0390hq0Y/jmz8ekEa4Ii9/SfAqSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZRKZtwYsT/makgslhtPf+yC+6GCm8uMfflWQ8d3WhGgkI0kXBcmTOfkw0HvCeiDvNVU0WyYGi1Onglu7wPRXJSpuZJae4140jz6TVet7M85zyQWaQ6lGxCpEKTA/YsZnDIN2rjxFRskiJBpdOUrPQLclDy2Tp7JPBDzD99QSAe8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nJQ4dr34; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJQ4dr34"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47f633e6058so2667945f8f.0
        for <linux-spi@vger.kernel.org>; Mon, 20 Jul 2026 04:57:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784548677; cv=none;
        d=google.com; s=arc-20260327;
        b=gr8JN6Fnhowxe/o2GhYhPuoETP5eTl3WSRGlgv2ePHxer8+QY//jdicO9GHBFg2TC6
         zl6ouzSXKUzJ2MwyLR5kQsFk1b8k2I3uFEO3+aqX89hWmbFNZni0HXxJD/KydSdr251J
         Ux1naMTrZiLJsWp1HI0u9QhnYhS65liGpvdz1pBQsbaw34ExnjVLImj5YYrkonYFadGM
         rzjDYAb3dAXJDaSQG6avFpHiVRW3w5EKtd4NeRMV5IhO1ADcbmf7ObzUquRtuFwwp4Ok
         3fPZGtJWW2cLqUHONMTe9ZyKxZuUkrPo0SboqIwcrH31ofUqzfXL4o6ZuxOY8BuxrBAz
         JOyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U3MDi5hJMY6ca1k0390hq0Y/jmz8ekEa4Ii9/SfAqSE=;
        fh=nMjAUcT4nswnZ4s3/yYi8d4mmaVX7WsJzsAQmIRiwrA=;
        b=G7MpqMMgxl1bJPn0iUNCRN3Do6wTKgK6MC3g4es/FyccvgHrGABV6yae3qEX4LT9ZO
         Prbzk8DxNIX2vqWlcmaQ2qh0ncsKTEpQ9tVB1iFnEKB+Dk5s9Pu9bDq9rBix/uhpjegN
         VlK5EfHiyRhR+PDVXljjXsIp+zzycFpD7jkZLqS/6gCv0/uEC7yVvoctbrzzAAWCjISM
         XahC2NBu8kCv9kBS42niXpyQ2H+jDUvhLIRj6EtKVQN/d0iCCxC+xTkVNzVVVoE88Rvi
         t9pvyKu6ukf/GbiUEuBJvYzXKn6Jh/stnrjH9lYZQCQj0ZuqaSds6dblb8xc5hBUz3NX
         QkYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784548677; x=1785153477; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U3MDi5hJMY6ca1k0390hq0Y/jmz8ekEa4Ii9/SfAqSE=;
        b=nJQ4dr34PzaYP8GBe2B31BqvIATjvjUKZaTPb7C35cNrTZpdq7SAbLJ4NCKZmNntbR
         XdTF23GnVsZVCjpa72RZSuAqyceabRqS2mUaOcTvlnTcXMQFsdw3zmB70/uQ/eX0FlEo
         sZydQs0EoxOhDr6uZjn0TPO9Tois1sTD17hk4lzyEBeApJLaxCSsUMU+WZwCSaahDMQF
         +KScP5B5uf/+rJLbVuxMBuGhEy4Uyr7E9ZSfWiAZdcEsyXMDX4JSVjerahSnIMJqEy1b
         ucHtfvCjV7WT7F3PXZEBEjEP4RsxrmzEHBg2vWlR/LLV5Uv2t4JFfgWFGKs21emXCdtM
         y05A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784548677; x=1785153477;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U3MDi5hJMY6ca1k0390hq0Y/jmz8ekEa4Ii9/SfAqSE=;
        b=h4pcG/FNTuW04tJNz+Xp6tuW8vMcrFYxIQ/FSzNulEC4Vz5UYCuSGm6Y7bStd3kJux
         Q/+vxqe2tHr/dE8p9NDj7Y41LE8N+ixBCiiXfIvQNePueY5peI6cb7kDVn26WNBD6mWX
         6WD0Bxi7EIRMY5nCJmnpxtJds/EHTYj6bcvvls70hNGDFlipH/SfOo6/N5rtRm1gj0U/
         EdPXMcICezF/oBNUqjMDhjuvSooZ84xEdXhhZClF2oHxvoTTl2klbNdnwj092cNJUq0q
         2Xx1o5/am6FmYzrTMd4p6XSKYjL8wikG7YybjGQab8A1Q+CcR4P76hBmyxoNnrOAsw3S
         76JQ==
X-Forwarded-Encrypted: i=1; AHgh+RqnwRsx646Pyezb/zt8MKqzrSRQRIzFlxmQzcajPapX1Oe5O2raP7XwzdIEfjU69rECLNTWtc1ldOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMZfFiDU7MQYMsj9NsB6vlFY8MJ6EpvyEUhkE6+ZmriAG3XmQy
	xgnk4eX7K2alX3joks4c5cLNXsdr3I+dW2CNzKPsoSZrk9wV86HemWTQ2ua9VGM88FbTKvQjcnq
	Eg28qUqrzBX7za9s5quF5X/sB8jQ9stw=
X-Gm-Gg: AR+sD10c4MCvxtxuetkZPzl0D5O+tKp/3I/M3EOyBid5gasszT1MHZTFJ/WCUWHBrGR
	lsZjA28nLxyl351lxG9wnDho0pINy5Ywxx9Ow5+9+V8+CbBONh4vVa3hU3TDphjhuaC9hEqDaIh
	aDilToM7W1JUM+WVt1Nr6imzepRZfiEbC0mTn2+pnIDfKux9LhAV4mP/rSc62scEWzc2WnsjFD1
	4tjkaTOmpHcdX3BRUlaA5sbHu5TGH7PuDkJVNlCsnV9MQCNQI8YO6WO6h2IhCvQpIem6MsCK5Uy
	RSx7fQIOFnjfyuhGkchj7TPW0e2KLiMPQAJoDVil2T6PhuQ3A/Vp2665PQ==
X-Received: by 2002:adf:e010:0:10b0:474:cd60:1154 with SMTP id
 ffacd0b85a97d-47f6232c9c2mr11371166f8f.41.1784548676698; Mon, 20 Jul 2026
 04:57:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715222417.2997712-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260715222417.2997712-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <2a5439f1-11e3-4194-a1b8-f00d0a8333b5@sirena.org.uk> <CA+V-a8vdrhnZs+1WyVxWJ7Vr+2A2_3zsw1z6bNUqvGi4OGHH0g@mail.gmail.com>
 <0c5248e0-4141-498a-ba01-e6c4225b28ac@sirena.org.uk>
In-Reply-To: <0c5248e0-4141-498a-ba01-e6c4225b28ac@sirena.org.uk>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Mon, 20 Jul 2026 12:57:30 +0100
X-Gm-Features: AUfX_mwFG40CBE6m7kuvfozDrhqMm7gmP9rkxoPyUwFPflVTPvbFZFy_oEFc730
Message-ID: <CA+V-a8u+Pjgvqprt6kupDc-A4ewMS=B3SqSQ85jwg7EYV4hGQg@mail.gmail.com>
Subject: Re: [PATCH 6/7] spi: spi-rpc-if: Implement 200ms runtime PM
 autosuspend delay
To: Mark Brown <broonie@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	linux-renesas-soc@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Prabhakar <prabhakar.csengg+renesas@gmail.com>, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Mon, Jul 20, 2026 at 12:51=E2=80=AFPM Mark Brown <broonie@kernel.org> wr=
ote:
>
> On Mon, Jul 20, 2026 at 12:45:29PM +0100, Lad, Prabhakar wrote:
> > On Sat, Jul 18, 2026 at 2:14=E2=80=AFPM Mark Brown <broonie@kernel.org>=
 wrote:
>
> > > On Wed, Jul 15, 2026 at 11:24:16PM +0100, Prabhakar wrote:
> > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> > > > Enable and configure the runtime PM autosuspend infrastructure duri=
ng
> > > > the controller probe sequence to safeguard chunked flash operations=
.
>
> > > Acked-by: Mark Brown <broonie@kernel.org>
>
> > Since there is no strict dependency between the rpc-if core driver and
> > spi-rpc-if patches, Krzysztof asked about the patch order/routing.
>
> > Is it OK with you if this SPI patch goes via the memory subsystem tree
> > along with the rest of the series?
>
> That's what an ack menas, though if there's no actual dependency I could
> just take it.
>
Got it, thanks!

Please go ahead and take this SPI patch through the SPI tree. I'll
split the series for v2 and send the remaining core rpc-if patches
through the memory tree via Krzysztof.

Cheers,
Prabhakar
