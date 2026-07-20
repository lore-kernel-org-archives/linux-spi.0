Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E01400974
	for <linux-spi@vger.kernel.org>; Mon, 20 Jul 2026 11:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784547960; cv=pass; b=XLX74slTSvQdiVohxRMIGe68z+e4iEXaY2lyaOyDsCQVxeYq8ChzEer9syL/JVTsjNwB8TMGKdGyec6qiZPJ/3urlAlSbKxUgCQEs0VWzzJntmzuZxJQ+RK0yF0yvXy+cprrJ0XP4MLG2+2zKQuaipfsw/0BmgB3TRw1c75llYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784547960; c=relaxed/simple;
	bh=O7GkuCmMPHFQEK9+vFlexZsM1aV7dbx4/uIBOAgzkVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bEW/Ps6yqMDg4/+54rcs7OL1uDyZR9gwU5r/ZCWB1sH0jd0apIdAj8acs/WnIrGXbW97FieqBV6Kb93dO37atGlE2DGjI1/KSPsivI3duQABw+MjkXDMYsZDVfvKyTlEweYFnJswatD5XMq12yf9zdqF3MANIbAJNOlMivExhe8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQCnKn/Z; arc=pass smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQCnKn/Z"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47f703a9e5dso381237f8f.0
        for <linux-spi@vger.kernel.org>; Mon, 20 Jul 2026 04:45:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784547955; cv=none;
        d=google.com; s=arc-20260327;
        b=Lo9V4YLfjVR9aIvtQeoKp9LCv93V2OkWEcIHiopYNXBSpMjv6U6NNoRYLd7uDjveuJ
         l8rh+5bKcP1AZKtW7FAwHJOVB5iiJi4XUye8LZp6yK8Agxas5TpcXN2rrPQBDlJvmYuR
         4th5Ce0Yb8VwaSz2zpeFkJweRkN2pwM4RfNB0tlKdIubNNAsd0AqoADPccyM2yYa65lM
         ZA9QGSKHh56eUURZi1u0ibXiK1Q+Z5Dr+wqIBGzkWqV1k3zZs8oznVuAr7q7plk91dbZ
         6QYsnK15yb2TF22IDk/e/Urmmde9mHNrtZL/BWL3Sf8ZkOdU3yMD48Oqb0r1zLi2UPzL
         p9OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=O7GkuCmMPHFQEK9+vFlexZsM1aV7dbx4/uIBOAgzkVQ=;
        fh=39qYs9BFqByMOuLVB9IBKrtdK4G55PTa8SlpvCG2IMA=;
        b=WlzJK1doYnBi530v38/6gHwoYLlSgBVP6PtjEelSydQTKr++2KdvSHFX91NOUzndyk
         rfckGwj5J0owmZubRlnlJ5e22oNYKkHUQFOIu59KhF/RSUDnSB5shiSvtFVeoZiAVvCC
         CW6Tkmd7PllCS4lIXLOvw+xnfEz23UsGqK/DzEBNdTOTDbrGqugSxCrDCDTyACmIhXDu
         GW1iAyFIwV7acSzRpHKBtmBDKkyKaQJnVpJaaAextRjO1QS7neA3KaPg4tMLoSkzB3Xf
         G6g9EdbkvaLzNi9HnZqb81byPea+ZU1y+Z5eCH8023BDnS1AqJ5gJ6XdGaC/+B1X/gio
         kYMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784547955; x=1785152755; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=O7GkuCmMPHFQEK9+vFlexZsM1aV7dbx4/uIBOAgzkVQ=;
        b=IQCnKn/ZUMiaoiw7n2A3OQ0zL9Oi8UGNmcOlHjdVNZuIjzGsrMRjFID8v9lmKsNLzc
         Kz8ROHOTPSC9F3OgLDtexAVxGPJEjJy468C9I7xfltEG/qT8wH2LnL3QJn7O7YPDnm63
         54nZz9zlpcwvuxnJz2y0aPvLOdy/gr7YdSOseHIw5fMy6wIEEXwd7UXWMhN+ikMIn3hq
         OuptsuCsSbbScdqTOBW1YYFkXIjwNpON14+vQt3d5y/6cwkwKcqW1fiYAAUx3IIFj6TB
         aHi2L7s+VLPysLEr66dq5nA7Matf8QVQVknnpTxD+onqXlutwiQkqkvAvy2hwLJSNROl
         tagQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784547955; x=1785152755;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O7GkuCmMPHFQEK9+vFlexZsM1aV7dbx4/uIBOAgzkVQ=;
        b=SvCF3FP/WdISPAf8uUIv+vQMGW4EJxftxuVC8a5fVLLsxa1GecMz/kVpJGUfTSJ339
         gbEpNLrEMoT/4ceTGIZkYeQwCv4/uD7dvAsEI1AYWktvYznbUu+D/JxfJfkVn19mmInT
         QcmPfwotqGW5mzjSsNbpnZm3q66ksYVE2zimB3wxDJE3H5GUT9mkqnHkycrVSmKVQ+/m
         wXt11fHfhKgajhv6w1KVgLWoWYftJbg1xtgM42hRsurc/5SBN8qIyBDbzQex7CuffPj/
         FYsa8F7SALJa8E7fPDBZr6gUVnSof7sllQ+QYsIYPJP6a0b61L+QZ9iXOO6kESfTL+rG
         CyLA==
X-Forwarded-Encrypted: i=1; AHgh+RrRkqzr2ocYVcpLRt0Me45hVooFuU4d6x4Tj2Mh4Ow2RtJ/b8NFvRQUZRW+Y9n0NS+PP0vLEEvivNA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnYQSPpxZR5apzXwRGA7RlbQ0+S+d+jRnnsCKJjqXI2D7X+PrY
	h3drSiibVM2KNJlpdD5LbqgZSBdSuovVCsELeFxdj7BrQi46QfWB42gYxygVZqnA5mY3JpnDRrG
	Y4gt6I3mNkdo9TauTh2nUGes1aZ5Kynw=
X-Gm-Gg: AR+sD10ETtvoL8eoaU5Ad0EaSUBjMXvdacx0xPDufIX0SxaqV/EybOIjZ1LtEhksWfD
	cPZsROCWx0nEDYkvAvuhdOiT6n31meyJ0e61LyMk95sNU4sNS2VVVJrwijwbJNHbJMwvMjGSRV3
	yid0uArufoactTyMgqZixzuObhN9d09hA6/605kcCE5A6xGwzuRqjHDTC/vUG6xAYewLbSjUqpw
	4zH+h/JoREAPbdZ/SWTBAE2lf2o4voVYrN7RD0Fy2m0NuBc43pyeleuutDfmBsYf96cA4POZEbJ
	QjZEHztyoYiDMjCq0hVmGShPGOYcd5YU1+as/5Z9D2WP9R0=
X-Received: by 2002:a5d:5d82:0:b0:47e:9f16:c0bf with SMTP id
 ffacd0b85a97d-47f62326f0bmr15817313f8f.30.1784547955341; Mon, 20 Jul 2026
 04:45:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715222417.2997712-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260715222417.2997712-7-prabhakar.mahadev-lad.rj@bp.renesas.com> <2a5439f1-11e3-4194-a1b8-f00d0a8333b5@sirena.org.uk>
In-Reply-To: <2a5439f1-11e3-4194-a1b8-f00d0a8333b5@sirena.org.uk>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Mon, 20 Jul 2026 12:45:29 +0100
X-Gm-Features: AUfX_my1Bz6eT87w37fWrzlXt1YHwrR0JFt9wOo0WteIhJRrlaxYxVnCyVuhPH4
Message-ID: <CA+V-a8vdrhnZs+1WyVxWJ7Vr+2A2_3zsw1z6bNUqvGi4OGHH0g@mail.gmail.com>
Subject: Re: [PATCH 6/7] spi: spi-rpc-if: Implement 200ms runtime PM
 autosuspend delay
To: Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, linux-renesas-soc@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Prabhakar <prabhakar.csengg+renesas@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mark,

Thank you for the review.

On Sat, Jul 18, 2026 at 2:14=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Wed, Jul 15, 2026 at 11:24:16PM +0100, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Enable and configure the runtime PM autosuspend infrastructure during
> > the controller probe sequence to safeguard chunked flash operations.
>
> Acked-by: Mark Brown <broonie@kernel.org>
>
Since there is no strict dependency between the rpc-if core driver and
spi-rpc-if patches, Krzysztof asked about the patch order/routing.

Is it OK with you if this SPI patch goes via the memory subsystem tree
along with the rest of the series?

Cheers,
Prabhakar
