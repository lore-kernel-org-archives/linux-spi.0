Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439EA39903D
	for <linux-spi@vger.kernel.org>; Mon,  9 Mar 2026 15:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773069176; cv=none; b=WqWCPxr64+YfT7NyvAb7KBU+4CGda3UvNSHAuj2aT38JKpVyDx+a3+pX70TrcRNUL0K11dc+N8fHclYYilTMvvobNk969xAg71VWk2LKw3SB/n61agVnSkfgxTGPjFgloOfxS+gIcZV4jTbv6FTUYX9sRkSfjEP3AcJX/4jpj8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773069176; c=relaxed/simple;
	bh=+JvlsBKqjI1HV+1kncw7ZI3uERUvcs4r4NAGDXhwfac=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y4daLr5QyEhZFQOaIDIAH+hUcTuazB9L0JBEIIOu75ReWqXW3F1r4zb26xtVTz06FRWVFLSscVET+YvA++7m48RzN8Ybsp8JGS49CkiEko+GWcgNBUgvGymCTYgcf+FuLKJfYfAOSkEVPmFFsl4TYeNg5nK/0wKj4WpJNl8vCeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nrVi0LdF; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nrVi0LdF"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id D8A9B4E425DC;
	Mon,  9 Mar 2026 15:12:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AE09C5FFB8;
	Mon,  9 Mar 2026 15:12:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8DEF410369BCD;
	Mon,  9 Mar 2026 16:12:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773069172; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=MFUuT1i3CoEQ+RFV5Q+XaILI6r1cUNtCHVqM62g6SC8=;
	b=nrVi0LdFidCzYgrltpoM3L2NmISNFRjbPlEomhZbtYBiyxV7pM/0WkX+JsW9xkTvZ9L1sy
	Wd/KHy+weEU5aBlsPWQFzrr5F4aPuaBr477/+O62rpk/yi9dcEEEiQV6onYfS6tIl8g8MM
	i5hWg/N2GcbPWs1ofcC513Uiq17CfEWoZP/Ud0JtzButvtNZgeQJik9fkdvlJk7foWfLdb
	s2TErxRmsUUJD3WWErKtPtYCrSp2lsLH781yIiJFDK38G7syf0StNFjWUPbYUZMug5UXuq
	8cRa+Pssv+p2oPOKNhtlWGlO816xjKvC3fixAxaLpoMwi0QyfaK0haBbFa1anA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Frieder Schrempf <frieder@fris.de>
Cc: Mark Brown <broonie@kernel.org>,  Richard Weinberger <richard@nod.at>,
  Vignesh Raghavendra <vigneshr@ti.com>,  Han Xu <han.xu@nxp.com>,
  Eberhard Stoll <eberhard.stoll@kontron.de>,  Frieder Schrempf
 <frieder.schrempf@kontron.de>,  Tudor Ambarus <tudor.ambarus@linaro.org>,
  Pratyush Yadav <pratyush@kernel.org>,  Michael Walle <mwalle@kernel.org>,
  linux-spi@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-mtd@lists.infradead.org,  imx@lists.linux.dev
Subject: Re: [PATCH RFC 4/7] mtd: spinand: toshiba: Add RX sampling delay
 values
In-Reply-To: <20260303-fsl-qspi-rx-sampling-delay-v1-4-9326bbc492d6@kontron.de>
	(Frieder Schrempf's message of "Tue, 03 Mar 2026 17:29:25 +0100")
References: <20260303-fsl-qspi-rx-sampling-delay-v1-0-9326bbc492d6@kontron.de>
	<20260303-fsl-qspi-rx-sampling-delay-v1-4-9326bbc492d6@kontron.de>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Mon, 09 Mar 2026 16:12:48 +0100
Message-ID: <87ldg1nij3.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Last-TLS-Session-Version: TLSv1.3


> @@ -277,7 +291,7 @@ static const struct spinand_info toshiba_spinand_table[] = {
>  					      &update_cache_variants),
>  		     0,
>  		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
> -				     tx58cxgxsxraix_ecc_get_status)),
> +				     tx58cxgxsxraix_ecc_get_status),
>  	/* 1.8V 4Gb (1st generation) */
>  	SPINAND_INFO("TH58NYG2S3HBAI4",
>  		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xAC),
> @@ -288,7 +302,7 @@ static const struct spinand_info toshiba_spinand_table[] = {
>  					      &update_cache_x4_variants),
>  		     SPINAND_HAS_QE_BIT,
>  		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
> -				     tx58cxgxsxraix_ecc_get_status)),
> +				     tx58cxgxsxraix_ecc_get_status),
>  	/* 1.8V 8Gb (1st generation) */
>  	SPINAND_INFO("TH58NYG3S0HBAI6",
>  		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xA3),
> @@ -299,7 +313,7 @@ static const struct spinand_info toshiba_spinand_table[] = {
>  					      &update_cache_x4_variants),
>  		     SPINAND_HAS_QE_BIT,
>  		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
> -				     tx58cxgxsxraix_ecc_get_status)),
> +				     tx58cxgxsxraix_ecc_get_status),
>  };

Are these 3 changes legitimate?
