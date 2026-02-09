Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B24B36606B;
	Mon,  9 Feb 2026 09:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770630506; cv=none; b=c72BBiTJOHheDPdBinTp+aEC2kyYgAEO9BI/hz3/ZNLtr+3h3dNKY3kZdsnLEua+fB8TjTsKZsMjZlOw83QFMTl+2zkLRyk1MC7vlDBOUWhSvn01JgvrtlHioAut2VW3ND3x93BKDNuXDwlOcqsXYdttZa1eeakvIIVXLV1YeXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770630506; c=relaxed/simple;
	bh=w/k37mANKnb9tE0V6Kub9ubfuIj32EQidedBAveARXk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=DKTeX7stZ6Q4IKLaNYcGy51RJmPwKWBF2GxlkoUng4pkZd6QYwT2XWP9ODAOIgSfLefo2NjZXK8WgC24iXnU+7qOoOU7yAXhzQIZKHwLLb/vPi7qKht6K65fpmwTGrVEkBkiAnzYocbOIMVhEDEKB6OhKWN5ueoWXLycRwlkR14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sl+XPEEP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sl+XPEEP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EA2AC16AAE;
	Mon,  9 Feb 2026 09:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770630505;
	bh=w/k37mANKnb9tE0V6Kub9ubfuIj32EQidedBAveARXk=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To:From;
	b=sl+XPEEPcBuTtRE9+reIUogcwKdqmLbonc5R0mA77HsibgCIvB9G9qucr/m42/oRE
	 w0GPdS7CvYZ4+2i2SVMeXXrA50euzmgBq29E1Q6kUSQXdwSSo4P2NBgpk47BnJ2TlH
	 X/0tSpo5+xw48Je5vD7LGbEX0d+ldPSA6kq0GIF4Gv3zOsaanSedgduJEOfM9g5sLk
	 r1/t9vIiITBneOxgIxElQtvJqbTQjJacJBpwmYCB3BGi5IpdoVUm+Spfxgwt5I4EwE
	 OLQES1Y7EaJKp9mOmW6FXvS3hfQDDzg1n6syAPe8cFAMBtB725DnlNUpM2FdWdlC9z
	 Q1NGlffK9b7Ig==
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=3fae006473f93b202e9fe7468c884ebf0118ef603a7a5dbb515b94d9e3be;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Mon, 09 Feb 2026 10:48:21 +0100
Message-Id: <DGAC4N62UZQQ.3R7TLX87PECU3@kernel.org>
Subject: Re: [RFC PATCH v2 09/12] spi: cadence-quadspi: add PHY tuning
 infrastructure
Cc: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
 <praneeth@ti.com>, <u-kumar1@ti.com>, <p-mantena@ti.com>, <a-dutta@ti.com>
From: "Michael Walle" <mwalle@kernel.org>
To: "Santhosh Kumar K" <s-k6@ti.com>, <broonie@kernel.org>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
 <tudor.ambarus@linaro.org>, <pratyush@kernel.org>
X-Mailer: aerc 0.20.0
References: <20260113141617.1905039-1-s-k6@ti.com>
 <20260113141617.1905039-10-s-k6@ti.com>
In-Reply-To: <20260113141617.1905039-10-s-k6@ti.com>

--3fae006473f93b202e9fe7468c884ebf0118ef603a7a5dbb515b94d9e3be
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Jan 13, 2026 at 3:16 PM CET, Santhosh Kumar K wrote:
> +static int cqspi_get_phy_pattern_offset(struct device *dev, u32 *offset)

..

> +	partition_np =3D of_get_child_by_name(flash_np, "partitions");
> +	if (!partition_np) {
> +		of_node_put(flash_np);
> +		return -ENODEV;
> +	}
> +
> +	for_each_child_of_node(partition_np, part_np) {
> +		if (of_property_read_string(part_np, "label", &label) ||
> +		    !strstr(label, "phypattern"))
> +			continue;

There was already a review comment on the last version. Moving this
into the driver doesn't make it any better. In fact this might
create a (bad) precedent for future drivers.

-michael

--3fae006473f93b202e9fe7468c884ebf0118ef603a7a5dbb515b94d9e3be
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCaYmtZhIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/g3nQF/ZehnFdPDNUb+qGtsugnARG8Gyx1wWmE7
KDHWkQsA/FeRC0O99ri4eyaI0daM3gcQAX9e7sCThdOPCBfvyBk7S8UhyVXKTiGF
1O3T7/Re6avtBysjtj8ooo9Fia8wiIqdViM=
=4bKt
-----END PGP SIGNATURE-----

--3fae006473f93b202e9fe7468c884ebf0118ef603a7a5dbb515b94d9e3be--
