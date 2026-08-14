Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E549370AF6;
	Fri, 14 Aug 2026 10:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786703028; cv=none; b=CL0qdeZzvEL0JWFnFbTzyPTb12jyE5YjK1pHjon43/Acvw1wFvzEt3bYyDpcSulXt4JP11noHnmaSA0RXAVZmlnlo3si2r3ZUME/q1zpUx8gRuq8IchQtSBQZOzoqeHf8DQS5Ab6AZ3G4FYphkB4JfbssxulktQoAihXcn4+1bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786703028; c=relaxed/simple;
	bh=hRSbzC0Pc9dhnfKC/c3R1xawMz7yD+2YD/1SBksfKxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n31lxJ/SvSID26FraJQWB1ITPZc99bh9V1J+IFYu+YqIaSBnE3vpG2ArHgNEgRL/NidyHAhZAb2B1fJ/90bIEMM+QjeWp1pzhk6AKOg8V7fnr2pm5+rS1GZ8kZUagEwatyvdrvDREgFFVCxVzIvCgeZpTB9GfBAiWC2s06CeJkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQS9sxXy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQS9sxXy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA2BF1F00A3A;
	Fri, 14 Aug 2026 10:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786703020;
	bh=Vv9ElWHr/YmaE7l5LFfutWEHAKuNlZRFB/RqWtFexJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fQS9sxXypKq0JbDvJieP+FbkJqcDMbLuY8RsXx1mNzQGqNdxU6HOCNzWJMbgQSi0W
	 jH+RwDIhcRpL/W09Jf8JNNSiEJ8YwwG6KsRK0E0T4PdRYb5GyEWvPjjX4wPAKT0Jol
	 4BTIjLoWV0HZMm19RoS7Thm9aN5N7Dr/8BvWwdPgaP7xcnm2WJOHmWAyuYHKgou5N5
	 j5svN3n5M3nzvT7OeIpPyZ0Tpk5DdrVbUNvYhsevyPRm3Oa+2oH0ecvn0KcIAiPL9o
	 V5JmVUbydgfMzRubR++NPyRHih5KMTaiEsiplyp0faSvsO9i+GGaPcJFSjSRm6hG3m
	 Om/r+7onHCMaw==
Date: Fri, 14 Aug 2026 12:23:33 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vladislav Leonov <vlad@zlab.su>
Cc: linux-rockchip@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, Simon Glass <sjg@chromium.org>, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>, 
	Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Subject: Re: [PATCH 18/25] spi: rockchip: Add support for RV1106
Message-ID: <20260814-jovial-black-swift-bf0dce@quoll>
References: <20260810121121.210040-1-vlad@zlab.su>
 <20260810121121.210040-19-vlad@zlab.su>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260810121121.210040-19-vlad@zlab.su>

On Mon, Aug 10, 2026 at 03:11:09PM +0300, Vladislav Leonov wrote:
> Add the "rockchip,rv1106-spi" compatible to the match table. No driver
> changes are needed beyond that, since the controller behaves like the
> other Rockchip variants already handled by the driver.
> 
> Signed-off-by: Vladislav Leonov <vlad@zlab.su>
> ---
> 
>  drivers/spi/spi-rockchip.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
> index 231fbcf0e7aa..447e6ff47c53 100644
> --- a/drivers/spi/spi-rockchip.c
> +++ b/drivers/spi/spi-rockchip.c
> @@ -1021,6 +1021,7 @@ static const struct of_device_id rockchip_spi_dt_match[] = {
>  	{ .compatible = "rockchip,rk3328-spi", },
>  	{ .compatible = "rockchip,rk3368-spi", },
>  	{ .compatible = "rockchip,rk3399-spi", },
> +	{ .compatible = "rockchip,rv1106-spi", },

Why do you need this? It's fully compatible, no?

Best regards,
Krzysztof

