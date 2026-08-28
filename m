Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1622134CFC5
	for <linux-spi@vger.kernel.org>; Fri, 28 Aug 2026 16:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787935129; cv=none; b=f5Xl1GlFvhXFTT01Wp+ktwg7hzFQqIi9XdeWJIM7KQHqDKNXG6oEuUdq4AG+8397NPPraCU56BjYQBgXmUk138ZRly8V5QIQt39Ke/jRLTV1j9e68FUArHBIGzmQ0Ce9hmTEdSBFXK4J2h+trEHLGZJaGh84WJIbcZIKmnhlkrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787935129; c=relaxed/simple;
	bh=IC8kZfYWqU4J3usyHPwyyd2uDdZsQHy2aZx07QPkuTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JGbvnaJLqnXnmQFq3twg9K8Dfdxf8H3GIP6Sq77cviQD6F/2+25LwSqr6nyxrhvGtgBzE6N5Go16vbhMD/kusR23DuHprHNP+kjmXOhL+SLHKZRHhFzgD5LL5kSp9tmq//fZ7TF+pFexK07z9Svvoi2+MF0a7adoPggbGHjg0rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fq4DjITC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fq4DjITC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD8FB1F000E9;
	Fri, 28 Aug 2026 16:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787935127;
	bh=NqO2urIYmWm+z9Jpxp20ikPDzlJDg10J9ALIYg0ol00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Fq4DjITCegYgZ12ARUQOd7phUtuIfTv9Qugj2ejpL51SQsp283A1bEN89adXqWDoK
	 WayXS+VTpr47VepPJtURhYplJy1qHMHisRWc7xAtudZ4t+dWU8yQmyeYhlVxqIIL8N
	 bDrwYk8OFQwwjXCz3M2iGWJyyfbSxvN0/jM86KJykgqf//AUu4r2Yk1qUUybK/w2eF
	 WnuzIax7Fg1KkkG52+xsAy/mRfCGiWIkk0++42Jt6vJZsmLWX9aS5Ftsh0mnrBjG9b
	 sR+kXq864EJvnZrlKcQFKGycWXR7qd3vFd0no+VVbm5+nAzaklsM96HSGck/VAiLFP
	 MK+VNK32qwtfQ==
Date: Fri, 28 Aug 2026 17:38:44 +0100
From: Mark Brown <broonie@kernel.org>
To: Li Jun <lijun01@kylinos.cn>
Cc: zhuyinbo@loongson.cn, linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: loongarch: add compatible for loongson spi
Message-ID: <647e2cd8-07c7-4aef-80c4-0e9c6b689d65@sirena.org.uk>
References: <20260828013146.2381737-1-lijun01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cTG9RkdZvYlYHfU/"
Content-Disposition: inline
In-Reply-To: <20260828013146.2381737-1-lijun01@kylinos.cn>
X-Cookie: Subject to change without notice.


--cTG9RkdZvYlYHfU/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 28, 2026 at 09:31:46AM +0800, Li Jun wrote:
> When the dsdt use "loongson, ls-spi", there is no tpm
> device node appearing in /dev, because the id 'ls-spi' does not
> appear in the loongson_spi_id_table. After add the id in the table,
> the function of tpm device is normal.

>  static const struct of_device_id loongson_spi_id_table[] = {
>  	{ .compatible = "loongson,ls2k1000-spi" },
> +	{ .compatible = "loongson,ls-spi" },
>  	{ }
>  };

Are these production devices - that compatible is very broad?  Also
there is binding documentation for this driver so the new compatible
should be documented somewhere, either with the rest of the binding or
probably better in incomplete-devices.yaml.

--cTG9RkdZvYlYHfU/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqRuZMACgkQJNaLcl1U
h9Bygwf/SLXSRkodDkzObatHTwF0C/3UoYJR5H027uJbDOVNPlcEXvSQhXQTG5ru
q3T6pfbOEOsekQFsROdmytAwY6TqRRTrHK5MEOJyBjVT5rCXgOjPb4zaj49rNT4V
eMUX+SEAtzcabUYLgxaAp+HAzdZFI5zPI8qldny3jN7+1r0jfXmceJaSetwrI8+g
piklNnQ7eP7cVa6xS/S5qSXMVHefwrhJpUCas9bfpDa4/9E/F9snZsX0qEy8MME4
hV0WfnW5DR4HvEctEVbvtheFVK+DxTDDuMnbtKbFf+/W/gTagrniKN6U6TwM3yTH
weROxDr9TjqHP+Nq1EFeXKeJn/xDrg==
=aVar
-----END PGP SIGNATURE-----

--cTG9RkdZvYlYHfU/--
