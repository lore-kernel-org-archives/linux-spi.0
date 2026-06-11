Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E3D331EBB;
	Thu, 11 Jun 2026 04:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781152898; cv=none; b=nsqIUmHSAObcXzTqnvHJjK1yz5I3cguKeULgm2gvnQxC9TpwGRJCEABMyarEls1S63hkwihKz21wRRu8v+8py+E41OYePMk6HVLphEQw5iY5cS9+RCxR5raGvmYhqyZd2/CaO+WSUFcyUFa79PsvJ2AnZNdbOZgUX6p9dIUd8Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781152898; c=relaxed/simple;
	bh=O5UL50dL2j3gIRJdcn1CXWPigbewWppsf4WHWE0i3FQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=p5wCe0AbmjjMX7kieQLunJzHByk4HiKW/UK1emtKMhR6uIeQhN2DCp9wry15l5qW75pfF1Xvz3P6KkB8nOTgUaqeNO4ZQeK6e8+IasnW2l7XM/rG9y96FQluuHy/Z2nC1M4ix8dX/UBNfM7PEuFK4TmKYv7e6qgwt3ZVIezBGsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=b8MYOE3Z; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="b8MYOE3Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1781152894;
	bh=eiWLnSSU4F3awHVV3u2QFSYxQvFnUPM+p2QcVcY5/5c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=b8MYOE3ZN+SFjNp6KT/5fHfj4AojvYFBsSCBKVSlU6Uc1Sr14LmGgTDs6AE+ZHiNi
	 NSEfp48voioC4dUce+kF2tyeXgaQ1cPhlNmR64/UkPcu0T/Y4FrMS6qbjBwrpiD4Dz
	 ynKRVzVUcCWah7kDmj3teMHO7sO/NcUo0igkT7DVBFLxcPqohgGYImxxiuWrAaygwk
	 8redMbewx4PisQ6NRWwjXi6Qv7sCyLfppXuzc2FiFMH7yX4wk69gohZdmYUQWS+Rl9
	 AUkjdRHzczNwej4SjcAHM9Dm0ON1j3AKhAh2wZMv1pCx4l2ob2JIKGJS5gJ2pyasBk
	 JDXPqYl0M0Luw==
Received: from [127.0.1.1] (unknown [180.150.112.11])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 3B13C60A0C;
	Thu, 11 Jun 2026 12:41:34 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, Tomer Maimon <tmaimon77@gmail.com>
Cc: openbmc@lists.ozlabs.org, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 avifishman70@gmail.com, tali.perry1@gmail.com, venture@google.com, 
 yuenn@google.com, benjaminfair@google.com
In-Reply-To: <20260610121822.2524634-1-tmaimon77@gmail.com>
References: <20260610121822.2524634-1-tmaimon77@gmail.com>
Subject: Re: (subset) [PATCH v5 0/3] Nuvoton NPCM FIU DTS fixes and binding
 conversion
Message-Id: <178115289418.1513794.15361783177002818407.b4-ty@b4>
Date: Thu, 11 Jun 2026 14:11:34 +0930
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Wed, 10 Jun 2026 15:18:19 +0300, Tomer Maimon wrote:
> This series fixes the in-tree NPCM7xx FIU controller nodes so their
> resources match what the DTS actually describes, and converts the legacy
> Nuvoton NPCM FIU binding to YAML DT schema.
> 
> Patch 1 drops the bogus "memory" entry from reg-names on the NPCM7xx FIU
> nodes.
> 
> [...]

Thanks, I've applied this to the BMC tree.

-- 
Andrew Jeffery <andrew@codeconstruct.com.au>

