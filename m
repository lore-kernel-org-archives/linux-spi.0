Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A97E2C3261;
	Tue, 20 Jan 2026 20:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768942153; cv=none; b=T0HgvBtUuoLaDGdunLGhVOHnuryrZww0fxaJMe3UtBS8/UnP+usQ8Qd34ojo+b56fcjRWAUE+ZyqrAMNEBDQQFpBjacO3jKQH5h/ruTn2o+qjFs6XZGwvtcso+DPlqS73GJyGN1DNY1Wh0BqAxTct9jWpb/JjlSmu2pEDkDbsLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768942153; c=relaxed/simple;
	bh=y07lUXXR9I+hg1dVmuu/CxuRNF3OcrvhEbQJ+/flGe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JyyInvqHoTMMI/zfpyjyuzSnCrCvIMNssGAcCNBXZLWW6VixGeVk9oRw6K1H7uSFXwSIlT88j36jjCLsV2WwB0DuW6mYybQzz16Janv1wD+T6UJ3SpEYIk1S1F4YRlsnC316EKF3r4XsvT7XhZJF7sr3n017PqBMbTa6LrrMO2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=B9NFqMHs; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="B9NFqMHs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=XuShmbIsWHkVNMchEJAOvTV/LRlfC3PDeUwV/9Gb9tw=; b=B9NFqMHsuVdpi53LPqtVcEevCC
	vkkuVm0zCdGkepUf/uYbkRE6zxo7T5lmJqRmj/OZUc1hl9Gu5g+4uNZIZGReL6zGdq/aBJTSeq3kZ
	4ZJEv/DtTs5Z/QKrFMqLppeGw/Bg5zzQvAatuwl4JlXXYb8+l8nl5VAhsKrzUZQoxkA8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1viIes-003inO-RL; Tue, 20 Jan 2026 21:49:02 +0100
Date: Tue, 20 Jan 2026 21:49:02 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Cc: Mark Brown <broonie@kernel.org>, Michal Simek <michal.simek@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] spi: xilinx: use device property accessors.
Message-ID: <e8259a1b-ad3a-4f87-ae56-00eb3f4aa4a1@lunn.ch>
References: <b9ad8ab8-7985-4c89-a82b-c7f31d32c167@sirena.org.uk>
 <a6d57890-89c1-445e-836c-d8239d20c621@amd.com>
 <b03307f7-93f6-4680-9241-cf28b5456fd0@sirena.org.uk>
 <a3fcef3a-d1e9-4b46-b114-3a82575e052e@amd.com>
 <980ad372-a2c7-417c-91f9-4958d3d1aaca@sirena.org.uk>
 <4831B269-DFC1-40E0-96B7-67981AC72562@nexthop.ai>
 <6e06696e-09a4-46e0-98fa-252690b888e0@sirena.org.uk>
 <BF71A04E-7FFB-42D1-8C8D-6FD13415EED5@nexthop.ai>
 <c3fc04a4-4b09-4c6a-a0f1-e5aa92a22976@sirena.org.uk>
 <80A8F67E-7A01-4F9F-9D84-29722678A2CE@nexthop.ai>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80A8F67E-7A01-4F9F-9D84-29722678A2CE@nexthop.ai>

> This is not for a normal off the shelf server. In our case we are
> building an embedded switch with an AMD CPU and Xilinx FPGAs that
> happens to use EDK2 based BIOS and ACPI.

I would actually say, that is the core of your problem.

Look around at the networking world. Nobody uses x86 for core
networking. Nobody uses ACPI. Everything is MIPS, ARM, or Risc-V and
using DT.  Linux has mature and complex DT bindings for networking,
ACPI has nothing.

You might want to consider using DT with x86. It is possible. Take a
look at drivers/misc/lan966x_pci.dtso, which is used for networking,
and can be used on x86.

    Andrew
