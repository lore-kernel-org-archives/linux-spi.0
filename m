Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CD23939DD;
	Mon, 16 Mar 2026 11:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773661882; cv=none; b=i6fd5dpz3rLZEf596a1lqImJ6qlQx/tRgn2R0pf/BM47o1/GuKR1itrhPNz+64S3I/ODoKGl/xkNbenr4ciS85TUdVVNOEsI1ZZDtY3DBP2Db4szwdkpYOBegyLjOTWjrHObi0pEpaSeOIMyn3uNb1MJQS1fGHUi51OUsC7Vtpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773661882; c=relaxed/simple;
	bh=TiviZHM5zqkrRp1szzwnT7Y9Gtkl5A+svcnnwrZ/QLo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DNG/DWhorIFdJYv2BzOC7aCSjBs4nbpbZfDZzer1JZ9KeYDSiI145r5YUu6tdv8noFavZIKFEA7jgbOdpR7zFfvjpyCBnUJWBWcabUoyyqhOvuJJ+uMLjD6ymsLH/eQuOesjSXA4S+EPtBTYYOqmg9ZCfViwzPo/QvCd1q1eafg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=M5NwzqlO; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="M5NwzqlO"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DDD6010B4E4;
	Mon, 16 Mar 2026 12:51:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1773661869;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=gLqRNziYfTKwhmR/kXC4v0RKk/f4h6dvo8NZkIa4mqM=;
	b=M5NwzqlOXcBTTllsjWxYKZSUDdCf08MefyxV6zbWk55oHcFwcctBW4gHdZEtwmN+DqNYAF
	d0Lwj3VMywksUKP0q1ywVLpf1Yvq2xn2TAB+XtHcFbAdKOICRTBO+Wua42rBFwplR8jov1
	d+qh/NzRHkSmS11LX3plerfvk8+oCWAVnYxJbXNouLM1iDWhFlEOZD8eMd6l+xQUfNcFco
	1MUIGykxp4RwpOpot3AOOvkcuN3Ppc7pYVFBm9Ac+FDKGxlKC5epl2+hchkSykg2SmbW0H
	qfNZzEW5Rgr7cDgveRjaBIqtXmPHTiIq0cV3VsZT+DKyAs8PX+ZwgCrpC2V2ZA==
Message-ID: <ddad0944-3ec2-4443-bb01-9140d48c5ae7@nabladev.com>
Date: Mon, 16 Mar 2026 12:51:06 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH spi-next 10/11] spi: spi-fsl-lpspi: fsl_lpspi_set_cmd():
 use mode from (struct fsl_lpspi_data::config::mode
To: Marc Kleine-Budde <mkl@pengutronix.de>, Frank Li <Frank.Li@nxp.com>,
 Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev,
 linux-kernel@vger.kernel.org, kernel@pengutronix.de
References: <20260316-spi-fsl-lpspi-cleanups-v1-0-1b695607702d@pengutronix.de>
 <20260316-spi-fsl-lpspi-cleanups-v1-10-1b695607702d@pengutronix.de>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20260316-spi-fsl-lpspi-cleanups-v1-10-1b695607702d@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 3/16/26 9:39 AM, Marc Kleine-Budde wrote:
> Commit 7ae4d097b752 ("spi: spi-fsl-lpspi: Handle clock polarity and phase")
> enhances the driver with clock polarity and phase handling. That commit
> adds a 2nd argument ("struct spi_device *spi") to the fsl_lpspi_set_cmd()
> function.
> 
> The "spi" pointer is used to access the "mode" of the current transfer.
> However the mode is already available via "fsl_lpspi->config.mode".
> 
> To simplify the driver remove the 2nd argument and use
> "fsl_lpspi->config.mode" to access the mode.

Reviewed-by: Marek Vasut <marex@nabladev.com>

Thanks
