Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB8C2D73B6;
	Tue, 29 Sep 2026 14:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790691550; cv=none; b=kjP28KuwcQVX9hiR+QKop7vfmDZJWxfsOSLyehd4+XolLswdBfACgfbEoGGsf9WMXBNPL+dCs4hZfVF29nDstlc7XhkvFGBVRCLKe8LXu3ctjzXaXhdmccCKb6hAYvCkfbXPt0ea4psCT14y594Ks/50Dn1clw62Hgy0RDcK4NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790691550; c=relaxed/simple;
	bh=msv1VfbxMouMfpJOqYtUp1zpAM93akbatSRAxanX0bU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fyNhUbZQdRQ9N0yI6mlHQ1UiV1aVucJL3O8FJ9/V5POEqr93sUAEDDuhQlrX44zoy2lfigVVqRZI/RyqoTEhne5ImJvqy6cn5SoKoe4LsOwB5FYdAYit+/f2nYTjbzgXays/BtWepWtgLcv8po11eXNJgH8j2zw7Ao8ZGVRObFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dxexv7PO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dxexv7PO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05C0E1F000FF;
	Tue, 29 Sep 2026 14:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790691549;
	bh=aQjpqFcUieJT14AJF/TfTki/tjD9DIi/u1j262xyIRk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Dxexv7POcq5Ca3nMeu4cnL+K3yWPXLpvA37q6s38MeC9cM3qAbNanJLK5YuQ3FXoi
	 3e5HxPl3oEz+2rDnEZcMm9HuWi18s3BeEaPxedw8xOWs8ffialIb9zIsePUK6doG6L
	 LNArvcZeX0ohwwwBRbLIgHTHv1dW1tQgfDROSRGkNFIxUS0hr2LGJW8LIxHMmcmt9g
	 5We4/ZNB6C7+gJx83BYYNtFAz8f9nmHgAZlK+MOJgS/LEfKUQTfqDg+txEiqH15ixN
	 Cu89DLNreVX1nA1UIgvXxjTJoBEnLnw65SnDJGQ+X1A+841Be4GChZZbvFu5XH5qPJ
	 qFa3flWGRWO2Q==
Date: Tue, 29 Sep 2026 15:19:05 +0100
From: Mark Brown <broonie@kernel.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Joseph Steel <recv.jo@gmail.com>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/5] spi: dw: use threaded interrupt and optimize the
 threaded ISR
Message-ID: <ae2432cd-5dcd-46a4-94e4-195b4ac9235e@sirena.org.uk>
References: <20260929121817.20896-1-jszhang@kernel.org>
 <20260929121817.20896-6-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2fWoiYUH4oomEPrZ"
Content-Disposition: inline
In-Reply-To: <20260929121817.20896-6-jszhang@kernel.org>
X-Cookie: 1 bulls, 3 cows.


--2fWoiYUH4oomEPrZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 08:18:17PM +0800, Jisheng Zhang wrote:
> To avoid blocking for an excessive amount of time, eventually impacting
> on system responsiveness, hard interrupt handlers should finish
> executing in as little time as possible.

>  static irqreturn_t dw_spi_transfer_handler(struct dw_spi *dws)
>  {
>  	u16 irq_status =3D dw_readl(dws, DW_SPI_ISR);
> @@ -245,7 +296,13 @@ static irqreturn_t dw_spi_transfer_handler(struct dw=
_spi *dws)
>  			dw_spi_mask_intr(dws, DW_SPI_INT_TXEI);
>  	}
> =20
> -	return IRQ_HANDLED;
> +	if (spi_controller_is_target(dws->ctlr) || !dws->rx_len || !dws->tx_len=
 ||
> +		!spi_get_csgpiod(dws->ctlr->cur_msg->spi, 0)) {
> +		return IRQ_HANDLED;
> +	} else {
> +		dw_spi_mask_intr(dws, 0xff);
> +		return IRQ_WAKE_THREAD;
> +	}
>  }

If we're handing a short transfer in the first interrupt then we will
already have completed the transfer at the point we check have which
would allow another CPU to start another transfer first.  If things go
very badly this might mean that the length checks look at the values
=66rom a new transfer and wake the thread.  We should probably set a local
flag before we complete the transfer and use that to decide if we wake
the thread.

--2fWoiYUH4oomEPrZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmq7yNgACgkQJNaLcl1U
h9CcPAf/QV5YoaXMJYh9cM78e+oU3PR9jRB/zbOq0ZtTbw6oFHF5r7E43RhOkEva
y0J2VHJZBYeq/akr+8Td4WLoDY1pQcjtzLXaGUQxb9QzGRnuJUUOxgFQIFSQoWV+
0FYdu13z8MBAn7vyBh1jH1qWUBNMBR+PioP6NWDyqIYAGPsth8H30R/Tzn7/E23P
cqeQuwF5ujNeThdK3q/emAZy1LKESNxjdQzxl7h1fs0ILM4Wl5w1Ki+lWpMJfC4e
s24IVRo0/H6wrN4kBog/fRNkHrZwhEYJx+1hHp0H1UHaZeCRIEB3SWBbmkH/x4Fa
PBDgOi2sSXantLSXcor/py36mZFreQ==
=Ueez
-----END PGP SIGNATURE-----

--2fWoiYUH4oomEPrZ--
