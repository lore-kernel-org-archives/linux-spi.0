Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1520C480324;
	Mon, 14 Sep 2026 17:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789405450; cv=none; b=JbmPABuxyYrmsUcvWCvtShiahuihs3O8UB/ebjNWLf7B9MSLKCj7cwQIJkUss+CgieL5iHK4WZgu29MVeyDoiLm+WGgOQYTPFBeqmGI3QrYIpffgXq/yiUGlqNUFLlZpeZx4jSU6xZ+cEfFjAbleB10CtWu3Bqer3lGV/SS2V6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789405450; c=relaxed/simple;
	bh=LX2HRALeP6kVWwMqDVM8FbZJpWRL31ZVmPATsUffHUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fnDVybF3LcPu0PosFH9sXCZtkgymX4oTJ+21IdTjqIvuEa9vWMq8E69hHcSE8irY1ivMFJ1Ycu3SP+fB86UYq4kIRNw79CA9H4r2h/PNIuTHMVFhXCiWF6xJxeOwe3kROMy+V4Po09lzR30X/oe7clPo9sQlzG454leJEiRzcVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ahHGnnW8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahHGnnW8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 339571F000FF;
	Mon, 14 Sep 2026 17:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789405448;
	bh=D11SiCjARZmfLjydnAFDDsk3oc5AvfRR5D6EpS16Rsg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ahHGnnW8WTlzySGsM42JuacN6EaH4Xz7vQbs2Ii1UKG4szi7DjCIE18Mcr8CyoM23
	 z0xXjB2caW07nxnkxYSDsB7VnUZd4b7hM2q2WLJi4M4vNmXWu1Ml7LnV+ETtpm6PD/
	 zETlal3U6BtedJUM5yTcVINo5w7mL1HeSRqp/plVKaAP5Gl/Zi8uOnivCk4pNxgaQS
	 7Wj3QnZ7xCo4n5umW0GgPmYFNLtgjNnyKcMXj6Q+azUzFZYcuekKPRhwQhX81P2a2Y
	 UBs5prO4Zt2+xoe8N8obCiATu7oApz2/DXiTuozGPkqAr83MDXRqzKZGIJrw58r+3S
	 0NtkuCP5CIKhA==
Received: by traversing.sirena.org.uk (Postfix, from userid 1000)
	id 6B9FCFD9F85; Mon, 14 Sep 2026 18:03:51 +0100 (BST)
Date: Mon, 14 Sep 2026 18:03:51 +0100
From: Mark Brown <broonie@kernel.org>
To: Jonas Rebmann <jre@pengutronix.de>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de
Subject: Re: [PATCH 2/7] spi: spidev_test: add compare mode
Message-ID: <aqgo93bzXQgMciTS@sirena.org.uk>
References: <20260914-spi-sun4i-spidev_test-v1-0-72d6a3b38cee@pengutronix.de>
 <20260914-spi-sun4i-spidev_test-v1-2-72d6a3b38cee@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VojHOG5x6Q3UbjP4"
Content-Disposition: inline
In-Reply-To: <20260914-spi-sun4i-spidev_test-v1-2-72d6a3b38cee@pengutronix.de>
X-Cookie: Orders subject to approval.


--VojHOG5x6Q3UbjP4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 04:50:41PM +0200, Jonas Rebmann wrote:
> From: Marc Kleine-Budde <mkl@pengutronix.de>
>=20
> Check whether the received data correspond to the transferred data but
> without enabling loopback mode in the controller.

> -	printf("Usage: %s [-2348CDFHILMNORSZbdilopsvw]\n", prog);
> +	printf("Usage: %s [-2348CDFHILMNORSZbdilcopsvw]\n", prog);

This is sorted alphabetically currently.

--VojHOG5x6Q3UbjP4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqoKOMACgkQJNaLcl1U
h9DZAgf+KRoKZrLT1YlJvDuErHYMC0bvyns2ifvXYOBZFswCeTX1eBNEvwoz8aUJ
sE5uKmjsdnNe1ZUpp845IrgnT9X+YUbBeVZjwqv/e15lnslmukLahcg1nicNg2zs
i/HBWzMOkGy8hthQi8MGxFprqjtz97uzRLaRVFKpBx2vOWEFHXdLKLJ7idTo67tJ
W0NN2odtDIGPCoCt49cgXZBboPZbsUlnePwqm5eSU+DI0HLg18Nt5OnQqgWuBE0D
K12c2kTxW2UDH4cy9RPyATvIgWL1mHs3NGN48LYoKxZuY7j71zDwTxkLOh4548Oa
PmW3aeX7Yv3N/azUCKmvp8xP0BXr5w==
=4jOr
-----END PGP SIGNATURE-----

--VojHOG5x6Q3UbjP4--
