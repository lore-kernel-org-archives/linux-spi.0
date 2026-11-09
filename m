Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794261793;
	b=k693kt0V727wCOzIrADKpcJ5sYajE3ESUxAum5W4YoReHp63vRAspmjdTrhNYphE0iz9
	 SlSiCtu312UpxLzzGqaz/NEw2Fu3j3CIb8FdA3+QlbQ76BXnOcU3GY5jsHm3dL74t9BlQ
	 H4RwpXccQxPlBf+viGWtKJhfHsNT0xevnurw2j8zzOJkErZYO7RJAXZCuxjYRGh7KcG2Y
	 JevpjF//0Zlqe3AEDGrjtu+2VE7y5mpxT5ReNBVw40Yu1PvrJ1olBecQsUwS7bMO3YAIC
	 f+rj1vhenVJP96fFLVyZWT6TusAu7MkRSFakWrm551XcWIj/dvvdqZTO44XFngnnk2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794261793;
	h=Received:DKIM-Signature:Received:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=5fhIsFIkZ4LdQ5n51OKo+Ec9EiIwq3J+ggnXRosBuV0=;
	b=QVh5H/5+8ut6Cn+lJeU4DHELzsn03rwOxKTNmdaHjvpTgUFVBSPNYF1tbcHAFQqWfNo8
	 is6EAnr4dA56PoD0+2H/kxJg9ufc/k8AzMJRAboZgZb/Ip8z23Zi/0H6dGDqK2C9jb5Xr
	 FYUJPVtYLaXgmfVXX9AOF1q54FwJv4J+30MMcHJOzpD89Vw8c01hWgdCiDRD0SoMPyfCU
	 24vFkJ3C7eZic4nG9ZXk7udP+7Wg2gi4puWHcC9iXY1zxpF5yKSJAx//Kfpt964KHq2nq
	 ZXhQtg7aZyGpDk/vqSwDjB/ETLgrKKYXe1snkX7dRAg68CiQCoy+/LPh8+xsy27YVZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="M4XcDj/y";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE52A606A325
	for <linux-spi@vger.kernel.org>; Mon,  9 Nov 2026 22:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M4XcDj/y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BC961F0089F;
	Mon,  9 Nov 2026 22:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794261792;
	bh=5fhIsFIkZ4LdQ5n51OKo+Ec9EiIwq3J+ggnXRosBuV0=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=M4XcDj/ySUy93StASaTwfHJCKkLzlAXG3gXwjwZyy8v9Q2+ByiEfj7UTrrSMq6yss
	 ig73Vs9xRVrorca0tCIh13fQ0SqfMn5ajSZHQ2g9Ajp6PAjxKf2mZGRwr06xTfy+BX
	 0LNdDN3ccKH8Eftn7HEY3b7WPIOU1RKDAts2Y+OQ6JwayWv2Js2b9Yx4LnBTJqiEUI
	 twyhFzWSoSKEWliXejADbCeL9n3LrquRDii626pN8ZU+bsawOmJUWIjzFVUiM9U5Ji
	 6JmnI6iJ5WYUlgb7/IqJ4kJuAAxuCopiqfSmWWELnsH/4rq3d/ijbPIRV2+e6iqHxo
	 s4Mihtv3dprew==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id 605163021CAC;
	Mon, 09 Nov 2026 22:03:04 +0000 (GMT)
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/2] spi: rockchip: add an atomic transfer function
From: Mark Brown <broonie@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: broonie@kernel.org, linux-spi@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 quentin.schulz@cherry.de, Lee Jones <lee@kernel.org>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>
In-Reply-To: <20261106181824.1361235-3-heiko@sntech.de>
References: <20261106181824.1361235-1-heiko@sntech.de>
 <20261106181824.1361235-3-heiko@sntech.de>
Date: Mon, 09 Nov 2026 22:02:46 +0000
Message-Id: <179426176656.3711751.13626253291583121519.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2042; i=broonie@kernel.org;
 h=from:subject:message-id; bh=hIdjP33i7ScW9DXNN0xZU7V5Fza7A95kmMy3uYeIb18=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLI+OUvc4lNbkP3sc6jhaq/Fx8JWX9zW1DyhW/PrN5svN
 osuaF9K6ShlYRDjYpAVU2SJy+J+WV/yeg3fwYVtMHNYmUCGMHBxCsBE3gowMlzjO79gTU6ohNQG
 gXstlt9NDnAI33Rf1JmoOvnD/s7Cg/MZGWaEcD7IEPlb/vyUj/eJWd56PWcfGFSIVb6ybvQMYyu
 Yxw0A
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

> Rockchip SPI controllers are often used to handle SPI connected PMICs that
> also handle system power-off events, like the RK806.

> +static int rockchip_spi_transfer_atomic(struct spi_device *spi, struct spi_message *msg)
> +{
> +	struct spi_controller *ctlr = spi->controller;
> +	struct rockchip_spi *rs = spi_controller_get_devdata(ctlr);
> +	bool cs_en = (spi->mode & SPI_CS_HIGH) ? 1 : 0;
> +	struct spi_transfer *xfer;
> +	int ret = 0;
> +
> +	pm_runtime_get_sync(rs->dev);

The check in spi_in_atomic_sync_mode() is true for SYSTEM_RESTART and
SYSTEM_SUSPEND which would get rather messy if something ends up with a
device that tries to do something in there.  Not sure if that's worth
worrying about or not.

> +	rockchip_spi_set_cs(spi, cs_en);

This won't DTRT with GPIO chip selects, that's normally handled by the
core.

> +		while (rs->tx_left || rs->rx_left) {
> +			u32 status = readl_relaxed(rs->regs + ROCKCHIP_SPI_SR);
> +
> +			if (rs->tx_left && !(status & SR_TF_FULL))
> +				rockchip_spi_pio_writer(rs);
> +
> +			if (rs->rx_left && !(status & SR_RF_EMPTY))
> +				rockchip_spi_pio_reader(rs);
> +		}
> +
> +		wait_for_tx_idle(rs, false);

This uses jiffies which don't advance in poweroff, and there's no
overall timeout here.

> +		if (xfer->cs_change && !list_is_last(&xfer->transfer_list, &msg->transfers)) {
> +			rockchip_spi_set_cs(spi, !cs_en);
> +			ndelay(10 * NSEC_PER_USEC);

udelay().

> +static int rockchip_spi_power_off(struct sys_off_data *data)
> +{
> +	struct rockchip_spi *rs = data->cb_data;
> +
> +	/* enable controller for possible calls from shutdown handlers */
> +	return pm_runtime_get_sync(rs->dev);

Would it not be safer to just eat the error here rather than refuse
poweroff?  Also pm_runtime_resume_and_get() is the more modern thing.

> +	ctlr->transfer_atomic = rockchip_spi_transfer_atomic;

The driver supports target mode as well, probably best to only register
this for host mode.

-- 
Mark Brown <broonie@kernel.org>
