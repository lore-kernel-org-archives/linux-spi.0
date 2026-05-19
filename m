Received: from smtpout7.mo534.mail-out.ovh.net (smtpout7.mo534.mail-out.ovh.net [54.36.140.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9E72475E3;
	Tue, 19 May 2026 05:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.36.140.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779168300; cv=none; b=NPVYiViS35Spb9LORZaBeQHXewj0LQZO7o1AcXTNiR+Fk74CwZkJ/i2cuKPzCvbr9NWQiTZ4M+Xff202Z6hX/mRQa1SPj2hqfY/kqf/5IG3hI1TvDD4qXPpXIbZQDJl0o1/+mjO3b+vc4d5jV3xhTbHqTMVr/bcInpamJakEd9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779168300; c=relaxed/simple;
	bh=Dz4h4tebbCujulDxoJ3+vxwJGCIW4ltMTN8PY2XygMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sascbgCTOmcM1lMPJUDBLEoZtfFmys6Qc3UxN0+UnlphxdBbuYmPQEcQbfGgOJPF8Jo8nU3G+iORgYgrj9OqYmJV0OsK2gv1J79eKuKZs8J0mhWMEsSHWGkJkKwYjAQlNU2Nn+4GIEA5qPPC1Q8Ay4QELEKFTok6EaKCjQFimQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaod.org; spf=pass smtp.mailfrom=kaod.org; dkim=pass (2048-bit key) header.d=kaod.org header.i=@kaod.org header.b=UFOP7Az2; arc=none smtp.client-ip=54.36.140.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaod.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaod.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kaod.org header.i=@kaod.org header.b="UFOP7Az2"
Received: from director1.derp.mail-out.ovh.net (director1.derp.mail-out.ovh.net [51.68.80.175])
	by mo534.mail-out.ovh.net (Postfix) with ESMTPS id 4gKNQv4ZXsz60B8;
	Tue, 19 May 2026 05:24:55 +0000 (UTC)
Received: from director1.derp.mail-out.ovh.net (director1.derp.mail-out.ovh.net. [127.0.0.1])
        by director1.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <BMC-SW@aspeedtech.com>; Tue, 19 May 2026 05:24:55 +0000 (UTC)
Received: from mta3.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.43.211])
	by director1.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4gKNQv2J6Rz5vLW;
	Tue, 19 May 2026 05:24:55 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.6])
	(Authenticated sender: clg@kaod.org)
	by mta3.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id BAE3312E3B55;
	Tue, 19 May 2026 05:24:53 +0000 (UTC)
Authentication-Results:garm.ovh; auth=pass (GARM-111S0054c8bd1e3-d3ef-4284-ba4e-ebb5c026c5fa,
                    A1C5BDF50025601E7F63D663DE463AD2E6007479) smtp.auth=clg@kaod.org
X-OVh-ClientIp:82.64.250.170
Message-ID: <5d16a357-9acf-468b-bbca-0d615f50a8b0@kaod.org>
Date: Tue, 19 May 2026 07:24:53 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: aspeed: Replace VLA parameter with flat pointer in
 calibration helper
To: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>, broonie@kernel.org,
 joel@jms.id.au, andrew@codeconstruct.com.au, linux-aspeed@lists.ozlabs.org,
 openbmc@lists.ozlabs.org, linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 BMC-SW@aspeedtech.com
Cc: kernel test robot <lkp@intel.com>
References: <20260518095708.2502537-1-chin-ting_kuo@aspeedtech.com>
 <20260518095708.2502537-3-chin-ting_kuo@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260518095708.2502537-3-chin-ting_kuo@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 17593030472268033226
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: dmFkZTE0iObQoePV2K1IhH/lNEfSblAOLwfgQuw3JoEnub5SozOtHYNazyv8nWJMCS9ATMcFGMTsyXaylTALoaNU765TsL1CA5M+JDrRdxbzWTERzO0GvgTfErFfsPFjmyGyvKtoi2sQKhyjk/3C6wk7rCMj9xft6HrUApWYeszRGEQxd49e8KdKWcQYqpUaAt/Plu4YtmK05kQh/EnFSVTwYzYZGyQyatwGRTjocDouBqYutoRycMSived2vCDkWh3UGftJ1HRoFqqq8YCrFwlx0kVJrdDSJcNZQHMTsgQzekmABOXgRbu2ZYwZKJfCsXvne3D+c3bMSXMSCOJTlPtJe2imD08vnxf4Uw7bPTw7XZOPZVOTHUD0yAbSk7GRDYH+qzAKV+CmWEVgu7df+EQMv8m+jhY9r0Dl1b2ABYbLZ1ViIu2vQmCQaw+pIUkLB3chSVb+BaceC7uKdJ/SwbCvlfD89qIfv1y/3RXt8f5EVPgfjUQ8Wxi3U7ZuuwD+Pp9zQPhRzSTxymqITYDfjWQCrYUDqEXZSv0rRt7SSARWIaPJywkmI18mIak/zAdh1sW0eTkaNunk0waDzJ5C4lMB2BxMR/tIvlhAk3W9+4hvHexGFX7Fp98b5cYpi4sVVTjGHDQM6lRxJjOfTMTuvQtBU4wrXRdcK86DGZEzhQjc5AG1Ag
DKIM-Signature: a=rsa-sha256; bh=XwOWnEeHG/j1dIISjUBQ3VGZjEvKu/Ve2bPF/FUDvjA=;
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1779168295; v=1;
 b=UFOP7Az2HvV97XOHN24hXTEOXwcKw638Dahvu5kW2FGeAFxhhH9jciWpTpx1pOtKPt6tC9P3
 L0fMrUfMz+g05Mcvz8Ex+CHCSxLKYgw04BkyVlVvX24MYk8DsG/Eq0u5ndFNfAkNSsgVFqPxWEv
 kKLVLfuQWDggX52WYVFvNPe7+/2XDBBE3jH+xzVMbRSCFzyz+giwxUNMNq1UCEGESTmA+GgX/Ts
 /yngGTRZ6zvG0NJIjaAaIjrcIP9yWU0hp38FWiDH1PlPbOXoSdZyc7CA4PKf9QzCrTTP++Pk9pS
 tl2JcBbIthflsZaXYXtGKTToZHGxFuUCg7qtcXprRDjOg==

On 5/18/26 11:57, Chin-Ting Kuo wrote:
> aspeed_spi_ast2600_optimized_timing() declared its buffer argument as a
> variable-length array parameter (u8 buf[rows][cols]), which causes a
> sparse warning. Replace the VLA parameter with a plain u8 * and compute
> the 2-D index manually. The corresponding call site is also updated.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202605180441.uD3toFRJ-lkp@intel.com/
> Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
> ---
>   drivers/spi/spi-aspeed-smc.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
> index 808659a1f460..c5275700de3d 100644
> --- a/drivers/spi/spi-aspeed-smc.c
> +++ b/drivers/spi/spi-aspeed-smc.c
> @@ -1467,8 +1467,7 @@ static int aspeed_spi_do_calibration(struct aspeed_spi_chip *chip)
>    * must contains the highest number of consecutive "pass"
>    * results and not span across multiple rows.
>    */
> -static u32 aspeed_spi_ast2600_optimized_timing(u32 rows, u32 cols,
> -					       u8 buf[rows][cols])
> +static u32 aspeed_spi_ast2600_optimized_timing(u32 rows, u32 cols, u8 *buf)
>   {
>   	int r = 0, c = 0;
>   	int max = 0;
> @@ -1478,7 +1477,7 @@ static u32 aspeed_spi_ast2600_optimized_timing(u32 rows, u32 cols,
>   		for (j = 0; j < cols;) {
>   			int k = j;
>   
> -			while (k < cols && buf[i][k])
> +			while (k < cols && buf[i * cols + k])
>   				k++;
>   
>   			if (k - j > max) {
> @@ -1541,7 +1540,7 @@ static int aspeed_spi_ast2600_calibrate(struct aspeed_spi_chip *chip, u32 hdiv,
>   		}
>   	}
>   
> -	calib_point = aspeed_spi_ast2600_optimized_timing(6, 17, calib_res);
> +	calib_point = aspeed_spi_ast2600_optimized_timing(6, 17, &calib_res[0][0]);
>   	/* No good setting for this frequency */
>   	if (calib_point == 0)
>   		return -1;



Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.

