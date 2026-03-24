Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DA6366546;
	Tue, 24 Mar 2026 16:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774369491; cv=none; b=PodjEKguK09s4qd+0tAsMu8LAcFvKWJkBv3tZhyPGLKfANXmOQsK90D2V8wiT8yKPILw0eaSUxTK/t1GdCFnZyg5kXTko0NAcZTHBfi9LZjRf1o5V0LL9pAKXrOvETzV5sIlxPcqWuDVk19zv5RFRnP6jYeABORCaa5kSSpIs+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774369491; c=relaxed/simple;
	bh=AV3JSQKuN5JjsAMvQHvfmEmII0cPQmEt6VWTDstHTBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r7YqAeA4Iz/e/4gxYKjXkzEkPctxgJA/gRPwZvvabGq9/G+SePJ4i3Xj4RxHhTGks5YlennpAuZrKD/s2UVEjadHK99TEgjPsfvcdqPsv8sE5NXCTqu34OVWOd8s79mwC75kv9QjqMobwu+UjjERhanYVs55zqc8+ExuQDiagfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+sqRzDa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+sqRzDa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0284C2BCB2;
	Tue, 24 Mar 2026 16:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774369491;
	bh=AV3JSQKuN5JjsAMvQHvfmEmII0cPQmEt6VWTDstHTBk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A+sqRzDaWhJwlRd8o7WxCj0yhm1IoCk4TASkn6BLPiYCjhSjAsUOmXxAGGuGKyfRO
	 k8kzcbV+JtU1oB70Sc8uidyX7+9Wf+yLtT9O+KtxIxTBkX0hhNCKSz2+NXXfrJmzLp
	 WlqcL6bJ3Q/6kknkguWOgy87/VM6Ebc7vixzLzaPjkePX8m9931unsB9Lr2xRmHVUF
	 ybDg348tkmiYW9iXnoE0df9uFr1VtfFQtsvXdH3kcank6h1lEwLcm3Eo0GRqVQ77fo
	 OWy8fmnh5a+Y3rGvBBOzIaaTmj8+f6rEz161fhEWLf4ZdkgXFxcA03Kgw0zCUiMqm0
	 B3hHY3MmA5pQA==
Date: Tue, 24 Mar 2026 16:24:46 +0000
From: Mark Brown <broonie@kernel.org>
To: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/6] spi: spi-qcom-qspi: Add interconnect support for
 memory path
Message-ID: <92c58ea3-5492-4de9-bcf7-d4a419480002@sirena.org.uk>
References: <20260324-spi-nor-v1-0-3efe59c1c119@oss.qualcomm.com>
 <20260324-spi-nor-v1-2-3efe59c1c119@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+9dB+3TDrc5h9gea"
Content-Disposition: inline
In-Reply-To: <20260324-spi-nor-v1-2-3efe59c1c119@oss.qualcomm.com>
X-Cookie: To make an enemy, do someone a favor.


--+9dB+3TDrc5h9gea
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 06:43:19PM +0530, Viken Dadhaniya wrote:

> @@ -829,6 +842,13 @@ static int __maybe_unused qcom_qspi_runtime_suspend(=
struct device *dev)
>  		return ret;
>  	}
> =20
> +	ret =3D icc_disable(ctrl->icc_path_mem);
> +	if (ret) {
> +		dev_err_ratelimited(ctrl->dev, "ICC disable failed for memory: %d\n", =
ret);
> +		icc_enable(ctrl->icc_path_cpu_to_qspi);
> +		return ret;
> +	}
> +

This reenables the ICC but not the clocks on error (which is a
preexisting bug with the error handling if the other ICC fails but
still...).

--+9dB+3TDrc5h9gea
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnCus0ACgkQJNaLcl1U
h9CSBwf/SlssMZysnjl/o8P4q4C0hXZGv8rwgCV/cDjkmFh8QLdE1R1hUkbBS+aK
7ecv/Mtj3NzB4bWuD/CnYmRWW07YajfBupommj0nf6aJr4xbufDbzWilo7pQDSSu
40HmJscewLPrL6kLT5F1YC+7AUgoui/eKKeZ/o87Hd4v1SebZexmBMvrKu3ztXYo
dXcGrOBz7McDvDk74QOxz3KPgHbk8bBW2iTisJev7fEclDYSY9SncnJhj9vkzTth
9lSkluzZnsrGHP8qq2ZqVIy+kF6e8Q8MwEL7pfYmF3RJV65nt4mH/YxhulgZw5W8
3eoGxDakn46tzr6HvQ9OeI88yMMGRg==
=AfuE
-----END PGP SIGNATURE-----

--+9dB+3TDrc5h9gea--
