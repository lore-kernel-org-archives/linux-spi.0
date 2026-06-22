Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33080CA45;
	Mon, 22 Jun 2026 09:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782120295; cv=none; b=CdVoPdCq1nCB5CjDFoC67KM4FWDWvxiW29oAfsP45YrFv69K4YXhmTJsn/L0p9ROXY4nvfMsQq38DcyrPuPrTvSXi3dxpeu+/uI37btTVPNv2Y3miDQa9oQZcZJCJvf+xZUWP1TWSnOmaPai0BVsdG5QNpMkUyGTzZt9JBoAIHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782120295; c=relaxed/simple;
	bh=/psBRO9a+1+vw71JPfTSql43m/kuBUfHerlJ0r9kBqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dUXpDudTn0SYSr0iUBXFgMnAcu9xsMMpCo5jATpqdACvM6j1/5uiWvXde3X1MGL5uveAWSusDnfJB84qIsEOe/Af8N11lVKfnAddDV4sIyFeDYXN/bh5Du6V5C73I+jf+QYil+ATIZN6NdSAqy/S3DKftRjD8W5lYAmAnMPe7LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tnijca6p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tnijca6p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CE2A1F000E9;
	Mon, 22 Jun 2026 09:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782120293;
	bh=AJX+sPInRCDW8SROfrGz9/Dj3td9IksSJtySC4l5cCQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Tnijca6pTeJfj1d0ffWt1sPKM1+PHPZDEcJyC4+HBB6uC6PQGFqG8dD3QF1fH5Vv+
	 0OBsnn7k/eJcnU7633ZPdA8MIhLYENaStsM+znWDF1dE91D00Yc/0xeWpGloHI1IlA
	 kMtL6xSkg1Bnicb6b8UbZrTKdENuDV+YkghV9TncCuVxjM27czPhdrbSAahZWNdgX5
	 X3GvHZrYScaFLCxHCCKd0DFhxQFmnCqt/cWN8U19SeC1z0ev6gQinv4nLN/n+Iq/VH
	 V9npCHHUQ1ecK9LSisBSYdfRROe+NjHuqUkPjOvtPquMi9Iq4z5wA6Oct5NKabEGmL
	 h9pJEoAYxJJZA==
Date: Mon, 22 Jun 2026 11:24:49 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ninad Naik <ninadnaik07@gmail.com>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, david.daney@cavium.com, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, me@brighamcampbell.com, 
	linux-kernel-mentees@lists.linux.dev, skhan@linuxfoundation.org
Subject: Re: [PATCH v3] spi: dt-bindings: octeon: Convert to DT schema
Message-ID: <20260622-auburn-aardwolf-of-apotheosis-82df8d@quoll>
References: <20260618180149.475658-1-ninadnaik07@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260618180149.475658-1-ninadnaik07@gmail.com>

On Thu, Jun 18, 2026 at 11:31:49PM +0530, Ninad Naik wrote:
> Convert octeon-3010 to DT schema
> 
> Signed-off-by: Ninad Naik <ninadnaik07@gmail.com>
> ---
> Changes in v3:
> - Change the maintainer from David Daney to Rob Herring

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

