Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9463AFCF0;
	Thu, 24 Sep 2026 22:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790289869; cv=none; b=fWM4+KsRvs5AVEm8ez8OSqfEN+bgVk2+cJC6hNKu3wuxNmLBgePBHh0extDH1KuGOHTx88Vx5A9K7NsbGP+F/lBcNAbamGMPlIJ3Y58NiD0IaUNVitf1jc3sNibbcoE5n2emWSgXLIJeiAhAzxUxIiCguXJBWvPKDGmbxydGNXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790289869; c=relaxed/simple;
	bh=/LcAwawtdh+vFXy4RPNGhay5ZAJ5ZL2TM79kGXhvM+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XUZW2E4KGJFfIg5kMhXRpVpfx90c8DbVEsQaMbWvE1AniXREIlLiOP1kwuovzChDxirXEi4Iu94aY67nYjodpYUMHsm9T5zgCS0dvwmdQ8JlJwOC9thBiDelBaIMz1UZmF5SuLTVQRPuaNsjZ27DZeqRkFi0julEcwvb03QAPMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/sMDUKy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/sMDUKy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B9201F000FF;
	Thu, 24 Sep 2026 22:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790289867;
	bh=KSp5vtGOZtUJ8r+LrSa8vQqGsW4HE7drn/gWpkEcRwI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=J/sMDUKyatmBvfxfR9vf4cmjK8LAYReknQWe2VcBZm/pr4YP9HlmsnJc/p3rZfS+j
	 56XerZBtaYeciJ/diNDgzj9K8FNWLr7yRPo49+OsE+BBnS9OV9oFIr4tWfsWgH2oOz
	 tewWAyqj0QgkCaQgILPoHKLAvlhWRUppkW1vAHt/fN17DF1UOtDtlGLqzL/152Posj
	 rbKIc3G+5GsTCfAZpkLrWZFZjfG0qqZ6Jej4MbMrEUnBsSqZzP5nMLEjpeYNKhLqjQ
	 lPGGxFVfqXo+xMvPW3Hl4vjWyx+XdL8BVa3pA+41JDrvFys6xED2B6KlfIlKQtiUoj
	 SjfrWLQO7+DMg==
Date: Thu, 24 Sep 2026 23:44:22 +0100
From: Mark Brown <broonie@kernel.org>
To: Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: konrad.dybcio@oss.qualcomm.com, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	chandana.chiluveru@oss.qualcomm.com,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] spi: qcom-geni: Use GPIO to notify master of SPI
 target activity
Message-ID: <fcf39ba0-ed92-4a47-b778-a6d39e6831a6@sirena.org.uk>
References: <20260824-use_gpio_to_notify_master_of_spi_target_activity-v4-0-fde2ebf043db@oss.qualcomm.com>
 <20260824-use_gpio_to_notify_master_of_spi_target_activity-v4-2-fde2ebf043db@oss.qualcomm.com>
 <95c6a43b-37b7-48eb-be88-79f1883212d6@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wTAftiCSfHDXtl/h"
Content-Disposition: inline
In-Reply-To: <95c6a43b-37b7-48eb-be88-79f1883212d6@sirena.org.uk>
X-Cookie: You enjoy the company of other people.


--wTAftiCSfHDXtl/h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 24, 2026 at 11:41:14PM +0100, Mark Brown wrote:
> On Mon, Aug 24, 2026 at 07:56:00PM +0530, Praveen Talari wrote:

> > When operating in SPI target mode, the GENI controller relies on an
> > external GPIO to notify the SPI master about the target's active state.

> I'll apply this since it probably doesn't actually matter but this is
> broken for probe deferral, and might cause issues if the system really
> does have a GPIO but it fails for some reason.  It's better to just
> handle all errors as errors, _optional() already returns NULL if the
> GPIO is genuintely missing.

Actually no, it needs a rebase anyway - please resend against for-7.4.

--wTAftiCSfHDXtl/h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmq1p8UACgkQJNaLcl1U
h9Bfkgf+JNq7EeZiGGKVXtqGg8FSC4PZwc8A09PQhuHez6cEkJ2P5P2IFbYaAu95
EByKLpuxp4N6yyHy7WDJQLov/T3FTH1mXpQTGS2d6toplztfwx1o51eEhkdLsEb6
dk0HvBNiaFxQ1LxA+YOLkmnFJ2gsf0UIoOGZaSRgSeycB8GC9moQhVAl2T2umjrR
eOA4ieU7BjTy/WiAMDo+zsYixQcTmB+EiA8A3hwq0PYZ0sukbQ6tiVop7dsOzpsr
M03A+LTZHnt0xSVF8SH82ZH/mWJQmt/JhmlWqcr4iV/uF9tVM4Dc3msb1m2FnOnN
bJBF1UolGYQxJxZ8QyRiMbAL6T9uqA==
=pap0
-----END PGP SIGNATURE-----

--wTAftiCSfHDXtl/h--
