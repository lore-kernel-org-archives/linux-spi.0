Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795800174;
	b=sX1YD8PHQEXr6UYRGQTNO80SVXCkeiXIylN08t647rDF7HTvoUG79kBabZiT5HK5f4zB
	 BkcolFKBb7gRNcDhW91RBuwe/aLFeNrP3+adLLKIQzrN2xuVuMgHANtDfLkWH4U1DGath
	 LFZVgHFKhDbgZ2KNRWi2shSIUugroDrK+TRHJglEOJTPyyYamY2A0OMMXCmizhgJPX6V5
	 StECJ5cxV+bILdKc6CzbZpAORma0KyfhxXWl+v6PBj+IodxUlV2NVZTznlVv93aOJoATH
	 YdbA60f4Rzq+ctW1dm9zYXC+xI9C3LY1bPl0+5dLh4WQNrSGUVtvEd8aJIuzK/ntfog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795800174;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:To:From:
	 Subject:X-Mailer:References:In-Reply-To:X-Last-TLS-Session-Version;
	bh=pubxOyQNxqJObSQRzP2EByZPCuSgU1IGzHB2bC+qN9U=;
	b=bDO4Uk1Oyvxq5NWvjI4vpQZHtuZ4aPzS8qOzbvnJ7WldwLQ60uIQiJ3IX+/9pLxAEsdH
	 SPeizHjJlicK5XbK5lBwmQcmHPycfrJFYE7WNPZUs6M71dk61PWiAsygj40obj6HrSynF
	 MyZZd23Jt8npCL8ufwIbMxL/a8OJyo+G3Q8F9K6Btwik0FwIzoJgKMug34MX2zDGq1UlK
	 6yjp4XFwZWcyvyIxf2CIvlnc2goMzm8OQXoeFPnYahuvJ0ThVQdJM58uGzPZnLnzt2Nos
	 mH3Xk5+2IdHVCgb/ilqKRrlImpL/LKB5wwkSSRje8s/xOEQn2ps9vjCxgzgfKl2wcmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=lJmWrYsS;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A58606A31C;
	Fri, 27 Nov 2026 17:22:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24A58606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=lJmWrYsS
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id A0F024E417C7;
	Fri, 27 Nov 2026 17:22:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5E33D6049C;
	Fri, 27 Nov 2026 17:22:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EC53911E90D65;
	Fri, 27 Nov 2026 18:22:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795800167; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=pubxOyQNxqJObSQRzP2EByZPCuSgU1IGzHB2bC+qN9U=;
	b=lJmWrYsSeVaZ8lnbvl7iZRf/Xsw9YMSMz7FPFKmlGc9QkU+qrFNgOfwl/815v8sGHvemZG
	jJ1/JDdD3F9T1QFViGRTlTb7cWyP1PCJa+oxyPceNJxBCgHWFaUO81tnqqphyfBFgxxBKx
	H7aOXcub76BfTSftj2ii0rCdO0fbI8uaqd2I15yM6a86XoUeang9PglyA5zmhyEb0LAbq1
	jMH4wSujc4aCGw8Iotuehl5ObBp4l5WlxmN7Jk3ao5nQ1uiIadiODOPV9IuYIT2j/jbMYo
	y+EynpzqiDwpNjSFtdd+k8oLX/t/0mHb7Bk8D2XfPGKfqZLrpjv4HXlDPAed0Q==
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Nov 2026 18:22:43 +0100
Message-Id: <DN6611WYQN57.39FY9Q6KK65TS@bootlin.com>
To: "Lee Jones" <lee@kernel.org>, "Mark Brown" <broonie@kernel.org>, "Foon
 Tan" <lftan@altera.com>, "Graham Moore" <grmoore@opensource.altera.com>,
 "Murugan R" <vadivel.muruganx.ramuthevar@intel.com>, "Vignesh Raghavendra"
 <vigneshr@ti.com>, "Pratyush Yadav" <p.yadav@ti.com>, "Dhruva Gole"
 <d-gole@ti.com>, <linux-spi@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH v2 06/10] spi: cadence-quadspi: Validate num-cs against
 CQSPI_MAX_CHIPSELECT
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261127153158.2969573-1-lee@kernel.org>
 <20261127153158.2969573-7-lee@kernel.org>
In-Reply-To: <20261127153158.2969573-7-lee@kernel.org>
X-Last-TLS-Session-Version: TLSv1.3

Hello Lee,

On Fri Nov 27, 2026 at 4:31 PM CET, Lee Jones wrote:
> cqspi_of_get_pdata() reads cqspi->num_chipselect from the "num-cs"
> Device Tree property without checking that it fits within
> CQSPI_MAX_CHIPSELECT.  cqspi_setup_flash() then validates each child
> node's chip select only against cqspi->num_chipselect before indexing
> cqspi->f_pdata[CQSPI_MAX_CHIPSELECT], allowing an out-of-bounds write
> if a DT specifies more than CQSPI_MAX_CHIPSELECT chip selects.
>
> Reject "num-cs" values exceeding CQSPI_MAX_CHIPSELECT in
> cqspi_of_get_pdata(), and store cs as u32 in cqspi_setup_flash() to
> match of_property_read_u32().
>
> Fixes: 0d62c64a8e48 ("spi: cadence-qspi: assert each subnode flash CS is =
valid")
> Closes: https://sashiko.dev/#/bug/linux-cd463fc8-1b94-4bcf-8d06-fae21b888=
94c
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
> v1 =3D> v2:
>  - Reject num-cs values exceeding CQSPI_MAX_CHIPSELECT in
>    cqspi_of_get_pdata() and store cs as u32 in cqspi_setup_flash(),
>    per Theo Lebrun's review.
>  - Simplify the commit message and drop the stable tag, per Theo
>    Lebrun's review.
>
>  drivers/spi/spi-cadence-quadspi.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)

Reviewed-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

