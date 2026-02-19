Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F09726A0DD;
	Thu, 19 Feb 2026 08:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771489994; cv=none; b=D/L+1D/aY8omKqGFL354MhXSXsoWu5zgpgS+BLQgAwbn+oDWNa+Oupv2q6gfkYRi+Z5N6bJItTJrei4J5QM6fYatmOeXGHTlNFSg7AgTv3YsWO98feLl2qBlOrTnyW2mtyiq6DAOaIodL6IxsaFYKYaUSt6vwbD6UbP5BXMkIIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771489994; c=relaxed/simple;
	bh=7CuuK/0ziAW4syVDA6KX77tamFKsOSxget6SwWeQIlk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=eh9hd5k7kruf6VZ/6WsqzeUlXNJFdN8dV1NroNTx9I7pntUa7dH6Q56KEFtP0hNS3bxy1nuCGxhu4AdFKfvaoPTPPRxGu4/2LVfbgtwebOQAftAjLWoQMSprpAFQAHjQ6IQhIpWb7jbSL3/KPTyEXYCDILEZ35gcxoL6186X23I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D9Mr9LYC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D9Mr9LYC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DC66C4CEF7;
	Thu, 19 Feb 2026 08:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771489994;
	bh=7CuuK/0ziAW4syVDA6KX77tamFKsOSxget6SwWeQIlk=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To:From;
	b=D9Mr9LYCm37L/N1CWOpScJRdqgnZLzw4qLlvMjs+U00wtD7L8FxIQgmfyJq6xksQL
	 OAN8I/siEyhOeWyxAzw7tKW1rHgcWRCtG+2KcOOONTvuQr6RAV1VhKvC/8sfDYjjf4
	 IRbtuSI/rrxB5oIQPKbv36fnl8PjnBY1DuBHNJmUJZbfgtc4nrAQPZNfHmw2E1IuGI
	 bvY/ScaFuLc6wK/UGnsHPf2AvvHygy95AGF7eC/9vneFb8kwH/4t95qZX84vnZsjz7
	 E16MGADpdkNdgRZeERs5NXewPl+d6hCNykOiiEqukdVPfoYga3iVPAWm1Ac7/T8scz
	 SKsxbN6W4tZAQ==
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=8180e7ca633d8ac0d60acc5bb8be376c76d43e2963a101100fb17d52ff94;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Thu, 19 Feb 2026 09:33:09 +0100
Message-Id: <DGISSIKZERL6.22GCNLNJG9KBY@kernel.org>
Subject: Re: [RFC PATCH v2 09/12] spi: cadence-quadspi: add PHY tuning
 infrastructure
Cc: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <richard@nod.at>, <vigneshr@ti.com>,
 <tudor.ambarus@linaro.org>, <pratyush@kernel.org>,
 <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
 <praneeth@ti.com>, <u-kumar1@ti.com>, <p-mantena@ti.com>, <a-dutta@ti.com>
From: "Michael Walle" <mwalle@kernel.org>
To: "Santhosh Kumar K" <s-k6@ti.com>, "Miquel Raynal"
 <miquel.raynal@bootlin.com>
X-Mailer: aerc 0.20.0
References: <20260113141617.1905039-1-s-k6@ti.com>
 <20260113141617.1905039-10-s-k6@ti.com>
 <DGAC4N62UZQQ.3R7TLX87PECU3@kernel.org> <87qzqqxml7.fsf@bootlin.com>
 <DGCXTWSCAH6R.22SIL82AUVGYI@kernel.org> <87fr76xgsl.fsf@bootlin.com>
 <54964ad3-64d7-4f4e-bcf9-f0b92b1df034@ti.com>
In-Reply-To: <54964ad3-64d7-4f4e-bcf9-f0b92b1df034@ti.com>

--8180e7ca633d8ac0d60acc5bb8be376c76d43e2963a101100fb17d52ff94
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Wed Feb 18, 2026 at 7:07 PM CET, Santhosh Kumar K wrote:
> Hello Michael and Miquel,
>
> On 12/02/26 18:25, Miquel Raynal wrote:
>> Hello,
>>=20
>>>>>> +	for_each_child_of_node(partition_np, part_np) {
>>>>>> +		if (of_property_read_string(part_np, "label", &label) ||
>>>>>> +		    !strstr(label, "phypattern"))
>>>>>> +			continue;
>>>>>
>>>>> There was already a review comment on the last version. Moving this
>>>>> into the driver doesn't make it any better. In fact this might
>>>>> create a (bad) precedent for future drivers.
>>>>
>>>> I remember complaining about it but not if there was a solution
>>>> foreseen. In SPI NAND the solution has been found: the pattern is in t=
he
>>>> driver and we load it into cache before PHY tuning. But for SPI NOR I
>>>> understood this wasn't possible. What would be an alternative?
>>>
>>> I'm not complaining about using a partition for the pattern but
>>> about the hardcoded name of it.
>>>
>>> It was proposed to use at least a device tree phandle to point to a
>>> partition (or so).
>>=20
>> Ah, yes indeed, thanks for clarifying this up (again) for me. I also
>> agree the hardcoded name is not ideal.
>
> I remember this was discussed in the previous version. As mentioned
> in v1, using a phandle may not be ideal since a single controller can
> be associated with multiple flashes. Regarding the suggestion to
> maintain an array of phandles - consider a configuration with three
> flashes (NAND, NOR, and another NAND). In such a case, we would not
> need a phandle for the NAND devices, right?

Miquel said:
 | I find pretty strange to have this property in the flash node,
 | even though I understand the reason. Perhaps an array of phandles
 | may work in the controller node instead?  So maybe the phandle
 | should be inside the flash node?

But why is this strange? Can't we treat it as some kind of hint for
the controller, esp. because as we now learned, that it's not needed
for NAND flashes?

I.e. for phy tuning to work you'll have either:
 - nand flash, there it just works out of the box
 - nor flash, you'll need a phy-calibration-pattern-hint property in
   the flash node pointing to a flash partition.

If you think about it, a flash partition with a fixed name is also
part of the flash node. You just add one more indirection to get rid
of the hardcoded name and have a proper DT ABI.

> Also, I'm trying to understand the practical difference between using
> the partition name versus a phandle. Since the phandle would still be
> named something like "phy_partition", it seems functionally similar.
> Please let me know if I'm missing something here.

A phandle will be part of the DT ABI. And it will be configurable by
the user.

-michael

--8180e7ca633d8ac0d60acc5bb8be376c76d43e2963a101100fb17d52ff94
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCaZbKxhIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/gfIQGAhm4BHvpagP/nqVzn2KYHGkLZLYVEFUXO
Eu1rxUUExUUxthrES6MNO5nq1l0/ShbSAYDvtKFe7f4djqUowfoczDGG2uyRYY+Q
C5mflOiigfpnGTVRUXm0MTFX+V7jb9vpNWc=
=Mowf
-----END PGP SIGNATURE-----

--8180e7ca633d8ac0d60acc5bb8be376c76d43e2963a101100fb17d52ff94--
