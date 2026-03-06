Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6523148D3
	for <linux-spi@vger.kernel.org>; Fri,  6 Mar 2026 23:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772840251; cv=none; b=udcPzaB5iIXV4vvkoEuEqZEWZBaTLEaaXl36CY+oRTsRHK6cKIKgm1Q0HV2DfalMetG96M8h15Nhk5VhavJfVe5qx2AUbcQa8ibGEPXIl1ZxL17GbdazXjzy2gkTNQwb5n8RGpUcWR88S7dMR9PWmG2dny3x7c+GWfw5SAkyyF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772840251; c=relaxed/simple;
	bh=YXrfxx+SlB/oWENyu6t2j0MOogXZ6HQNTGOFPuzE06U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nbo7ksTjmmI9avAfcwpPocbS7tUmaOC7Yltvn0pn/cIA6nlkD8Asn670ileRpkDcVQtmv2knd6Q8tjvr1lKpS9C66UcBStYIaMxPVpZoD6bMLRDdpTxUuvqa0sd4oV3Cpm3bSd1hpiNNWovjcITpCEy2We4kobbOhJeXqOeIuJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=yiWBKtih; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="yiWBKtih"
Received: from eig-obgw-5003b.ext.cloudfilter.net ([10.0.29.155])
	by cmsmtp with ESMTPS
	id ybhrv3vcPCxrGyejZvz3ro; Fri, 06 Mar 2026 23:37:29 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id yejYvT3tM2l0kyejYvUK9d; Fri, 06 Mar 2026 23:37:28 +0000
X-Authority-Analysis: v=2.4 cv=UfRRSLSN c=1 sm=1 tr=0 ts=69ab6538
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=7vwVE5O1G3EA:10 a=qNABUOcEAAAA:8
 a=VwQbUJbxAAAA:8 a=xnXoI3Q-Js2OMDcH0-MA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Ytm653ucTKQjCvbzLygB:22 a=L5EjiQpGQaFGZdqT14z7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=R7eSIQ9PWsy1l0xwhOzzafvIk3P6i6NImXb6Jaj1Ic8=; b=yiWBKtihdLLUr6EF7dmIsIHt64
	YBvRcsRdYSHf6JFVbc9P4+iDuvfXGL9UxB4r2mI4GZWL21c9srjn0oBNBuQ4CyIZ3dtzeY1336+Z7
	/QDT6TrR+b9V3tfy271iR82K5ml2kEGJIF5jw2RNWrd2ed5m3Yqnst7pf84Wjo+r5qM6goeI3WfgZ
	XlOhhD0IoVRcZ7WB5sgwdwYCudG3u1EWRTTW3+tXz867RhN3VvCmOHlS3FjwRM8ponCjbNVzxB71F
	p8IT1xghsZbsrjLRsZ+zBCTh7FLEgd9pLeBPgy4gS9h+z9+N2vOagNzOENZrtVZnELgAKPpyHOZVR
	n6OXiYxA==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:42920 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <re@w6rz.net>)
	id 1vyejX-000000044Yt-4A1d;
	Fri, 06 Mar 2026 16:37:28 -0700
Message-ID: <c965f23f-4e71-46e8-915f-7c9ab3e5385a@w6rz.net>
Date: Fri, 6 Mar 2026 15:37:26 -0800
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: spi: Regression with v7.0-rc1 on VisionFive 2
To: Mark Brown <broonie@kernel.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, Conor Dooley
 <conor@kernel.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, wsa+renesas@sang-engineering.com
References: <a3ca5e9b-7446-497e-8df2-7ef2b42a02e9@w6rz.net>
 <aaL2WVO_7bl6vNp5@sirena.co.uk> <20260228-ragweed-theater-b02967937353@spud>
 <20260228-defuse-extenuate-cf2a90ae66ea@spud> <87tsuvh6iw.fsf@bootlin.com>
 <96e93ca0-ea10-4071-99ca-98f7219833d7@w6rz.net>
 <aatIrfp7fIznkgsq@sirena.co.uk>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <aatIrfp7fIznkgsq@sirena.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5620.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - w6rz.net
X-BWhitelist: no
X-Source-IP: 73.162.206.103
X-Source-L: No
X-Exim-ID: 1vyejX-000000044Yt-4A1d
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net ([10.0.1.180]) [73.162.206.103]:42920
X-Source-Auth: re@w6rz.net
X-Email-Count: 4
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfNTwEdFbQFoUV2DBmY3/0bRUt7nDMUYfHvm4VRdLBYPqAT0j2l7R2M1nwtypWleJ6hcfqAVqIgzO/4oqdR/oRbH8cv2OvqNtDMOPc7jJruSiFA4YwQZh
 6C7BokTZ3tdjaavjdTZXH51OkUlXh2WD/wnM5BoiciN160VbsmF4Xuwx7Ysu34jXo7AIQzVb23H4eEegSIvn0ZAx+ZcUnh3aUrc=

On 3/6/26 13:35, Mark Brown wrote:
> On Wed, Mar 04, 2026 at 01:52:08PM -0800, Ron Economos wrote:
>> On 3/4/26 09:02, Miquel Raynal wrote:
>>> The other change that could be "it" is the change of order between reset
>>> handling and clock. That would be quite messy if that was the error but
>>> I cannot find another explanation. Ron, can you please try to revert
>>> this patch locally and then move the clk_prepare_enable() of the APB and
>>> AHB clocks earlier, right after the ref clock is also enabled? If the
>>> platform fails to boot, there is maybe a weird internal relationship
>>> with the resets.
>>> Otherwise can you compare the clk_get_rate() on all three clocks in both
>>> cases?
>> I'm happy to help you debug this, but you have to send me a patch to
>> the reverted file. I have no idea where the ref clock is enabled.
> I think Miquel means
>
> commit c9117602a87c441c4f05a2cc4d9be45c96140146
> Author: Mark Brown <broonie@kernel.org>
> Date:   Fri Mar 6 20:16:33 2026 +0000
>
>      test
>
> diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
> index 2d287950d44c..d74446f6db5a 100644
> --- a/drivers/spi/spi-cadence-quadspi.c
> +++ b/drivers/spi/spi-cadence-quadspi.c
> @@ -1932,6 +1932,12 @@ static int cqspi_probe(struct platform_device *pdev)
>   	reset_control_assert(rstc_ocp);
>   	reset_control_deassert(rstc_ocp);
>   
> +	if (ddata->jh7110_clk_init) {
> +		ret = cqspi_jh7110_clk_init(pdev, cqspi);
> +		if (ret)
> +			goto disable_clk;
> +	}
> +
>   	cqspi->master_ref_clk_hz = clk_get_rate(cqspi->clk);
>   	host->max_speed_hz = cqspi->master_ref_clk_hz;
>   
> @@ -1959,11 +1965,6 @@ static int cqspi_probe(struct platform_device *pdev)
>   		if (ddata->quirks & CQSPI_NEEDS_APB_AHB_HAZARD_WAR)
>   			cqspi->apb_ahb_hazard = true;
>   
> -		if (ddata->jh7110_clk_init) {
> -			ret = cqspi_jh7110_clk_init(pdev, cqspi);
> -			if (ret)
> -				goto disable_clk;
> -		}
>   		if (ddata->quirks & CQSPI_DISABLE_STIG_MODE)
>   			cqspi->disable_stig_mode = true;
>   
> which does the right thing:
>
>     https://lava.sirena.org.uk/scheduler/job/2535610
>
> but I'm fairly sure it's not an ordering thing.  The patch includes:
>
> -       static struct clk_bulk_data qspiclk[] = {
> -               { .id = "apb" },
> -               { .id = "ahb" },
> -       };
>
> but never adds those names back, this means that while we do ask for
> three clocks none of them have IDs specified so we just end up
> requesting the same clock three times which might be what's needed on
> most integrations but not here.  The below seems to do the trick for me,
> I'll write a commit log and post - testing appreciated:
>
>    https://lava.sirena.org.uk/scheduler/job/2535662
>
> diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
> index 649ff55333f0..7a7f92e9c7a3 100644
> --- a/drivers/spi/spi-cadence-quadspi.c
> +++ b/drivers/spi/spi-cadence-quadspi.c
> @@ -76,6 +76,11 @@ struct cqspi_flash_pdata {
>   	u8		cs;
>   };
>   
> +static struct clk_bulk_data cqspi_clks[CLK_QSPI_NUM] = {
> +	[CLK_QSPI_APB] = { .id = "apb" },
> +	[CLK_QSPI_AHB] = { .id = "ahb" },
> +};
> +
>   struct cqspi_st {
>   	struct platform_device	*pdev;
>   	struct spi_controller	*host;
> @@ -1823,6 +1828,7 @@ static int cqspi_probe(struct platform_device *pdev)
>   	}
>   
>   	/* Obtain QSPI clocks. */
> +	memcpy(&cqspi->clks, &cqspi_clks, sizeof(cqspi->clks));
>   	ret = devm_clk_bulk_get_optional(dev, CLK_QSPI_NUM, cqspi->clks);
>   	if (ret)
>   		return dev_err_probe(dev, ret, "Failed to get clocks\n");

Works good here. I'll send a tested-by: when you post the patch.

ubuntu@visionfive:~$ lsblk
NAME         MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
mtdblock0     31:0    0    16M  0 disk     <-----
mmcblk1      179:0    0 119.3G  0 disk
└─mmcblk1p1  179:1    0 119.2G  0 part
nvme0n1      259:0    0 465.8G  0 disk
├─nvme0n1p1  259:1    0 465.6G  0 part /
├─nvme0n1p2  259:2    0    16M  0 part
├─nvme0n1p12 259:3    0     4M  0 part
├─nvme0n1p13 259:4    0     2M  0 part
└─nvme0n1p15 259:5    0   100M  0 part /boot/efi

