Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127E32030A;
	Thu,  4 Jun 2026 00:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780531823; cv=none; b=I2wsR+WhPXCVRSCGEIywyN5LamGFRAM2cdRcsSFd2Wwy1fqntzbXWLttfgQmAzB67RfOcm6R9gUT5+TwxAasmIAL8di984mdPj9Gp9xOVs8ZKgCKJLxS0KbVdD9tTBD9W9TpzHJJyQanBnXlwxS5CjYXJ8eTSMGm+YwJ2OKSSpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780531823; c=relaxed/simple;
	bh=V22SbfWRAteLoq5tAOie0P6MZ/OeJura6CbWl6xN60A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bdhQzKqoYRSm4ENUN9lstV6m0R+dy993qypsEDLjaLrT/YBOLDYpgI7K1JM7AHR4XMJC01rIVDrLuVrolWyzVHcS619E0m2zMBJZ7u7mpSx33B5XRnabpe2gwS6U6ejVytN1vjVeYG2Wp25uehMEMHfFTmN4sshDwqlri48Fh7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lIOvpkqq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lIOvpkqq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E161F1F00893;
	Thu,  4 Jun 2026 00:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780531822;
	bh=RzX0lWZRD5DxGElPyOZGgm2BFxosY8aWf2oXsoDIaRA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lIOvpkqqN1ywebcDLtr9Qao8fkXd2zC6JYHNl5+Q6sjbJf7L2swGQ8b0JkjpXQMTW
	 UuPt2TelIYhykfwzxP38SkNU2nOCJxNl1g/cWcQoP6j1L/PTrHFmst/5tbQn82EKaJ
	 quL+uH80Act6V/umkYFWaMFBi0v2QRCpEzIBCUj+HOw13ZRvfe5GxLdjvHYRz4+jC/
	 p3CxbLEBd/3H+QNs6fKlIk8juTZV21EPo/jhvf65y4YaHvNHwSDZJVHDLxfzeCRifN
	 P8WXwVraROJy2u2NyQRyvG0zyipOeaTmHRUf2yG+F/f8NXnXrcRHxJ9ZtmDELD+1ZD
	 WkwGchkvRsGBg==
Date: Thu, 4 Jun 2026 07:51:12 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] spi: cadence-xspi: Support 32bit and 64bit slave dma
 interface
Message-ID: <aiC98CaOgjs-q39m@xhacker>
References: <20260602235825.28614-1-jszhang@kernel.org>
 <e9259b2d-38f4-47bd-8816-3940c2314e9d@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e9259b2d-38f4-47bd-8816-3940c2314e9d@sirena.org.uk>

On Wed, Jun 03, 2026 at 09:20:29AM +0100, Mark Brown wrote:
> On Wed, Jun 03, 2026 at 07:58:25AM +0800, Jisheng Zhang wrote:
> 
> > +	} else {
> > +		if (IS_ALIGNED((uintptr_t)src, 8) && IS_ALIGNED((uintptr_t)buf, 8)) {
> > +			readsq(src, buf, len >> 3);
> 
> readsq() and writesq() are only defined under CONFIG_64BIT AFAICT, but
> the driver will build on 32 bit.  We need to configure out this option
> on 32 bit architectures.

Currently, the cadence-xspi has depended on 64BIT, the dependency was
introduced by commit d58ecc54bb09 ("spi: cadence: Add 64BIT Kconfig
dependency") for marvell sdma handling. So we have two choices:

A. guard the marvell sdma handling with CONFIG_64BIT, and remove the
above hardcoded dependency, then introduce proper readsq/writesq
handling.

B. keep the 64BIT dependency, and review the merge this patch as is.

Which do you prefer? I'll cook newer version if you prefer option A.

Thanks
