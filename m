Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795083370;
	b=4QGLzR6jj5MzBUIJQQtXGa6vXQnM0ytnDHO6BV1la9NbuMMK+2OHz0QAyz8pPqVjpvyQ
	 qEkYLPGSfaKnk5Wh/RYSh0NdufGH+ubUfG/0xAyAwbyAu8gQD3DCReIc5GUHMFlc/QEN6
	 VCnr27thuC6ie9+22rghzG44zSBOXCyoGyjyLzpEqYr/V4xXN4qXnUJNg2yKk9CVv0wv+
	 3TjbBHgmHOzsW44GmsSp7JKb1SkvOFtg4KNCkTBw8Yu+UxDhmL9q+3sqdndWTqD/CDKuw
	 snDgf9vLPii0+jtifsRu/2YcDAv2gwdoFKcdhUlEStNCzLkC2chBxqQZYVBHfUPMB7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795083370;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Subject:Cc:To:
	 From:X-Mailer:References:In-Reply-To:X-Last-TLS-Session-Version;
	bh=iobtCfn8EFQLi1QR3m/ewET1qprBKHmaYyEVyi3cf1U=;
	b=jKnU3R5XXnuqch1V8/sR4Jg4YVahm0RJf8xI8K97/KNUHXIo+jLcg4VswBpAGz4ZfEp2
	 twOAP841acyKGxU68b2QrnWNkvEBKLHeQPm1S2w2ED5ChTnYsRb60SUNqOgpGICjfDfWG
	 bBrAEx2/f+HRpLZybewWPOudnw4J5FiX4Eg1Jf5FEvBRO8O3dD5JudoVnJ9jIRIGWY6hO
	 QPXI+v/NGOHk6hMDJWta3ozNAqILIn7huOauNvxi3YwoatsD17qOSEI/Q3Ju3npzVDIm6
	 rVnyjt4fQECeJripgLL2ST7uQ2uOXfiLr8y84zO3DIpzQG543eiExJNlttewXYbltVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=GivbN5j6;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59036606A324;
	Thu, 19 Nov 2026 10:16:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59036606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=GivbN5j6
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 02C934E4156A;
	Thu, 19 Nov 2026 10:16:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C8C0860237;
	Thu, 19 Nov 2026 10:16:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 46F1011BC17F1;
	Thu, 19 Nov 2026 11:15:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795083358; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=iobtCfn8EFQLi1QR3m/ewET1qprBKHmaYyEVyi3cf1U=;
	b=GivbN5j6JnNwoQuWrLk1np2/mro20p1FB2cuifa3KzI+Nr9bZ1Ms6eoj5q/w9w8+8CAvyd
	v8kFbqX1bnFmEULAh04Rkc4f1xrQJdqiuze3qF6kU1ENmjwuydY3D9G0dQHH0RlMUEz74D
	J/+Q1gIN0a0G3hS7FphiRf6rrhoxy3DPuX7rV9hv6NbHWv/wH475Po1mbaiMXjU+Qj6cie
	uFmXZRbS+ANzS55VIsmENuJJRwgjca+GYJvFY9oofQLtL/Fb9aNSzM1xPanXivkbwaKu/R
	/tCipcmvgHv3otxsjwbwBZFoYt1qo+DYi0XTmh6IAjLh5cVIFFCC/ZMbNCnjuQ==
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
Date: Thu, 19 Nov 2026 11:15:53 +0100
Message-Id: <DMZ3XW6ZEFDF.2WJ1XU4UKTRAH@bootlin.com>
Subject: Re: [PATCH 06/10] spi: cadence-quadspi: Bound chip select against
 f_pdata array size
Cc: <stable@vger.kernel.org>
To: "Lee Jones" <lee@kernel.org>, "Mark Brown" <broonie@kernel.org>, "Foon
 Tan" <lftan@altera.com>, "Graham Moore" <grmoore@opensource.altera.com>,
 "Murugan R" <vadivel.muruganx.ramuthevar@intel.com>, "Vignesh Raghavendra"
 <vigneshr@ti.com>, "Pratyush Yadav" <p.yadav@ti.com>, "Dhruva Gole"
 <d-gole@ti.com>, <linux-spi@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, =?utf-8?q?Miqu=C3=A8l_Raynal?=
 <miquel.raynal@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261119091810.3440619-1-lee@kernel.org>
 <20261119091810.3440619-7-lee@kernel.org>
In-Reply-To: <20261119091810.3440619-7-lee@kernel.org>
X-Last-TLS-Session-Version: TLSv1.3

Hello Lee,

On Thu Nov 19, 2026 at 10:17 AM CET, Lee Jones wrote:
> cqspi_setup_flash() uses the chip select taken from each flash child
> node's reg property to index the fixed-size cqspi->f_pdata[] array,
> which has CQSPI_MAX_CHIPSELECT entries.
>
> The range check now compares the chip select against num_chipselect,
> which comes straight from the num-cs property and is never clamped to
> CQSPI_MAX_CHIPSELECT.  A device tree which specifies num-cs greater than
> CQSPI_MAX_CHIPSELECT together with a flash node at a correspondingly
> high reg value therefore causes writes beyond the end of f_pdata[].
>
> Reject chip selects which do not fit in f_pdata[] as well as those which
> exceed num-cs.  While at it, store the chip select in a u32, matching
> of_property_read_u32(), so that values with the top bit set cannot
> become negative and slip past the bounds checks.

This commit message was hard to read! Can we do better?
The issue at hand is super simple.

Repeating the last sentence:

> While at it, store the chip select in a u32, matching
> of_property_read_u32(), so that values with the top bit set cannot
> become negative and slip past the bounds checks.

Come on! 2147483648 chip selects?

> Fixes: 0d62c64a8e48 ("spi: cadence-qspi: assert each subnode flash CS is =
valid")
> Closes: https://sashiko.dev/#/bug/linux-cd463fc8-1b94-4bcf-8d06-fae21b888=
94c
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>

Is this worthy of backporting to all stable releases? It is a indeed
a bug fix but which can only occur with a broken DT, probably during
development. It sounds like a lot of churn.

> ---
>  drivers/spi/spi-cadence-quadspi.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-=
quadspi.c
> index 844df97111d7..fbb917c104b0 100644
> --- a/drivers/spi/spi-cadence-quadspi.c
> +++ b/drivers/spi/spi-cadence-quadspi.c
> @@ -1751,7 +1751,8 @@ static int cqspi_setup_flash(struct cqspi_st *cqspi=
)
>  	struct platform_device *pdev =3D cqspi->pdev;
>  	struct device *dev =3D &pdev->dev;
>  	struct cqspi_flash_pdata *f_pdata;
> -	int ret, cs, max_cs =3D -1;
> +	int ret, max_cs =3D -1;
> +	u32 cs;
> =20
>  	/* Get flash device data */
>  	for_each_available_child_of_node_scoped(dev->of_node, np) {
> @@ -1761,8 +1762,9 @@ static int cqspi_setup_flash(struct cqspi_st *cqspi=
)
>  			return ret;
>  		}
> =20
> -		if (cs >=3D cqspi->num_chipselect) {
> -			dev_err(dev, "Chip select %d out of range.\n", cs);
> +		if (cs >=3D cqspi->num_chipselect ||
> +		    cs >=3D CQSPI_MAX_CHIPSELECT) {
> +			dev_err(dev, "Chip select %u out of range.\n", cs);
>  			return -EINVAL;
>  		}

OK this does fix the bug. Here is another proposal though:
ensure at probe that cqspi->num_chipselect <=3D CQSPI_MAX_CHIPSELECT.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

