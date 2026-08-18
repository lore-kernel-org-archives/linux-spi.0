Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826DD2C15AB;
	Tue, 18 Aug 2026 13:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787058128; cv=none; b=pOFN7W/VFRBU2iaupPCGSEQIwMDk+G/sr7B8y3wRpLYQ9qOaU06hC7e6s7fr5HtVqLKApIz/BxEzz1O7N5fLND/gDn+u0ZdviqweHO6jLXgmqjg0fVQ5cOnQoTnKcKNPa4xQa6aCvDnQQxZEeEsGfLRGUykMvPNGyBYSjMQYFzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787058128; c=relaxed/simple;
	bh=HNHH/4IyUACffgLs8fjtH7lkK2cGElZU/Dw8wCOUOxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NuvpY1RJi2+D3TPp3Lolg7E1Yhu0McIpO5nb/enDIAwju5IEyredFnqHe33cZ0jbHa4rk/OAT/lER042nD7084eJSlEYQ6H6MDErYhBTy5s/6FTZbHBDPBKvsFLs9AnJByDwnzi/DKUGgh4ohmc7KU/AHIkfURjnP9j/5Rf+m48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j3ofqNQk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j3ofqNQk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B31741F00A3F;
	Tue, 18 Aug 2026 13:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787058127;
	bh=HNHH/4IyUACffgLs8fjtH7lkK2cGElZU/Dw8wCOUOxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=j3ofqNQksTuAzXBkn7Y0dAM5dr+l84wFwA4xBrmjnpspbl+QK86wesZ/jVGsESVAu
	 xD/ErqJJsRh9J8pS8zAw72LauSVXtUz//zvCG0OHHRqWEmyG4DYdQdexvNzx1xbFA1
	 +r31bvn3UPLFb+g8UIsLs6DJSkh0E+wKWE3ahzfunijYSsCaZYkZJNOWuPXHQ+2BMr
	 vRh5QmZFO+8HrIP05fsJqYImsZmyt7kq7OAftdSJnoGylH8+JqPMaRrWQgQmUB5TQ+
	 1yOyqsaZERd0qGmKNqJ792S1deTNUyfCLwF6ABmJyG2OrdAv7ckhTEzCKqVETyuc9w
	 74SOU8ecqYkIQ==
Date: Tue, 18 Aug 2026 14:02:03 +0100
From: Mark Brown <broonie@kernel.org>
To: Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: konrad.dybcio@oss.qualcomm.com, mukesh.savaliya@oss.qualcomm.com,
	linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, chandana.chiluveru@oss.qualcomm.com
Subject: Re: [PATCH v2 0/2] spi: qcom-geni: Add shutdown and panic notifier
 support
Message-ID: <7603533a-92e1-44b0-a301-dac79dd27923@sirena.org.uk>
References: <20260818-add-shutdown-and-panic-notifier-for-spi-v2-0-eb25d56634a0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7OnN4c4Ovz95NXMs"
Content-Disposition: inline
In-Reply-To: <20260818-add-shutdown-and-panic-notifier-for-spi-v2-0-eb25d56634a0@oss.qualcomm.com>
X-Cookie: Smile!  You're on Candid Camera.


--7OnN4c4Ovz95NXMs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 18, 2026 at 04:15:53PM +0530, Praveen Talari wrote:
> On VM-based platforms, if an SPI DMA transfer is in progress when the
> guest is torn down (via reboot/shutdown or a panic/crash), the DMA
> engine can keep issuing transactions to IOVAs that have already been
> invalidated as part of teardown. The SMMU then raises context faults,
> which can affect other VMs sharing the same SMMU instance and obscure
> the real root cause of the crash.

This doesn't apply against current code, please check and resend.

--7OnN4c4Ovz95NXMs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqEV8oACgkQJNaLcl1U
h9C9Zwf+K0069U7xnVdkmj+9ormsD+ZIVwtZiiQndjHqPCYfbj/pDUbS98P5GEDS
czpBslllmUIViB2HXG7b0y+9h/EwQOmgZ6pBSZdlLBDSmBnJXZl1LsmTfNPjInlg
fBRZIxxyYz6cnZbSKhVWs+UmIRnH18EYLiJgtU0UoMEuIyCmfRl7t72vnETKBGjw
4kEwCzBs2UJ9cYt8KHD3wffRDuxjzU3GhNg7aMFT6Nw0Edz4DWUroFFrwB/l92Xb
LBSs/IvLsS5pHBY6S+9bzxe2tdnbTQSamV406NLxtDtSBAXTmM10Sy77ri8jd+00
t6BfDK5cvsS2FlqjCSGESD0JoZDPkw==
=XgsM
-----END PGP SIGNATURE-----

--7OnN4c4Ovz95NXMs--
