Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408D41E5714;
	Tue,  4 Aug 2026 12:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785846016; cv=none; b=GEvgJw42+m+PK0mFj5pKwn+2V5WKKFg+oR5/6m5PoDSP1Oau95JqG/3OFtoJiky1rejyl4fdMID94eOkQkbMeSyx5OlRASr7X4cz5jkNwCpns0kn+/q2SuLILYtAV93Pjnv5Khw6Aq3gDa7ZWAcyRiXuW14IeWSzdEi3oMi28GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785846016; c=relaxed/simple;
	bh=BwrI5sQtfV+qO1B6bMG8U5HmDx6PZOD559FHr71hTWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ctBt8qFju+F3drsCO47MIyD4CmdH9mCUPthawZKxdrktIZEi2Xu4IQZOCNHKBdPQxtwM5018oLFl+fLYJ3faLUfO0FdjaRaUZFRctRbcDrNRvtHUwV8b+pXT5JvB1+Y+36Tpbg16hGwc5YJW9G8sRWxMepsuUtvB+u5BzMG+h7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1AbMORev; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1AbMORev"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E536B1F000E9;
	Tue,  4 Aug 2026 12:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785846014;
	bh=43V8Vcr7/ZgENMRf8BBVhplkuKW0VEmbjigo3HtCvdc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=1AbMORevw/0tXDtxT40hlAZbaCbCxKN9m9NyY5H4VnoRPpgjFifbYKzabDZ87WFF7
	 kX8Ba+wST/MIfOOrHdqZhK0wJszsesHQYg9j+sQgww2/PajD5XidguA1Z8Veu4cmEP
	 rdUtTqgANSlDV3iEun4ki0evO73huS2jjaDCvaV4=
Date: Tue, 4 Aug 2026 14:18:42 +0200
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
Message-ID: <2026080416-lagoon-delirium-8e84@gregkh>
References: <20260804115259.4065638-1-krishnamoorthi.m@amd.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804115259.4065638-1-krishnamoorthi.m@amd.com>

On Tue, Aug 04, 2026 at 05:22:55PM +0530, Krishnamoorthi M wrote:
> Feedback Requested
> ==================
> 
>   1. We chose a dedicated bus_type for the reasons described above
>      (capability negotiation, four independent channels, asynchronous
>      ALERT#). Does the community agree this is the right direction, or
>      is there a strong preference to extend the SPI subsystem instead?

That's up to the SPI maintainers and developers...

>   2. Is the blocking notifier chain the right mechanism for event
>      delivery to slave drivers?

Notifier chains are almost never the correct solution, especially for
real data you wish to send to devices/drivers.  Just use a real
callback function you have to register for, and a workqueue, or
something like that.  Ideally just use the process context of the thread
that created the data in the first place, why can't something simple
work like that?

>   3. Any concerns with the ops table design or the -EOPNOTSUPP fallback?
>   4. Naming and structure of the public API in include/linux/espi/espi.h.

What specifically are you asking for for this?  Do you have userspace
code you want to integrate, if so, does it work with this?  And where
does it live?

thanks,

greg k-h
