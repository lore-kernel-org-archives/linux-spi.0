Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFCC44605E;
	Tue, 11 Aug 2026 14:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786458997; cv=none; b=ndYyIM0NGliDIB5ph6GQFsn5HTGfjZMJCIVY9TjhxzUAQWV08B9yG79qNdMZczDhMkGZyX1jb+bTeIzNqg+Ni9aSYeAw96HuGVTSZn7Cns8+4sw7ehsWiZhn944HhL8+/wBcIJGmngJU36g4Ek+lvfA3CllpRLsxpq+rUhiR0Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786458997; c=relaxed/simple;
	bh=SWxH+mb3VCfT7J5Xo6DasTdYiKW4M3Qf0ZfEvbkcjvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gULjrUDMA+BWi7dvOr4cHgGoBv+3hzmAQWBFakxi+aS82Ki6zYc/y+ceJrYi55QaMUutnp4bLJQj0QwWs4L8sUUWcBWhCwAguyaGN5ukUzopePW/rw2LQgae9ORaejul8wBHbH44xk9+bnYijH//cVtVxoxTEkNmKpc4tLSGIoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZB+2JJ+a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZB+2JJ+a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 142721F000E9;
	Tue, 11 Aug 2026 14:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786458996;
	bh=wiZ7no0XlCoBnIs6g2WSqwwt3nDM4+tURvWhQMCc1d4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZB+2JJ+aRn+oTtZ1RSMbtJDOJJU3HjjrRW8cZ7RZOuYYBBJy7yfAKthOyICAnnALE
	 zU2U4g+AZ47Zwp9paUv6EVVGJj6uPzSj3jBoWAYX7mOMJE7plkHRX0kd7FJti7Mxpc
	 Mqa3uYD0Y3mFMatfF245ZJ7a2j4sk5sxhdSzDPm2IGuOnIpme1wVIKgjNMrIQ7B/KP
	 GyDKQLvnxZSbQ1ey/PJqF6st+IZhUutgTG6/gicwpro4sXZdeakC5qY3VZQiZq9iCZ
	 N5rq2B+bicL0N9+2PQwKwFlZSLGywDlVTryiHJkEtMXBp5qcxdzw42gdDkkPakJZ1Q
	 15mN4oe9LN/yA==
Date: Tue, 11 Aug 2026 15:36:32 +0100
From: Mark Brown <broonie@kernel.org>
To: Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: konrad.dybcio@oss.qualcomm.com, mukesh.savaliya@oss.qualcomm.com,
	linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, chandana.chiluveru@oss.qualcomm.com
Subject: Re: [PATCH 2/2] spi: qcom-geni: Add panic notifier to suspend
 controller during panic
Message-ID: <92fc6c7b-ea87-4577-b200-2bb36388f387@sirena.org.uk>
References: <20260805-add-shutdown-and-panic-notifier-for-spi-v1-0-b5db170d491e@oss.qualcomm.com>
 <20260805-add-shutdown-and-panic-notifier-for-spi-v1-2-b5db170d491e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BLl5EzWbCCQL02Jn"
Content-Disposition: inline
In-Reply-To: <20260805-add-shutdown-and-panic-notifier-for-spi-v1-2-b5db170d491e@oss.qualcomm.com>
X-Cookie: Take me drunk, I'm home again!


--BLl5EzWbCCQL02Jn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 05, 2026 at 04:12:10PM +0530, Praveen Talari wrote:
> When a VM crashes with an active SPI DMA transfer in progress, the
> SMMU raises context faults as the DMA engine continues to access
> IOVAs that are invalidated when the VM's memory context is torn down.
> These faults can affect other VMs sharing the same SMMU instance and
> obscure the root cause of the crash.

> +static int spi_geni_panic_notifier(struct notifier_block *nb,
> +				   unsigned long action, void *data)
> +{
> +	struct spi_geni_master *mas = container_of(nb, struct spi_geni_master, panic_nb);
> +	struct spi_controller *spi = dev_get_drvdata(mas->dev);
> +
> +	spi_controller_suspend(spi);

This will take locks - are you sure that's OK in a panic handler?

> -	return devm_spi_register_controller(dev, spi);
> +	ret = devm_spi_register_controller(dev, spi);
> +	if (ret)
> +		return ret;
> +
> +	mas->panic_nb.notifier_call = spi_geni_panic_notifier;
> +	ret = atomic_notifier_chain_register(&panic_notifier_list, &mas->panic_nb);
> +	if (ret)
> +		return ret;
> +
> +	return devm_add_action_or_reset(dev, spi_geni_unregister_notifiers, mas);

Should we have the notifier in place before registation, what happens if
we panic while probing a SPI device which is probing as a result of
registering the controller?

--BLl5EzWbCCQL02Jn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmp7M28ACgkQJNaLcl1U
h9CtgAf/f+6KUg6XOD9iIRFVR4rVpXye7ircQCwBQTKLQmyadEoMmiseBOTGIlGz
S+0SKs/Qjy/k+zIyDeJtacOCxEEtVXgs+YZ/Vt3x6yv0fvwqjA70ZZBJguLGb1UZ
EBdRiCE2MuxkeMrmuVvN1Slkth+OPL9U0h6Lh2T0Ue6PO9gM+ZlNWVqCSU3mDybQ
GLDGWZw7xYtBrfPZ5oMmp0SEMmJHIvi9BWx64+kvNQ+Q4nPnIzGd2+8wGKUW30gL
OEcYXD54lUv2RxVZ5rQKxI+eT5kdCPc92M6x3+O2XwTi8RSwmmqWQApxViQwc4Mw
suRbzVi+MP4YnPsfvmWY64X3LV7Cxg==
=f4mQ
-----END PGP SIGNATURE-----

--BLl5EzWbCCQL02Jn--
