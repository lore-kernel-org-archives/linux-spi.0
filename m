Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com [74.125.225.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E976247CA62
	for <linux-spi@vger.kernel.org>; Fri,  2 Oct 2026 11:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790939567; cv=none; b=gLL6Z3PKLYFhKENPBnGjHfVnJkrPeHofTaRCew1aD62PikHiFPIrqrf1a4h/KTwFgo2ANsNOoYkd2GAz/xrDfNEvlQQDRgKIZWvDd8CmgQEHdGTUlRz2k2NhSXMC+4MdKSC6+NAcBtUTDx/zvgqUae84lUetBlXVf76BMVyq7sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790939567; c=relaxed/simple;
	bh=+tK14WpoRtFvM1GF6Iy9jNqGoc2KBjWKkKZg8oF+y8g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=alYUAgqhWU0sqaGvvCoBGZh5IRcLdoQv0Xj5SBQCyldPBlOOfVZRM/pQWEjoqtHat+EOv4Gx1oZ8HOgpYNgAc7Z/OhPZlUSwx8C7TgLRTnarbAItXHFrNuI5pd6/taWkxX8E6FGAHr2TL99/bTsCb8aJj7pUYwUEO7dIKCe4OhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=npmmAOAl; arc=none smtp.client-ip=74.125.225.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="npmmAOAl"
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-48aef5d66c1so2333874f8f.3
        for <linux-spi@vger.kernel.org>; Fri, 02 Oct 2026 04:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790939564; x=1791544364; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SQOQV1ATfhMaKONDJVd6HhB6Jyj0fejjrTFbl7JHLkE=;
        b=npmmAOAlPXNHvuNDuJvAsRRy2sdP4FJlponQ/fl7PAT3q8IpRZjswWQIUPUFKLBAU7
         FA4IkIiXZ/V+8We9aKwTvC5KnksMDPrI2F1p3NHKGeo5ceNS9wggZj1KxU3zntfUmV5X
         LXAGNjwhHplwZhKxp5O0YcID/2TDRa1ymIutRKUYQ3supSudEMiiXyTZAwKq3FCxs/aw
         Xzvqpg0Q7M6GN0O+ekBKU2cdrpKpSmts3tMhMJp2fk8uZhXifs8EhpmTibEyso2UV/j8
         VHocejlXlroCcnQ8X7lE2FE59n2R/Y+lCaHvhQykEvQ6Zknz9YHvKMSVu+RpLrN6AL5k
         6Nyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790939564; x=1791544364;
        h=in-reply-to:content-disposition:content-type:mime-version
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SQOQV1ATfhMaKONDJVd6HhB6Jyj0fejjrTFbl7JHLkE=;
        b=mVurMS8DYUyWA0KqVExH8fGCUx1j2v+dRmCmRkMwcrMuFo2PqeJHpBNfkcJcFDFFSJ
         ktT5XDJSlPenMGmf0WYPcZKdbWs+vjpVAM16KVxoJbGYCqZH//SM0m/dL24VpBvAvPLM
         VLsgVqViM1yMDapj9r/AEebT3DMzlwbrB5SUSkoaJm13/hqgDZycUTxLJoF5ZuOUvFkH
         Dai/NGzbiBIIG+2OqfPOcPihsowdpF1IdAGZ5v5JbaV/A9JK2M/vo0jL3EAi75ng/xa5
         vpIy+KL5+WJOdiTVVNCpEloLsTybQC9NuqRny9YgTS25lC3E2cR+xL07WnAGt+ucTMEs
         AbpQ==
X-Forwarded-Encrypted: i=1; AKwUvBwoQ3+lrnoWlWoxdpaxWf3uhGelHyrp4kNUSnE6cw+J5exQTCzmVSg8O889u5PjFRKOGRohU9IdV3I=@vger.kernel.org
X-Gm-Message-State: AFuF++n/28ZeXd8ETPmDuWYe2G+5d9z9PtCLsV/goU/5FSFH+KsuG2ci
	mYT2Tazvtl+BBcN1EgiS8ERnjRzk+S1ReqjrjueiUjPHoQW59VtEu4J9
X-Gm-Gg: AYBFou1T/Q4qBdvO9LpQFkhEQhWV2uBNBOXm9V9weFlaXDg3d09V3gaE2gJjeW7aX+S
	4KjEU+0vMR87DmjLhfNnYrlN2nuMoRXyyqaiGI32l/CrGoIuGIlJTINqMYP38fY2lDgl+vl0GzK
	H7loumT+hQvLN2JeUq3wCAakqBmCEMAp3Poju95GwNKn1TphtmD9QaTThpPBgPopfTJ1cvKLR1M
	9tO4WQoOLnm6PFtQEqlm2vmL7CL6wj883PcZn6akOpYxtXELskAXq1Pu2PdWBKau4lmF4hEM0Od
	h1YYnjb1mTQxMUCySNCzS8hB9b/7hln0/AZfCEUjqwaOHXt/rlsst4nOuea7Sq+jrkUf8Volq5U
	K/7spGWMFzSwiyVTXrulxXA/vCdH6NWJnekAvCBGbkA6fSrInMv0TgehLXJ17BsHmS7t01ECbIj
	dCdPuyb8gJDD20ilKFN9D1Wlky5TZbQbH6fBw78ZknhfdVRHMX9nKpLfvtJq3RntOYWPU=
X-Received: by 2002:a05:600c:3b19:b0:4a0:25d5:e853 with SMTP id 5b1f17b1804b1-4a02759a425mr42668275e9.35.1790939563758;
        Fri, 02 Oct 2026 04:12:43 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a03ff2280csm42446365e9.4.2026.10.02.04.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 04:12:42 -0700 (PDT)
Date: Fri, 2 Oct 2026 14:12:38 +0300
From: Dan Carpenter <error27@gmail.com>
To: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: p.zabel@pengutronix.de, james.tai@realtek.com, cy.huang@realtek.com,
	stanley_chang@realtek.com, eleanor.lin@realtek.com,
	jyanchou@realtek.com, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/2] spi: spi-mem: Add Realtek SPI NOR flash controller
 driver
Message-ID: <20260930065945.88008-3-eleanor.lin@realtek.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930065945.88008-1-eleanor.lin@realtek.com>
Message-ID: <20261002111238.zmU8TY9cdPo1jRPt_Xg1el9kj_ozynuVbJQ2-farWEs@z>

Commit aca8cbecdd2e ("spi: spi-mem: Add Realtek SPI NOR flash
controller driver") from Sep 30, 2026 (linux-next), leads to the
following Smatch static checker warning:

	drivers/spi/spi-rtk-nor.c:347 rtk_spi_supports_op()
	warn: '(-95)' is not bool

On Wed, 30 Sep 2026 14:59:45 +0800 Yu-Chun Lin <eleanor.lin@realtek.com> wrote:
> +static bool rtk_spi_supports_op(struct spi_mem *mem,
> +				const struct spi_mem_op *op)
> +{
> +	if (op->cmd.buswidth != 1)
> +		return false;
> +
> +	if (op->cmd.dtr || op->addr.dtr || op->data.dtr)
> +		return false;
> +
> +	if (op->addr.nbytes != 0) {
> +		if (op->addr.buswidth > 1)
> +			return false;
> +		if (op->addr.nbytes < 3 || op->addr.nbytes > 4)
> +			return false;
> +	}
> +
> +	/*
> +	 * The data window is access-triggered: each CPU access to host->iobase
> +	 * generates one complete SPI transaction. Consecutive byte accesses
> +	 * therefore cannot be merged into a single transaction, so
> +	 * multi-byte stateless commands are not supported by this controller.
> +	 */
> +	if (!op->addr.nbytes && op->data.nbytes > 1)
> +		return -EOPNOTSUPP;

This is a bool function.  s/-EOPNOTSUPP/false/?

regards,
dan carpenter

> +
> +	if (op->dummy.nbytes != 0) {
> +		if (op->dummy.buswidth > 1 || op->dummy.nbytes > 7)
> +			return false;
> +	}
> +
> +	if (op->data.nbytes != 0 && op->data.buswidth > 2)
> +		return false;
> +
> +	return spi_mem_default_supports_op(mem, op);
> +}

