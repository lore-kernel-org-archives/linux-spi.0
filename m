Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4E244A3F0;
	Wed, 16 Sep 2026 19:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789585841; cv=none; b=MXf1zzA3K3qEmks3piCYmPChdz0nc0PKO6TtNvgMbutBalyEH7gjROLuXzx7BreS3IpgI9zX/sASYOmM4VpUvYZK+RT40uSoy04EVK+BHAnOcFJSi6yQiu9kNRhKUCTosMk3C+moWVRMUvzwUFCzldAAD7DLy16pMH+zeopZAi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789585841; c=relaxed/simple;
	bh=ThpdXpEr6b715RBOkk8mQ1lu6V2MawzySQ0mRcVNDOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jhBu27qDEKMrRzRzp5MZNv7nE6xJNz2qOMmBqoFJt3GUGk4nYIIZ6i4WBFREW1D7yi3psBvXMpEm+k8OBb58oMlJ+PzIDtgLdDKd8LnahVZEddSwrKBv3DRgEhxEzkG7YFtfrFtQZeVSlgEA3/8Scr3wLsWYRi2yzN3xVggy+o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
X-PTX-Original-Recipient: broonie@kernel.org
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-PTX-Original-Recipient: mkl@pengutronix.de
X-PTX-Original-Recipient: kernel@pengutronix.de
Received: from [0.0.0.0] (ptz.office.stw.pengutronix.de [IPv6:2a0a:edc0:0:900:1d::77])
	(Authenticated sender: jre@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id BE525202B14;
	Wed, 16 Sep 2026 21:10:17 +0200 (CEST)
Message-ID: <e036be79-978d-415b-bd1a-904a03877522@pengutronix.de>
Date: Wed, 16 Sep 2026 21:10:17 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] spi: spidev_test: add compare mode
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de
References: <20260916-spi-sun4i-spidev_test-v2-0-e7d25bf96e4e@pengutronix.de>
 <20260916-spi-sun4i-spidev_test-v2-2-e7d25bf96e4e@pengutronix.de>
Content-Language: en-US
From: Jonas Rebmann <jre@pengutronix.de>
In-Reply-To: <20260916-spi-sun4i-spidev_test-v2-2-e7d25bf96e4e@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 2026-09-16 19:41, Jonas Rebmann wrote:
> [...]
> @@ -451,6 +458,9 @@ int main(int argc, char *argv[])
>   	if (input_tx && input_file)
>   		pabort("only one of -p and --input may be selected");
>   
> +	if (compare & (SPI_TX_OCTAL | SPI_TX_QUAD | SPI_TX_DUAL))

This is supposed to say
+	if (compare && mode & (SPI_TX_OCTAL | SPI_TX_QUAD | SPI_TX_DUAL))

> +		pabort("-c (--compare) conflicts with -2 (--dual), -4 (--quad) or -8 (--octal)");
> +
Will fix in v3

-- 
Pengutronix e.K.                           | Jonas Rebmann               |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |

