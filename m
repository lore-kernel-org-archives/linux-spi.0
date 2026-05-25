Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FC6388E76;
	Mon, 25 May 2026 14:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779719525; cv=none; b=jEbj0XihHTYcHBCwnPjvmvYf193regAHOX5WXz0Vme2tvXpTi0UGsLXtOX7+AFwnDkkH/jB0IiwsrRqHH/s/yml3Gm71Vgh9NVrawqDqkbatpDAewkUfnBhE9dDZ0IN8Fq9zn3jYiIQvlpHDS72jdKhNdrJC0+UpWOo/r0EM/Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779719525; c=relaxed/simple;
	bh=eGmtutfTNHWCuzZSq69FOEN+O3d1bZKZjSA0iYqjCTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nXM/xSfEiiuXVCGo1sMrcsbsI1fsw0mtmCkK23TBSom6Bor7u0g42XrgjhLXSqbl9H62kQA2O4Kj3GABErwz54IZrETjkCYjmmi5bJY1QnG+BXzTZDnsxY383iR5c3lsE8wu8/d4EC/dabEHZtoEOMAUHt0zPytNiUQJe2SugEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jD7AcrDk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jD7AcrDk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 282771F000E9;
	Mon, 25 May 2026 14:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779719524;
	bh=/7eXa2b7iK7xeOlwfPy93bRK+JmdOZMxt1VR1hawuUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jD7AcrDkmarwVFuc2vrrWovXwPEdCj+NyWrUdZd9xc9HvuCa7gwWLNcW0mLjUVCal
	 EzxEYNCh759AbJTVmT68NDCB9EJNkR5/ejZ6p5scY0RHcyYFbAm2ugg7uIlFBJyoIp
	 Qi19JLzh++mO3/CUrcbtrrgv8p0hBya4vtEd3IMP3LzmKxhxiCRFoRjXUDjLLE0U4c
	 DomH2jK5iRiDuD2NrAv5wlvU7/XgobvTrUTPU9OmRu5wb4+kdlKwuLXNtCN3pX1E7O
	 P1aYOqln/360EpZHWKDyaeq+z/OPSnGfW/0tYQ/u9XB+f0ItsU1khj56LufxQEdrhr
	 3fBT1G+thAKzQ==
Date: Mon, 25 May 2026 15:32:00 +0100
From: Mark Brown <broonie@kernel.org>
To: Peng Yang <pyangyyd@gmail.com>
Cc: Serge Semin <fancer.lansen@gmail.com>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Peng Yang <pyangyyd@amazon.com>
Subject: Re: [PATCH] spi: dw: fix race between transfer IRQ handler and
 timeout handler
Message-ID: <d08e1763-1130-48ef-9804-22e708c6e8f2@sirena.org.uk>
References: <20260522095727.18307-1-pyangyyd@amazon.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="K936rvH8MW1gkn2v"
Content-Disposition: inline
In-Reply-To: <20260522095727.18307-1-pyangyyd@amazon.com>
X-Cookie: Prevent forest fires.


--K936rvH8MW1gkn2v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 05:57:27PM +0800, Peng Yang wrote:
> dw_spi_transfer_handler() can race with dw_spi_handle_err() on SMP.
> When an IRQ-based transfer times out, the error path resets the chip
> while the IRQ handler is still accessing the FIFO on another CPU.
> This causes bus errors on platforms where empty FIFO access is illegal.

> Fix by adding a spinlock around FIFO access and chip reset to make them
> in serial.


> @@ -240,7 +243,9 @@ static irqreturn_t dw_spi_transfer_handler(struct dw_=
spi *dws)
>  	 * have the TXE IRQ flood at the final stage of the transfer.
>  	 */
>  	if (irq_status & DW_SPI_INT_TXEI) {
> +		spin_lock_irqsave(&dws->buf_lock, flags);
>  		dw_writer(dws);
> +		spin_unlock_irqrestore(&dws->buf_lock, flags);

I am having an incredibly hard time convincing myself that these very
tight locking windows are safe, especially given that we're using a
value for irq_status we took before the lock.

>  static inline void dw_spi_abort(struct spi_controller *ctlr)
>  {
>  	struct dw_spi *dws =3D spi_controller_get_devdata(ctlr);
> +	unsigned long flags;
> =20
>  	if (dws->dma_mapped)
>  		dws->dma_ops->dma_stop(dws);
> =20
> +	spin_lock_irqsave(&dws->buf_lock, flags);
>  	dw_spi_reset_chip(dws);
> +	spin_unlock_irqrestore(&dws->buf_lock, flags);
>  }

What prevents an abort happening between checking the interrupt status
and trying to do a read or write, and/or is it safe for the readers and
writers to run after we reset the hardware?  We didn't reset any driver
state AFAICT, just the hardware.

--K936rvH8MW1gkn2v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoUXV8ACgkQJNaLcl1U
h9DLLwf/dnkbTS1W0gSQfGF0FYiG10eBPceV1UcX8eu+W5wdygDDWC+REaS5P5U6
EAUi1zuYhE8H4EniAmmsKGk/sTlH247xl4ilmVDvF6mkF25SK+fsxU6zmBWOrK+h
Pb5IRscryzJ++B/kBsk/AhkJ0vHjuh9VLkpm+ujTiGzT2Z/aOPAv009KIXL5UsrU
SPJ48yzm5Dj6lWle/lxnIonqQfyUV/cPVRQkG3lvA3lJ29P8og0S2NrnOqPVM7z3
AcdA5t6CkthiasqT2xsBh0czyRrypNIIOFyfRDMkh5B3kx8ulYtx5p4ywFlOOZkG
KWsW+t4W/aoVhTxl2WNpE6Za+qqc6w==
=UqZ8
-----END PGP SIGNATURE-----

--K936rvH8MW1gkn2v--
