Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C865C3C7689;
	Tue,  4 Aug 2026 13:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785849994; cv=none; b=rNyLJoP2AcjxTG2G/tKP3fsEWMRNC/7Xs/u1ze70VtNiAsHvkQW7SHGSO5LhMRtlwgSkkAdRnx4Rvt32TwYI7UWSG46t9AocTh+MkDmi6PzzgKHSX6H88cKBjcEp6JKgFd+7bR/2itHWveejKLNAOSeX2MgGYm503PPz2qM3muw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785849994; c=relaxed/simple;
	bh=V+pZ+0zQGj8SXN0nB5hhQSg8A1d1HH0N8OxsN2C9znU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kzkrz/2H+1hu650XolLpfBefrkoEn/Z1e5JgsMK5vs/ZLtu0EzdsgSSvPhBN5yf63zTb9RUMe6eKIrNZ2ZFl1nbdOE0OBYyDj4UdewseSbqwSBty0o9sH/DWmYhV0LBXl4Ce9Cf8VknVHVslJMqKzDs+OwPKxnroNnvGv1p1aik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=npPVQA1N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="npPVQA1N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E307E1F00A3A;
	Tue,  4 Aug 2026 13:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785849993;
	bh=mozmpqxreYt7kfWXg/1a/5py6oUvYOv4Rfa/YPbStmU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=npPVQA1NPT3z3In8PEI4GA24tKxI4vrxoDN8lFrWQ8JbTz0eFtjO5YVTPs75yOamX
	 wH8a+1ILRGn4sQ3WReFTVZetBWeBlGJHy5cL4YW928zyQMgfPghenIVS9SCU6CiLfF
	 jave392O/lw+ZhPcq4aKXqfYAHYNof5Nwb9x/4/Q=
Date: Tue, 4 Aug 2026 15:26:16 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Krishnamoorthi M <krishnamoorthi.m@amd.com>
Cc: linux-kernel@vger.kernel.org, broonie@kernel.org,
	linux-spi@vger.kernel.org, akshata.mukundshetty@amd.com,
	bleung@chromium.org, groeck@chromium.org,
	chrome-platform@lists.linux.dev, corbet@lwn.net,
	linux-doc@vger.kernel.org, skhan@linuxfoundation.org,
	andrew@codeconstruct.com.au, linux-aspeed@lists.ozlabs.org,
	openbmc@lists.ozlabs.org
Subject: Re: [RFC PATCH 0/4] espi: introduce eSPI bus framework
Message-ID: <2026080449-festivity-computer-693f@gregkh>
References: <20260804115259.4065638-1-krishnamoorthi.m@amd.com>
 <2026080416-lagoon-delirium-8e84@gregkh>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026080416-lagoon-delirium-8e84@gregkh>

On Tue, Aug 04, 2026 at 02:18:42PM +0200, Greg KH wrote:
> On Tue, Aug 04, 2026 at 05:22:55PM +0530, Krishnamoorthi M wrote:
> >   4. Naming and structure of the public API in include/linux/espi/espi.h.
> 
> What specifically are you asking for for this?  Do you have userspace
> code you want to integrate, if so, does it work with this?  And where
> does it live?

Oops, sorry, I thought this was uapi stuff, nevermind...

greg "i need more coffee" k-h
