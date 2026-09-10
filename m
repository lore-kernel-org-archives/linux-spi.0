Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9DC49B5D0;
	Thu, 10 Sep 2026 22:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789078630; cv=none; b=TKdrJYFyEklZ4Prr7ee8JDkF8fypYNF2oDTjFAohMkMCI2oRkh//8E8ZkTpAGZhH0im/CqYU6ClMxt2Ess/gvzqc0v2AKwP+znZTWTIVgxcRRweWG/72Snh722W+APGEWiJMjYrzDnqQS1rWIBwytuAi2wqkCm3tv6OhVOlzTPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789078630; c=relaxed/simple;
	bh=beq27RQOuBz3rmFCqPNVU5aWnBcD61l1tdD2FKrwUYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BsuE3lDB0V8KKIvicxG+yyQAXKiouVDyYWrbiOoD7FUifR0iaE+dUSSrtA/BjyTUPOwN7zgpSerOTuJuAG6iKTWTq2/yzfaUndpU7o4+qWVixArd0Zlm8p9pY2JiLLtUxUw4I43MlP3ZrdCJ6xywzEP8hFYDj4lpnFmCVfEA54I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QhZ6GkK5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QhZ6GkK5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07D0C1F000FF;
	Thu, 10 Sep 2026 22:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789078628;
	bh=URxl+o12EE5hMsUw7PASgNl0kBa2m8/VC3cuEfTrfVU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QhZ6GkK5Fi+B92sXeqP2okF2KVRInAO6KAai3sgu99GWqIo4awuMhRcjdEwv2a7TR
	 sSXFZHcpv2jryjIhMjqjS5CgU35POEjp9ptdzXZrr8Upd6T0xxPYarfmzP/5XGOnjg
	 ArY8U37vevokDBDgXk+iKq4zokwlJZgLAAdU9TOLCSnig63pc3vf2qpdvwMQg8h54K
	 GtiRXyt4KHR1bDemNlCRNc7wgrZCHgHmioJoTSgv6syeI9/UZ9/rLq+t6tzbD4x51A
	 UaW0yW8iER2m/TKd4kfpMuwVWq64avcSJ4ah3LLBmVb6bCHoAwZk0IWah0Czu1k8KZ
	 grDQAJ2/yeZog==
Date: Thu, 10 Sep 2026 23:17:05 +0100
From: Mark Brown <broonie@kernel.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/5] spi: dw: use threaded interrupt and optimize the
 threaded ISR
Message-ID: <8303de6e-20a6-482c-82bf-ec87034042f0@sirena.org.uk>
References: <20260909143652.9234-1-jszhang@kernel.org>
 <20260909143652.9234-6-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="e6MNrUW3BJ/Ft3nO"
Content-Disposition: inline
In-Reply-To: <20260909143652.9234-6-jszhang@kernel.org>
X-Cookie: Gravity brings me down.


--e6MNrUW3BJ/Ft3nO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 09, 2026 at 10:36:52PM +0800, Jisheng Zhang wrote:
> To avoid blocking for an excessive amount of time, eventually impacting
> on system responsiveness, hard interrupt handlers should finish
> executing in as little time as possible.

> +static irqreturn_t dw_spi_irq_thread_fn(int irq, void *dev_id)
> +{
> +	struct spi_controller *ctlr =3D dev_id;
> +	struct dw_spi *dws =3D spi_controller_get_devdata(ctlr);
> +	u32 rx, tx, imask, mask =3D 0;
> +	bool finalize =3D false;
> +
> +	do {

=2E..

> +	} while (rx !=3D 0 || tx !=3D 0);

This will sit and drive the FIFOs for as long as we manage to push data
through them.  Usually we should have DMA so any long transfers wouldn't
be here but if there's systems with this controller wired up without DMA
we could potentially end up doing very large transfers, that can trigger
the hung task detector.  The simplistic solution is to use cond_resched()
to give other things a chance to run.

The hardirq handler would just do one round of FIFO operations and
return, allowing other things to happen until the device interrupts
again.

> +static irqreturn_t dw_spi_host_handler(struct dw_spi *dws)
> +{
> +	if (dw_spi_check_status(dws, false)) {
> +		spi_finalize_current_transfer(dws->ctlr);
> +		return IRQ_HANDLED;
> +	}
> +
> +	dw_spi_mask_intr(dws, 0xff);
> +
> +	return IRQ_WAKE_THREAD;
> +}

It feels like it might be good to do one round of FIFO in the hardirq
handler before deferring for a longer transfer, that would avoid needing
to schedule for very short transfers.  Essentially a copybreak like we'd
use for choosing between PIO and DMA.  This is entirely based on vibes
rather than having benchmarked anything, but all your numbers seem to be
for larger transfers rather than a continual stream of short transfers.
The people doing stuff like running CAN buses often run into trying to
saturate the bus which means they are very concerned with the latency
=66rom transaction initiation to completion, and from completion to
initiating the next transfer.

TBH along those lines with really short transfers (eg, read/write 16 bit
registers) we might not want to bother with the interrupt at all and
poll but that's a separate thing.

--e6MNrUW3BJ/Ft3nO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqjLGAACgkQJNaLcl1U
h9AHIQf+J74EtVYvLl9CcdiDt0gfsgKDRFSet8CgLa/bpWROMLnJe/AahN3aYTsL
6uSISfkYeWk6zhnRyElAZLXRVoEJA5GwM9iau2Uw06ffAQAjpjR3DsWraFnsOKr6
ln42pQc86nfnonzdWS+xH5oW+6SR4n/hhK6VQT8qSV+NLj7LOJDu5YDo8ZmCU222
eU9mRVyX4JXs9TSGj9/AnGV2CQ12wT1QmNNKuovGISMEeP+dIU0Wobw2ZFqrmZ9s
7mTAnVdiDtdWQvKsyQNnNbHwyU3TcPnzlMyxRNSRQNODVESUgar8AlfGgIdvHXjV
IZ15Y23C1EfLsIaPwdkNobURLX65pg==
=cT1g
-----END PGP SIGNATURE-----

--e6MNrUW3BJ/Ft3nO--
