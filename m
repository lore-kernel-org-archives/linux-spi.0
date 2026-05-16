Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0831F12D21B
	for <linux-spi@vger.kernel.org>; Sat, 16 May 2026 04:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778906531; cv=pass; b=gNN0AfwDP898mPqQE7OK/v24atG91hnfj0Zg/qqHtn0VHS8rIeYIZhESVTFn3UEhSLUDf4FkXtYKnTYcR/Yl3DmqC6kiSIyiJiOfDmUnZfS1BhgsGvkh/r21RH0d5aq7jvzb6JmvMW2B6e7A9hAW0Om/UPZEqdr+C9M5WumE4Ko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778906531; c=relaxed/simple;
	bh=tXPPmUZyf5MuabSQHldu4lkzFFPHHcibPJ0HTL0gEx0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s498Gt2o2tcAbND0LgIVUcVVnRq0xBFJ8zd9z/f8WvhKX/0aPFhjW36szq3xxM9jiGtMsbHBjJSPVvX301M0yffGivrzToqycaKHC62bHirptd+h8AEmFMPyQoDJyT5ylaq3ymNRj02jZeDhYkSmoLPxjBY29W/R8nf9do8Rp/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fh30MCkh; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fh30MCkh"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3695bf7d082so501532a91.0
        for <linux-spi@vger.kernel.org>; Fri, 15 May 2026 21:42:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778906529; cv=none;
        d=google.com; s=arc-20240605;
        b=j5op9KGW3tXYlKnjXnWqZgm7Ayx/9DRakOqsUHrFyqDv+7JkwXg7x99IG3SSFDd5s5
         rcXHuNQOnZN0t4FUlFZZYeydm6/Q1lzj7TnaBpoXgXSyrMBxyZBCBE/b0J6yEqvSoGFN
         V/23B+RlT13z9AWh2MkU1yUxzyxkGvmNncQTeE2fxuZbWF6TBM/tXCXpiiubJsk8xkCc
         IAxvmRabjvp0/U1tSnEXzxeueeIyomi0wiSVvjxWX9bYpRR9/vwpk7BHmLbflybdxqi+
         2D9Un4uG//apvJcVdScdojfrg/VljRZlUEndkwF4Bp+mupFnNTGmhtZ5RR6jo7VOvCoo
         JCQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V8Rh4zLdk4DbxG4I/TJfE5EGq2t+0o38Iqvwi9s0NFM=;
        fh=s83ePmeZ/Qo/mWtUZC6inXe8I/8WOdRc9dUVoCjdaRc=;
        b=DewN18bHXjtM0ZKJT2hWEPZ+nh65QP8P9UeRpW2hPOhHwycKYDkqm1YmI3Ct/gediN
         Qm2fi7oy3652rV879U37ttRyo+FdAzdxiyJTwtKGAKRMTnlfH3nHwToWxU/CIEqYr1Mq
         MmKH+1oe6hwUEyG1HPV2bzpSksj86IL+YEHz+EQX4EE4Ppvw3T91Uq0O6FSgj45N+G3y
         t1ZlQrjB72cW5zeIF+4+41859iP+o3Eho/Vi8/3VwQMqnWQwxihqq1ldMsfANpCnMcM5
         1wV2BnfNdzV9043R1yjtx80wnsgxfdgquvAa1yzkDe26t4+IsxQt1A51gy1PRDpf70jJ
         Pklw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778906529; x=1779511329; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V8Rh4zLdk4DbxG4I/TJfE5EGq2t+0o38Iqvwi9s0NFM=;
        b=fh30MCkhPDVPVL0Eoffh7bE4PhX/MRpMeaLMtBZmnT53wpgwtYZ8a5vIdlMJ158DqK
         ENyZrKHhrEEFUnayoe1pqrGixzPyFJPcdz3Mxlh4vzghxixM1R6KffLV6Q+Z9CCqxyI1
         kllwLLu+1rWu0YB5RZUFieSbTX0zWF+UZM1wL+5fxT2pfVoJ4oK2nbhfETxfomKxc6Ul
         LSpfR6WJosCFKYNBWHKPvpFL5ycROZCzuWUqfiv5bGeMBFOwVHdV4aX/Yhe3WpCBxcAt
         Ips0hH5O5MDc/sfI/WH3pPLh8iaeHglwtkBsMUftqS27oGUslzqKHixJ3a5BjRZTC0+z
         T7mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778906529; x=1779511329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V8Rh4zLdk4DbxG4I/TJfE5EGq2t+0o38Iqvwi9s0NFM=;
        b=KkwnKxn43P7lRmvvMomBP8fPK+ngteMOhLJdFoy4g39QGUWEBjKiXwfxjtU+kgw5Op
         ScQN55RWNVz0QwoOQdf2GLLEK2QQS2aG/WBiyrt2Hwq+olX7xkY4rjTpbpAUjXJ+T+aZ
         bugsopUsPlgIXJ8OAFDhkF668rNM8SZ/91dI8HOqIUQqNAherhVDoB0Uc31DVwzlsT0C
         EvbXc83iEeQqzVGkBY5vLkDuQ6c8zbzefxlZHJBd/aMzQI/ZKBAzH2/KG3DUq4CtHAE4
         KmNA7PH0EJUfK9l9MlE0usBcRRVYtwL8dU4tzP6VBs4+plvyF/TDfelABlprdFFAJls4
         Mixw==
X-Forwarded-Encrypted: i=1; AFNElJ+pXsnqgGYulfuQx4OkjYCH0YQ9f4U0rqYfucZ0/fc98nqzFXz/Jh54HHu3xGlx+Hr0luyS526oqfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUD6V5J0DySUO7FUQshhivhtllbVTB5obzupb3KErBHbbXqbiW
	epLSCti+D0EjoQMXv7DIh1JZZePeLcKCmUC6yLyUf96BehzL3En2Bc3OOPz5UKtkuY8fBfMMb+r
	h7S/QcuKPIHR2YuHzT1p1/BVMsuLZGcc=
X-Gm-Gg: Acq92OFVhIVX3m92W7JiXF0DO/XsPMkGdopxbdVPpiu9rZ1xzbi0e/jvN+VoLhlip5z
	MHcKYopKfqHEGsYYcCgmJs0BxgEW2ebFe6Xon3EjvLusje0zKtxdKMMxZc3ihbsz2qxumWcTA4G
	JCTx5tUOeA8em+gsNoizHweHgQmpXOuhNd0oDvfPsS1fXQ6FmiuyL+Z47MJfc2OzF4nCJ7mGWi2
	VcAzRBdo4ZHk11sIpQEeSKJGoTsG4QFOJYiO3b8r7Xsb/tBiG9p2xvdiJALVQpKdWWCoYME+hVV
	ndioYN+UU6WmwILPWVAr2uvON18YFJRNAdcUjmIbZGswhwQOOg3uuRNksyaRPLcRSlHxMelCutb
	DABvqNepNVh92AnDuFOROaiKRKF0/H5bl
X-Received: by 2002:a17:90a:c106:b0:365:c8e3:ec53 with SMTP id
 98e67ed59e1d1-36951c953d1mr7210638a91.20.1778906528768; Fri, 15 May 2026
 21:42:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260516-atmel-v1-0-674fb4707af6@gmail.com> <agfXl-FiZ-PN_cGT@sirena.co.uk>
In-Reply-To: <agfXl-FiZ-PN_cGT@sirena.co.uk>
From: Felix Gu <ustc.gu@gmail.com>
Date: Sat, 16 May 2026 12:41:56 +0800
X-Gm-Features: AVHnY4ImmFjH8rHc5xVGey21fu2ZKT2avAYpf9JXGJ-yEfs3n1n9B8uArB3txUs
Message-ID: <CAN4SLj3H3Sc_N42KnYMzgpe8LcFE-6EHeNxnBY2o35jP74_BkQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] spi: atmel: two fixes
To: Mark Brown <broonie@kernel.org>
Cc: Ryan Wanner <ryan.wanner@microchip.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Radu Pirea <radu.pirea@microchip.com>, Richard Genoud <richard.genoud@bootlin.com>, 
	Wenyou Yang <wenyou.yang@atmel.com>, linux-spi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 16, 2026 at 10:34=E2=80=AFAM Mark Brown <broonie@kernel.org> wr=
ote:
>
> On Sat, May 16, 2026 at 01:20:33AM +0800, Felix Gu wrote:
> > Signed-off-by: Felix Gu <ustc.gu@gmail.com>
> > ---
> > Felix Gu (2):
> >       spi: atmel: fix resource leak on DMA buffer allocation failure
> >       spi: atmel: fix DMA resource leak on probe error paths
>
> This needs a rebase for current mainline, I didn't check but I suspect
> it's conflicting witj Johan's fixes.
Hi Mark,
The two commits are already based on Johan=E2=80=99s fixes:
commit ebf99aebc458391893c598f1caddd42bfcc97fc5
Author: Johan Hovold johan@kernel.org
Date: Wed Apr 29 11:13:16 2026 +0200
spi: atmel: switch to managed controller allocation

There should not be any conflicts.

Best regards,
Felix
