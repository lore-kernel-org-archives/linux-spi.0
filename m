Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AEA3E0C6F
	for <linux-spi@vger.kernel.org>; Mon,  9 Mar 2026 15:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773069943; cv=none; b=lEJOazW9nr2WqOvOJALE8OdP0BgWO3lGsU9fRTqYndg/0NxwNRAPoniDoog60qVVC/SRuRFXhExgYYKawsLC9Xru/Gp2p0AZgA2ixKKq8Y58nKf0Wv3+XxmY/RnLuEikLrU2a3Z7OVkwtzXvqKPYarb4JqEoN0WCL8mmStOOKqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773069943; c=relaxed/simple;
	bh=71UfLNvBJo5oEjJuFzP+LnOwtwqhZfxiR6bEOecHXDs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VL1qO1njia5JiO01merFe5jrQpQwGlkQLL2Iaz6kmkXcuy6hzgDissu9iCDdQzxCPOJhC2PDn9eyctKMfXBYwrWOjc52f9RfBW76gfjtfim62VtJg4UhXwPoQ531PmFecNUjuD2ZXCVdJvIX4sW/ezFSGJ/Nks7IwA2FM6tkDJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OI7u5PZt; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OI7u5PZt"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 16F784E425DE;
	Mon,  9 Mar 2026 15:25:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CF96A5FFB8;
	Mon,  9 Mar 2026 15:25:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2370E10369A1E;
	Mon,  9 Mar 2026 16:25:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773069939; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=uODB/LZsYADvm7F3kzuesCoyLdm5GvhcYmJKOvIxhy4=;
	b=OI7u5PZth1aX/JdL6KTWo+3XI6LDY6V8PpSBTHuxC3bmYapyjnX+hewcruBKlsajwY9jNs
	ee7ZW94OEis+b13BgeApI4/WUCdk1Cg0FW4OB5Zna7jIvhaSwEy56WNb1e2U/6shc5shHZ
	qPNz1Jmmtf2KAoG9UFy9vge7DtZTZ4H3Y4Cs2xigIUSA38aVcgeMf23AIt0TNWi9y11j4S
	OwvqPm4NKQoyt3/CvngfMQSgqUndMEHev4pfqnPWiMproJJ08OJyIONyJ/kJF8Q2WlZdKE
	WaqQmyfqye/WEdSkoM7tSZ3s6zVQp9a4PNaOBKheiS7aFozQ/6AsMG98+uIFOg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Frieder Schrempf <frieder@fris.de>
Cc: Mark Brown <broonie@kernel.org>,  Richard Weinberger <richard@nod.at>,
  Vignesh Raghavendra <vigneshr@ti.com>,  Han Xu <han.xu@nxp.com>,
  Eberhard Stoll <eberhard.stoll@kontron.de>,  Frieder Schrempf
 <frieder.schrempf@kontron.de>,  Tudor Ambarus <tudor.ambarus@linaro.org>,
  Pratyush Yadav <pratyush@kernel.org>,  Michael Walle <mwalle@kernel.org>,
  linux-spi@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-mtd@lists.infradead.org,  imx@lists.linux.dev, Santhosh Kumar K
 <s-k6@ti.com>
Subject: Re: [PATCH RFC 5/7] spi: Add RX sampling point adjustment
In-Reply-To: <20260303-fsl-qspi-rx-sampling-delay-v1-5-9326bbc492d6@kontron.de>
	(Frieder Schrempf's message of "Tue, 03 Mar 2026 17:29:26 +0100")
References: <20260303-fsl-qspi-rx-sampling-delay-v1-0-9326bbc492d6@kontron.de>
	<20260303-fsl-qspi-rx-sampling-delay-v1-5-9326bbc492d6@kontron.de>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Mon, 09 Mar 2026 16:25:35 +0100
Message-ID: <87fr69nhxs.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hello,

+ Santhosh

On 03/03/2026 at 17:29:26 +01, Frieder Schrempf <frieder@fris.de> wrote:

> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>
> Some SPI devices such as SPI NAND chips specify a clock-to-RX-sampling
> delay constraint, which means that for the data read from the device
> at a certain clock rate, we need to make sure that the point at
> which the data is sampled is correct.
>
> The default is to assume that the data can be sampled one half clock
> cycle after the triggering clock edge. For high clock rates, this
> can be too early.
>
> To check this we introduce a new core function spi_set_rx_sampling_point()
> and a handler set_rx_sampling_point() in the SPI controller.
>
> Controllers implementing set_rx_sampling_point() can calculate the
> sampling point delay using the helper spi_calc_rx_sampling_point()
> and store the value to set the appropriate registers during transfer.
>
> In case the controller capabilities are not sufficient to compensate
> the RX delay, spi_set_rx_sampling_point() returns a reduced clock
> rate value that is safe to use.
>
> This commit does not introduce generic logic for controllers that
> don't implement set_rx_sampling_point() in order to reduce the clock
> rate if the RX sampling delay requirement can not be met.
>
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> ---
>  drivers/spi/spi.c       | 73 +++++++++++++++++++++++++++++++++++++++++++=
++++++
>  include/linux/spi/spi.h |  8 ++++++
>  2 files changed, 81 insertions(+)
>
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 61f7bde8c7fbb..b039007ed430f 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -3988,6 +3988,77 @@ static int spi_set_cs_timing(struct spi_device *sp=
i)
>  	return status;
>  }
>=20=20
> +/**
> + * spi_calc_rx_sampling_point - calculate RX sampling delay cycles
> + * @spi: the device that requires specific a RX sampling delay
> + * @freq: pointer to the clock frequency setpoint for the calculation. T=
his gets
> + *        altered to a reduced value if required.
> + * @max_delay_cycles: the upper limit of supported delay cycles
> + * @delay_cycles_per_clock_cycle: the ratio between delay cycles and
> + *				  master clock cycles
> + *
> + * This function takes in the rx_sampling_delay_ns value from the SPI de=
vice
> + * and the given clock frequency setpoint and calculates the required sa=
mpling
> + * delay cycles to meet the device's spec. It uses the given controller
> + * constraints and if those are exceeded, it adjusts the clock frequency
> + * setpoint to a lower value that is safe to be used.
> + *
> + * Return: calculated number of delay cycles
> + */
> +unsigned int spi_calc_rx_sampling_point(struct spi_device *spi, unsigned=
 int *freq,
> +					u16 max_delay_cycles,
> +					u16 delay_cycles_per_clock_cycle)
> +{
> +	unsigned long long temp;
> +	u16 delay_cycles;
> +
> +	/* if sampling delay is zero, we assume the default sampling point can =
be used */
> +	if (!spi->rx_sampling_delay_ns)
> +		return 0;
> +
> +	temp =3D *freq * delay_cycles_per_clock_cycle * spi->rx_sampling_delay_=
ns;
> +	do_div(temp, 1000000000UL);
> +	delay_cycles =3D temp;
> +
> +	if (delay_cycles > max_delay_cycles) {
> +		/*
> +		 * Reduce the clock to the point where the sampling delay requirement
> +		 * can be met.
> +		 */
> +		delay_cycles =3D max_delay_cycles;
> +		temp =3D (1000000000UL * delay_cycles);
> +		do_div(temp, spi->rx_sampling_delay_ns * delay_cycles_per_clock_cycle);
> +		*freq =3D temp;

This is silently modifying the spi_device structure, I don't like this much.

> +	}
> +
> +	dev_dbg(&spi->controller->dev, "calculated RX sampling point delay: %u =
cycle(s) at %lu KHz", delay_cycles, *freq / 1000);
> +
> +	return delay_cycles;
> +}
> +EXPORT_SYMBOL_GPL(spi_calc_rx_sampling_point);
> +
> +/**
> + * spi_set_rx_sampling_point - set the RX sampling delay in the controll=
er driver
> + * @spi: the device that requires specific a RX sampling delay
> + * @freq: the clock frequency setpoint for the RX sampling delay calcula=
tion
> + *
> + * This function calls the set_rx_sampling_point() handle in the control=
ler
> + * driver it is available. This makes sure that the controller uses the =
proper
> + * RX sampling point adjustment. This function should be called whenever
> + * the devices rx_sampling_delay_ns or the currently used clock frequency
> + * changes.
> + *
> + * Return: adjusted clock frequency
> + */
> +unsigned int spi_set_rx_sampling_point(struct spi_device *spi, unsigned =
int freq)
> +{
> +	if (spi->controller->set_rx_sampling_point)
> +		return spi->controller->set_rx_sampling_point(spi, spi->max_speed_hz);
> +
> +	return freq;
> +}
> +EXPORT_SYMBOL_GPL(spi_set_rx_sampling_point);
> +
>  /**
>   * spi_setup - setup SPI mode and clock rate
>   * @spi: the device whose settings are being modified
> @@ -4090,6 +4161,8 @@ int spi_setup(struct spi_device *spi)
>  		}
>  	}
>=20=20
> +	spi->max_speed_hz =3D spi_set_rx_sampling_point(spi, spi->max_speed_hz);

I believe we need a clearer yet stronger logic around the setting of
max_speed_hz.

The "maximum speed" parameter is reaching its limit. This is clearly
what needs to be discussed with Santhosh. The SPI tuning series is
playing with this value as well.

Cheers,
Miqu=C3=A8l
