Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA7F2EF653
	for <linux-spi@vger.kernel.org>; Fri, 22 May 2026 08:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779437960; cv=none; b=ae4uX13/BYPZOyj8ICLk2STSP0o/cs0buhGBi+9vdy/zL2QTsKjGMtECvGlxie7dv8dkDBnPk/BPnihhBeg9HsjZjnuQvJXM8ottP/Ens26JZV3Xx+aaa8ps2T+qPfvsVbNrJKGJhbArGjH7GEWhfvzMsQ0qcXyAD16u8bkQSr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779437960; c=relaxed/simple;
	bh=zCi8ZdrsxuhGcTHyngAjC9ks6CyMGi/DkWAmtkRQTlU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TFDpHEXxjzX63nK6kofjEK2wJgj/7JFTkvu445w5OMSvby2b3YBS8ACfmXvgG1MSCT5yjGBTWF3q+TjCTqktyKnkFn+/AMEoIpkMylQPy9O5jejR+AWxpCMzZmr2+2nSrfJYOsB6nJ76oSo4Sq8ODOFiitb3LIuiwuH0d2zUsZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M3KgfnTf; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3KgfnTf"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-44a74032ff8so5209037f8f.1
        for <linux-spi@vger.kernel.org>; Fri, 22 May 2026 01:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779437958; x=1780042758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=USopUhbYAD9H+P5jY922wxECkr8a746/WdiaOhzpN58=;
        b=M3KgfnTfjoLi0GiN5khzdJYdgm1vckvSeaFkav9JNdGa5TcyD8SbKPWqvM/XFFaj1v
         zknAPvKMLdOb0ATBX2X6Np3QHkNL6to067d0nqhnruNtvKLQv5fpgld588AgX+nefs9y
         T9Is/WkrJd94OihhszN6EM3XJdPh/aDMKrqCFdY5/KrsRGgEHcj/qufWHgmDAX/d5nOm
         YfUzjGVTT9jeJEiGSAZEyhfuQcEsbJSJEwPrqlenub8YP3Rt9Xf4oaaJzNpuEjqZQiGL
         t88+3j+6STs608IhJQ2PwLydBA2ZfosxyLpdIET+mJfzm3SmEos3xMlBDE/Fz22dA4Or
         BkmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779437958; x=1780042758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=USopUhbYAD9H+P5jY922wxECkr8a746/WdiaOhzpN58=;
        b=VqJGusiwT59pQteWEqmZYPkmWXt/CjJ5LmXedvb7S4rEO3ZkILX/AhSDfhISK7bGeE
         Crfx8Sb0LtA6UhY4xDsCcWuSuIQwxcbjsLnlbtNoxuSS4aS/Nmk4kW8ejZGLHL5/jDsl
         jKlF9wl+pUEiDX2ohgG70TPdkdc7lYUjwzo8KDSKFlWWjYoZbJziRN4TlTP3eH10n91b
         dEWZ8WZKVyygG3L2fRw97AJBxN0xducedx/sh2z4mXJeEqq7MuwXadHgPSaOBTrVZiZq
         b44HCEgtg0bJfJLj9Bh0eozlG1/wuezGFXuXMc6MBHrSanbxBXNAzDf0WH54ZksNtOS2
         B42Q==
X-Forwarded-Encrypted: i=1; AFNElJ9lJx5qB0wssNbAdS1bq9/03oqVWLy0Lb2qd9VgcuP9PdqEgAApHw+X9JREpj7KvXpczaO5ydvvHOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwEVf+5CwvSnOzgMaH9jyGTbNs/avTMnf5hnrIxS2+rAdLYsMS
	Brr/Yz21toXz7pZ08LEtTHhEQOTK/m7aHJ/cOkaEZMRW6XPitDiB5Zo1
X-Gm-Gg: Acq92OGrN1sis9rtTITMz73C8hSXtwJ1J6fHwY714AfZrc7xYyT7WVjO1qOo85sovRb
	vM9vGYcBGSPqgraM7ujp3TA0EwoxpcFYW2WTDOYDoq+6TlAaE5nBvi/Zo+u6Z3dFHVWw2HbKjzA
	vsRu+GfmGE8L6HXy2cBSIX5lgfHJPjdHDK+vPyhE04k4oQxe74BEQYBqZOa5ht5rj5M/w+Qsdg1
	By2D54VD09HBYX22nGodmZVeT5+h2KIEFcQm3CDKJ9icHdy3xTR/UBhEZTzl3ITLxEYu1CkHb2B
	/l1n4r5QWJUSQNTg7/fllxaDdHVqq++Xt063H4qXkYZr+AZxahJvViws4gz6/CTeZ5vSLtSgm/a
	4sprailwolr+sRtAHWLiP72jxEg3yZIPkjtY9856c3qYOi13PNy7w/rBOmkwqDcsJHERqHokQyg
	7zx3wmW5dk8aAPwQghzPPtSG5a5Lafy4AcAlw0kWvbUyH9X22/rTk7EBYf4rf+N7L8
X-Received: by 2002:a05:6000:1848:b0:45e:73eb:2a75 with SMTP id ffacd0b85a97d-45eb367fb1amr3404088f8f.16.1779437957497;
        Fri, 22 May 2026 01:19:17 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6ccd04dsm2451454f8f.9.2026.05.22.01.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 01:19:17 -0700 (PDT)
Date: Fri, 22 May 2026 09:19:15 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Cc: <clg@kaod.org>, <broonie@kernel.org>, <joel@jms.id.au>,
 <andrew@codeconstruct.com.au>, <linux-aspeed@lists.ozlabs.org>,
 <openbmc@lists.ozlabs.org>, <linux-spi@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <BMC-SW@aspeedtech.com>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 2/2] spi: aspeed: Replace VLA parameter with flat
 pointer in calibration helper
Message-ID: <20260522091915.65dde4ad@pumpkin>
In-Reply-To: <20260522071621.102507-3-chin-ting_kuo@aspeedtech.com>
References: <20260522071621.102507-1-chin-ting_kuo@aspeedtech.com>
	<20260522071621.102507-3-chin-ting_kuo@aspeedtech.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 22 May 2026 15:16:21 +0800
Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com> wrote:

> aspeed_spi_ast2600_optimized_timing() declared its buffer argument as a
> variable-length array parameter (u8 buf[rows][cols]), which causes a
> sparse warning. Replace the VLA parameter with a plain u8 * and compute
> the 2-D index manually. The corresponding call site is also updated.

This code is all a bit horrid.
The 6 and 17 (which are also used in the array declaration) have to match t=
he
TIMING_DELAY_HCYCLE_MAX and TIMING_DELAY_INPUT_MAX values used for the loop=
s.

In any case the code would be more obvious if the 'run length' of test
passes was counted during the initial loop.
Looks like it wants at least 4 ones, after you've got that many
(and a fail) there is little point continuing the delay loop for
that hcycle.

-- David


>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202605180441.uD3toFRJ-lkp@i=
ntel.com/
> Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  drivers/spi/spi-aspeed-smc.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
> index 808659a1f460..027caa2eeb5c 100644
> --- a/drivers/spi/spi-aspeed-smc.c
> +++ b/drivers/spi/spi-aspeed-smc.c
> @@ -1467,8 +1467,7 @@ static int aspeed_spi_do_calibration(struct aspeed_=
spi_chip *chip)
>   * must contains the highest number of consecutive "pass"
>   * results and not span across multiple rows.
>   */
> -static u32 aspeed_spi_ast2600_optimized_timing(u32 rows, u32 cols,
> -					       u8 buf[rows][cols])
> +static u32 aspeed_spi_ast2600_optimized_timing(u32 rows, u32 cols, u8 *b=
uf)
>  {
>  	int r =3D 0, c =3D 0;
>  	int max =3D 0;
> @@ -1478,7 +1477,7 @@ static u32 aspeed_spi_ast2600_optimized_timing(u32 =
rows, u32 cols,
>  		for (j =3D 0; j < cols;) {
>  			int k =3D j;
> =20
> -			while (k < cols && buf[i][k])
> +			while (k < cols && buf[(i * cols) + k])
>  				k++;
> =20
>  			if (k - j > max) {
> @@ -1541,7 +1540,7 @@ static int aspeed_spi_ast2600_calibrate(struct aspe=
ed_spi_chip *chip, u32 hdiv,
>  		}
>  	}
> =20
> -	calib_point =3D aspeed_spi_ast2600_optimized_timing(6, 17, calib_res);
> +	calib_point =3D aspeed_spi_ast2600_optimized_timing(6, 17, &calib_res[0=
][0]);
>  	/* No good setting for this frequency */
>  	if (calib_point =3D=3D 0)
>  		return -1;

