Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BCF42901C;
	Tue, 18 Aug 2026 16:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787072360; cv=none; b=cbl/1JYNtwK8j27LHNCRsItuEWVagxxv9LsgSgZsBlva/sglIIk0qavDeqa5/ylMwTvPfy2b8fufEJI6X8FDgX3b3xha8gt8Ze/rJjL0auzqG471xZPMjBGdBhsMNlXf62GKXWJ1QWwtDWILgNg7WwZD2sF/1akxbiN/1B6mpAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787072360; c=relaxed/simple;
	bh=qANcu16uoZ+ABpAp2RCAPEboS+TrR/N7tlf1WD6SThs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BNeXzyXrzrrLXseeWbU/TyfBYoxb5FWIZR+dCNP8KOIFiAvovLxRkktyGHw5U8enUDjHcVQCHsvAVFPDpOEIBHyiTEjYMGZ9Y/MRVc19ArFegRUtzdUxWZRyKtlsGtR2tKs3BwJkbPyKn44hgYGTVDgpLyYNAViHrsCgspgalDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iCPc6Ffw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iCPc6Ffw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18A541F000E9;
	Tue, 18 Aug 2026 16:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787072358;
	bh=ggwiN+VBldpOpEmqrWu9zWQx9QpGpq1CF45MZHglses=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iCPc6FfwHVOejpu/qdj0czkugnp3AYb8CYC9gXsL0wosHFCNWpSqIaLCLgqoBJlHi
	 ofc2wN3WQRGALt3tZg5dvNQHQAP6f/tzxbe+3KzBh82Ax3TjAPlrDwrgIErfpjXKOy
	 58rtQYDyfjuUQPIHfOdOu2b2AmtXuGRUMS2hLbFsZ0KuFffaOXCdqhek+ZHtvYh1q+
	 1G9WNOhIvTPLsrU4iaGbIq7kI3on0eeHgjqtPsae4utvMUV+7sbnObOPdZbVtExwNw
	 zjMhtREABDXXL6SM+mRR5RrgRpV3OX3YT2PWW3jnYEk/hRaoZOX+CVG21NGRUttmpz
	 FuOFOSmkcYXng==
Date: Tue, 18 Aug 2026 17:59:15 +0100
From: Mark Brown <broonie@kernel.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] spi: dw: use DW_SPI_INT_MASK instead of hardcoded
 0xff
Message-ID: <1b3c5561-47e2-4b85-b13c-8467c5f6ea29@sirena.org.uk>
References: <20260817151404.28324-1-jszhang@kernel.org>
 <20260817151404.28324-3-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lm1TBidl9fkylfQt"
Content-Disposition: inline
In-Reply-To: <20260817151404.28324-3-jszhang@kernel.org>
X-Cookie: Smile!  You're on Candid Camera.


--lm1TBidl9fkylfQt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 17, 2026 at 11:14:04PM +0800, Jisheng Zhang wrote:
> The Interrupt Mask Register valid bits is bit[5:0] which is well
> defined with DW_SPI_INT_MASK, use it instead of the incorrect(but no
> harm) and hardcoded 0xff.

>  	dw_reader(dws);
>  	if (!dws->rx_len) {
> -		dw_spi_mask_intr(dws, 0xff);
> +		dw_spi_mask_intr(dws, DW_SPI_INT_MASK);

As I'm reasonably sure I said before this looks fairly obviously like
defensive programming intended to handle future versions of the IP that
define more mask bits sensibly.

--lm1TBidl9fkylfQt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqEj2IACgkQJNaLcl1U
h9BrjAf/RmF2L5aWVBCQvCivbFoJBzdf7HmTKd14LJWfExaskeECoenSgcKNENrh
u6gNEcCl8HxC5xZd3+fAfYNwDxLrkD/FGJ7atAhcbHDoZaXRBVkCP6PsY2+31USy
fQ8QdOSGGonYOBYE0kUVFI4nA2yvSZahhy+b8gv4MVHi/9gxqkGz0hmh1E0hwzSY
49fjHtE8zcYBoJ4dW+xU0OqVreczhVpbbsThEJt9or+OAPkEfhG0rQAJKG/J40J+
jq2+7aaFZI/PjtRMj+oLuavwU8fgJk/cFJucMlqG/SR4nkMUEx1fyYJCgk75NoHt
2R7zVKOkyrzu1O4bl3id+bXju83etw==
=D4X0
-----END PGP SIGNATURE-----

--lm1TBidl9fkylfQt--
