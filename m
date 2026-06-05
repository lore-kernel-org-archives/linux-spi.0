Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C642BF507;
	Fri,  5 Jun 2026 00:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780618043; cv=none; b=FvybMNXqJNOxUeax84BimGck2vqm7l1URXuGjSpPvGRFKx3WnGnoR/CV8P+o6DUdXW3MC2Q+bqMLr8ywXuuYVwO5rgU1T8IVlZSNTGKzJOjP9lXzx4+3Cs3tzZI/5B+dUf8upE5YyBMi3shwqn+BEVKYVWhfi20XVaUMMpjqN/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780618043; c=relaxed/simple;
	bh=qQ1gKR0VsPz2gS3HiMirt9VSg/PYoqTIxj2DajnmV3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BYLUNP8bpZz+ra9yfKlJDai9xAtoZ7DbdYj/SkRSDvuOLUQP5CfwgHkR4g4TpRDg3T0X0xETp4cmTxyWXcB1Sm6KAEvKNkfESZ0kswwEAs8Tl82SDiogxoLfdkYI/T77gfTIUtsXQOPxHO4zfASmEQJ9MgyKjRhxMwtMOX/0oTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U9a9FUSf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U9a9FUSf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63FA81F00893;
	Fri,  5 Jun 2026 00:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780618042;
	bh=Ea9lo/3/rWEOf6JSqdoBy+an7qwf43asgBGVpX1UKHE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=U9a9FUSf2rOnKtzzhT7yk6SB7G0lsbvCnlq7G/TT0azlBnqPFC9DQPDWflsODelxi
	 bJa4pJBBcETnZzMXKMc6Ps//OaAM3kCgUaR0vHtoO/U38z+uEB4fWgag5nI7tn8nhj
	 rX+DZdpmfN7wsuXrvcPtwJZDV+n52Vbdm6DrqCEmJ/ncXQCDx4h1UAHaUySuB8yqV1
	 cFfA081X5WtqVVm2agm4Jml1Dj3+pCvymoP44rQRgMVubXWMxOynhESbMYFPb7l6vm
	 UOQk4WAW3i7pKWRyrvBK9zxdRaAkTvSBPgL1jV4lSXc/EhGj+Qfw5jNao6yBe4ZV/I
	 +aNcFQOP2GClQ==
Date: Fri, 5 Jun 2026 02:07:17 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Thomas Lin <thomas_lin@lecomputing.com>
Cc: rafael@kernel.org, lenb@kernel.org, hoan@os.amperecomputing.com, 
	linusw@kernel.org, brgl@kernel.org, mika.westerberg@linux.intel.com, 
	andriy.shevchenko@linux.intel.com, jsd@semihalf.com, broonie@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-spi@vger.kernel.org, lucas_hao@lecomputing.com, puntar_liu@lecomputing.com, 
	jihua_tao@lecomputing.com, stan_xu@lecomputing.com, lumin_liu@lecomputing.com, 
	notics_zhang@lecomputing.com, braden_zhang@lecomputing.com, harold_wu@lecomputing.com, 
	will_zhang@lecomputing.com, aurora_jiang@lecomputing.com, ryen_lin@lecomputing.com, 
	andy_jiang@lecomputing.com
Subject: Re: [PATCH v4 3/3] i2c: designware: Add ACPI ID LECA0003 for LECARC
 SoCs
Message-ID: <aiIQwjt3LVFbjT5e@zenone.zhora.eu>
References: <20260520081140.637637-1-thomas_lin@lecomputing.com>
 <20260520081140.637637-4-thomas_lin@lecomputing.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520081140.637637-4-thomas_lin@lecomputing.com>

Hi Thomas,

On Wed, May 20, 2026 at 04:11:36PM +0800, Thomas Lin wrote:
> Add ACPI ID "LECA0003" for LECARC SoCs that integrate
> the DesignWare I2C controller.
> Also add corresponding ACPI description in acpi_apd.c.
> 
> Signed-off-by: Thomas Lin <thomas_lin@lecomputing.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Reviewed-by: Andi Shyti <andi.shyti@kernel.org>

I'm OK for this to go through GPIO.

Andi
