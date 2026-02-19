Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D484283FC5;
	Thu, 19 Feb 2026 12:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771503284; cv=none; b=Ho8fE4jtpA15cLD+HL2hmR2Qi7y+YJj/pqlXiysgjddy122g7Z+fZ+bjew4TXtZAUkD83SfnNo69DpI/p4snqWosdbWt13KipTCTj9AxG6wMZueCZwPBG54Tnv585gOKHeIU9Mr+k/i7b1s4RuUFsrfR5LvH1UG2ga492l4S6So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771503284; c=relaxed/simple;
	bh=hxSCJULIk3S57PIoIXZwF+R4TIgdUV4y4Fpg2rlZIo4=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Subject:Cc:From:
	 References:In-Reply-To; b=kplnrx36YlNyP6kNQWiUV9knfO8NPAgMB2sE3+zYlDFHpEcs1Js3zimqrUxNjwovy7gVwZgqAK0ehLi4kDm0HCLPHvq17BfErcgNjVk0Zksjr5vT3po75dro2VPKSqGmHgOoU+QwX3+QdVhhmFgx/ZIO+kbJH0vDSE/ejAydNKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qp/ApliP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qp/ApliP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45AF8C4CEF7;
	Thu, 19 Feb 2026 12:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771503283;
	bh=hxSCJULIk3S57PIoIXZwF+R4TIgdUV4y4Fpg2rlZIo4=;
	h=Date:To:Subject:Cc:From:References:In-Reply-To:From;
	b=qp/ApliPrsrwlR/JHVXYzV19s2uUGZ5UF2wu1w3MdpN6L+8jhxgGugk7ak0qY8Xl4
	 BFRZei7FoCJkatL1MjbDRu9JzWu0JfTYdqagH0/astqyeB+KNqAZ4z3B5bjOCbeNN6
	 VDvvpLY+hsvk3F8lnnNmkmA0JvS7x7UVDjvGsWnTG6zRdTgVxNNqQ+ocEcv13CXBrs
	 0LLE3zcfG8idmyKF9J4HIuwlQ4eK8AzkI2795xFuY69P4X9d+NnhSuPbb5krW/ZN4i
	 kD64mA96w7O3C1Jc9zafJrA/eyyjCQdcsv+03q11Q5TJve7AJkmLTrpbiObg+VuZ2f
	 xbPL9Yrhmo4BQ==
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=789f55f8419955e9a8d78cb3b3e5bcab957df757f53d5db9f426fb813101;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Thu, 19 Feb 2026 13:14:39 +0100
Message-Id: <DGIXI3RVPSJW.3J77RFU4JK6O2@kernel.org>
To: "Miquel Raynal" <miquel.raynal@bootlin.com>, "Santhosh Kumar K"
 <s-k6@ti.com>
Subject: Re: [RFC PATCH v2 08/12] spi: cadence-quadspi: read 'has-dqs' DT
 property
Cc: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <richard@nod.at>, <vigneshr@ti.com>,
 <tudor.ambarus@linaro.org>, <pratyush@kernel.org>,
 <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
 <praneeth@ti.com>, <u-kumar1@ti.com>, <p-mantena@ti.com>, <a-dutta@ti.com>
From: "Michael Walle" <mwalle@kernel.org>
X-Mailer: aerc 0.20.0
References: <20260113141617.1905039-1-s-k6@ti.com>
 <20260113141617.1905039-9-s-k6@ti.com> <87h5rvgkjs.fsf@bootlin.com>
In-Reply-To: <87h5rvgkjs.fsf@bootlin.com>

--789f55f8419955e9a8d78cb3b3e5bcab957df757f53d5db9f426fb813101
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Thu Feb 5, 2026 at 6:35 PM CET, Miquel Raynal wrote:
> On 13/01/2026 at 19:46:13 +0530, Santhosh Kumar K <s-k6@ti.com> wrote:
>
>> Add a boolean field to struct cqspi_flash_pdata to store whether the
>> attached flash device supports DQS (Data Strobe) mode. Read this from
>> the 'spi-has-dqs' device tree property during flash node parsing.
>>
>> This is preparatory infrastructure for PHY tuning support. The field
>> will be used by subsequent patches to configure read data capture timing
>> with DQS enabled for improved margins in high-speed operations.
>>
>> Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
>
> As mentioned in my answer to the cover letter, I am not too much in
> favour of this property because this is something that is somewhat
> related to the chip ID, thus discoverable. I drafted something to get
> rid of this property already, I will share it for opening the
> discussion.
>
> However, for now I am closing my eyes on the fact that the DQS pin might
> not be wired to the controller. In this case we will need some kind of
> "dqs-not-wired" DT property, that's true, but also easily manageable at
> the core level later, when/if the need arises.

Usually, a DQS pin is optional. AFAIK, there is no requirement for
it. I.e. it will probably work fine with slower frequencies and
using an internal loopback. So if you run your flash with slower
frequency you can probably save one pin and use it for something
different.

What I wanted to say is, that not having a DQS pin wired is not
really a mistake. But "dqs-not-wired" sounds exactly like it.
So IMHO it should be the other way around and the device tree should
tell you that *is* wired, if we cannot find detect it otherwise,
like looking at pinmuxing for example (not sure that is feasible
though).

-michael

--789f55f8419955e9a8d78cb3b3e5bcab957df757f53d5db9f426fb813101
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCaZb+rxIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/hX7gGAj59K5l6FuqHIr1P5IbyI4Z0sXZHmHc1o
mDd2Q85Sij8uG8z4QIYml9Qi/puGcxn6AX9WLWJocfkBRAQ6y5MLqQi4fl9IzeI+
dVa+uqTigEU7b9VOdNknXxmEnzfxKWiRiTo=
=bXm6
-----END PGP SIGNATURE-----

--789f55f8419955e9a8d78cb3b3e5bcab957df757f53d5db9f426fb813101--
