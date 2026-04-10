Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB20018AE3;
	Fri, 10 Apr 2026 15:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775836309; cv=none; b=UadG5Kw409033Y93arSJrtdlWPHmh3WMk8xmiglWxfEsCsDYgv3yQO6P9Y5ke4nLA/W5TRwu9DpU/oXeoe3Hu9TmhFtNd8N99oG5LmKW6/L9VMEblKeeOasPRN8pH0Cm23k263TuRWoalm5N2BnDq6u9oCPvjz8/MIM240MdlzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775836309; c=relaxed/simple;
	bh=1vnxlyanMc7rxGXJuZW9/GoUGctW7bcAr9dzLRt7UOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nk068LVosj0cmgffyAcvdbEvFP4Q/+cqn7CIw5PWG2qNjo1w/oPTg6OieaMd4ftxXenSnTfGLA4Q0kWB9wKanVQdLkPsqFfcvhNLwBhPxtQ2c1zT8PP69EdNTwZDb3flmdiIFo75ixvPZjqnyFOXioU7ZmowRvFs2stMZLc7ld4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mi9Fm7Rs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mi9Fm7Rs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23C22C19421;
	Fri, 10 Apr 2026 15:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775836309;
	bh=1vnxlyanMc7rxGXJuZW9/GoUGctW7bcAr9dzLRt7UOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mi9Fm7RsiYH0PEYWgcUHSQwb83CVaMQ9N6F5W/TOImjxkXmmBsRDvtR2bWMcRxDHp
	 zDLJk76HhyJxg4mMP5/BOlKGmC2O1tpyx4TdZLuv5yAgbdg/5IX6AqEcALoc/IMyrs
	 b7xi8uemhj/Aammypk+sCMXuESr+Kufh2KxloG5vQ3JGF47Cj53N2EBxoJjYygxuQC
	 85O/vOFrwdxTfr+kylL8JcOJOGo/b/QFp/rUQMLTQg1xrWjB/WbEWSxZaSgyk9Wcnx
	 buRcywz1Ae5c98cOMMa4B2dAjfiBlY5pxrVOPEeRz7E7gNltYqzXqvPNv4a5Epax4l
	 mNJXVkH7IkRRA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wBE94-00000000XfG-3C1W;
	Fri, 10 Apr 2026 17:51:46 +0200
Date: Fri, 10 Apr 2026 17:51:46 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Saravana Kannan <saravanak@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] spi: fix resource leaks on device setup failure
Message-ID: <adkckl8w_3Mn9G5G@hovoldconsulting.com>
References: <20260410154907.129248-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410154907.129248-1-johan@kernel.org>

On Fri, Apr 10, 2026 at 05:49:05PM +0200, Johan Hovold wrote:
> Make sure to call controller cleanup() if spi_setup() fails while
> registering a device to avoid leaking any resources allocated by
> setup().

> Changes in v2:
>  - only call cleanup() if spi_setup() fails during registration
>  - use spi_cleanup() helper
>  - fix controller cleanup() documentation (new patch)

Bah, I missed to add "v2" to Subject. Let me know if you prefer me to
send a v3...

Johan
