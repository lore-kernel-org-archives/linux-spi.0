Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF88E18FC80
	for <linux-spi@vger.kernel.org>; Sun,  7 Jun 2026 04:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780808345; cv=none; b=Q6EuNizvU/uidGFU30nkyXZ87AdQS9Tiq6jsLtYH+EWOaf1nqublqNIvFl+DlbJJSIr3OjGiJbgcLqtdOBaSmtRtj8haAOhCSVJXeHZyBsjOTk69o/pEk32UgsfMGr2E2J1PAn5L1pWjEr3XblYLVARa3lGOZwRZ3rQ3ntSpNB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780808345; c=relaxed/simple;
	bh=b12924DuJhSujCb8obAxr+0rYAgYetLrAl45i5tZNLw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k6y5919HIUSoqPl0bWes1y2pQzH++csOzTQseM/f2ZAJdhGfXSz7m2gSwq5QEAuwHiJ86EK4XGeHIKpg8xYMrVzaHFZ8hL4Y8G/zJrhqsXxDO7NCElbNN9k2FwsvUDon+2VFm6tNwtzOr9MUgye2iPaOYpZMqEYN2paV/gbP7KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool; spf=pass smtp.mailfrom=packett.cool; dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b=JjBKFDZi; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b="JjBKFDZi"
Message-ID: <806c1868-1c4c-4f53-a6ab-84b336fff7c0@packett.cool>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=packett.cool;
	s=key1; t=1780808331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FRsz/MTVg52Z24SOeL5roYX4pr+4ZAE5rR19Cnv50aE=;
	b=JjBKFDZiSv3jYVCCPqTRUemHJQMpptcvXUNDFWhPIt0+IJCMJvJs9JpEeyKF+eQV0kbnSe
	BW4JrEaXEhbfiOvC0/dB0Vmh9E+j00yVMem6fHoxcL4+xtw//j8MkA6KdifodW46R3wgCU
	B8/HVubpsG2hwS440kwFY79ccKykM761Job9RXAI04x9R69KgNpyd1cJnEBApKK33Lve/H
	Pc12ohG033SllrwXp/whiH1S0AJhF0vl35nb6axXYaTPjsZwzrSKWzwc+pq/dJBITG4bth
	pRzR28Tpv2cVLqFanQAMS62wPZJWFkxp091zeg7kiIz1852B8rulTCUbCsq1kQ==
Date: Sun, 7 Jun 2026 01:58:45 -0300
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: spi: geni-qcom: any planned QSPI support?
To: Carter <carterd1016@gmail.com>, praveen.talari@oss.qualcomm.com,
 broonie@kernel.org, andi.shyti@kernel.org
Cc: linux-spi@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <CAJ+nLsRXTc=3LagGVdNiAPttL38tPVub_UOKuqJq91J9U0M+9w@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Val Packett <val@packett.cool>
In-Reply-To: <CAJ+nLsRXTc=3LagGVdNiAPttL38tPVub_UOKuqJq91J9U0M+9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 6/5/26 1:43 AM, Carter wrote:
> I hope I've found myself in the correct location; I haven't ever
> officially participated in kernel shenanigans. I've been working on
> enabling the trackpad on a Surface Laptop 7 (x1e80100, "romulus"). The
> touchpad is an HID-over-SPI device (with a driver patched from
> https://lore.kernel.org/all/20260402-send-upstream-v3-0-6091c458d357@chromium.org/)
> hanging off a GENI QUP serial engine (spi19 / qup2_se3), but it
> requires QSPI transfers - the SE reports protocol 9 which is unknown
> to the mainline spi-geni-qcom driver.
>
> I did find a patch for this driver online out of the linux-surface
> community which may have even gotten it from another source. The patch
> seems to work, however it is very low quality and I suspect it may
> have been vibe-coded.

This one, right?

https://github.com/scuggo/x1e-nixos/blob/931cf9966ba3a213946329ce95b07635a34cd839/kernel/modules/qcom-qspi/spi-geni-qcom.patch
https://github.com/scuggo/x1e-nixos/blob/931cf9966ba3a213946329ce95b07635a34cd839/kernel/modules/qcom-qspi/gpi.patch

I'm not sure what's "very low quality" about it tbh, and what are the 
tells to suspect it was vibe coded?

> I wanted to ask: is there any active or planned
> work to add a QSPI mode to qcom,geni-spi controllers? I was unable to
> personally find any related patches or conversations on lore, but I
> may not have been searching in the right places.
>
> If nothing exists, I'm happy to make an attempt myself. I worry about
> getting in the way of more important matters as this would be my first
> time submitting any patch work and I am bound to make mistakes, but I
> will attempt it where that is welcome.

I'd start with the existing series above, it looks almost ready for 
review to me?

~val

