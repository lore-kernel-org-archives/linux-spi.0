Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D0C28F5;
	Mon, 30 Mar 2026 07:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774855018; cv=none; b=Pq1gjYvzuxObxq2JZkYQLVZQW7K13HwQ5/SUbNTdE1gdTh28lJfVIiihOimELvPQ9+pUknwJ/QV2G+NMObl50sjN0+dOv8slzcyZ5YUC8d9+LA2zUuWpnkMcBosRS4fgpdKYHRHy4FUji/PKT07lTsTfvU5bPK5WylyT9a2dctk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774855018; c=relaxed/simple;
	bh=CnYOibETHQVOnRtTG9pk77TUVBQ/hmWCGfvaR5DXM2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hf/JOzISP5auXRswWdmofIF4CzUPP1Nama2VgsCyDDnfLCmOzi5U47pk+tlxXFdZmmMHG4iTZ35HxdaOHsw0024OVHMkylinBx2MVqcXxc6KyVuGO+oMUavDyNpwKx2uXPQGozgCKCYgiGsxOvOXz38rnCAMSZEg5KzeHhNXUpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aNkX6JmJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aNkX6JmJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F26C5C4CEF7;
	Mon, 30 Mar 2026 07:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774855018;
	bh=CnYOibETHQVOnRtTG9pk77TUVBQ/hmWCGfvaR5DXM2A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aNkX6JmJa6nT8ppnsDdTbfs8H35LHcohrTR6GyKFhmxjXPSHvB4h1TZxgimq3bYCz
	 0zGorsRyw2d4a0hnKCVGy46uFcQT64VBQS1AuEqZxQL/0y8BW+4f1KzNLyOlWw/gId
	 ybxDVCPEivem6uzWs6HbXzj6KzjVOmqGHgsaKe724wU0yJ2FRJVhJadjs8xcY4oZ74
	 xO17XaT9l53FyqPEmETSDUVABkKcVDbb+zm1vGdi4ssMlfQ9HMylLWmFec+EQh5CsB
	 XjIx99nPQ+esX4yn4hIceJ3Bc6rweJDQZGyG7h6kvHyEvcdOK4SzZ6+450kUTAeiGP
	 3mLOAPdbnffiQ==
Date: Mon, 30 Mar 2026 09:16:56 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: charles-antoine.couret@mind.be
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2 v2] devicetree: spi: add spi-mosi-idle-low property
 support
Message-ID: <20260330-invisible-rich-ant-e7fdab@quoll>
References: <20260329125832.2985115-1-charles-antoine.couret@mind.be>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260329125832.2985115-1-charles-antoine.couret@mind.be>

On Sun, Mar 29, 2026 at 02:58:32PM +0200, charles-antoine.couret@mind.be wrote:
> From: Charles-Antoine Couret <charles-antoine.couret@mind.be>
> 
> This flag means that device requires the MOSI line to be low
> when it's in idle state.
> 
> Signed-off-by: Charles-Antoine Couret <charles-antoine.couret@mind.be>
> ---
>  Documentation/devicetree/bindings/spi/spi-controller.yaml | 5 +++++
>  1 file changed, 5 insertions(+)


There is no patch 1/2 here, even on mailing lists, so probably this has
messed threading.

Please use subject prefixes matching the subsystem. You can get them for
example with 'git log --oneline -- DIRECTORY_OR_FILE' on the directory
your patch is touching. For bindings, the preferred subjects are
explained here:
https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters

Best regards,
Krzysztof

