Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27FFC2FF;
	Tue, 17 Feb 2026 15:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771343128; cv=none; b=FZ2FeCDVaXjA4wrsnV0QDuTDeFYSl5lTt6jpmObeM299dRX2EO8bJURV3zP4MvyIZ+YTU0JJ8Kfr41uhZqGRCjTuxXhLPvO8CnLaph+3+KTkvmrg8rX/QaRHri6WmpcEdixqjdfuh6XU70TPZC1MjQrmfeNBSwgxymfbV3BZawo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771343128; c=relaxed/simple;
	bh=9OFR4oH3Zk84H3xfRvdUSrHB2a6gJ5ZvV7zt654XCrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XSNusGGyCWn4nLCCecyiADlPju0mMB6mhbayEgk8IsG27QwTiRiVBGqbGKk2LszQ/XcIPevX2StkcrUmiFLtk1D4uaLnf5lzjMFl4tfNqVj5m1y1Qodi1vpLANeDh7vXmYh6dyg5NebTHRU1IfqjK9HtZL8kXoy38LIiT40SIBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jKnQR2cr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKnQR2cr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F578C4CEF7;
	Tue, 17 Feb 2026 15:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771343128;
	bh=9OFR4oH3Zk84H3xfRvdUSrHB2a6gJ5ZvV7zt654XCrI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jKnQR2cr1XLg2EolDlgOOsJJvW5kynO8j6yNVGsRIDnUXfll6v6Reco+E6qPaE7nE
	 EKdbWwSrPUUCBi7wG96d28bGUVIXtTtVbEaziiMRJeFaBGbeAUv+C2Mr/p7uN0Co6p
	 Bq3lGuicCZR8YR4wdoZ1oj803QSmbRH6hKq64AslV7n4EVYZeapSUv5Xb4EjxRdae7
	 qOSNKf0KYR0cqtYBvjg1wSdZq+NF7iOpX6Ry3Wj2XiYMgUITrSW3hde/XvOhmdRyUW
	 2R7M1Z9AAW3Msu1ymEjqmihLdWZMPIWg9ZJ02fFwfSP0tRW89HXq9L/9iNXjzlBVwp
	 ntkiCOSSCHYGw==
Date: Tue, 17 Feb 2026 15:45:22 +0000
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Praveen Talari <praveen.talari@oss.qualcomm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, bryan.odonoghue@linaro.org,
	dmitry.baryshkov@oss.qualcomm.com, andersson@kernel.org,
	bjorn.andersson@oss.qualcomm.com, prasad.sodagudi@oss.qualcomm.com,
	mukesh.savaliya@oss.qualcomm.com, quic_vtanuku@quicinc.com,
	aniket.randive@oss.qualcomm.com,
	chandana.chiluveru@oss.qualcomm.com
Subject: Re: [PATCH v1 0/4] Enable SPI on SA8255p Qualcomm platforms
Message-ID: <dde7127a-7341-427c-817c-35be6310dfff@sirena.org.uk>
References: <20260112190134.1526646-1-praveen.talari@oss.qualcomm.com>
 <20260114-truthful-just-boobook-16494b@quoll>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k5qFPc8EOj1BI2pK"
Content-Disposition: inline
In-Reply-To: <20260114-truthful-just-boobook-16494b@quoll>
X-Cookie: I'm into SOFTWARE!


--k5qFPc8EOj1BI2pK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 14, 2026 at 10:00:06AM +0100, Krzysztof Kozlowski wrote:
> On Tue, Jan 13, 2026 at 12:31:30AM +0530, Praveen Talari wrote:

> > Dependencies:
> > This series depends on Enable I2C on SA8255p Qualcomm platforms
> > https://lore.kernel.org/all/20260112104722.591521-1-praveen.talari@oss.qualcomm.com/

> It should not because it means it cannot be easily applied by
> maintainers.

> Why can't you decouple the dependencies?

I assume that was the soc changes mixed into that series rather than
something I2C specifc, there should really be a shared branch with just
that stuff that driver subsystems can pull.  In any case none of the
dependencies landed so I'll discard this, please resubmit when there's a
clearer story with dependencies.

--k5qFPc8EOj1BI2pK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmUjREACgkQJNaLcl1U
h9AUSgf9HxRu/lpm0ydOjbz6RqYmUoYPIKSLnPcwvcvhmWLtzpXY9RFsPe/b0oZs
x4VvH8Z4dASHwXd1oMl3tx9fOxo5RaVxky5TE4CbWK3HntGVLcFCKoAADQ3OpyGS
qtbPpEQGbbgfmTgVrnqL7RTCrmcIXyyF2ar12dyQFCGaLf5/fMViNCrXSvvV7u6i
6rL4GNl+oSDfq/0RYA6KXzOv1feGLbOTyRVKp4QXyo1sIqKBjVlfj2blHh0o5tpB
OS5KfL1Gdhzu89wzPXPUdCJKmqKyyhQcPxIaHTDxynjfpPI2FOggy5TfdVbqw6+H
htetCfMeP6a8hv6Xkff0poO/XkirSA==
=Y04F
-----END PGP SIGNATURE-----

--k5qFPc8EOj1BI2pK--
