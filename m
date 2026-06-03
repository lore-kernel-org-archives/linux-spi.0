Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FD63DE441;
	Wed,  3 Jun 2026 16:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780502477; cv=none; b=EyigOCl2MtpytLI2bajYt+DlN5UVKwzYEcqSF5GiKf95SLDn6dbnU1J/3fefzbCt7Ia4mt+Ama+UxUxm5/c5Q4lbqld01gTsWT6QVoOWY/jkhrVULWXL6TpyVSszKEvkcl0OxysXBT7ElB/Lmt023/C4VF6Qz62nJwlES9bUnrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780502477; c=relaxed/simple;
	bh=BsbNWYH2izjNOlDmI6SDg0Mqw8LEsK+UeDW79yunUl8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gYWX3yKX0QSoifqMUD4xKEUulvJyFRGlY+omzsHR6ifs2jr/WAPcInG+ibN84HpSGduAXJ9lU1KeqncfuawBNMlZoJZhscxLLtFhMqcqNtOSZ/AIAnFY+GFhZCSF8t5j5P6TqwcOBceBv1bBe72XVGORm1iilMOcBxlGjSesuZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=2mSyo6ob; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="2mSyo6ob"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id D62944E40115;
	Wed,  3 Jun 2026 16:01:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A1B675FA0A;
	Wed,  3 Jun 2026 16:01:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5AF7410888CCD;
	Wed,  3 Jun 2026 18:01:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780502472; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=BsbNWYH2izjNOlDmI6SDg0Mqw8LEsK+UeDW79yunUl8=;
	b=2mSyo6ob2XjgIYSC6YCVIviauScosz4++r4o2nlrcqQmCtc37rKKI/nelCWMCXnv7L5gwv
	kzg9BeDuf4FNeNKQPGgcMjGdrcz+6XdgWB+ALzXsfqlvu47abJSsUOA/BQ23IxpHUK4skv
	wDlqudx4SA6+bPFD02rtBT3LxbHaT86ovWvv5Ne8w48KiA6sa2bHAcCrAmUtAj4DsOMCBg
	SV0D9313Gthd0PjoA5TbUVXlLNvtxaQO4LszmbeY4APM6KvwVcRj4kreiL/Vgp+Fn4IwQ5
	jhfX1+NJ06sOhFQ67Mx/we1is+1MPU6dM2U76t7+lxy2kHxLS3uK3vOKOP5JAQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Rob Herring <robh@kernel.org>
Cc: Santhosh Kumar K <s-k6@ti.com>,  broonie@kernel.org,
  krzk+dt@kernel.org,  conor+dt@kernel.org,  richard@nod.at,
  vigneshr@ti.com,  pratyush@kernel.org,  mwalle@kernel.org,
  takahiro.kuwano@infineon.com,  linux-spi@vger.kernel.org,
  devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-mtd@lists.infradead.org,  praneeth@ti.com,  u-kumar1@ti.com,
  a-dutta@ti.com
Subject: Re: [PATCH v3 02/13] spi: dt-bindings: cdns,qspi-nor: add PHY
 tuning pattern partition property
In-Reply-To: <20260602164945.GA475455-robh@kernel.org> (Rob Herring's message
	of "Tue, 2 Jun 2026 11:49:45 -0500")
References: <20260527175527.2247679-1-s-k6@ti.com>
	<20260527175527.2247679-3-s-k6@ti.com>
	<20260602164945.GA475455-robh@kernel.org>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Wed, 03 Jun 2026 18:01:07 +0200
Message-ID: <87zf1by5oc.fsf@bootlin.com>
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

On 02/06/2026 at 11:49:45 -05, Rob Herring <robh@kernel.org> wrote:

> On Wed, May 27, 2026 at 11:25:16PM +0530, Santhosh Kumar K wrote:
>> PHY tuning requires a known data pattern to be readable from flash.
>> When no partition is explicitly identified, the controller must search
>> all available partitions to locate the pattern by label, which adds
>> overhead and relies on label naming conventions outside the
>> controller's control.
>
> I agree 'label' is not the best choice. Software should not care what=20
> 'label' contains. It should really be 'compatible' instead.

But compatible does not seem relevant in this case, right? We are just
flagging the location of "some useful data for the controller".

>> Add cdns,phy-pattern-partition, a phandle property that allows the DT
>> author to directly reference the flash partition holding the PHY tuning
>> pattern. The controller uses this partition during calibration, avoiding
>> the partition search entirely.
>
> Do you have any data that this approach being "direct" is faster? In=20
> fact, it might be worse. Instead of searching just the limited number of=
=20
> partition subnodes, you now search the entire tree for a matching=20
> phandle value. We do have phandle caching, so that might save you
> here.

True, but besides performance considerations, I personally do not find
elegant using a partition name/label, but maybe that's just personal
taste :-)

Thanks,
Miqu=C3=A8l
