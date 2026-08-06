Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EF2448BA1
	for <linux-spi@vger.kernel.org>; Thu,  6 Aug 2026 19:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786044896; cv=pass; b=MYaKS95CVId8Ga+1yqWbx/A0KFSnkXKKr5/5Rbg5IeVyUBkRX1/GakAxNOdVGqUawkh2CN8aOba3mry7vCqPgA8q9n1RV38HKR+4KDNI1UrXk5YMhq75O5SCZef5a+yp9NuiIOiEZ5bYrup8pxcC7g/6OPBIthjvVLGy2dUYe8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786044896; c=relaxed/simple;
	bh=IPGYrL5YopGY6jHYZUjhq4IWDB6CwkF4f3RnyaldM64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nPjBNcgPkZNXLSf3e1+Cuk78NR2AI4bnnBix/hSS/uZyCUTcxRhf3fXNfxCb8FuoClVk9dvo27rmrK7frWiAdl/qb8hubM33M7M2EHGD2x6/HJVjdCK3aDBAI5tGnsqcvRiFsVy4Y+iwqK+VFFuMRjphJcN74fL6lDVeSB3P21Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z3DIe8FD; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3DIe8FD"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c1f5208b38dso466825366b.0
        for <linux-spi@vger.kernel.org>; Thu, 06 Aug 2026 12:34:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786044892; cv=none;
        d=google.com; s=arc-20260327;
        b=ba/jaTS1mC/b6hKm48tzGuonpP+5ubdfTrUucmyFpAmNFH+I+joefn3cNRRq8pbfCP
         jnb1qHm3vSUOZo07m7f9f+2fNC3xTzl7ajZR471sa5pkuRz1GdI5ww7zSZjlbpi56NaX
         TbYWXT8fFiwL+iXqA1V82nQISefZ6FD5CTTBstKvaruosxMFIh3tWtQ5OuK/Woj1kmyB
         dhtyn1lRkD5/MoalMAqTYHilgXphf9xejaHFzVQjQnPvMfh5HGUroHzFexE/M4Sp3GDP
         CADcybB/HPtPq8t8O7hUoGKIV8wZS0w+WuRCPPaea4ZlVK+25mCEz4ix2qZm5r0UsZYG
         mhaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yTybaho/RnG78AyalN7ANgkLVE3kyTSc7lUe0ekmOL4=;
        fh=9HxaSDyez3di68rNTGAsXLbC99xFXI23MKZtHSZcvac=;
        b=bX5OSMXH/Ey7N+LQaBOBjK23vO6bpM6sk591e5Su/BFbqwg9g+TedAVDaKP+0uK/1O
         Jk/Mitq1Rx92slFsyw3g3pZGVB6FOV/W1ECf6NgijQe1vuL2iheI6XELewOOLjCbhJSn
         c+ZS4yMHnf+/s4Zo8lJFScguqDvuVZCn/EmHY1FUdoWCI3OFNPmFwc1xwscM7lkBk4Qc
         Y27j3vm9QwW7wy4e5XC3baUICMFOkm1oMvMi40RoI1iwyzrE5t2B5yqOm6HUZZNuysGn
         SV4DSuj7jbX+/bLTQoqlDSgDuFs5LKo4YqUu9LHaSQ6PuEvoyi5j/ehDVV8rwwwz8P81
         1mLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786044892; x=1786649692; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yTybaho/RnG78AyalN7ANgkLVE3kyTSc7lUe0ekmOL4=;
        b=Z3DIe8FDKyQD/kvjrLm7w7C6mMPxiYK54QWun4v/xRe3L2ZPgWdxV7zLnUM9xgBLkZ
         0IN0fp9M7x3MCh9MCXigPOuWOXRfpEnMEr1x4/VUfR5gFh8zc4Ckm0XsC0fitwLtUss4
         sn2GMEUriC6dUMcMZnSWXO1lNB/gdSmR4MP1QyVX+5ltcecgNI2Aun5LEOwZ5taG5mt7
         WwfoiehH3nwRcsLYMBEo72/2Bi6v10jjX6vtlLyUUI+PU3U88N3NbqZGCYd7Vz2Cmme4
         SYrf1QMj3TifHKyqO2rpqtU97BVBLB4GufUt4DtmI+EgEABGSFYhfDIUCy+uzwE0pAzn
         V+Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786044892; x=1786649692;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yTybaho/RnG78AyalN7ANgkLVE3kyTSc7lUe0ekmOL4=;
        b=UH+FSEqxANkBYgTiuxbPX30+pyuC6rIQUyf21fikBibiR7lVT5TIeXKtgho0j91BFZ
         Y4OaBCqi8H4FYsJyrfTQgdXhZMMPkx+de1XwpJ6lcf3Rlq6VODahEC6NYaLL/PrcPNP6
         JEZtNOWKlbx+EJghrpn1WDB7nvo/lWBYIXx2gHUXZpeTw7i3d70J5cvsViw6V3FwE2WR
         7Ttt+vBjGDLFIBdTpWHhKKT7Nml55ZEI7hQLA6cJlq1arRNlQSqa2zN85R4JjEtf6mJ+
         lZqT0iDDf6Crz9EhzHGgHfpDSmTm3zxVojw+QR3PNvs7k8oxx0+pjxJyxNgBsgTvpCRT
         bQiQ==
X-Forwarded-Encrypted: i=1; AHgh+RqbbmEW77dokElWz//Hh43hLpbPIWDf+X2clFfrh9qOI1hoq7RdyqnMTNb2Jzlkpz3MxrklejTkbWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLGvRKZ/KiuUXZRkLvz1FNZtLhjADOwZP5bG3L/AhLdBisazbZ
	Ndc2wCKqGRMjsG4tW6rt2h2bGTcG72EVtdp78yCJhHMKuQSnLVGRzIU7bnuUxt9ALgpnYQcIx2G
	4kxPvwhgmlsrj7YuwUn9unzzy/Pm/b3o=
X-Gm-Gg: AR+sD13AOTvj83QouBECkVHSuMyFMU8idcacLq4TXuNB9fFjQPfflehA1w6ZPlJVuos
	xeCm/eLX2Bo/CHmUoVxh2yJtCKNXHkDKa1b9CLfkV1SxERUI38v0qt24+cG9GzOdC1AVR4QPPzK
	ThELsI/b15ArT6ZUoYExdD4Alp+qLEiX65E/6k4lKNisvZjtvIQ0JcASrvSNj5OF88wQsvlyXzM
	ZP0vEuXy1M0oSlegnAIMgpzmDUs3jpXG8y5039Zr8lKR8aWFfvcL0igwf6I2e20ByZh7dypLcvN
	lARH3Llxrm08GSk1IRjOvUfKMVYHB3vyM6+aBJbeUY6lLJraXERih1X/UBUvovNZYTfSiZdP0xs
	LfzexDVJuEpqJRFYBFK9iUm2Zcx/OLzMUBcZ/7QcrtGqixIVEkBhLPuaEhEdhj9CY2mD4PZUgDz
	HJfmX9HI6Zqh15QZQ5uFmAUhX+ROtMAQ==
X-Received: by 2002:a17:907:a0b:b0:beb:133d:cf02 with SMTP id
 a640c23a62f3a-c2039e29ef4mr932664266b.26.1786044892248; Thu, 06 Aug 2026
 12:34:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805151456.756579-1-jiang_hh2019@163.com> <20260805151456.756579-2-jiang_hh2019@163.com>
In-Reply-To: <20260805151456.756579-2-jiang_hh2019@163.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 6 Aug 2026 22:34:16 +0300
X-Gm-Features: AUfX_mzhpZOoP5SBgm7z7n7EE78rYd3qIr5_cLrLJQFQNkIrGO20BV3BHjV1M0g
Message-ID: <CAHp75Vf=riT4uCVrF+bHuAB-xCLV8wRZrn0WVVRsfxN_-0WAPg@mail.gmail.com>
Subject: Re: [PATCH 1/2] spi: Fix DMA mapping ownership on partial map failure
To: Honghui Jiang <jiang_hh2019@163.com>
Cc: broonie@kernel.org, andy@kernel.org, andriy.shevchenko@linux.intel.com, 
	fancer.lancer@gmail.com, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 6:15=E2=80=AFPM Honghui Jiang <jiang_hh2019@163.com>=
 wrote:
>
> If RX mapping fails after TX mapping succeeds, __spi_map_msg() unmaps
> TX but leaves tx_sg_mapped set.  If TX mapping fails on a later
> transfer, mappings created for earlier transfers remain active.
>
> In both cases, cur_{tx,rx}_dma_dev have not yet been updated because they
> are assigned only after every transfer has been mapped.  The subsequent
> spi_unmap_msg() may therefore unmap the TX mapping again or release
> earlier mappings using a NULL or stale device.  An empty SG table does
> not prevent the NULL dereference because dma_unmap_sg_attrs() accesses
> the device before checking the entry count.
>
> Publish both mapping devices before mapping starts and unwind all
> failures through __spi_unmap_msg().  This clears the mapping flags and
> releases each mapping once with the device that created it.

The Fixes tag refers to the commit that moved from per message to per
transfer mapping flags. Can you elaborate why it was no problem
before? (Not sure if we need the answer to be included in the commit
message, probably the cover letter is the best choice for this info.)

...

> +static int __spi_unmap_msg(struct spi_controller *ctlr, struct spi_messa=
ge *msg);

For a fix this is probably okay to introduce, but can we get rid of
forward declaration by moving the unmapping routine above? If so, can
you also add another patch for that?

>  static int __spi_map_msg(struct spi_controller *ctlr, struct spi_message=
 *msg)

...

> -       ret =3D -ENOMSG;
> +       /*
> +        * Store the devices before mapping so partial failures can be un=
wound
> +        * with the device that created each mapping.
> +        */
> +       ctlr->cur_tx_dma_dev =3D tx_dev;
> +       ctlr->cur_rx_dma_dev =3D rx_dev;

Does unwind routine nullify them? If not, there is a chance that some
code (maybe in the future) might use stale pointers.

...

>                         if (ret !=3D 0)
> -                               return ret;
> +                               goto unwind;

> +                       if (ret !=3D 0)
> +                               goto unwind;

Since you touched these lines, perhaps it makes sense to drop ' !=3D 0'
parts to make it follow the regular pattern.


--
With Best Regards,
Andy Shevchenko
