Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340B23ED5CA;
	Wed, 22 Apr 2026 14:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776868881; cv=none; b=DfXJ8p8JP9i0mdqSGvdXu7XLSCC4CWw62WfoiGEWGmYjE/tqS0AF2iZHOCrBe2Vov0KcLxX7ZGsPZAIQ7goo3z/AF3wTlZXiypPDt9HZF16ybKrXqUJKd5Z0bmkjXW/+JJXVls3XhrLVcgSVQ7Ut+/+QxXj97rflj6z5KJ5B0/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776868881; c=relaxed/simple;
	bh=D45WQYSl5r0uqkoRoYcpHVhAdbSd3B3ptEHmJ7jA1IQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oNWyFEnf0n2b9If/ZRlX6pL34K1Yz1hxESKaUKXatjqG4kOFhC9SxT1XPh1jACuWF/PnO/07sOOIWd+n//6CCyH/eKDJF4F0YhnjYrR0kCGD8lDrIYdEhYgbdlUTVlD5v5r7bvy1iM1TVMDsMmy8M1/ofe8O6C9c08ecHRoExMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gw4jz4QJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gw4jz4QJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DA7CC19425;
	Wed, 22 Apr 2026 14:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776868881;
	bh=D45WQYSl5r0uqkoRoYcpHVhAdbSd3B3ptEHmJ7jA1IQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gw4jz4QJYAJbdEoKy3KE/QcacC1kzDRRMlMu+IBoBsJbzYpc86IKDuW1iXnxygjwB
	 QHvErj9vU5juZzVOAyuGkw+x8cSvUGPGpAhOEBnvO9OQE4FRqlNz+3aiS/ZQ5fElsa
	 3y2oxJdlw7FTRD1ks6Jh6Bw7QO/bpWd3e59jB+T/dk7+hQ8gWlsl1d+I6iCs+wL6fl
	 ZOtfucFKjrMJgurPy4PqYygBPwu20eAIKHxG/FGOanBgzvy0QZMCmWVQ76mMHdETWJ
	 nix8AQsfbUl+T+KIBJRzUD9DqoF9oYvJD9alxcqCRAUj9oHuAnZZgykpv4Okvz2AH7
	 QoFpoT6L8sZRQ==
Date: Wed, 22 Apr 2026 15:41:16 +0100
From: Mark Brown <broonie@kernel.org>
To: Vishwaroop A <va@nvidia.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>, smangipudi@nvidia.com,
	Francesco Dolcini <francesco@dolcini.it>
Subject: Re: [PATCH 1/2] spi: add new_device/delete_device sysfs interface
Message-ID: <14c0d967-c89b-4b1a-b26b-f66052936404@sirena.org.uk>
References: <20260420031417.291442-1-va@nvidia.com>
 <20260420031417.291442-2-va@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ijEH42X9vsQS0Rhr"
Content-Disposition: inline
In-Reply-To: <20260420031417.291442-2-va@nvidia.com>
X-Cookie: I'm definitely not in Omaha!


--ijEH42X9vsQS0Rhr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2026 at 03:14:16AM +0000, Vishwaroop A wrote:
> Development boards such as the Jetson AGX Orin expose SPI buses
> on expansion headers (e.g. the 40-pin header) so that users can
> connect and interact with SPI peripherals from userspace. The
> standard way to get /dev/spidevB.C character device nodes for
> this purpose is to register spi_device instances backed by the
> spidev driver.

Copying in Francesco who's been working on similar things from the DT
overlay side.

> The new_device file accepts:
>=20
>   <modalias> <chip_select> [<max_speed_hz> [<mode>]]
>=20
> where chip_select is required, while max_speed_hz and mode are
> optional and default to 0 if omitted. max_speed_hz =3D=3D 0 is
> clamped to the controller's maximum by spi_setup(); mode =3D=3D 0
> selects SPI mode 0 (CPOL=3D0, CPHA=3D0).

> +static ssize_t
> +new_device_store(struct device *dev, struct device_attribute *attr,
> +		 const char *buf, size_t count)

> +	status =3D spi_add_device(spi);
> +	if (status) {
> +		spi_dev_put(spi);
> +		return status;
> +	}
> +
> +	mutex_lock(&ctlr->userspace_clients_lock);
> +	list_add_tail(&spi->userspace_node, &ctlr->userspace_clients);
> +	mutex_unlock(&ctlr->userspace_clients_lock);
> +	dev_info(dev, "%s: Instantiated device %s at CS%u\n", "new_device",
> +		 modalias, chip_select);

I think there's some entertaining locking issues here if someone decides
to try to unregister a controller while we're adding a device.  The
controller is going to want the add_lock while it cleans up, and we have
a window where the device is known to the core via spi_add_device() so
could be deleted but might still end up on the userspace_clients list.

--ijEH42X9vsQS0Rhr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmno3gsACgkQJNaLcl1U
h9C5Vwf9EC8uNMt0H3VyX/19nU7fxVB+cOX0Z10H7rTGzLnyFGaQh6y+OHmta/c2
mLvkwwt2d1kFMIYZACgIhojbfVWy1I986KfRC7bcq6hamGgSJnC/ljZze1/O9PZz
2yfMBiqAwgJChsjsnaMaGVXC4affXNcVOhRZANXJXVVeKk7WShrKtnp9mkzcdlTS
wMiwsmWVQIP3uB4/6gadAsyxAJrifn6uzMcFMSQZKqs+kaMY9tVL1FHguyEv+LOr
P59hCA6b97GvI+AhiZWIrPWVMggS+jNnUutzKWgJCW5+WF3iR/Xq/WDJdV1ShREK
rY3iRpVtUv5WFjtNeLYIHYsDfzQMNQ==
=L8Y/
-----END PGP SIGNATURE-----

--ijEH42X9vsQS0Rhr--
