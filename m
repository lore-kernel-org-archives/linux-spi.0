Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DE0396D36
	for <linux-spi@vger.kernel.org>; Thu, 24 Sep 2026 14:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790259725; cv=none; b=L5d84qkXTFE7aTGQATaLaAiPLKQOR++nShgxRjAaVwS5UDp6/rO44suyFSEsRHzXtoHJqaL1uQ2EqqLi+IX3N69+BPhC74RNkTYz7rMqbKZuyDCOAQq3Ho1ItXZxN9TwqCG4WYUxcD7Gf0oN9nA2LnyYguuWVptlAfgdO2lsIig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790259725; c=relaxed/simple;
	bh=eWxj+wblHAI7sgVw77TEJdetXf+YjxLT/CX18mBkIcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kTCavUcyc6HJBHwKdCMrTkJ4Z8BKtTpKzZO2uVNG1LWbhelfZtVMQuwmdFRc37vT/WSDwx7LJLEPMgXYNEF39ECoQIaDR7VyOB0rQXHe25tD1JtC3res+aZm+aXLa5TH4s7TSOqKrS5/B8qnwUqEqQyDKLotN7EiNpHPXWR3rAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hwWyFNCT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hwWyFNCT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CC931F000FF;
	Thu, 24 Sep 2026 14:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790259722;
	bh=kt2T+i6VM7ci7hyq43RsUgsfEKZUJWz3m9Kv1tE7lC4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hwWyFNCTrzKwmB2vt9Im92/Yy65oacZI7kDM7SDUMuch+3xI0sWwcM3kA0Vq5Bi2S
	 GYvmQ9nIBKWww64OrJ0X/BC2nfAlN0ed9tlup6UcmvVZQAHvGw1DOYPwHjrJD/5h7D
	 cwXo79IbOxJ1KzFJO1r/7DMlGV0Ex6asNXEWjTdDgfFN60jyhL4i3KJBaRAkukLhib
	 Ah32ZYMPIE/2Vl3PUnM/wKrXCUv0rWvDTRwtCcfwXy4mbYaEoNUT5sbCYmchNp3ujz
	 J1jpj77/UqYNBmuD9n2UdhXFWJzMFSi/nGyK5uUl4SGo5aX4QHZ9oHmC+zHFPOJVDL
	 /zf0cpId0iEiw==
Date: Thu, 24 Sep 2026 15:21:58 +0100
From: Mark Brown <broonie@kernel.org>
To: "Wen Bin, Leong" <leong.wen-bin@hpe.com>
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: Re: Subject: Question about lack of timeout in spi-altera-core
 polling path
Message-ID: <c2451875-9217-47ef-a8c9-486b9215a7a6@sirena.org.uk>
References: <PH0PR84MB15263715756E3D68DA63C119BD812@PH0PR84MB1526.NAMPRD84.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BLXIZaSI0UssXkDx"
Content-Disposition: inline
In-Reply-To: <PH0PR84MB15263715756E3D68DA63C119BD812@PH0PR84MB1526.NAMPRD84.PROD.OUTLOOK.COM>
X-Cookie: Oh, so there you are!


--BLXIZaSI0UssXkDx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 24, 2026 at 01:40:53PM +0000, Wen Bin, Leong wrote:

> Is there a hardware guarantee from the Altera SPI IP that RRDY
> must always assert after a TX write, or would a timeout and
> -ETIMEDOUT handling be appropriate here?

> I'm trying to understand whether the infinite wait is intentional
> based on the IP specification, or simply historical driver behavior.

Even if the IP is supposed to guarantee a response we should probably
implement a timeout, something external to the IP might break it.  It's
just a historical driver issue.

--BLXIZaSI0UssXkDx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmq1MgYACgkQJNaLcl1U
h9AvGAf/dI0l/kvX02nxiTE3JYPODuxESRaOur09rpdjWzTMN4C6dZ1p1bLtY9US
cKqbkEF3OOWXf9Y5hiu+tYYHmmSNwzRu9wlfUCRxf5kI/NvESFQbkzP9IP/U5w9s
FzzD+BwhPcRDLX5C9JW60N8bgLEnG7xPm0R7e3A+EB3DYRFQmDK/Wxorr3k+SVS3
ovqR04JRj0HBd+yyzALoO2W3TfYrFY+Xo4KSmOjT3br3HKuGGsVmfnrNx7L+9U/U
oI5G3wUgRoAN1b99Mj3kBkrdhRXzp4CjATbxCr0E5EwF4qQBuAm5370punCY7DFu
S8+YK2MWwoK5BCCv17XI/UMZK6uRUQ==
=HRnu
-----END PGP SIGNATURE-----

--BLXIZaSI0UssXkDx--
