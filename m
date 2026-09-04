Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FEB49EC45
	for <linux-spi@vger.kernel.org>; Fri,  4 Sep 2026 14:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788531289; cv=none; b=gwjeD0JRQxO7yiJtd/PBedv4uwNCEAYKkabXguJmYpQt/75T5tcYsQAPbHsaFK0wxS41FWQmuLYL5bv6HzcASPz5T5/qtI7nDBp9jEBIXn+F2XlQssu5JIyMly104/JuThkcKtC1LhXrzHiQacQ4lbh7CWYiaGFeDM8TPxz/Y0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788531289; c=relaxed/simple;
	bh=bXUUFTrQPpAc+iKmJN+Y3+pAIqk/wumQU91M8g4LqA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HrEDgWbRLs3C5qdVPckRPVvoMZYrft7GLkBQ3crWe+Z6N9cDohyrUyXoUIoxeif8xQMY0teJ7U4isL0Gt6J2LUJqw0RPoMSDkvtsPvLaVsBbFh4SXoIdP2Dd36KeHbUtn35L9GQg9exob+pKXgkCpMIa9FVjbVeirMJGSrbHFps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XGQuVtZx; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGQuVtZx"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84e4efb18c9so50126b3a.0
        for <linux-spi@vger.kernel.org>; Fri, 04 Sep 2026 07:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788531287; x=1789136087; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lPRA+ajA+tYqtSUpBWFvED6ALQ4ZW0UcvXJfNjQCvJw=;
        b=XGQuVtZx02DZmoFdjrTCVL9zKbbLPRijmF0D2mqPxEzGC/CRnpCoNBWaOd/nZpKVqb
         3WmCry6YXp2h2SDrqQhapP9VZza8L/UItXqmb3Uy6jZqyehaeq+vVzrQir3b/feT1Zbn
         wPc8Py4nZBDKCRLmBCh9G2vjPRvvTyg6UFn0bFuDMiszRUacOaz27/PQ1v1/TBdzGa6t
         975XU9Tge+JkQmRX6+AFAlFmVDKXcGepPIRIwJD0LlvS2F5RPblC5mKhrVhllFWDgsUJ
         nTJtGp/vuSh9qIBB6w43bt5IWWINOzT/FxVOsYCqp2fXKzuLu4X2eXC9tY77AdyGpXcQ
         krGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788531287; x=1789136087;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lPRA+ajA+tYqtSUpBWFvED6ALQ4ZW0UcvXJfNjQCvJw=;
        b=tM6JojvdvaeTA9t+ajoeHei2HEBsHABrw+YRa3viNuJ7wSUzVYM5zKA0jiiMGrMOAp
         2ppfVUrDYD/VNMEWaCuxMPqbqWrCbGZTXj7VpYGYDixbERpHttiK0bOPqXDJ6+X7FOBz
         X/Qm/LH7OmKgicrm+0EUL3MUbqfhhzmHiycD9tFgklPGxlySL9u/PsNpxBRrFrIcQV6Q
         K0WPSCY8Ze3g4Zxu/MJKccSDn6TcIoJI7Mn+JQGo0ZYjtpFB/OWP6a6kZIjr1FRJIJL4
         jUDUkp6AhUPa+e85LIt/vqqC8sLsFOG/qAWO9X0L83CvhXP2dvnFt5KpZOnQzZpFl61H
         6n1w==
X-Forwarded-Encrypted: i=1; AKwUvBz4P+Yyhvn4Bm4NNoT5PoZ4ivF5mUY1hyCoVtnux3DVqkQgmcBvFg/YGdNp2e0QsrfNBMINW7u7sqU=@vger.kernel.org
X-Gm-Message-State: AFuF++lEn5ZMS1qn1vXVJ2VHM82oGCI743BvqD/RJyHcOCUYMHsJKymd
	/nvsfa0U4RNxVWq+GG5414c6nNgz5kBGhuVw2JvkvRC9PdVvcngQ+jdx
X-Gm-Gg: AYBFou0wa98AXFTo1o8todFweEyGX9ZQ2O59JyJAJdjsWtZbaWSQewLNeDlqRqRQk6A
	EK5g8ldZDZDiFWYGEX2Zzfq6lJtq5XNhSxwseWjPoTh536axBRhIBUQtPGQmtf263tOTzqV7Ud8
	R6z662NxFRm1Zunfj+LOdj4BHz7fpQz+3YgbOG4MeBMHBNtOIQPVs5EgEL7V9qVS2ld+JQefOFA
	eEEMfd0nsiSHSK7ciumtZmtyFjkfqXMWIC5kIyuq9Aq/qKtO04jNncgnKE4vkqbNkGD2YYMLNer
	bCBbaA1sjRqjBCtZsL4LVSpJCBWg6npNArL8FHE7JZvM1mt0e6AtPhYnAbIBIhs1EKo9yfLw/DU
	EP4kBUlygDOodc0RtcyDhCaDABAkPA69I4mpE7JDBEKH2ErpFpjG3UoHvvQzkT4UcTpwlmc9L2w
	RVHVRvVNBM32uKmRMCWOpbGP88cEsZq05vdiHqbRnsMV5y5U98jjbIdpSkLr1zpDHJIjjMcKW6I
	I1q
X-Received: by 2002:a17:90b:3b81:b0:39b:3510:4af7 with SMTP id 98e67ed59e1d1-39b380fb91bmr1732726a91.1.1788531286631;
        Fri, 04 Sep 2026 07:14:46 -0700 (PDT)
Received: from JSANTO12-L01.ad.analog.com ([191.23.4.35])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339885d29esm7939487eec.2.2026.09.04.07.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 07:14:45 -0700 (PDT)
Date: Fri, 4 Sep 2026 11:14:40 -0300
From: Jonathan Santos <jonath4nns@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	broonie@kernel.org, nuno.sa@analog.com,
	michael.hennerich@analog.com, andriy.shevchenko@intel.com,
	Dennis Heinzel <dennis.heinzel@irs.systems>
Subject: Re: [PATCH] spi: axi-spi-engine: fix stale SYNC IRQ pending
Message-ID: <aprSUH9u5W8hNUpV@JSANTO12-L01.ad.analog.com>
References: <04d51e99b8cddce51113db933d806e83848f04f5.1788313558.git.Jonathan.Santos@analog.com>
 <db8c87a3-1035-4023-8929-aae47ef7b20a@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db8c87a3-1035-4023-8929-aae47ef7b20a@baylibre.com>

On 09/03, David Lechner wrote:
> On 9/3/26 8:49 AM, Jonathan Santos wrote:
> > spi_engine_setup() sends a SYNC(1) command and polls SYNC_ID to confirm
> > it was parsed by the FPGA, but never clears the corresponding interrupt
> > pending bit (INT_PENDING[SYNC]). When the first real SPI transfer starts
> > and INT_SYNC is enabled, that stale pending bit fires immediately, causing
> > the IRQ handler to see the leftover SYNC_ID from setup, match it against
> > the current transfer's ID, and prematurely signal completion before the
> > hardware finishes.
> > 
> > This race manifests at low SPI clock frequencies (~2-3 MHz), where the
> > FPGA takes long enough to execute the transfer that handler is parsed
> > before it finishes. At higher SCLK rates the transfer completes fast
> > enough that the issue is masked.
> > 
> > Fix this by clearing INT_PENDING[SYNC] after the polled SYNC, ensuring no
> > stale interrupt is left pending.
> > 
> > Reported-by: Dennis Heinzel <dennis.heinzel@irs.systems>
> > Link: https://ez.analog.com/linux-software-drivers/f/q-a/604145/axi-spi-engine-stale-sync-pending-can-complete-first-transfer-early-at-low-spi-clock-2-3-mhz
> 
> Should be Closes rather than Link in this case.
> 
> And needs a Fixes tag.
> 
> > Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> > ---
> >  drivers/spi/spi-axi-spi-engine.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
> > index 02bbc5d0cfc5..9e9bbe109ce5 100644
> > --- a/drivers/spi/spi-axi-spi-engine.c
> > +++ b/drivers/spi/spi-axi-spi-engine.c
> > @@ -887,6 +887,7 @@ static int spi_engine_setup(struct spi_device *device)
> >  	struct spi_controller *host = device->controller;
> >  	struct spi_engine *spi_engine = spi_controller_get_devdata(host);
> >  	unsigned int reg;
> > +	int ret;
> >  
> >  	if (device->mode & SPI_CS_HIGH)
> >  		spi_engine->cs_inv |= BIT(spi_get_chipselect(device, 0));
> > @@ -922,8 +923,13 @@ static int spi_engine_setup(struct spi_device *device)
> >  	writel_relaxed(SPI_ENGINE_CMD_SYNC(1),
> >  		       spi_engine->base + SPI_ENGINE_REG_CMD_FIFO);
> >  
> > -	return readl_relaxed_poll_timeout(spi_engine->base + SPI_ENGINE_REG_SYNC_ID,
> > -					  reg, reg == 1, 1, 1000);
> > +	ret = readl_relaxed_poll_timeout(spi_engine->base + SPI_ENGINE_REG_SYNC_ID,
> > +					 reg, reg == 1, 1, 1000);
> > +
> > +	/* Clear the stale SYNC pending bit so it doesn't fire when the IRQ is later enabled */
> > +	writel_relaxed(SPI_ENGINE_INT_SYNC, spi_engine->base + SPI_ENGINE_REG_INT_PENDING);
> > +
> > +	return ret;
> >  }
> >  
> >  static int spi_engine_transfer_one_message(struct spi_controller *host,
> > 
> > base-commit: 183f05a300eab41e4578337eac59335730dfebf9
> 
> We have the same poll timeout in spi_engine_trigger_enable(). Do we need
> a similar fix there too?
>

Yes, Thanks for pointing that out! We have the same issue there:
The _trigger_enable() generates the SYNC interrupt, which is not cleared
while in offload mode and it is fired in the next FIFO mode transfer
when the SYNC interrupt is enabled.

I will include this in the next version.
