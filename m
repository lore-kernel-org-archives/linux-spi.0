Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86ADF30BB94
	for <linux-spi@vger.kernel.org>; Wed, 25 Mar 2026 10:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774434166; cv=pass; b=deX+PfNf/6YH3Z7XoPvzJ2w7xQOEWl5w0orpop4g8cNcWWkDUNp5AHZcGlGelAI9lH9VCrhD1vBYmlkykNuErX10aV6WLfm1EUBLo3AW6jSqOj7kSUwwGk0ibVPLZVKpizRJHjovTR8hZlCmR3QxwwBKil9LjigxrdMFsKUFwGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774434166; c=relaxed/simple;
	bh=ak/OG2lAGEZSwH/OhUCjLYanzmvBa4sFEeeu6PK08is=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FYw/73y99/CpcJ04fyydp7E5hq+KG1Sgmifr+cqNjp9qrSEWvP6/L6dy07ukKPtzRph6t74j1Qks2NHEd2Sqne8oySrW8RUrHxkib6z8a5JWp30uIwlJyMpW855vkIHQfcicfzhT8hj0d/3fNb3Atlf1BYM9Wv80pREtkKGRxLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6E4VH7w; arc=pass smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6E4VH7w"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c7358a7a8d1so1415530a12.3
        for <linux-spi@vger.kernel.org>; Wed, 25 Mar 2026 03:22:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774434165; cv=none;
        d=google.com; s=arc-20240605;
        b=Q9rlMeM6x1mVhf8Q6RxIgBm+DRXDU4wWxbVCeGj6As+X7PIS+SJvtThWJHiDQeYnha
         YblX56NxJupUxPRNRDvhOX2ORlt/uBUyzO8R+OssqDRLg8cLs6O1bsyyWqWRTlJRnUrs
         TyvH80CTWEi1mSSZiZoZKXcT/XavKZlB34s931qzCTwSD31vKoXAaDeBmP4UUKfIGMhV
         6+oQX0n9Hv59j1r2vPlIXaMDhi2US3RCOkWtI9FhYfID4WmMODVuR39ibQvobDGHhs4h
         L8/bqYH3kkgSHoLlMJFzEsHyrktMHyHqiukQrS4slcxtUEuTdgq9FBSe30H3jex53sqf
         UsTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8nZJE6MXg4INlJLa4tIZbHcF5ur/snqPoQ3m4+4x9vg=;
        fh=fNinHbCHazAcoP+wbKhtfIDCAw3nVgVIB+X3rikTbpI=;
        b=acZ7scKu12QoK07I9S2tHHWZG3rFhnlkvSij9DPUUX9uzsJ2cXjdolkoTnkJNwEBQ6
         DrGX52TrcWLYUJ8Uo5YcQms1SW6/6jrRrn3BS5e78miqU5xCVg7/ZELMouSLPyd74TsS
         qb8EZOBCKDvXVqMYPnyImzU9C+2VMfezC3KIU0/VM/jFRCpcAd1rfPSkqoqrYK7Oj5OH
         Q7AqG/ZuwmHKOPAlqVIoMAAwXxhycyPc7lMlRWaFYLmF9ig2NxJQmiFCMppvvckk7bMg
         d1K9icPV4Sd5UUnvylcXTma7B6CspO1PRDACgGeqrL8D2zl2BhTjLnswE6QixBbCOJ3p
         iKtw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774434165; x=1775038965; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8nZJE6MXg4INlJLa4tIZbHcF5ur/snqPoQ3m4+4x9vg=;
        b=O6E4VH7wOExLa7+f/b/ys7NB52/uASNFyGqFR6dnNeFBuT9YALQZh80VNo4bo1q0PT
         A/yzWQsNo4FBWwLbYp+c7TIaq60NnJHR4Ued93PTode7AcbEzpd6am0dPWZHRYeFT7f0
         dl7WSPJ7HgAVhvEFys1irRxKRm+XBvA544q3j2cHf0s/YafzCMUk+x0kBAXW6IcuJYSh
         vAz9qlIThZxbqVnytLaemEOFiUjDCdssoWsO3dGPhoAN6/oelXRsb/sbHyR+Oxri3GjN
         MtkJcFTj4mLVZPj1R+zMSyG+uHLI7BO2jS1FYwoVIBKHiyWP2mV2mUZQtVMMS4CVcX0E
         unEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774434165; x=1775038965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8nZJE6MXg4INlJLa4tIZbHcF5ur/snqPoQ3m4+4x9vg=;
        b=GPvgYMRpv7IoQYoSFTwqr1T6t7cZx8GPHthahORC4qnjdo1LWqYnFIYx8MznLJ7C9p
         3REtJTArIDVhmLh/5zKL/6pZcWmn9Nd+iy5jJt2g1cJtJeWmj/TXl7JZnXS4AoZNi+xH
         2g/8tsJ6y7hmcBZbah31Nn6nlU0nhouS7geCY6k5NbgJ5FMDcMb869MRb16KKIlbSfbY
         gnBnqjhDXX/L1qNrub00KOaV7T84mbwpM3Kiq4oUzH2vv5bPawSsp7MbICN25hJdluBF
         WFMaODo3bFahKVbzYn/Phcw0Q054bXhkV8ZMyXch5bQKLCluZdwiprmx9vpynRLCOaE4
         9E6A==
X-Forwarded-Encrypted: i=1; AJvYcCXWzBU5qbYNm6WYaAcALPmwsTReCPlaum1bio2cdfUBNTz00mrw8KDFF1OY9qMqwZ6Ro/+ScOVfu3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyumrpQxC/a+1imp4w3kRWiazTGENa8eVAYlfpnDUeHgeQSmv57
	3t0dDsVKua3UvHdbmq7pd+R7fTxEuj1NpEwrhQ3bvOlrTmhaDroLbWKele7wlvmF58QWxr3nq4W
	vDmKN2y4RDhxVvweuE/7uiLB2+GIuRB4=
X-Gm-Gg: ATEYQzxFiYb7pFEBJ+prJSCenflH8w0gPwAzD9nuXAJLbiBRg1jtzTT10kWLG//mHiz
	TxhrZyiavOtWSAHjWdgi/G7VjouGUsOLZW9Ky7oazNIcHlah1/4DScP0vmN6CG5euoyC6tFzGEG
	VL2sCrVN4GIbTNV9XO1oIHI8UdTPnOsn4ukK3A2+Sxhbpo3b4oMFau/EF1rsTbTzUNv+sT3T4Pa
	F/2ewKeq06J01TEbLNtIdZcWXRKGkq3e5Gl9lxMZlE3Nq56zNRWqNOp1rWcYagKUftb3obOe1ut
	7N5Y2gw=
X-Received: by 2002:a17:903:37c3:b0:2ae:c795:6b4a with SMTP id
 d9443c01a7336-2b0b0987036mr34202215ad.11.1774434164682; Wed, 25 Mar 2026
 03:22:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <176797260995.67850.318976521283878747.b4-ty@kernel.org>
 <20260324145548.139952-1-ustc.gu@gmail.com> <acOw2lGiQbPr-MGf@ashevche-desk.local>
In-Reply-To: <acOw2lGiQbPr-MGf@ashevche-desk.local>
From: Felix Gu <ustc.gu@gmail.com>
Date: Wed, 25 Mar 2026 18:22:33 +0800
X-Gm-Features: AaiRm51YWFT8anCioGgl8yM1WeHNLe_RhM6XZkQVTolKhCp1zmENTHCNBVxy7XQ
Message-ID: <CAN4SLj2ybx6Hici+KDbfQScxOcoVSxV56mTncCn7OVpKVRXEDQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] spi: Simplify devm_spi_*_controller()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2026 at 5:54=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> > It seems has a potential corner case in this commit.
> >
> > The issue is that devm_add_action_or_reset() triggers its callback
> > immediately if the internal devres allocation fails.
>
> Yes, it does.
>
> > This creates the following sequence:
> > 1. spi_register_controller(ctlr) succeeds.
> > 2. devm_add_action_or_reset() is called but fails.
> > 3. The "reset" triggers devm_spi_unregister_controller(ctlr) immediatel=
y.
> > 4. This calls spi_unregister_controller(ctlr).
> > 5. For controllers allocated via spi_alloc_host() (where
> >    ctlr->devm_allocated is false), spi_unregister_controller() calls
> >    put_device(&ctlr->dev).
> > 6. This drops the reference count to zero and frees the ctlr structure.
>
> I am not sure I see how the sequence is different from the say this
>
>         ret =3D spi_register_controller(...)
>         if (ret)
>                 goto err;
>         // ...if success do something else...
>         ret =3D foo();
>         if (ret) {
>                 spi_unregister_controller(...);
>                 goto err;
>         }
>
> So, each driver should be prepared for an error handling in which it shou=
ld
> release resources in the reversed order.
>
> > However, the driver still holds the ctlr pointer and will typically
> > attempt its own cleanup, leading to a use-after-free or double-free.
>
> You mean buggy driver? Any real example of the use case?
>
> In the 5. you implied something like
>
>         ret =3D spi_alloc_host();
>         ...
>         ret =3D devm_spi_register_controller()
>
> ?
>
> But this is against the rule how devm must be used.
>
> > What are your thoughts on this? Does this analysis seem correct, or am
> > I missing a detail in how the refcounting is handled here?
>
> Is this analysis AI assisted?
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

Hi Andy,
I got the thoughts from an AI review from sashiko and  verified it on my ow=
n.
https://sashiko.dev/#/patchset/20260322-rockchip-v1-1-fac3f0c6dad8%40gmail.=
com

Best Regards,
Felix
